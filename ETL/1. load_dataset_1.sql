-- Load Dataset 1 into a MySQL Database

DROP DATABASE IF EXISTS PoliceKillingsUS;
CREATE DATABASE PoliceKillingsUS;

USE PoliceKillingsUS;

-- Create tables for the csv files

DROP TABLE IF EXISTS PoliceKillingsUS;
CREATE TABLE PoliceKillingsUS (
	id INTEGER,
	name VARCHAR(50),
	date DATE,
	manner_of_death VARCHAR(50),
	armed  VARCHAR(50),
	age INT,
	gender VARCHAR(50), 
	race VARCHAR(50),
	city VARCHAR(50),
	state VARCHAR(50),
	signs_of_mental_illness VARCHAR(50),
	thread_level VARCHAR(50),
	flee VARCHAR(50),
	body_camera VARCHAR(50),
	PRIMARY KEY (id)
);

DROP TABLE IF EXISTS MedianHouseholdIncome;
CREATE TABLE MedianHouseholdIncome (
	geographic_area VARCHAR(50),
	city VARCHAR(50),
	median_income INTEGER,
	PRIMARY KEY (geographic_area, city)
);

DROP TABLE IF EXISTS PercentagePeopleBelowPovertyLevel;
CREATE TABLE PercentagePeopleBelowPovertyLevel (
	geographic_area VARCHAR(50),
	city VARCHAR(50),
	poverty_rate DOUBLE,
	PRIMARY KEY (geographic_area, city)
);

DROP TABLE IF EXISTS PercentOver25CompletedHighSchool;
CREATE TABLE PercentOver25CompletedHighSchool (
	geographic_area VARCHAR(50),
	city VARCHAR(50),
	percent_completed_hs DOUBLE,
	PRIMARY KEY (geographic_area, city)
);

DROP TABLE IF EXISTS ShareRaceByCity;
CREATE TABLE ShareRaceByCity (
	geographic_area VARCHAR(50),
	city VARCHAR(50),
	share_white DOUBLE,
	share_black DOUBLE,
	share_native_american DOUBLE,
	share_asian DOUBLE,
	share_hispanic DOUBLE,
	PRIMARY KEY (geographic_area, city)
);

-- Load the data from the csv files into the tables(Change the file path to the path of your files)
LOAD DATA LOCAL INFILE 'F:/DAWA-root/DAWA/Work/Project/Datasets/Dataset 1/PoliceKillingsUS.csv' 
INTO TABLE PoliceKillingsUS 
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r'
IGNORE 1 ROWS 
(id,name,@date,manner_of_death,armed,age,gender,race,city,state,signs_of_mental_illness,thread_level,flee,body_camera)
SET date = STR_TO_DATE( @date, '%d/%m/%y');

LOAD DATA LOCAL INFILE 'F:/DAWA-root/DAWA/Work/Project/Datasets/Dataset 1/MedianHouseholdIncome2015.csv' 
INTO TABLE MedianHouseholdIncome 
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r'
IGNORE 1 ROWS ;

LOAD DATA INFILE 'F:/DAWA-root/DAWA/Work/Project/Datasets/Dataset 1/PercentagePeopleBelowPovertyLevel.csv' 
INTO TABLE PercentagePeopleBelowPovertyLevel 
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r'
IGNORE 1 ROWS ;

LOAD DATA INFILE 'F:/DAWA-root/DAWA/Work/Project/Datasets/Dataset 1/PercentOver25CompletedHighSchool.csv' 
INTO TABLE PercentOver25CompletedHighSchool 
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r'
IGNORE 1 ROWS ;

LOAD DATA INFILE 'F:/DAWA-root/DAWA/Work/Project/Datasets/Dataset 1/ShareRaceByCity.csv' 
INTO TABLE ShareRaceByCity 
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r'
IGNORE 1 ROWS ;
