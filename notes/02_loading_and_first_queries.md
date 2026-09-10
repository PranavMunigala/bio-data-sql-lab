# Loading the dataset and first queries

## Loading

`scripts/load_db.sh` rebuilds `clinic.db` from scratch and loads
`patients`, `encounters`, and `observations` from `data/raw/CSV/`.

```bash
scripts/load_db.sh clinic.db
```

**Gotcha:** `sqlite3 .import` only auto-derives column names from the CSV
header when it's *creating* a new table. If the table already exists,
the first row of input is treated as data, not a header, so it must be
skipped explicitly with `--import --skip 1`. Mixing the two up — e.g.
passing `--skip 1` on a fresh table — causes `.import` to skip the real
header and instead treat the first *data* row as the header, corrupting
both the column names and the row count (1171 rows became 1170, with
columns named after a patient's actual SSN/name/etc.). The script always
drops and recreates the table so `--skip` is never needed.

## Row counts after loading

| table | rows |
|---|---|
| patients | 1,171 |
| encounters | 53,346 |
| observations | 299,697 |

Matches the counts documented in [01_data_shape.md](01_data_shape.md).

## First queries

See [`queries/01_basic_counts.sql`](../queries/01_basic_counts.sql).

Patients by gender:

| GENDER | n |
|---|---|
| F | 609 |
| M | 562 |

Encounters by class:

| ENCOUNTERCLASS | n |
|---|---|
| wellness | 19,106 |
| ambulatory | 18,936 |
| outpatient | 9,003 |
| urgentcare | 2,373 |
| emergency | 2,090 |
| inpatient | 1,838 |
