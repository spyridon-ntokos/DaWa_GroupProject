USE US_Police_Fatalities_Stage_Map;

DROP TABLE IF EXISTS MapWeaponClass;
CREATE TABLE MapWeaponClass ENGINE=MEMORY AS
SELECT DISTINCT f.FWeapon AS WName, 
CASE
	WHEN f.FWeapon = 'KNIFE' THEN 'MELEE'
	WHEN f.FWeapon = 'GUN' THEN 'RANGED'
	WHEN f.FWeapon = 'UNARMED' THEN 'UNARMED'
	WHEN f.FWeapon = 'TOY WEAPON' THEN 'HARMLESS'
	WHEN f.FWeapon = 'NAIL GUN' THEN 'CONTACT WEAPON'
	WHEN f.FWeapon = 'VEHICLE' THEN 'VEHICLE'
	WHEN f.FWeapon = 'HATCHET' THEN 'MELEE'
	WHEN f.FWeapon = 'SWORD' THEN 'MELEE'
	WHEN f.FWeapon = 'BOX CUTTER' THEN 'MELEE'
	WHEN f.FWeapon = 'MACHETE' THEN 'MELEE'
	WHEN f.FWeapon = 'HAMMER' THEN 'MELEE'
	WHEN f.FWeapon = 'METAL OBJECT' THEN 'MELEE'
	WHEN f.FWeapon = 'SCREWDRIVER' THEN 'MELEE'
	WHEN f.FWeapon = 'LAWN MOWER BLADE' THEN 'CONTACT WEAPON'
	WHEN f.FWeapon = 'GUNS AND EXPLOSIVES' THEN 'EXPLOSIVES'
	WHEN f.FWeapon = 'CORDLESS DRILL' THEN 'CONTACT WEAPON'
	WHEN f.FWeapon = 'METAL POLE' THEN 'POLEARMS'
	WHEN f.FWeapon = 'TASER' THEN 'CONTACT WEAPON'
	WHEN f.FWeapon = 'METAL STICK' THEN 'POLEARMS'
	WHEN f.FWeapon = 'MEAT CLEAVER' THEN 'MELEE'
	WHEN f.FWeapon = 'METAL PIPE' THEN 'POLEARMS'
	WHEN f.FWeapon = 'STAPLER' THEN 'CONTACT WEAPON'
	WHEN f.FWeapon = 'BLUNT OBJECT' THEN 'CONTACT WEAPON'
	WHEN f.FWeapon = 'CROSSBOW' THEN 'RANGED'
	WHEN f.FWeapon = 'BEAN-BAG GUN' THEN 'RANGED'
	WHEN f.FWeapon = 'STRAIGHT EDGE RAZOR' THEN 'MELEE'
	WHEN f.FWeapon = 'GUN AND KNIFE' THEN 'COMBINATION'
	WHEN f.FWeapon = 'CHAIN SAW' THEN 'MELEE'
	WHEN f.FWeapon = 'PICK-AXE' THEN 'MELEE'
	WHEN f.FWeapon = 'FLASHLIGHT' THEN 'HARMLESS'
	WHEN f.FWeapon = 'SHOVEL' THEN 'MELEE'
	WHEN f.FWeapon = 'BASEBALL BAT' THEN 'MELEE'
	WHEN f.FWeapon = 'AXE' THEN 'MELEE'
	WHEN f.FWeapon = 'SPEAR' THEN 'POLEARMS'
	WHEN f.FWeapon = 'PITCHFORK' THEN 'MELEE'
	WHEN f.FWeapon = 'HATCHET AND GUN' THEN 'COMBINATION'
	WHEN f.FWeapon = 'UNKNOWN' THEN 'UNKNOWN'
	WHEN f.FWeapon = 'ROCK' THEN 'CONTACT WEAPON'
	WHEN f.FWeapon = 'PIECE OF WOOD' THEN 'CONTACT WEAPON'
	WHEN f.FWeapon = 'BAYONET' THEN 'MELEE'
	WHEN f.FWeapon = 'PIPE' THEN 'POLEARMS'
	WHEN f.FWeapon = 'GLASS SHARD' THEN 'CONTACT WEAPON'
	WHEN f.FWeapon = 'MOTORCYCLE' THEN 'VEHICLE'
	WHEN f.FWeapon = 'BRICK' THEN 'CONTACT WEAPON'
	WHEN f.FWeapon = 'METAL RAKE' THEN 'POLEARMS'
	WHEN f.FWeapon = 'BATON' THEN 'MELEE'
	WHEN f.FWeapon = 'CROWBAR' THEN 'MELEE'
	WHEN f.FWeapon = 'OAR' THEN 'POLEARMS'
	WHEN f.FWeapon = 'MACHETE AND GUN' THEN 'COMBINATION'
	WHEN f.FWeapon = 'TIRE IRON' THEN 'MELEE'
	WHEN f.FWeapon = 'SCISSORS' THEN 'MELEE'
	WHEN f.FWeapon = 'AIR CONDITIONER' THEN 'MELEE'
	WHEN f.FWeapon = 'POLE AND KNIFE' THEN 'COMBINATION'
	WHEN f.FWeapon = 'BEER BOTTLE' THEN 'CONTACT WEAPON'
	WHEN f.FWeapon = 'SHARP OBJECT' THEN 'MELEE'
	WHEN f.FWeapon = 'BASEBALL BAT AND BOTTLE' THEN 'COMBINATION'
	WHEN f.FWeapon = 'FIREWORKS' THEN 'EXPLOSIVES'
	WHEN f.FWeapon = 'PEN' THEN 'CONTACT WEAPON'
	WHEN f.FWeapon = 'FLAGPOLE' THEN 'POLEARMS'
	WHEN f.FWeapon = 'METAL HAND TOOL' THEN 'CONTACT WEAPON'
	WHEN f.FWeapon = 'CARJACK' THEN 'VEHICLE'
	WHEN f.FWeapon = 'BASEBALL BAT AND FIREPLACE POKER' THEN 'COMBINATION'
	WHEN f.FWeapon = 'HAND TORCH' THEN 'CONTACT WEAPON'
	WHEN f.FWeapon = 'GARDEN TOOL' THEN 'CONTACT WEAPON'
	WHEN f.FWeapon = 'POLE' THEN 'POLEARMS'
	ELSE 'UNKNOWN'
END AS WClass
FROM US_Police_Fatalities_Stage_Clean.Fatality f;