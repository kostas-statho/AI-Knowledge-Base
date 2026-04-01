---
name: oim-db-structure
description: Fetch the live OIM database schema and update (or create) the db_discovery.md structure export. Reports table counts, row counts, and highlights key tables.
argument-hint: "[--compare] [--out path/to/output.md]"
user-invocable: true
allowed-tools: "Bash, Read, Glob"
---

Fetch the live OIM database schema and update `Implementation_Guides/resources/db_discovery.md`.

## Step 1 — Check prerequisites

Run in parallel:
```bash
py -3 -c "import pyodbc; print('pyodbc OK:', pyodbc.version)"
ls "C:/Users/OneIM/Knowledge_Base/Scripts/OIM_Automation/oim_db_discover.py"
ls "C:/Users/OneIM/Knowledge_Base/Implementation_Guides/resources/db_discovery.md" 2>/dev/null && echo "EXISTS" || echo "NOT FOUND"
```

If `pyodbc` is missing:
```bash
py -3 -m pip install pyodbc
```

Note whether `db_discovery.md` already exists — if yes, this is an **update run** (report will be overwritten).

## Step 2 — Capture previous stats (update run only)

If `db_discovery.md` existed, read the Summary section to capture:
- Previous total tables count
- Previous tables-with-data count
- Previous generated timestamp

Use Read tool on `Implementation_Guides/resources/db_discovery.md` (first 30 lines are enough).

## Step 3 — Run discovery

```bash
cd "C:/Users/OneIM/Knowledge_Base/Scripts/OIM_Automation" && py -3 oim_db_discover.py
```

This connects to `STATHOPOULOSK/OneIM`, queries all 691+ tables and their columns, and writes the report. Expect ~10–30 seconds.

If the argument `--out <path>` was passed, forward it:
```bash
py -3 oim_db_discover.py --out "<path>"
```

## Step 4 — Report results

Read the new `db_discovery.md` (first 30 lines for the Summary table).

Print a report:
```
OIM Database Structure — Updated
─────────────────────────────────────
  Server    : STATHOPOULOSK / OneIM
  Generated : <timestamp from report>
  Tables    : <total>  (previously: <N> if update run)
  With data : <N>      (previously: <N> if update run)
  File size : <KB>
  Output    : Implementation_Guides/resources/db_discovery.md
```

If this was an update run, show a change summary:
- New tables: +N  (or "none")
- Tables dropped: -N  (or "none")
- Tables with data change: ±N rows gained/lost in totals

## Step 5 — Highlight key tables

Run this query to surface the tables most relevant to OIM automation work:
```bash
py -3 -c "
import pyodbc
conn = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};Server=STATHOPOULOSK;Database=OneIM;UID=OneIM_Admin;PWD=Password.123;TrustServerCertificate=yes;')
cur = conn.cursor()
groups = {
    'AAD / Azure AD':       ['%AAD%', '%Entra%', '%AzureAD%'],
    'Exchange / O365':      ['%Mailbox%', '%EXO%', '%O3E%', '%O365%', '%EX0%'],
    'Job / Queue / Process':['%Job%', '%Queue%', '%QBM%', '%Schedule%'],
    'CCC Custom':           ['CCC%'],
}
for group, patterns in groups.items():
    where = ' OR '.join(f\"t.name LIKE '{p}'\" for p in patterns)
    cur.execute(f'''
        SELECT t.name, SUM(p.rows) AS TotalRows
        FROM sys.tables t JOIN sys.partitions p ON t.object_id=p.object_id
        WHERE p.index_id IN (0,1) AND ({where})
        GROUP BY t.name HAVING SUM(p.rows) > 0
        ORDER BY TotalRows DESC
    ''')
    rows = cur.fetchall()
    print(f'  {group}:')
    for r in rows: print(f'    {r[0]:45} {r[1]:>8,} rows')
    if not rows: print('    (none with data)')
conn.close()
"
```

Print these as a formatted list grouped by category.

## Step 6 — Confirm output

```bash
ls -lh "C:/Users/OneIM/Knowledge_Base/Implementation_Guides/resources/db_discovery.md"
```

Tell the user:
- The file is ready at `Implementation_Guides/resources/db_discovery.md`
- It is **Ctrl+F searchable** — every table has a `###` heading with row count
- Run `/project:git-commit-push` to commit the updated structure to git if needed

## Error handling

| Error | Action |
|---|---|
| `No module named 'pyodbc'` | `py -3 -m pip install pyodbc` then retry |
| `Could not connect` | Check Designer/Manager are connected to same DB; verify credentials in `oim_db_discover.py` |
| `oim_db_discover.py not found` | Script is at `Scripts/OIM_Automation/oim_db_discover.py` — check path |
| File not updated | Check disk space; ensure `Implementation_Guides/resources/` directory exists |
