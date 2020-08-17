USE US_Police_Fatalities_DWH_CDWH;

-- Creation and setting ot table MentalIllness
DROP TABLE IF EXISTS MentalIllness;
CREATE TABLE MentalIllness ( 
    idMentalIllness INTEGER AUTO_INCREMENT,
    MIVal VARCHAR( 5 ) NOT NULL,
	PRIMARY KEY (  idMentalIllness )
 ) ;

INSERT INTO MentalIllness (MIVal)
VALUES 
		('TRUE'),
		('FALSE');