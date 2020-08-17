-- Populate the table State

USE US_Police_Fatalities_Stage_Clean;

TRUNCATE TABLE State;
INSERT INTO State (SCode, SName) 
SELECT substring(stateCode, 2), UPPER(state)
FROM PoliceFatalities.SatePopulation
WHERE state IS NOT NULL
ORDER BY state;