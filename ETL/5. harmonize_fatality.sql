-- Harmonize the data from the two datasets

USE US_Police_Fatalities_Stage_Clean;

-- Harmonize data from Dataset 2

DROP TEMPORARY TABLE IF EXISTS TempFatality1;
CREATE TEMPORARY TABLE TempFatality1 ENGINE=MEMORY AS
SELECT UPPER(f.name) AS FName, f.date AS FDate, 
CASE
	WHEN f.city = '' THEN 'UNKNOWN'
	ELSE UPPER(f.city) 
END AS FCity,
s.idState, f.age AS FAge, 
CASE 
	WHEN f.armed = '' THEN 'UNKNOWN'
	WHEN f.armed = 'Tasered' THEN 'TASER'
	ELSE UPPER(f.armed)
END AS FWeapon,
CASE
	WHEN f.race = '' THEN 'UNKNOWN'
	ELSE UPPER(f.race)
END AS FRace,
f.mental_illness AS FMentalIllness,
CASE 
	WHEN f.gender = '' THEN 'UNKNOWN'
	ELSE UPPER(f.gender)
END AS FGender
FROM PoliceFatalities.PoliceFatalities f
JOIN State s ON f.state = s.SCode
GROUP BY FName, FDate, FCity, idState, FAge, FWeapon, FRace, FMentalIllness, FGender
ORDER BY f.date;

-- Harmonize data from Dataset 1

DROP TEMPORARY TABLE IF EXISTS TempFatality2;
CREATE TEMPORARY TABLE TempFatality2 ENGINE=MEMORY AS
SELECT UPPER(pk.name) AS FName, pk.date AS FDate, UPPER(pk.city) AS FCity,  s.idState, pk.age AS FAge, 
CASE 
	WHEN pk.armed = '' THEN 'UNKNOWN'
	WHEN pk.armed = 'undetermined' THEN 'UNKNOWN'
	WHEN pk.armed = 'ax' THEN 'AXE'
	ELSE UPPER(pk.armed)
END AS FWeapon,
CASE
	WHEN pk.race = '' THEN 'UNKNOWN'
	WHEN pk.race = 'A' THEN 'ASIAN'
	WHEN pk.race = 'B' THEN 'BLACK'
	WHEN pk.race = 'H' THEN 'HISPANIC'
	WHEN pk.race = 'N' THEN 'NATIVE'
	WHEN pk.race = 'O' THEN 'OTHER'
	WHEN pk.race = 'W' THEN 'WHITE'
END AS FRace,
pk.signs_of_mental_illness AS FMentalIllness,
CASE 
	WHEN pk.gender = 'F' THEN 'FEMALE'
	WHEN pk.gender = 'M' THEN 'MALE'
END AS FGender
FROM PoliceKillingsUS.PoliceKillingsUS pk
JOIN State s ON pk.state = s.SCode
GROUP BY FName, FDate, FCity, idState, FAge, FWeapon, FRace, FMentalIllness, FGender
ORDER BY pk.date;

-- Remove duplicate entries form TempFatality1

DELETE  f1 FROM TempFatality1 f1
WHERE f1.FName = 'ANGEL ALAN GLEASON' AND f1.FRace != 'HISPANIC' ;

UPDATE TempFatality1 f1
SET f1.FWeapon = 'GUN'
WHERE f1.FName = 'JOHN TOZZI' AND f1.FRace = 'WHITE';

DELETE  f1 FROM TempFatality1 f1
WHERE f1.FName = 'JOHN TOZZI' AND f1.FRace != 'WHITE' ;

DELETE  f1 FROM TempFatality1 f1
WHERE f1.FName = 'NILES LEO MESERVEY' AND f1.FMentalIllness = 'FALSE' ;

DROP TEMPORARY TABLE IF EXISTS TempDuplicateGroups;
CREATE TEMPORARY TABLE TempDuplicateGroups AS
SELECT  f1.FName, f1.FDate, f1.FCity, f1.idState FROM TempFatality1 f1
GROUP BY  f1.FName, f1.FDate, f1.FCity, f1.idState
HAVING COUNT(*) > 1;

DROP TEMPORARY TABLE IF EXISTS TempDuplicateEntries;
CREATE TEMPORARY TABLE TempDuplicateEntries AS
SELECT  f1.* FROM TempFatality1 f1
JOIN TempDuplicateGroups dg ON f1.FName = dg.FName 
AND f1.FDate = dg.FDate 
AND f1.FCity = dg.FCity
AND f1.idState = dg.idState;

DELETE f1 FROM TempFatality1 f1
JOIN TempDuplicateEntries fd ON f1.FName = fd.FName 
AND f1.FDate = fd.FDate 
AND f1.FCity = fd.FCity
AND f1.idState = fd.idState
WHERE f1.FRace = 'UNKNOWN' AND fd.FRace != 'UNKNOWN'
OR f1.FWeapon = 'UNKNOWN' AND fd.FWeapon != 'UNKNOWN'
OR f1.FAge = 0 AND fd.FAge != 0;

DELETE f1 FROM TempFatality1 f1
JOIN TempFatality2 f2 
WHERE  f2.FName = f1.FName AND
f2.FDate = f1. FDate AND
f2.FCity = f1.FCity AND
f2.idState = f1.idState;