-- Scripts for Assigning Class Skills, Spells, Weapons, Armor, and Equipment
-- DATA MAPPING SCRIPTS BELOW
-- -----------------------------------------------

DROP PROCEDURE IF EXISTS assign_weapon_class;
DELIMITER //
CREATE PROCEDURE assign_weapon_class
(
	class_name_param VARCHAR(64),
    weapon_name_param VARCHAR(64),
    quantity_param INT,
    ranged_melee ENUM('ranged','melee')
)
/**
 * Procedure to assign weapon to a class
 * User Input: Class Name, Weapon Name, Weapon Quantity, Range/Melee
 */
BEGIN
	DECLARE sql_error INT DEFAULT FALSE;
    
	DECLARE c_id INT;
    DECLARE class_prof ENUM('simple','martial','exotic');
    DECLARE w_type ENUM('simple','martial','exotic');
    DECLARE w_id INT;
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    SET sql_error = TRUE;
    
    SELECT equipment_id INTO w_id
    FROM equipment
    WHERE equipment_name = weapon_name_param;
    
    SELECT class_id into c_id
    FROM class
    WHERE class_name = class_name_param;
    
    IF ranged_melee = 'ranged' THEN
		SELECT weapon_type INTO w_type
		FROM ranged_weapons
		WHERE w_id = equipment_id;
	ELSE
		SELECT weapon_type INTO w_type
		FROM melee_weapons
		WHERE w_id = equipment_id;
	END IF;
    
	SELECT weapon_proficiency INTO class_prof
	FROM class
    WHERE class_id = c_id;
    
    IF sql_error = FALSE THEN
		CASE
			WHEN class_prof = 'simple' THEN
				IF w_type = 'simple' THEN
					INSERT INTO class_equipment_loadout
					VALUES(c_id,w_id,quantity_param);
					SELECT('Weapon assignment successful') as Message;
				ELSE 
					SELECT('Weapon assignment failed due to proficiency conflict') as Message;
				END IF;
			WHEN class_prof = 'martial' THEN
				IF w_type = 'exotic' THEN
					SELECT 'Weapon assignment failed due to proficiency conflict' as Message;
				ELSE
					INSERT INTO class_equipment_loadout
					VALUES(c_id,w_id,quantity_param);
					SELECT('Weapon assignment successful') as Message;
				END IF;
			WHEN class_prof = 'exotic' THEN
				INSERT INTO class_equipment_loadout
				VALUES(c_id,w_id,quantity_param);
				SELECT('Weapon assignment successful') as Message;
		END CASE;
	ELSE
		SELECT 'Database error on weapon assignment' as Message;
	END IF;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS assign_armor_class;

DELIMITER //
CREATE PROCEDURE assign_armor_class
(
	class_name_param VARCHAR(64),
    armor_name_param VARCHAR(64),
    quantity_param INT
)
/**
 * Procedure to assign armor to a class
 * User Input: Class Name, Armor Name, Armor Quantity
 */
BEGIN
	DECLARE sql_error INT DEFAULT FALSE;
    
	DECLARE a_id INT;
    DECLARE class_prof ENUM('light','medium','heavy');
    DECLARE a_type ENUM('light','medium','heavy');
    DECLARE c_id INT;
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    SET sql_error = TRUE;
    
    SELECT equipment_id INTO a_id
    FROM equipment
    WHERE equipment_name = armor_name_param;
    
    SELECT class_id into c_id
    FROM class
    WHERE class_name = class_name_param;
    
    SELECT armor_proficiency INTO class_prof
	FROM class
    WHERE class_id = c_id;
    
    SELECT armor_type INTO a_type
    FROM armor
    WHERE a_id = equipment_id;
    
    IF sql_error = FALSE THEN
		CASE
			WHEN class_prof = 'light' THEN
				IF a_type = 'light' THEN
					INSERT INTO class_equipment_loadout
					VALUES(c_id,a_id,quantity_param);
					SELECT('Armor assignment successful') as Message;
				ELSE 
					SELECT('Armor assignment failed due to proficiency conflict') as Message;
				END IF;
			WHEN class_prof = 'medium' THEN
				IF a_type = 'heavy' THEN
					SELECT 'Armor assignment failed due to proficiency conflict' as Message;
				ELSE
					INSERT INTO class_equipment_loadout
					VALUES(c_id,a_id,quantity_param);
					SELECT('Armor assignment successful') as Message;
				END IF;
			WHEN class_prof = 'heavy' THEN
				INSERT INTO class_equipment_loadout
				VALUES(c_id,a_id,quantity_param);
				SELECT('Armor assignment successful') as Message;
		END CASE;
	ELSE
		SELECT 'Database error on armor assignment' as Message;
	END IF;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS assign_misc_equipment_class;
DELIMITER //
CREATE PROCEDURE assign_misc_equipment_class
(
	class_name_param VARCHAR(64),
    equipment_name_param VARCHAR(64),
    quantity_param INT
)
/**
 * Procedure to assign weapon to a class
 * User Input: Class Name, Weapon Name, Weapon Quantity, Range/Melee
 */
BEGIN
	DECLARE sql_error INT DEFAULT FALSE;
    
	DECLARE c_id INT;
    DECLARE e_id INT;
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    SET sql_error = TRUE;
    
    SELECT equipment_id INTO e_id
    FROM equipment
    WHERE equipment_name = equipment_name_param;
    
    SELECT class_id into c_id
    FROM class
    WHERE class_name = class_name_param;
    
    IF sql_error = FALSE THEN
		INSERT INTO class_equipment_loadout
		VALUES(c_id,e_id,quantity_param);
		SELECT('Equipment assignment successful') as Message;
	ELSE 
		SELECT('Equipment assignment failed') as Message;
	END IF;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS assign_spells_class;
DELIMITER //
CREATE PROCEDURE assign_spells_class
(
	class_name_param VARCHAR(64),
    spell_name_param VARCHAR(64),
    level_param INT
)
/**
 * Procedure to assign spell to a class
 * User Input: Class Name, Spell Name, Spell Level
 */
BEGIN
	DECLARE sql_error INT DEFAULT FALSE;
    
	DECLARE c_id INT;
    DECLARE s_id INT;
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    SET sql_error = TRUE;
    
    SELECT spell_id INTO s_id
    FROM spells
    WHERE spell_name = spell_name_param;
    
    SELECT class_id into c_id
    FROM class
    WHERE class_name = class_name_param;
    
    IF sql_error = FALSE THEN
		INSERT INTO class_spells
		VALUES(c_id,s_id,level_param);
		SELECT('Spell assignment successful') as Message;
	ELSE 
		SELECT('Spell assignment failed') as Message;
	END IF;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS assign_skills_class;
DELIMITER //
CREATE PROCEDURE assign_skills_class
(
	class_name_param VARCHAR(64),
    skill_name_param VARCHAR(64),
    level_param INT
)
/**
 * Procedure to assign skill to a class
 * User Input: Class Name, Skill Name, Skill Level
 */
BEGIN
	DECLARE sql_error INT DEFAULT FALSE;
    
	DECLARE c_id INT;
    DECLARE s_id INT;
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    SET sql_error = TRUE;
    
    SELECT skill_id INTO s_id
    FROM skills
    WHERE skill_name = skill_name_param;
    
    SELECT class_id into c_id
    FROM class
    WHERE class_name = class_name_param;
    
    IF sql_error = FALSE THEN
		INSERT INTO class_skills
		VALUES(c_id,s_id,level_param);
		SELECT('Skill assignment successful') as Message;
	ELSE 
		SELECT('Skill assignment failed') as Message;
	END IF;
END //
DELIMITER ;