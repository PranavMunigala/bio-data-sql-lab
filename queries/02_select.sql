-- Step 2 SELECT practice against the scratch load (clinic_raw.db).
-- Run: sqlite3 clinic_raw.db < queries/02_select.sql

-- Q1: How many patients?
SELECT COUNT(*) AS n_patients
FROM patients;


-- Q2: How many patients are female?
SELECT COUNT(*) FROM patients WHERE GENDER = 'F';

-- Q3: The 10 oldest patients
SELECT * FROM patients ORDER BY BIRTHDATE ASC LIMIT 10;

-- Q4: Count of encounters by ENCOUNTERCLASS
SELECT ENCOUNTERCLASS, COUNT(*) AS encounter_count FROM encounters GROUP BY ENCOUNTERCLASS;

-- Q5: Average claim cost by ENCOUNTERCLASS
SELECT ENCOUNTERCLASS, AVG(TOTAL_CLAIM_COST)
FROM encounters
GROUP BY ENCOUNTERCLASS;

-- Q6: The 5 most common conditions
SELECT DESCRIPTION, COUNT(*) FROM conditions GROUP BY DESCRIPTION ORDER BY COUNT(*) DESC LIMIT 5;

-- Q7: How many distinct observation descriptions?
SELECT COUNT(DISTINCT DESCRIPTION) FROM observations;

-- Q8: Total healthcare expenses across all patients
SELECT SUM(HEALTHCARE_EXPENSES) FROM patients;

-- Q9: How many patients have a DEATHDATE? (empty CSV cells load as '' not NULL)
SELECT COUNT(*) FROM patients WHERE DEATHDATE != '';

-- Q10: Min / max / avg Body Height (VALUE is text, so CAST it to a number)
SELECT MIN(CAST(VALUE AS REAL)), MAX(CAST(VALUE AS REAL)), AVG(CAST(VALUE AS REAL))
FROM observations WHERE DESCRIPTION = 'Body Height';
