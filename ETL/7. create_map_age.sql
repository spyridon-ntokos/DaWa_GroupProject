DROP DATABASE IF EXISTS US_Police_Fatalities_Stage_Map;
CREATE DATABASE US_Police_Fatalities_Stage_Map;

USE US_Police_Fatalities_Stage_Map;

CREATE TABLE MapAgeGroup ( 
    idAgeGroup INTEGER AUTO_INCREMENT,
    AGName VARCHAR(50),
	AGLowerBound INTEGER,
	AGUpperBound INTEGER,
	PRIMARY KEY ( idAgeGroup )
 ) ;

INSERT INTO MapAgeGroup(AGName, AGLowerBound, AGUpperBound) VALUES ('CHILDREN', 1, 12); 
INSERT INTO MapAgeGroup(AGName, AGLowerBound, AGUpperBound) VALUES ('TEENAGERS', 13, 17); 
INSERT INTO MapAgeGroup(AGName, AGLowerBound, AGUpperBound) VALUES ('ADULTS', 18, 64); 
INSERT INTO MapAgeGroup(AGName, AGLowerBound, AGUpperBound) VALUES ('ELDERLY', 65, 107); 
INSERT INTO MapAgeGroup(AGName, AGLowerBound, AGUpperBound) VALUES ('UNKNOWN', 0, 0); 