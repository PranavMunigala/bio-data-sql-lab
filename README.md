# bio-data-sql-lab

A workspace for exploring biological/bio-data datasets with SQLite and DuckDB.

## Structure

- `data/raw/` — raw source data (gitignored; not tracked)
- `queries/` — saved SQL queries
- `notes/` — analysis notes and writeups
- `scripts/` — helper scripts (loading, transforming, exporting data)

## Tools

- `sqlite3` — SQLite CLI
- `duckdb` (Python) — `import duckdb`
- DB Browser for SQLite (`sqlitebrowser`) — GUI for point-and-click inspection

## Notes

Database files (`*.db`, `*.duckdb`) and `*.parquet` files are gitignored — keep them local.
