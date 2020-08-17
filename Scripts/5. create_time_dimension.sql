USE US_Police_Fatalities_DWH_CDWH;

DROP PROCEDURE IF EXISTS buildCalendar;
DELIMITER $$
CREATE PROCEDURE buildCalendar(pi_startDATUM DATE, pi_endDATUM DATE)
BEGIN
  DECLARE v_idTAG,  v_idMONAT, v_idJAHR INT DEFAULT 0;
  DECLARE  v_oldMONAT,  v_oldJAHR INT DEFAULT -1;
  DECLARE  v_curMONAT, v_curJAHR INT;
  DECLARE v_curDATUM DATE;
  SET v_curDATUM = pi_startDATUM;
  -- generate calendar entries; year first
  WHILE v_curDATUM <= pi_endDATUM DO
    SET v_curJAHR = YEAR(v_curDATUM);
    IF v_curJAHR <> v_oldJAHR THEN
      SET v_idJAHR = v_idJAHR + 1;
      SET v_oldJAHR = v_curJAHR;
      INSERT INTO TYear VALUES (v_idJAHR, v_curJAHR);
    END IF;
    -- then months
    SET v_curMONAT = MONTH(v_curDATUM);
    IF v_curMONAT <> v_oldMONAT THEN
      SET v_idMONAT = v_idMONAT + 1;
      SET v_oldMONAT = v_curMONAT;
      INSERT INTO TMonth VALUES (v_idMONAT, v_idJAHR, v_curMONAT, MONTHNAME(v_curDATUM));
    END IF;
    -- finally days
    SET v_idTAG = v_idTAG + 1;
    INSERT INTO TDay VALUES (
      v_idTAG, v_idMONAT,  v_curDATUM);
    SET v_curDATUM = DATE_ADD(v_curDATUM, INTERVAL 1 DAY);
  END WHILE;
--  SELECT 'Eingefügt wurden' AS Text, v_idJAHR AS Jahre, v_idMONAT AS Monate,
--    v_idWOCHE AS Wochen, v_idTAG AS Tage;
END
$$
DELIMITER ;

-- Time section

DROP TABLE IF EXISTS TDay;
CREATE TABLE TDay (
  idDAY INTEGER NOT NULL AUTO_INCREMENT,
  idMONTH INTEGER NOT NULL,
  DDateVal DATE NULL,
  PRIMARY KEY(idDAY)
);

DROP TABLE IF EXISTS TMonth;
CREATE TABLE TMonth (
  idMONTH INTEGER NOT NULL AUTO_INCREMENT,
  idYEAR INTEGER NOT NULL,
  MNumVal INTEGER NULL,
  MNameVal VARCHAR(20) NULL,
  PRIMARY KEY(idMONTH)
);


DROP TABLE IF EXISTS TYear;
CREATE TABLE TYear (
  idYEAR INTEGER NOT NULL AUTO_INCREMENT,
  YNumVal INT(4) NULL,
  PRIMARY KEY(idYEAR)
);

-- *+*+* Time Hierarchy *+*+*

TRUNCATE TABLE TDay;
TRUNCATE TABLE TMonth;
TRUNCATE TABLE TYear;

CALL buildCalendar('2000-01-01','2017-12-31');

-- FKs for Time hierarchy 
  
ALTER TABLE TDay ADD
  FOREIGN KEY FK_TM_DAY_MNTH (idMONTH) REFERENCES TMonth(idMONTH);
  
  
ALTER TABLE TMonth ADD
  FOREIGN KEY FK_TM_MNTH_QRT (idYEAR) REFERENCES TYear(idYEAR);
  

-- useful index, especially for generating the SALES table
ALTER TABLE TDay ADD UNIQUE KEY IX_DAY_Date (DDateVal);
  
DROP PROCEDURE buildCalendar;
