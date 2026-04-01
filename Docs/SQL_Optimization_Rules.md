# SQL Optimization Rules — Query Evaluation Reference

> Runtime reference for the OIM Query Evaluator. Based on verified academic sources and industry methodology.
> Version: 1.0 | Last updated: 2026-04-01

---

## Chapter 1 — SARGability

**Definition**: A predicate is SARGable (Search ARGument able) if SQL Server can use an index seek to evaluate it. Non-SARGable predicates force index scans or table scans.

### 1.1 Conditions that destroy SARGability

| Pattern | Example | Fix |
|---|---|---|
| Function on column | `YEAR(DateCreated) = 2024` | `DateCreated >= '2024-01-01' AND DateCreated < '2025-01-01'` |
| Implicit type conversion | `NVarcharCol = 'literal'` | `NVarcharCol = N'literal'` (N-prefix) |
| Arithmetic on column | `Salary + 100 > @val` | `Salary > @val - 100` |
| Leading wildcard | `Name LIKE '%smith'` | Full-text search, or trailing wildcard if business allows |
| Negation | `Status <> 'Active'` | Evaluate if positive range is usable |
| OR across columns | `Col1 = 'a' OR Col2 = 'b'` | UNION of two seeks, or indexed view |

### 1.2 The N-prefix rule (critical for OIM)

All OIM string columns are `nvarchar`. Comparing without the N-prefix causes SQL Server to implicitly convert the **entire column** to the literal's collation, forcing a scan:

```sql
-- BAD: CONVERT_IMPLICIT on entire column (scan)
WHERE CentralAccount = 'jsmith'

-- GOOD: seeks on the index
WHERE CentralAccount = N'jsmith'
```

This applies to all string comparisons including GUID-like UID values stored as nvarchar.

**Source**: SQL Server documentation; CONVERT_IMPLICIT execution plan warnings.

### 1.3 Function rewrites

| Original | Rewrite |
|---|---|
| `YEAR(col) = 2024` | `col >= '2024-01-01' AND col < '2025-01-01'` |
| `LEFT(col, 3) = 'abc'` | `col LIKE N'abc%'` |
| `ISNULL(col, '') = 'x'` | `col = N'x'` (if NULLs are rare) |
| `LEN(col) > 5` | Not rewritable — apply in post-filter or add computed column |
| `UPPER(col) = 'ABC'` | Use case-insensitive collation or `col = N'abc'` |

---

## Chapter 2 — Index Design & Usage

### 2.1 Index types and selectivity

- **Clustered index**: defines physical row order. One per table (usually PK).
- **Non-clustered index**: separate B-tree with row locator. Multiple allowed.
- **Covering index**: non-clustered index that includes all columns needed by a query (key + INCLUDE columns) — eliminates key lookup.
- **Filtered index**: non-clustered with WHERE clause — smaller, faster for selective subsets.

**Selectivity**: High-selectivity columns (many distinct values) benefit most from indexes. Low-selectivity columns (binary flags, status enums with few values) are poor index candidates unless filtered.

### 2.2 Index key order

Composite indexes are left-prefix sensitive. `INDEX ON (A, B, C)` supports seeks on `(A)`, `(A,B)`, `(A,B,C)` but NOT on `(B)` or `(C)` alone.

Design composite index key order as: **equality columns first**, then **range column last**.

### 2.3 Key lookups

When a non-clustered index does not cover all required columns, SQL Server performs a key lookup (RID or clustered index lookup) for each matching row. On large result sets this is expensive. Fix: add missing columns to INCLUDE clause of the index.

### 2.4 Covering index pattern

```sql
-- Query
SELECT UID_Person, FirstName, LastName FROM Person WHERE CentralAccount = N'jsmith'

-- Ideal covering index
CREATE INDEX IX_Person_CentralAccount ON Person (CentralAccount) INCLUDE (FirstName, LastName)
```

---

## Chapter 3 — Join Optimization

### 3.1 Join elimination (FK trust)

SQL Server can eliminate a join if:
1. The join is on a single-column trusted FK relationship
2. The joined table's columns are not referenced in SELECT, WHERE, or ORDER BY
3. The relationship guarantees 1:0..1 cardinality (no row multiplication)

**Trusted FK requirement**: FK must be declared as `WITH CHECK` (not `NOCHECK`). In OIM, FK trust cannot be assumed without verification via `sys.foreign_keys`.

**Source**: Galindo-Legaria & Rosenthal, "Outerjoin Simplification and Reordering for Query Optimization", ACM TODS 1997.

### 3.2 LEFT JOIN → INNER collapse

A LEFT JOIN that has a non-nullable equality predicate on the right table's column in WHERE is semantically equivalent to an INNER JOIN:

```sql
-- These are semantically identical if StatusID is NOT NULL on the right table
SELECT p.Name FROM Person p
LEFT JOIN Status s ON p.StatusID = s.StatusID
WHERE s.StatusName = N'Active'     -- filters out NULLs, collapses to INNER
```

The optimizer may detect this, but explicit INNER JOIN is clearer and safer.

### 3.3 Unnecessary joins

A join is unnecessary if:
- The joined table contributes no columns to SELECT or GROUP BY
- The join condition does not filter rows (no WHERE on joined table)
- The join is INNER on a 1:many relationship without any filtering

Remove unnecessary joins to reduce cardinality estimation errors and I/O.

### 3.4 Join order and cardinality errors

Leis et al. (PVLDB 2015, Join Order Benchmark) demonstrated that all major commercial query optimizers — including SQL Server — produce large cardinality estimation errors on queries joining ≥5 tables. Errors compound multiplicatively: a 2× error per join reaches 32× error at 5 joins.

**Practical implication**: For queries with ≥5 joins, consider:
- Adding query hints (`OPTION (HASH JOIN)`, `FORCE ORDER`)
- Breaking into CTEs with `OPTION (MAXRECURSION 0)` to materialize intermediate results
- Using temp tables to force statistics re-estimation at join boundaries

**Source**: Leis et al., "How Good Are Query Optimizers, Really?", PVLDB 9(3), 2015.

### 3.5 Implicit join syntax

Avoid comma-separated join syntax (ANSI-89):
```sql
-- BAD (implicit cross join with filter)
FROM Person p, ADSAccount a WHERE p.UID_Person = a.UID_Person

-- GOOD
FROM Person p INNER JOIN ADSAccount a ON p.UID_Person = a.UID_Person
```

Implicit syntax is harder to read, more error-prone, and does not support OUTER JOINs clearly.

---

## Chapter 4 — Statistics & Cardinality Estimation

### 4.1 The histogram model

SQL Server maintains per-column histograms with up to **200 steps** (RANGE_HI_KEY values). For columns with >200 distinct values, the histogram interpolates between steps, which introduces estimation error.

Problematic scenarios:
- Columns with highly skewed distributions (most rows in one bucket)
- Ascending key problem: new values inserted beyond histogram max are estimated as 1 row
- Multi-column correlations: SQL Server estimates dimensions independently by default

**Source**: Ioannidis, "The History of Histograms (Abridged)", VLDB 2003.

### 4.2 Cardinality Estimator (CE) model

SQL Server 2014+ introduced CE model 120 (vs legacy 70). CE120 handles:
- Multi-predicate selectivity more accurately (uses exponential backoff)
- Correlated column heuristics
- Outer join selectivity

Check: `SELECT compatibility_level FROM sys.databases WHERE name = 'OneIM'`

CE70 (compat level < 120) uses simpler estimation that can significantly underestimate joins.

### 4.3 Statistics staleness

Statistics are outdated when row counts change significantly (default threshold: 20% of rows + 500 rows changed). Stale stats lead to wrong cardinality estimates and bad plan choices.

Check staleness: `SELECT STATS_DATE(object_id, stats_id) FROM sys.stats WHERE object_id = OBJECT_ID('Person')`

Update with: `UPDATE STATISTICS Person WITH FULLSCAN`

---

## Chapter 5 — Plan Stability & Parameter Sniffing

### 5.1 Parameter sniffing

When SQL Server first compiles a parameterized query, it generates a plan optimized for the **parameter values at that moment** (the "sniffed" values). If subsequent executions use very different values, the cached plan may be highly suboptimal.

**High-risk OIM scenarios**:
- Filtering by `Queue` name (one queue may have 95% of rows)
- Filtering by `OrderState` (vastly different row counts per state)
- Filtering by `TaskName` in JobQueue

**Source**: Dutt, Narasayya, Chaudhuri, "Leveraging Re-Costing for Online Optimization of Parameterized Queries with Guarantees", SIGMOD 2017.

### 5.2 Mitigation strategies

| Strategy | When to use | Trade-off |
|---|---|---|
| `OPTION (RECOMPILE)` | Ad hoc queries, wildly varying params | Recompile cost on every execution |
| `OPTION (OPTIMIZE FOR (@p = 'value'))` | Known "average" value exists | Hardcodes optimization for one value |
| `OPTION (OPTIMIZE FOR UNKNOWN)` | No good representative value | Uses average statistics, avoids sniffing |
| Parameter Sensitive Plan (PSP) SQL 2022 | Automatic, up to 3 plan variants | Limited to 3 variants, not always triggered |

**Source**: Kimberly Tripp (SQLskills), "Parameter Sniffing, Embedding, and the RECOMPILE Options".

### 5.3 Plan cache pollution

Ad-hoc literal-heavy queries generate a new plan cache entry for every unique literal combination. This wastes memory and increases compile frequency.

Fix: Enable **Optimize for Ad Hoc Workloads** (`sp_configure 'optimize for ad hoc workloads', 1`) — stores plan stub on first execution, full plan only if query runs again.

Better fix: parameterize queries with `sp_executesql`.

---

## Chapter 6 — Quick Reference

### Anti-pattern checklist

- [ ] `SELECT *` in production queries — enumerate required columns
- [ ] String literals without N-prefix on nvarchar columns
- [ ] Functions on filter columns (`YEAR()`, `LEFT()`, `ISNULL()`, etc.)
- [ ] Leading wildcard LIKE (`%text`)
- [ ] Unfiltered scans of large tables (JobHistory ~38K, AttestationHistory ~2K)
- [ ] Missing `WITH (NOLOCK)` on read-only queries (OIM context)
- [ ] Joins on 5+ tables without TOP/WHERE restrictions
- [ ] Correlated subqueries in SELECT list or WHERE
- [ ] CTEs referenced multiple times (SQL Server re-executes each reference)
- [ ] Recursive CTE on manager hierarchy without MAXRECURSION cap or HelperHeadPerson
- [ ] `XOrigin = 1` instead of `(XOrigin & 1) = 1` (bitfield check)

### OIM-specific traps

| Trap | Symptom | Fix |
|---|---|---|
| `PersonWantsOrg.UID_Person` | Returns wrong/no results | Use `UID_PersonOrdered` |
| `DPRJournal.StartTime` | Column not found | Use `CreationTime` / `CompletionTime` |
| `AttestationRun.IsCompleted` | Column not found | Use `PolicyProcessed IS NOT NULL` |
| `Ready2EXE = 'ACTIVE'` | Returns 0 rows | Valid values: TRUE, FALSE, OVERLIMIT, FINISHED |
| `IsGranted = 0` as "approved" | Inverted logic | 1=approved, 0=denied, NULL=pending |
| Writing to `JobQueue` without trigger disable | Breaks OIM processing chain | Wrap with `QBM_PTriggerDisable` / `QBM_PTriggerEnable` |

### Decision tree: optimizing a slow OIM query

```
1. Run SET STATISTICS IO ON — check logical reads
2. Is there a table scan? → Check for N-prefix, function on column, missing index
3. Are reads high on lookup? → Consider covering index (add INCLUDE columns)
4. Is cardinality estimate far off? → Update stats WITH FULLSCAN
5. Does it sniff badly? → Add OPTION (RECOMPILE) or OPTIMIZE FOR UNKNOWN
6. ≥5 joins? → Review join necessity, consider temp tables at join boundaries
7. Unnecessary joins? → Remove tables not used in SELECT/WHERE
8. Missing NOLOCK? → Add WITH (NOLOCK) for OIM read-only queries
```

---

## Academic Citations

| Source | Key finding | Applied in rule |
|---|---|---|
| Leis et al., PVLDB 9(3) 2015 | All major optimizers produce large CE errors on ≥5 join queries | Ch. 3.4, Academic Risk AR flags |
| Ioannidis, VLDB 2003 | 200-step histogram model limitations and skew | Ch. 4.1 |
| Dutt/Narasayya/Chaudhuri, SIGMOD 2017 | Parameter sniffing pathology and PSP | Ch. 5.1–5.2 |
| Galindo-Legaria & Rosenthal, ACM TODS 1997 | Join elimination requires trusted FK | Ch. 3.1 |
| Ramachandra et al. (Froid), PVLDB 11(4) 2018 | Scalar UDF inlining; pre-2019 UDFs serialize execution | Academic Risk AR4 |
| Lee et al., PVLDB 16(11) 2023 | 13% of production queries improve ≥2× with exact cardinalities | Ch. 4 |
| Berenson, Gray et al., SIGMOD 1995 | NOLOCK/READ UNCOMMITTED isolation risks | Academic Risk AR5 |
