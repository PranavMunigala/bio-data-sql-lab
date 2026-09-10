# Data Shape — patients.csv, encounters.csv, observations.csv

Source: Synthea-generated synthetic patient data (`data/raw/CSV/`). No data
dictionary file shipped with the repo, so column meanings below come from
Synthea's standard CSV export schema.

## patients.csv

**Row count:** 1,171 (excluding header)

**Identifier column:** `Id` — a UUID, one row per patient. This is the
primary key other files reference.

**Column meanings:**

| Column | Meaning |
|---|---|
| Id | Unique patient identifier (UUID) |
| BIRTHDATE | Date of birth |
| DEATHDATE | Date of death (blank if still alive) |
| SSN | Synthetic Social Security number |
| DRIVERS | Driver's license number |
| PASSPORT | Passport number |
| PREFIX | Name prefix (Mr., Mrs., etc.) |
| FIRST | First name |
| LAST | Last name |
| SUFFIX | Name suffix (Jr., III, etc.) |
| MAIDEN | Maiden name |
| MARITAL | Marital status code (S, M, etc.) |
| RACE | Race |
| ETHNICITY | Ethnicity |
| GENDER | Gender (M/F) |
| BIRTHPLACE | City/state/country of birth |
| ADDRESS | Street address |
| CITY | City of residence |
| STATE | State of residence |
| COUNTY | County of residence |
| ZIP | Postal code |
| LAT | Latitude of address |
| LON | Longitude of address |
| HEALTHCARE_EXPENSES | Total lifetime healthcare expenses |
| HEALTHCARE_COVERAGE | Total lifetime amount covered by insurance |

**Columns that are empty a lot:**
- `SUFFIX` — 99.0% empty (1,159 / 1,171) — most people don't have a name suffix
- `DEATHDATE` — 85.4% empty (1,000 / 1,171) — most simulated patients are still alive
- `MAIDEN` — 71.7% empty (840 / 1,171) — only applies to people who changed their name
- `ZIP` — 46.4% empty (543 / 1,171)
- `MARITAL` — 32.5% empty (380 / 1,171)
- `PASSPORT` — 23.3% empty (273 / 1,171)
- `PREFIX` — 20.8% empty (244 / 1,171)
- `DRIVERS` — 18.2% empty (213 / 1,171)

## encounters.csv

**Row count:** 53,346 (excluding header)

**Identifier column:** `Id` — a UUID, one row per encounter (a single visit/
interaction with the healthcare system).

**Column meanings:**

| Column | Meaning |
|---|---|
| Id | Unique encounter identifier (UUID) |
| START | Encounter start timestamp |
| STOP | Encounter end timestamp |
| PATIENT | Foreign key → `patients.csv.Id` |
| ORGANIZATION | Foreign key → the healthcare organization/facility |
| PROVIDER | Foreign key → the individual clinician |
| PAYER | Foreign key → the insurance payer |
| ENCOUNTERCLASS | Type of encounter (ambulatory, emergency, inpatient, wellness, etc.) |
| CODE | Standardized encounter code (SNOMED) |
| DESCRIPTION | Human-readable description of the encounter |
| BASE_ENCOUNTER_COST | Base cost of the encounter |
| TOTAL_CLAIM_COST | Total cost claimed |
| PAYER_COVERAGE | Amount covered by the payer |
| REASONCODE | Diagnosis code that prompted the encounter |
| REASONDESCRIPTION | Human-readable reason for the encounter |

**Columns that are empty a lot:**
- `REASONCODE` — 74.2% empty (39,569 / 53,346)
- `REASONDESCRIPTION` — 74.2% empty (39,569 / 53,346) — most encounters
  (routine checkups, wellness visits, etc.) aren't tied to a specific
  diagnosis/reason

**Column that points at patients.csv:**
`PATIENT` holds the patient's `Id` from `patients.csv` — this is the
foreign key joining encounters to patients (`encounters.PATIENT =
patients.Id`).

## observations.csv

**Row count:** 299,697 (excluding header)

**Identifier column:** none — this table has no dedicated `Id`/primary key
column. Each row is one observation/measurement, uniquely identified only
by the combination of `PATIENT`, `ENCOUNTER`, `CODE`, and `DATE`.

**Column meanings:**

| Column | Meaning |
|---|---|
| DATE | Timestamp the observation was recorded |
| PATIENT | Foreign key → `patients.csv.Id` |
| ENCOUNTER | Foreign key → `encounters.csv.Id` (the visit during which this was recorded) |
| CODE | Standardized observation code (LOINC) |
| DESCRIPTION | Human-readable name of the observation (e.g. "Body Weight") |
| VALUE | The recorded value |
| UNITS | Unit of measurement for VALUE (e.g. kg, mmHg) |
| TYPE | Data type of VALUE (numeric, text, etc.) |

**Columns that are empty a lot:**
- `ENCOUNTER` — 10.1% empty (30,363 / 299,697) — some observations aren't
  tied to a specific encounter
- `UNITS` — 4.2% empty (12,719 / 299,697) — non-numeric observations
  (text results, survey responses) have no unit

## Cross-file key

`encounters.csv.PATIENT` → `patients.csv.Id` is the join column linking
encounters to the patient they belong to. (Similarly,
`observations.csv.PATIENT` → `patients.csv.Id` and
`observations.csv.ENCOUNTER` → `encounters.csv.Id`.)
