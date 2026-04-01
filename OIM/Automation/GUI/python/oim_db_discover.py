"""
oim_db_discover.py — Discover all tables and columns in the OIM SQL Server database.

Produces a searchable Ctrl+F-friendly markdown report:
  Implementation_Guides/resources/db_discovery.md

Every base table gets:
  - Row count (from sys.partitions — no full table scan)
  - Full column list (name, data type, max length, nullable)

Usage:
  py -3 oim_db_discover.py
  py -3 oim_db_discover.py --out "C:\\some\\other\\path.md"

Requirements:
  pip install pyodbc
  ODBC Driver 17 for SQL Server  (or older "SQL Server" driver as fallback)
"""

import sys
import os
import argparse
from datetime import datetime
from collections import defaultdict

try:
    import pyodbc
except ImportError:
    print("ERROR: pyodbc not installed. Run: pip install pyodbc")
    sys.exit(1)


# ── Connection ─────────────────────────────────────────────────────────────────
# Edit these if the database details change.
_SERVER   = "STATHOPOULOSK"
_DATABASE = "OneIM"
_UID      = "OneIM_Admin"
_PWD      = "Password.123"

_DRIVERS = [
    "ODBC Driver 17 for SQL Server",
    "ODBC Driver 18 for SQL Server",
    "SQL Server",                     # older built-in driver — last resort
]

# Default output path (relative to this script's location)
_HERE = os.path.dirname(os.path.abspath(__file__))
_DEFAULT_OUT = os.path.normpath(
    os.path.join(_HERE, "..", "..", "Implementation_Guides", "resources", "db_discovery.md")
)


# ── Connect ────────────────────────────────────────────────────────────────────

def _connect() -> pyodbc.Connection:
    """Try each ODBC driver in order; return first successful connection."""
    last_err = None
    for driver in _DRIVERS:
        conn_str = (
            f"DRIVER={{{driver}}};"
            f"Server={_SERVER};"
            f"Database={_DATABASE};"
            f"UID={_UID};"
            f"PWD={_PWD};"
            "TrustServerCertificate=yes;"
        )
        try:
            conn = pyodbc.connect(conn_str, timeout=15)
            print(f"[db] Connected via '{driver}'  →  {_SERVER} / {_DATABASE}")
            return conn
        except pyodbc.Error as e:
            last_err = e
    raise RuntimeError(
        f"Could not connect to {_SERVER}/{_DATABASE}.\n"
        f"Last error: {last_err}\n"
        f"Tried drivers: {_DRIVERS}"
    )


# ── Queries ────────────────────────────────────────────────────────────────────

def get_all_tables(cur: pyodbc.Cursor) -> list[str]:
    """Return all base table names, sorted alphabetically."""
    cur.execute("""
        SELECT TABLE_NAME
        FROM INFORMATION_SCHEMA.TABLES
        WHERE TABLE_TYPE = 'BASE TABLE'
        ORDER BY TABLE_NAME
    """)
    return [row[0] for row in cur.fetchall()]


def get_row_counts(cur: pyodbc.Cursor) -> dict[str, int]:
    """
    Return {table_name: row_count} for every table in one query.
    Uses sys.partitions — fast, no full table scan.
    """
    cur.execute("""
        SELECT t.name AS TableName, SUM(p.rows) AS TotalRows
        FROM sys.tables t
        JOIN sys.partitions p ON t.object_id = p.object_id
        WHERE p.index_id IN (0, 1)
        GROUP BY t.name
        ORDER BY t.name
    """)
    return {row[0]: int(row[1]) for row in cur.fetchall()}


def get_all_columns(cur: pyodbc.Cursor) -> dict[str, list[dict]]:
    """
    Return {table_name: [{col}, ...]} for ALL tables in one query.
    Avoids N+1 column queries across hundreds of tables.
    """
    cur.execute("""
        SELECT
            c.TABLE_NAME,
            c.COLUMN_NAME,
            c.DATA_TYPE,
            c.CHARACTER_MAXIMUM_LENGTH,
            c.NUMERIC_PRECISION,
            c.NUMERIC_SCALE,
            c.IS_NULLABLE
        FROM INFORMATION_SCHEMA.COLUMNS c
        JOIN INFORMATION_SCHEMA.TABLES t
          ON c.TABLE_NAME = t.TABLE_NAME
         AND t.TABLE_TYPE = 'BASE TABLE'
        ORDER BY c.TABLE_NAME, c.ORDINAL_POSITION
    """)
    result = defaultdict(list)
    for row in cur.fetchall():
        table, col, dtype, maxlen, num_prec, num_scale, nullable = row

        # Build a readable type string
        if dtype in ("nvarchar", "varchar", "char", "nchar"):
            type_str = f"{dtype}({maxlen if maxlen and maxlen != -1 else 'MAX'})"
        elif dtype in ("decimal", "numeric") and num_prec is not None:
            type_str = f"{dtype}({num_prec},{num_scale})"
        else:
            type_str = dtype

        result[table].append({
            "name":     col,
            "type":     type_str,
            "nullable": "YES" if nullable == "YES" else "NO",
        })
    return dict(result)


# ── Report writer ──────────────────────────────────────────────────────────────

def write_report(
    tables: list[str],
    row_counts: dict[str, int],
    columns: dict[str, list[dict]],
    out_path: str,
) -> None:
    """Write the full discovery report as UTF-8 markdown."""

    os.makedirs(os.path.dirname(out_path), exist_ok=True)

    tables_with_data = sum(1 for t in tables if row_counts.get(t, 0) > 0)
    total_cols = sum(len(v) for v in columns.values())
    ts = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

    lines = [
        f"# OIM Database Discovery",
        f"",
        f"_Generated: {ts}_  ",
        f"_Server: `{_SERVER}` | Database: `{_DATABASE}`_",
        f"",
        f"---",
        f"",
        f"## Summary",
        f"",
        f"| Metric | Value |",
        f"|--------|-------|",
        f"| Total tables | {len(tables):,} |",
        f"| Tables with rows > 0 | {tables_with_data:,} |",
        f"| Total columns | {total_cols:,} |",
        f"| Generated | {ts} |",
        f"",
        f"---",
        f"",
        f"## All Tables",
        f"",
        f"> Tip: Use **Ctrl+F** to search for a table or column name.",
        f"",
    ]

    for table in tables:
        rows = row_counts.get(table, 0)
        cols = columns.get(table, [])

        lines.append(f"### {table}  ({rows:,} rows)")
        lines.append(f"")

        if cols:
            lines.append(f"| Column | Type | Nullable |")
            lines.append(f"|--------|------|----------|")
            for col in cols:
                lines.append(f"| {col['name']} | `{col['type']}` | {col['nullable']} |")
        else:
            lines.append(f"_No column information available._")

        lines.append(f"")

    content = "\n".join(lines)
    with open(out_path, "w", encoding="utf-8") as f:
        f.write(content)


# ── Main ───────────────────────────────────────────────────────────────────────

def main():
    if hasattr(sys.stdout, "reconfigure"):
        sys.stdout.reconfigure(encoding="utf-8")

    parser = argparse.ArgumentParser(
        description="Discover all OIM database tables and columns"
    )
    parser.add_argument(
        "--out", default=_DEFAULT_OUT,
        help=f"Output markdown path (default: {_DEFAULT_OUT})"
    )
    args = parser.parse_args()

    print(f"[db] Connecting to {_SERVER}/{_DATABASE}...")
    conn = _connect()
    cur = conn.cursor()

    print(f"[db] Fetching table list...")
    tables = get_all_tables(cur)
    print(f"[db]   {len(tables):,} tables found")

    print(f"[db] Fetching row counts (sys.partitions)...")
    row_counts = get_row_counts(cur)
    with_data = sum(1 for t in tables if row_counts.get(t, 0) > 0)
    print(f"[db]   {with_data:,} tables have rows")

    print(f"[db] Fetching all columns (single query)...")
    columns = get_all_columns(cur)
    total_cols = sum(len(v) for v in columns.values())
    print(f"[db]   {total_cols:,} columns across {len(columns):,} tables")

    cur.close()
    conn.close()

    print(f"[db] Writing report → {args.out}")
    write_report(tables, row_counts, columns, args.out)

    size_kb = os.path.getsize(args.out) // 1024
    print(f"[db] Done. Report: {size_kb:,} KB — open in VS Code and Ctrl+F to search.")


if __name__ == "__main__":
    main()
