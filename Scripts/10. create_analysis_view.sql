USE US_Police_Fatalities_DWH_DM;
DROP VIEW IF EXISTS VFatality;
CREATE VIEW VFatality AS
SELECT d.DDateVal AS Complete_Date, d.MNameVal AS `Month` , d.YNumVal AS `Year`, 
       c.SName AS `State`, c.CName AS City ,c.CHighSchoolLevel, 
       c.CPovertyLevel, c.CHouseholdIncome, c.CShareWhite, c.CShareBlack,
       c.CShareNativeAmerican, c.CShareAsian, c.CShareHispanic,   
       a.idAge AS Age, a.AGName AS Age_Group, w.WName AS Weapon, 
       w.WCName AS Weapon_Category, r.RName AS Race, m.MIVal AS MentalIllness, 
       g.GName AS Gender, f.NumberOfShootings

FROM   Fatalities f

JOIN   TDAY d ON d.idDAY = f.idDay
JOIN   City c ON c.idCity = f.idCity
JOIN   Age a ON a.idAge = f.idAge
JOIN   Weapon w ON w.idWeapon = f.idWeapon
JOIN   Race r ON  r.idRace = f.idRace
JOIN   MentalIllness m ON  m.idMentalIllness = f.idMentalIllness
JOIN   Gender g ON  g.idGender = f.idGender 

GROUP BY DDateVal, MNameVal, YNumVal, SName, CName,  AGName, WName,
					 WCName, RName, MIVal, Gname, NumberOfShootings
ORDER BY DDateVal

