USE US_Police_Fatalities_DWH_CDWH;

DROP TABLE IF EXISTS Weapon;
CREATE TABLE Weapon (
	idWeapon INTEGER AUTO_INCREMENT,
	idClass INTEGER NOT NULL,
	WName VARCHAR(50) NOT NULL,
	PRIMARY KEY (idWeapon)
);

DROP TABLE IF EXISTS WeaponClass;
CREATE TABLE WeaponClass (
	idClass INTEGER AUTO_INCREMENT,
	WCName VARCHAR(50) NOT NULL,
	PRIMARY KEY (idClass)
);

ALTER TABLE Weapon
ADD FOREIGN KEY Fk_0 ( idClass ) REFERENCES WeaponClass ( idClass ) 
ON DELETE NO ACTION 
ON UPDATE NO ACTION;

TRUNCATE TABLE WeaponClass;
INSERT INTO WeaponClass (WCName)
SELECT DISTINCT WClass
FROM US_Police_Fatalities_Stage_Map.MapWeaponClass;

TRUNCATE TABLE Weapon;
INSERT INTO Weapon (WName, idClass) 
SELECT DISTINCT WName, idClass
FROM US_Police_Fatalities_Stage_Map.MapWeaponClass
JOIN WeaponClass wc ON WClass = wc.WCName;