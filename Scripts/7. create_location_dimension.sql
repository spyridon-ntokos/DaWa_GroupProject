USE US_Police_Fatalities_DWH_CDWH;

SET SQL_SAFE_UPDATES = 0;

-- Create table City
DROP TABLE IF EXISTS City;
CREATE TABLE City ( 
    idCity INTEGER NOT NULL AUTO_INCREMENT,
    idState INTEGER NOT NULL,
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
);

-- Create table State
DROP TABLE IF EXISTS State;
CREATE TABLE State ( 
    idState INTEGER NOT NULL,
    SCode VARCHAR( 2 ) NOT NULL,
    SName VARCHAR( 50 ) NOT NULL,
	PRIMARY KEY ( idState )
);

ALTER TABLE City ADD FOREIGN KEY Fk_0 ( idState ) REFERENCES State( idState ) 
ON DELETE NO ACTION 
ON UPDATE NO ACTION;


-- A function that returns the state code based on state ID
DELIMITER $$
DROP FUNCTION IF EXISTS get_state_code $$
CREATE FUNCTION get_state_code(
	stateId INTEGER
)
RETURNS VARCHAR( 2 )
BEGIN
	DECLARE stateCode VARCHAR( 2 );

	SELECT s.SCode
	FROM State s
	WHERE s.idState = stateId
	INTO stateCode;

	RETURN stateCode;
END $$
DELIMITER ;


-- A function that returns high school level in a specific city of a specific state
DELIMITER $$
DROP FUNCTION IF EXISTS get_high_school_level $$
CREATE FUNCTION get_high_school_level(
	stateId INTEGER,
	cityName VARCHAR( 50 )
)
RETURNS DOUBLE
BEGIN
	DECLARE highSchoolLevel DOUBLE DEFAULT 0;
	DECLARE stateCode VARCHAR( 2 );

	SET stateCode = get_state_code(stateId);

	SELECT percent_completed_hs
	FROM PoliceKillingsUS.PercentOver25CompletedHighSchool
	WHERE geographic_area = stateCode AND 
		(LOWER(city) = LOWER(cityName) OR 
			city LIKE CONCAT(cityName, ' %'))
	LIMIT 1
	INTO highSchoolLevel;

	RETURN highSchoolLevel;
END$$
DELIMITER ;


-- A function that returns poverty level in a specific city of a specific state
DELIMITER $$
DROP FUNCTION IF EXISTS get_poverty_level $$
CREATE FUNCTION get_poverty_level(
	stateId INTEGER,
	cityName VARCHAR( 50 )
)
RETURNS DOUBLE
BEGIN
	DECLARE povertyLevel DOUBLE DEFAULT 0;
	DECLARE stateCode VARCHAR( 2 );

	SET stateCode = get_state_code(stateId);

	SELECT poverty_rate
	FROM PoliceKillingsUS.PercentagePeopleBelowPovertyLevel
	WHERE geographic_area = stateCode AND
		(LOWER(city) = LOWER(cityName) OR 
			city LIKE CONCAT(cityName, ' %'))
	LIMIT 1
	INTO povertyLevel;

	RETURN povertyLevel;
END $$
DELIMITER ;


-- A function that returns median household income in a specific city of a specific state
DELIMITER $$
DROP FUNCTION IF EXISTS get_household_income $$
CREATE FUNCTION get_household_income(
	stateId INTEGER,
	cityName VARCHAR( 50 )
)
RETURNS INTEGER
BEGIN
	DECLARE householdIncome DOUBLE DEFAULT 0;
	DECLARE stateCode VARCHAR( 2 );

	SET stateCode = get_state_code(stateId);

	SELECT median_income
	FROM PoliceKillingsUS.MedianHouseholdIncome
	WHERE geographic_area = stateCode AND
		(LOWER(city) = LOWER(cityName) OR 
			city LIKE CONCAT(cityName, ' %'))
	LIMIT 1
	INTO householdIncome;

	RETURN householdIncome;
END $$
DELIMITER ;


-- A function that returns share of white people in a specific city of a specific state
DELIMITER $$
DROP FUNCTION IF EXISTS get_share_white $$
CREATE FUNCTION get_share_white(
	stateId INTEGER,
	cityName VARCHAR( 50 )
)
RETURNS DOUBLE
BEGIN
	DECLARE shareWhite DOUBLE DEFAULT 0;
	DECLARE stateCode VARCHAR( 2 );

	SET stateCode = get_state_code(stateId);

	SELECT share_white
	FROM PoliceKillingsUS.ShareRaceByCity
	WHERE geographic_area = stateCode AND
		(LOWER(city) = LOWER(cityName) OR 
			city LIKE CONCAT(cityName, ' %'))
	LIMIT 1
	INTO shareWhite;

	RETURN shareWhite;
END $$
DELIMITER ;


-- A function that returns share of black people in a specific city of a specific state
DELIMITER $$
DROP FUNCTION IF EXISTS get_share_black $$
CREATE FUNCTION get_share_black(
	stateId INTEGER,
	cityName VARCHAR( 50 )
)
RETURNS DOUBLE
BEGIN
	DECLARE shareBlack DOUBLE DEFAULT 0;
	DECLARE stateCode VARCHAR( 2 );

	SET stateCode = get_state_code(stateId);

	SELECT share_black
	FROM PoliceKillingsUS.ShareRaceByCity
	WHERE geographic_area = stateCode AND
		(LOWER(city) = LOWER(cityName) OR 
			city LIKE CONCAT(cityName, ' %'))
	LIMIT 1
	INTO shareBlack;

	RETURN shareBlack;
END $$
DELIMITER ;


-- A function that returns share of native americans in a specific city of a specific state
DELIMITER $$
DROP FUNCTION IF EXISTS get_share_native_american $$
CREATE FUNCTION get_share_native_american(
	stateId INTEGER,
	cityName VARCHAR( 50 )
)
RETURNS DOUBLE
BEGIN
	DECLARE shareNativeAmerican DOUBLE DEFAULT 0;
	DECLARE stateCode VARCHAR( 2 );

	SET stateCode = get_state_code(stateId);

	SELECT share_native_american
	FROM PoliceKillingsUS.ShareRaceByCity
	WHERE geographic_area = stateCode AND
		(LOWER(city) = LOWER(cityName) OR 
			city LIKE CONCAT(cityName, ' %'))
	LIMIT 1
	INTO shareNativeAmerican;

	RETURN shareNativeAmerican;
END $$
DELIMITER ;


-- A function that returns share of Asians in a specific city of a specific state
DELIMITER $$
DROP FUNCTION IF EXISTS get_share_asian $$
CREATE FUNCTION get_share_asian(
	stateId INTEGER,
	cityName VARCHAR( 50 )
)
RETURNS DOUBLE
BEGIN
	DECLARE shareAsian DOUBLE DEFAULT 0;
	DECLARE stateCode VARCHAR( 2 );

	SET stateCode = get_state_code(stateId);

	SELECT share_asian
	FROM PoliceKillingsUS.ShareRaceByCity
	WHERE geographic_area = stateCode AND
		(LOWER(city) = LOWER(cityName) OR 
			city LIKE CONCAT(cityName, ' %'))
	LIMIT 1
	INTO shareAsian;

	RETURN shareAsian;
END $$
DELIMITER ;


-- A function that returns share of hispanic people in a specific city of a specific state
DELIMITER $$
DROP FUNCTION IF EXISTS get_share_hispanic $$
CREATE FUNCTION get_share_hispanic(
	stateId INTEGER,
	cityName VARCHAR( 50 )
)
RETURNS DOUBLE
BEGIN
	DECLARE shareHispanic DOUBLE DEFAULT 0;
	DECLARE stateCode VARCHAR( 2 );

	SET stateCode = get_state_code(stateId);

	SELECT share_hispanic
	FROM PoliceKillingsUS.ShareRaceByCity
	WHERE geographic_area = stateCode AND
		(LOWER(city) = LOWER(cityName) OR 
			city LIKE CONCAT(cityName, ' %'))
	LIMIT 1
	INTO shareHispanic;

	RETURN shareHispanic;
END $$
DELIMITER ;


-- Populate table State
TRUNCATE TABLE State;
INSERT INTO State
SELECT idState, SCode, SName
FROM US_Police_Fatalities_Stage_Clean.State;


-- Populate table City
TRUNCATE TABLE City;
INSERT INTO City (idState, CName, CHighSchoolLevel, CPovertyLevel, CHouseholdIncome, CShareWhite, CShareBlack, CShareNativeAmerican, CShareAsian, CShareHispanic)
SELECT DISTINCT f.idState, f.FCity, 
	get_high_school_level(f.idState, f.FCity), 
	get_poverty_level(f.idState, f.FCity), 
	get_household_income(f.idState, f.FCity), 
	get_share_white(f.idState, f.FCity), 
	get_share_black(f.idState, f.FCity),
	get_share_native_american(f.idState, f.FCity),
	get_share_asian(f.idState, f.FCity),
	get_share_hispanic(f.idState, f.FCity)
FROM US_Police_Fatalities_Stage_Clean.Fatality f
ORDER BY f.FCity;

-- Remove duplicate cities with redundant 'city' part
DELETE
FROM City USING City, City c1
WHERE City.idCity != c1.idCity AND 
	City.idState = c1.idState AND
	City.CName LIKE CONCAT(c1.CName, ' city');

-- Remove duplicate village
DELETE
FROM City
WHERE CName = 'SANTA NELLA VILLAGE';
