USE US_Police_Fatalities_DWH_CDWH;

-- Creation and setting ot table Race
DROP TABLE IF EXISTS Race;
CREATE TABLE Race ( 
    idRace INTEGER AUTO_INCREMENT,
    RName VARCHAR( 20 ) NOT NULL,
	PRIMARY KEY ( idRace )
 ) ;

INSERT INTO Race (RName)
VALUES 
		('WHITE'),
		('BLACK'),
		('HISPANIC'),
		('NATIVE'),
		('ASIAN'),
		('OTHER'),
		('UNKNOWN');
