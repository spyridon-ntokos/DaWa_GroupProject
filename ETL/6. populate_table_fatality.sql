-- Populate the table Fatality with the harmonized data

USE US_Police_Fatalities_Stage_Clean;

TRUNCATE TABLE Fatality;
INSERT INTO Fatality(FName, FDate, FCity, idState,  FAge, FWeapon, FRace, FMentalIllness, FGender)
SELECT * FROM TempFatality1 f1
UNION
SELECT * FROM TempFatality2 f2
ORDER BY FDate;

ALTER TABLE Fatality ADD KEY idx_State ( idState );

UPDATE Fatality
SET FCity = 'ALBUQUERQUE'
WHERE FCity = 'ALBUQUERUE';
