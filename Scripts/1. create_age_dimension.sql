DROP DATABASE IF EXISTS US_Police_Fatalities_DWH_CDWH;
CREATE DATABASE US_Police_Fatalities_DWH_CDWH;

USE US_Police_Fatalities_DWH_CDWH;

DROP TABLE IF EXISTS Age;
CREATE TABLE Age ( 
    idAge INTEGER NOT NULL,
    idAgeGroup INTEGER NOT NULL,
	PRIMARY KEY ( idAge )
 ) ;

DROP TABLE IF EXISTS AgeGroup;
CREATE TABLE AgeGroup ( 
    idAgeGroup INTEGER NOT NULL,
    AGName VARCHAR( 50 ) NOT NULL,
	PRIMARY KEY ( idAgeGroup )
 ) ;

ALTER TABLE Age ADD FOREIGN KEY Fk_0 ( idAgeGroup ) REFERENCES AgeGroup( idAgeGroup ) ON DELETE NO ACTION ON UPDATE NO ACTION;

TRUNCATE TABLE AgeGroup;
INSERT INTO AgeGroup
SELECT idAgeGroup, AGName 
FROM US_Police_Fatalities_Stage_Map.MapAgeGroup;

TRUNCATE TABLE Age;
INSERT INTO Age
SELECT DISTINCT f.FAge, ag.idAgeGroup
FROM US_Police_Fatalities_Stage_Clean.Fatality f
JOIN US_Police_Fatalities_Stage_Map.MapAgeGroup ag ON f.FAge BETWEEN ag.AGLowerBound AND ag.AGUpperBound
ORDER BY f.FAge;

ALTER TABLE Age ADD KEY idx_Age ( idAgeGroup );