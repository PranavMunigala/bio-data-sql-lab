#!/usr/bin/env bash
# Loads the Synthea CSV exports into a fresh SQLite database.
#
# Usage: scripts/load_db.sh [path/to/db]
# Defaults to clinic.db in the repo root.
set -euo pipefail

DB="${1:-clinic.db}"
CSV_DIR="data/raw/CSV"

# Fresh start each run so column names/row counts stay correct — .import
# auto-derives column names from the header only when creating a NEW table.
rm -f "$DB"

for csv in patients encounters observations; do
    sqlite3 "$DB" <<EOF
.mode csv
.import ${CSV_DIR}/${csv}.csv ${csv}
EOF
done

echo "Loaded into ${DB}:"
sqlite3 "$DB" <<'EOF'
.headers on
.mode column
SELECT 'patients' AS table_name, COUNT(*) AS row_count FROM patients
UNION ALL
SELECT 'encounters', COUNT(*) FROM encounters
UNION ALL
SELECT 'observations', COUNT(*) FROM observations;
EOF
