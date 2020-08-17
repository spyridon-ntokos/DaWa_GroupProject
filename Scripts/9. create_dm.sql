-- Creation of the datamart. Each table is created and inserted.

DROP DATABASE IF EXISTS US_Police_Fatalities_DWH_DM;
CREATE DATABASE US_Police_Fatalities_DWH_DM;
USE US_Police_Fatalities_DWH_DM;

-- Time table

DROP TABLE IF EXISTS TDay;
CREATE TABLE TDay (
  idDAY INTEGER NOT NULL AUTO_INCREMENT,
  DDateVal VARCHAR(20) NULL,
  MNumVal INTEGER NULL,
  MNameVal VARCHAR(20) NULL,
  YNumVal INTEGER NULL,
  PRIMARY KEY(idDAY)
);

INSERT INTO TDay (  
  SELECT t.idDAY, t.DDateVal,  m.MNumVal, m.MNameVal, y.YNumVal
  FROM US_Police_Fatalities_DWH_CDWH.TDAY t  JOIN US_Police_Fatalities_DWH_CDWH.TMONTH m
  ON t.idMONTH = m.idMONTH  JOIN US_Police_Fatalities_DWH_CDWH.TYEAR y
  ON m.idYEAR = y.idYEAR
);

-- Age table

DROP TABLE IF EXISTS Age;
CREATE TABLE Age ( 
    idAge INTEGER NOT NULL,
    AGName VARCHAR( 50 ) NOT NULL,
	PRIMARY KEY ( idAge )
 ) ;

INSERT INTO Age (
	SELECT a.idAge, ag.AGName
	FROM US_Police_Fatalities_DWH_CDWH.Age a JOIN US_Police_Fatalities_DWH_CDWH.AgeGroup ag
	ON a.idAgeGroup = ag.idAgeGroup
	);

-- Weapon table

DROP TABLE IF EXISTS Weapon;
CREATE TABLE Weapon (
	idWeapon INTEGER AUTO_INCREMENT,
	WName VARCHAR(50) NOT NULL,
	WCName VARCHAR(50) NOT NULL,
	PRIMARY KEY (idWeapon)
	);

INSERT INTO Weapon (
	SELECT w.idWeapon, w.WName, wc.WCName
	FROM US_Police_Fatalities_DWH_CDWH.Weapon w JOIN US_Police_Fatalities_DWH_CDWH.WeaponClass wc
	ON w.idClass = wc.idClass
	);

-- Gender table 

DROP TABLE IF EXISTS Gender;
CREATE TABLE Gender ( 
    idGender INTEGER AUTO_INCREMENT,
    GName VARCHAR( 20 ) NOT NULL,
	PRIMARY KEY ( idGender )
 ) ;

INSERT INTO Gender (
  SELECT * 
  FROM US_Police_Fatalities_DWH_CDWH.Gender
);

-- Race table

DROP TABLE IF EXISTS Race;
CREATE TABLE Race ( 
    idRace INTEGER AUTO_INCREMENT,
    RName VARCHAR( 20 ) NOT NULL,
	PRIMARY KEY ( idRace )
 ) ;

INSERT INTO Race (
  SELECT * 
  FROM US_Police_Fatalities_DWH_CDWH.Race
);

-- MetntalIllnes table

DROP TABLE IF EXISTS MentalIllness;
CREATE TABLE MentalIllness ( 
    idMentalIllness INTEGER AUTO_INCREMENT,
    MIVal VARCHAR( 5 ) NOT NULL,
	PRIMARY KEY (  idMentalIllness )
 ) ;

INSERT INTO MentalIllness (
  SELECT * 
  FROM US_Police_Fatalities_DWH_CDWH.MentalIllness
);
	

-- City Table

DROP TABLE IF EXISTS City;
CREATE TABLE City ( 
    idCity INTEGER NOT NULL AUTO_INCREMENT,
	SName VARCHAR( 50 ) NOT NULL,
    CName VARCHAR( 50 ) NOT NULL,
    CHighSchoolLevel DOUBLE NOT NULL,
    CPovertyLevel DOUBLE NOT NULL,
    CHouseholdIncome INTEGER NOT NULL,
    CShareWhite DOUBLE NOT NULL,
    CShareBlack DOUBLE NOT NULL,
    CShareNativeAmerican DOUBLE NOT NULL,
    CShareAsian DOUBLE NOT NULL,
    CShareHispanic DOUBLE NOT NULL,
	PRIMARY KEY ( idCity )
) ;

INSERT INTO City (
	SELECT c.idCity,  s.SName, c.CName, c.CHighSchoolLevel, c.CPovertyLevel, c.CHouseholdIncome,
	       c.CShareWhite, c.CShareBlack, c. CShareNativeAmerican, c.CShareAsian, c.CShareHispanic
	FROM   US_Police_Fatalities_DWH_CDWH.City c JOIN US_Police_Fatalities_DWH_CDWH.State s
	ON     c.idState = s.idState
);

-- Fatalities Table

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

INSERT INTO Fatalities (
  SELECT * 
  FROM US_Police_Fatalities_DWH_CDWH.Fatalities
);




-- Enable efficient analyses

ALTER TABLE TDAY ADD KEY IX_tMonth (MNumVal);
ALTER TABLE TDAY ADD KEY IX_tYear (YNumVal);



