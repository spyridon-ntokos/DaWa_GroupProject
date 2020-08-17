-- Create the staging area 

DROP DATABASE IF EXISTS US_Police_Fatalities_Stage_Clean;
CREATE DATABASE US_Police_Fatalities_Stage_Clean;

USE US_Police_Fatalities_Stage_Clean;

CREATE TABLE Fatality ( 
    idFatality INTEGER AUTO_INCREMENT,
    FName VARCHAR( 50 ) NOT NULL,
    FDate DATE NOT NULL,
    FCity VARCHAR( 50 ) NOT NULL,
    idState INTEGER NOT NULL,
    FAge INTEGER NOT NULL,
    FWeapon VARCHAR( 50 ) NOT NULL,
    FRace VARCHAR( 50 ) NOT NULL,
    FMentalIllness VARCHAR( 5 ) NOT NULL,
    FGender VARCHAR( 7 ) NOT NULL,
	PRIMARY KEY ( idFatality )
 ) ;

CREATE TABLE State ( 
    idState INTEGER AUTO_INCREMENT,
    SCode VARCHAR( 2 ) NOT NULL,
    SName VARCHAR( 50 ) NOT NULL,
	PRIMARY KEY ( idState )
 ) ;

ALTER TABLE Fatality ADD FOREIGN KEY Fk_0 ( idState ) REFERENCES State( idState ) ON DELETE NO ACTION ON UPDATE NO ACTION;

