USE US_Police_Fatalities_DWH_CDWH;

-- Creation and setting ot table Gender
DROP TABLE IF EXISTS Gender;
CREATE TABLE Gender ( 
    idGender INTEGER AUTO_INCREMENT,
    GName VARCHAR( 20 ) NOT NULL,
	PRIMARY KEY ( idGender )
 ) ;

INSERT INTO Gender (GName)
VALUES 
		('MALE'),
		('FEMALE'),
		('UNKNOWN');
