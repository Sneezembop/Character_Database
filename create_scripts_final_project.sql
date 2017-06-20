USE mydb;

DROP PROCEDURE IF EXISTS create_armor;
DELIMITER //
CREATE PROCEDURE create_armor
(
	a_name VARCHAR(64),
    a_weight INT,
    a_description VARCHAR(140),
    a_rating INT,
    a_type ENUM('light','medium','heavy')
)
/**
 * Procedure to add new armor to database. All data user generated except for Equipment_ID.
 * Takes as input the armor's name, weight, description, armor rating, and armor type.
 */
BEGIN
	DECLARE sql_error INT DEFAULT FALSE;
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    SET sql_error = TRUE;
    
	START TRANSACTION;
    
		INSERT INTO equipment(equipment_name,equipment_weight,equipment_description)
        VALUES (a_name,a_weight, a_description);
        
        INSERT INTO armor
        VALUES ((SELECT equipment_id FROM equipment WHERE a_name = equipment_name),a_rating,a_type);
        
        IF sql_error = FALSE THEN
			COMMIT;
            SELECT CONCAT('Armor, ',a_name, ', successfully added to game.') as Message;
		ELSE
			ROLLBACK;
            SELECT 'Armor not successfully added to game' as Message;
		END IF;
END //
DELIMITER ;
 
DROP PROCEDURE IF EXISTS create_melee_weapon;

DELIMITER //
CREATE PROCEDURE create_melee_weapon
(
	mw_name VARCHAR(64),
    mw_weight INT, 
    mw_hit INT, 
    mw_damage INT, 
	mw_type ENUM('simple','martial','exotic'), 
    mw_reach INT, 
    mw_attribute ENUM('strength', 'dexterity'),
    mw_desc VARCHAR(140)
)
/**
 * Transaction to add new melee weapon to database.  All data user generated except for Equipment_ID.
 * Takes in the melee weapon name, weight, hit modifier, damage modifier, type of weapon, reach, attribute modifier, and description.
 */
BEGIN
	DECLARE sql_error INT DEFAULT FALSE;
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    SET sql_error = TRUE;
    
    START TRANSACTION;
		
        INSERT INTO equipment(equipment_name,equipment_weight,equipment_description)
        VALUES (mw_name,mw_weight,mw_desc);
        
        INSERT INTO melee_weapons
        VALUES ((SELECT equipment_id FROM equipment WHERE mw_name = equipment_name), mw_hit,mw_damage,mw_type,mw_reach,mw_attribute);
        
        IF sql_error = FALSE THEN
			COMMIT;
            SELECT CONCAT('Melee weapon, ',mw_name, ', successfully added to game.') as Message;
		ELSE
			ROLLBACK;
            SELECT 'Melee Weapon not successfully added to game' as Message;
		END IF;
END //
DELIMITER ;
 
DROP PROCEDURE IF EXISTS create_ranged_weapon;

DELIMITER //
CREATE PROCEDURE create_ranged_weapon
(
	rw_name VARCHAR(64),
    rw_weight INT, rw_hit INT,
    rw_damage INT, 
    rw_type ENUM('simple','martial','exotic'), 
    rw_distance INT, rw_attribute ENUM('strength', 'dexterity'),
    rw_description VARCHAR(140), rw_projectile VARCHAR(64)
)
/**
 * Transaction to add new ranged weapon to database.
 * User Input: ranged weapon name, weight, hit modifier, damage modifier, type of weapon, reach, attribute modifier, description, and projectile name.
 */
BEGIN
	DECLARE sql_error INT DEFAULT FALSE;
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    SET sql_error = TRUE;
    
    START TRANSACTION;
		
        INSERT INTO equipment(equipment_name,equipment_weight, equipment_description)
        VALUES (rw_name,rw_weight, rw_description);
        
        INSERT INTO ranged_weapons
        VALUES ((SELECT equipment_id FROM equipment WHERE rw_name = equipment_name), rw_hit,rw_damage,rw_distance,rw_type,
			(SELECT equipment_id FROM equipment WHERE rw_projectile = equipment_name),rw_attribute);
        
        IF sql_error = FALSE THEN
			COMMIT;
            SELECT CONCAT('Ranged weapon, ',rw_name, ', successfully added to game.') as Message;
		ELSE
			ROLLBACK;
            SELECT 'Ranged weapon not successfully added to game' as Message;
		END IF;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS create_new_class;

DELIMITER //
CREATE PROCEDURE create_new_class
(
	c_name VARCHAR(64),
    armor_prof ENUM('light','medium','heavy'), 
    weapon_prof ENUM('simple','martial','exotic'),
	class_desc VARCHAR(140),
    c_attrb1 ENUM('strength','intelligence','dexterity','wisdom','charisma','constitution'), 
    c_attrb2 ENUM('strength','intelligence','dexterity','wisdom','charisma','constitution')
)
/**
 * Transaction to add a new class to the game.
 * User input consists of: class name, armor proficiency, weapon proficiency, class description, primary attribute 1, and primary attribute 2
 */
BEGIN
	DECLARE sql_error INT DEFAULT FALSE;
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    SET sql_error = TRUE;
		
	INSERT INTO class(class_name,armor_proficiency,weapon_proficiency,class_description,attribute1,attribute2)
	VALUES (c_name, armor_prof, weapon_prof, class_desc, c_attrb1, c_attrb2);
        
	IF sql_error = FALSE THEN
		SELECT CONCAT('Class, ',mw_name, ', successfully added to game.') as Message;
	ELSE
		SELECT 'Class not successfully added to game' as Message;
	END IF;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS create_new_spell;

DELIMITER //
CREATE PROCEDURE create_new_spell
(
	s_name VARCHAR(64),
    s_desc VARCHAR(128),
    s_damage INT,
	s_healing INT,
    s_hit INT,
    s_attribute ENUM('intelligence','wisdom','charisma')
)
/**
 * Transaction to add new Spell to the game
 * Input: Spell Name, Spell Description, Spell Damage, Spell Healing, Spell Hit, Spell Attribute
 */
BEGIN
	DECLARE sql_error INT DEFAULT FALSE;
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    SET sql_error = TRUE;

	INSERT INTO spells(spell_name,spell_description,spell_damage,spell_healing,spell_hit,attribute)
	VALUES (s_name,s_desc,s_damage,s_healing,s_hit,s_attribute);
        
	IF sql_error = FALSE THEN
		SELECT CONCAT('Spell, ',s_name, ', successfully added to game.') as Message;
	ELSE
		SELECT 'Spell not successfully added to game' as Message;
	END IF;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS create_new_skill;

DELIMITER //
CREATE PROCEDURE create_new_skill
(
	s_name VARCHAR(64), 
    s_desc VARCHAR(140), 
    s_attribute  ENUM('strength','intelligence','dexterity','wisdom','charisma','constitution')
)
/**
 * Transaction to add new Skill to the game
 * Input: Skill Name, Skill Description, Skill Attribute
 */
BEGIN
	DECLARE sql_error INT DEFAULT FALSE;
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    SET sql_error = TRUE;
        
    INSERT INTO skills(skill_name,skill_description,attribute)
        VALUES (s_name,s_desc,s_attribute);
        
	IF sql_error = FALSE THEN
		SELECT CONCAT('Skill, ',s_name, ', successfully added to game.') as Message;
	ELSE
		SELECT 'Skill not successfully added to game' as Message;
	END IF;
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS create_player;
DELIMITER //
CREATE PROCEDURE create_player
(
    email_param	VARCHAR(24),
    fname_param	VARCHAR(24),
    lname_param	VARCHAR(24)
)
/**
 * Procedure to create new player
 * User Input: Email Address (PK), First Name, Last Name
 */
BEGIN
	INSERT INTO players (player_email, player_fname, player_lname)
    VALUES (email_param, fname_param, lname_param);
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS create_character;
DELIMITER //
CREATE PROCEDURE create_character
(
    character_name_param	VARCHAR(24),
    class_name_param	VARCHAR(64),
    player_email_param VARCHAR(24)
)
/**
 * Procedure to create a new character in the game
 * User Input: character_name, character_class, player_email
 */
BEGIN
	DECLARE sql_error INT DEFAULT FALSE;
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    SET sql_error = TRUE;
    
	INSERT INTO characters(character_name, class_id, player_id)
    VALUES (character_name_param, 
		(SELECT class_id FROM class WHERE class_name = class_name_param), 
        (SELECT player_id FROM players WHERE player_email = player_email_param));
	
	IF sql_error = FALSE THEN
		SELECT CONCAT('Character, ',character_name_param, ', successfully added to game.') as Message;
	ELSE
		SELECT 'Character not successfully added to game' as Message;
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
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    SET sql_error = TRUE;
    
	DECLARE a_id INT;
    DECLARE class_prof ENUM('light','medium','heavy');
    DECLARE a_type ENUM('light','medium','heavy');
    DECLARE c_id INT;
    
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
		IF class_prof = a_type THEN
			INSERT INTO class_equipment_loadout
			VALUES(c_id,a_id,quantity_param);
			SELECT('Armor assignment successful') as Message;
		ELSE 
			SELECT('Armor assignment failed due to proficiency conflict') as Message;
		END IF;
	ELSE
		SELECT 'Database error on armor assignment' as Message;
	END IF;
END //
DELIMITER ;
    
    