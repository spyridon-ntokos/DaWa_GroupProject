USE US_Police_Fatalities_DWH_CDWH;

-- Create and set up of table Fatalities
DROP TABLE IF EXISTS Fatalities;
CREATE TABLE Fatalities ( 
    idFatality INTEGER AUTO_INCREMENT,
    idDay INTEGER NOT NULL,
	idCity INTEGER NOT NULL,
	idAge INTEGER NOT NULL,
	idWeapon INTEGER NOT NULL,
	idRace INTEGER NOT NULL,
	idMentalIllness INTEGER NOT NULL,
	idGender INTEGER NOT NULL,
	NumberOfShootings INTEGER NOT NULL,
	PRIMARY KEY ( idFatality ),
	FOREIGN KEY (idDay) REFERENCES TDay(idDay),
	FOREIGN KEY (idCity) REFERENCES City(idCity),
	FOREIGN KEY (idAge) REFERENCES Age(idAge),
	FOREIGN KEY (idWeapon) REFERENCES Weapon(idWeapon),
	FOREIGN KEY (idRace) REFERENCES Race(idRace),
	FOREIGN KEY (idMentalIllness) REFERENCES MentalIllness(idMentalIllness),
	FOREIGN KEY (idGender) REFERENCES Gender(idGender)
 );
 
 -- Create temporary table
DROP TABLE IF EXISTS Temp_Fatalities;

CREATE TEMPORARY TABLE Temp_Fatalities ( 
    idDay INTEGER NOT NULL,
	idCity INTEGER NOT NULL,
	idAge INTEGER NOT NULL,
	idWeapon INTEGER NOT NULL,
	idRace INTEGER NOT NULL,
	idMentalIllness INTEGER NOT NULL,
	idGender INTEGER NOT NULL
 );

-- Populate temporary table with data
INSERT INTO Temp_Fatalities (idDay, idCity, idAge, idWeapon, idRace, idMentalIllness, idGender)
SELECT d.idDAY, c.idCity, a.idAge, w.idWeapon, r.idRace, m.idMentalIllness, g.idGender
FROM US_Police_Fatalities_Stage_Clean.Fatality f
JOIN TDay d ON d.DDateVal = f.FDate
JOIN City c ON c.CName = f.FCity AND c.idState = f.idState
JOIN Age a ON a.idAge = f.FAge
JOIN Weapon w ON w.WName = f.FWeapon
JOIN Race r ON r.RName = f.FRace
JOIN MentalIllness m ON m.MIVal = f.FMentalIllness
JOIN Gender g ON g.GName = f.FGender;


-- Insert data into fatalities table grouped by the same case based on IDs and total count of the same cases
INSERT INTO Fatalities (idDay, idCity, idAge, idWeapon, idRace, idMentalIllness, idGender, NumberOfShootings)
SELECT idDay, idCity, idAge, idWeapon, idRace, idMentalIllness, idGender, COUNT(*) AS NumberOfShootings 
FROM Temp_Fatalities
GROUP BY idDay, idCity, idAge, idWeapon, idRace, idMentalIllness, idGender ORDER BY NumberOfShootings;

-- Delete temporary table
DROP TABLE Temp_Fatalities;