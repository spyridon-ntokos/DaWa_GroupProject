-- Load Dataset 2 into a MySQL Database

DROP DATABASE IF EXISTS PoliceFatalities;
CREATE DATABASE PoliceFatalities;

USE PoliceFatalities;

-- Create tables for the csv files

DROP TABLE IF EXISTS PoliceFatalities;
CREATE TABLE PoliceFatalities (
	uid INTEGER,
	name VARCHAR(50),
	age INT,
	gender VARCHAR(50),
	race VARCHAR(50),
	date DATE,
	city  VARCHAR(50),
	state VARCHAR(50),
	manner_of_death VARCHAR(50), 
	armed VARCHAR(50),
	mental_illness VARCHAR(50),
	flee VARCHAR(50),
	PRIMARY KEY (uid)
);

DROP TABLE IF EXISTS SatePopulation;
CREATE TABLE SatePopulation (
	stateCode VARCHAR(50),
	state VARCHAR(50),
	popEst VARCHAR(50),
	PRIMARY KEY (stateCode)
);

-- Load the data from the csv files into the tables(Change the file path to the path of your files)
LOAD DATA LOCAL INFILE 'E:/DAWA/Lab Project/Datasets/Dataset 2/Police Fatalities.csv' 
INTO TABLE PoliceFatalities 
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(uid, name, age, gender, race, @date, city, state, manner_of_death, armed, mental_illness, flee)
SET date = STR_TO_DATE( @date, '%m/%d/%Y');

LOAD DATA LOCAL INFILE 'E:/DAWA/Lab Project/Datasets/Dataset 2/censusStatePopulations2014.csv' 
INTO TABLE SatePopulation 
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r'
IGNORE 1 ROWS ;

