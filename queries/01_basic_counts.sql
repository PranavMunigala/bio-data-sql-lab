-- Basic sanity/exploration queries against the loaded tables (clinic.db).

-- Row counts per table
SELECT 'patients' AS table_name, COUNT(*) AS row_count FROM patients
UNION ALL
SELECT 'encounters', COUNT(*) FROM encounters
UNION ALL
SELECT 'observations', COUNT(*) FROM observations;

-- Patients by gender
SELECT GENDER, COUNT(*) AS n
FROM patients
GROUP BY GENDER;

-- Encounters by class
SELECT ENCOUNTERCLASS, COUNT(*) AS n
FROM encounters
GROUP BY ENCOUNTERCLASS
ORDER BY n DESC;
