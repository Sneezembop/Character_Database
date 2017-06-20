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
    email_param	VARCHAR(64),
    fname_param	VARCHAR(64),
    lname_param	VARCHAR(64)
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


-- DATA MAPPING SCRIPTS BELOW
-- -----------------------------------------------



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
		IF class_prof = w_type THEN
			INSERT INTO class_equipment_loadout
			VALUES(c_id,w_id,quantity_param);
			SELECT('Weapon assignment successful') as Message;
		ELSE 
			SELECT('Weapon assignment failed due to proficiency conflict') as Message;
		END IF;
	ELSE
		SELECT 'Database error on weapon assignment' as Message;
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


-- DELETE DATA SCRIPTS BELOW:


    
/** delete char procedure ***/
DROP PROCEDURE IF EXISTS delete_character;
DELIMITER //
CREATE PROCEDURE delete_character
(
    character_name_param	VARCHAR(64)
)
BEGIN
	DECLARE sql_error INT DEFAULT FALSE;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    SET sql_error = TRUE;
        
	DELETE FROM characters
	WHERE character_name = character_name_param;
	
	IF sql_error = FALSE THEN
		COMMIT;
		SELECT CONCAT('Character , ',character_name_param, ', successfully deleted from game.') as Message;
	ELSE
		ROLLBACK;
		SELECT 'Character deletion was not successful' as Message;
	END IF;
END //

DELIMITER ;

/** delete spells procedure ***/
DROP PROCEDURE IF EXISTS delete_spells;
DELIMITER //
CREATE PROCEDURE delete_spells
(
    spell_name_param	VARCHAR(64)
)
BEGIN
	DECLARE sql_error INT DEFAULT FALSE;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    SET sql_error = TRUE;
        
	DELETE FROM spells
	WHERE spell_name = spells_name_param;
	
	IF sql_error = FALSE THEN
		COMMIT;
		SELECT CONCAT('Spell , ',spell_name_param, ', successfully deleted from game.') as Message;
	ELSE
		ROLLBACK;
		SELECT 'Spell deletion was not successful' as Message;
	END IF;
END //

DELIMITER ;

/** delete skills procedure ***/
DROP PROCEDURE IF EXISTS delete_skills;
DELIMITER //
CREATE PROCEDURE delete_skills
(
    skill_name_param	VARCHAR(64)
)
BEGIN
	DECLARE sql_error INT DEFAULT FALSE;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    SET sql_error = TRUE;
        
	DELETE FROM skills
	WHERE skill_name = skill_name_param;
	
	IF sql_error = FALSE THEN
		COMMIT;
		SELECT CONCAT('Skill , ',skill_name_param, ', successfully deleted from game.') as Message;
	ELSE
		ROLLBACK;
		SELECT 'Skill deletion was not successful' as Message;
	END IF;
END //

DELIMITER ;

/** delete equipment procedure ***/
DROP PROCEDURE IF EXISTS delete_equipment;
DELIMITER //
CREATE PROCEDURE delete_equipment
(
    equipment_name_param	VARCHAR(64)
)
BEGIN
	DECLARE sql_error INT DEFAULT FALSE;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    SET sql_error = TRUE;
        
	DELETE FROM equipment
	WHERE equipment_name = equipment_name_param;
	
	IF sql_error = FALSE THEN
		COMMIT;
		SELECT CONCAT('Equipment , ',equipment_name_param, ', successfully deleted from game.') as Message;
	ELSE
		ROLLBACK;
		SELECT 'Equipment deletion was not successful' as Message;
	END IF;
END //

DELIMITER ;

/** delete player procedure ***/
DROP PROCEDURE IF EXISTS delete_player;
DELIMITER //
CREATE PROCEDURE delete_player
(
    player_email_param	VARCHAR(64)
)
BEGIN
	DECLARE sql_error INT DEFAULT FALSE;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    SET sql_error = TRUE;
        
	DELETE FROM players
	WHERE player_email = player_email_param;
	
	IF sql_error = FALSE THEN
		COMMIT;
		SELECT CONCAT('Player , ',player_email_param, ', successfully deleted from game.') as Message;
	ELSE
		ROLLBACK;
		SELECT 'Player deletion was not successful' as Message;
	END IF;
END //

DELIMITER ;

/** delete class procedure ***/
DROP PROCEDURE IF EXISTS delete_class;
DELIMITER //
CREATE PROCEDURE delete_class
(
    class_name_param	VARCHAR(64)
)
BEGIN
	DECLARE sql_error INT DEFAULT FALSE;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    SET sql_error = TRUE;
        
	DELETE FROM class
	WHERE class_name = class_name_param;
	
	IF sql_error = FALSE THEN
		COMMIT;
		SELECT CONCAT('Class , ',class_name_param, ', successfully deleted from game.') as Message;
	ELSE
		ROLLBACK;
		SELECT 'Class deletion was not successful' as Message;
	END IF;
END //

DELIMITER ;



-- UPDATE DATA SCRIPTS BELOW



/** character name change **/
DROP PROCEDURE IF EXISTS change_char_name;
DELIMITER //
CREATE PROCEDURE change_char_name
(
    old_name_param	VARCHAR(64),
    new_name_param	VARCHAR(64)
)
BEGIN
	DECLARE sql_error INT DEFAULT FALSE;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    SET sql_error = TRUE;
        
	UPDATE characters
	SET character_name = new_name_param
	WHERE character_name = old_name_param;


	IF sql_error = FALSE THEN
		COMMIT;
		SELECT CONCAT(old_name_param, ', successfully changed to ', new_name_param) as Message;
	ELSE
		ROLLBACK;
		SELECT 'Character name change was not successful' as Message;
	END IF;
END //

DELIMITER ;

/** player email change **/
DROP PROCEDURE IF EXISTS player_email_change;
DELIMITER //
	CREATE PROCEDURE player_email_change
	(
		old_email_param	VARCHAR(64),
		new_email_param	VARCHAR(64)
	)
BEGIN
	DECLARE sql_error INT DEFAULT FALSE;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    SET sql_error = TRUE;
        
	UPDATE players
	SET player_email = new_email_param
	WHERE player_email = old_email_param;

	IF sql_error = FALSE THEN
		COMMIT;
		SELECT CONCAT(old_email_param, ', successfully changed to ', new_email_param) as Message;
	ELSE
		ROLLBACK;
		SELECT 'Player email change was not successful' as Message;
	END IF;
END //

DELIMITER ;


/****
INCREASE HEALTH TRIGGER
***/

SET GLOBAL event_scheduler = ON;  
/**Event to increase health**/
DROP EVENT IF EXISTS increase_health_event;
DELIMITER //

CREATE EVENT increase_health_event
ON SCHEDULE EVERY 30 SECOND
DO BEGIN
    UPDATE characters
    SET health_points = health_points + 1;
END//

DELIMITER ;


/***
*************************************
*************************************
*************************************
LEVEL UP TRIGGER
*************************************
*************************************
*************************************
***/

DROP TRIGGER IF EXISTS leveled_up;

DELIMITER //

CREATE TRIGGER leveled_up
  BEFORE UPDATE ON characters
  FOR EACH ROW  
  
BEGIN
	DECLARE sql_error INT DEFAULT FALSE;
    DECLARE old_level INT;
    DECLARE new_level INT;
    DECLARE primary1 VARCHAR(64);
    DECLARE primary2 VARCHAR(64);
    DECLARE character_cons_mod INT;
    DECLARE char_current_health INT;
    DECLARE char_total_health INT;
    DECLARE char_id INT:
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    SET sql_error = TRUE;
    
    SELECT OLD.character_id
    INTO char_id
    FROM characters;
    
    SELECT OLD.character_level
    INTO old_level
    FROM characters;
    
    SELECT NEW.character_level
    INTO new_level
    FROM characters;
    
    SELECT cl.attribute1
    INTO primary1
    FROM characters c join class cl
		ON c.class_id = cl.class_id;
        
    SELECT cl.attribute2
    INTO primary2
    FROM characters c join class cl
		ON c.class_id = cl.class_id;
    IF new_level > old_level THEN
		START TRANSACTION;
			IF new_level % 2 = 0 THEN
				CASE 
					WHEN primary1 = 'strength' THEN
						UPDATE characters
						SET strength = strength + 1; 
					WHEN primary1 = 'intelligence' THEN
						UPDATE characters
						SET intelligence = intelligence + 1;
                    WHEN primary1 = 'dexterity' THEN
						UPDATE characters
						SET dexterity = dexterity + 1;
                    WHEN primary1 = 'wisdom' THEN
						UPDATE characters
						SET wisdom = wisdom+ 1;
                    WHEN primary1 = 'charisma' THEN
						UPDATE characters
						SET charisma = charisma + 1;
                    WHEN primary1 = 'constitution' THEN
						UPDATE characters
						SET constitution = constitution + 1;
				END CASE;
                CASE 
					WHEN primary2 = 'strength' THEN
						UPDATE characters
						SET strength = strength + 1; 
					WHEN primary2 = 'intelligence' THEN
						UPDATE characters
						SET intelligence = intelligence + 1;
                    WHEN primary2 = 'dexterity' THEN
						UPDATE characters
						SET dexterity = dexterity + 1;
                    WHEN primary2 = 'wisdom' THEN
						UPDATE characters
						SET wisdom = wisdom+ 1;
                    WHEN primary2 = 'charisma' THEN
						UPDATE characters
						SET charisma = charisma + 1;
                    WHEN primary2 = 'constitution' THEN
						UPDATE characters
						SET constitution = constitution + 1;
				END CASE;
                
			ELSEIF new_level % 2 = 1 THEN
				UPDATE characters
				SET strength = strength + 1; 

				UPDATE characters
				SET intelligence = intelligence + 1;

				UPDATE characters
				SET dexterity = dexterity + 1;

				UPDATE characters
				SET wisdom = wisdom+ 1;

				UPDATE characters
				SET charisma = charisma + 1;

				UPDATE characters
				SET constitution = constitution + 1;
			END IF;
            
            SELECT constitution INTO character_cons_mod
            FROM characters
            WHERE character_id = char_id;
            
            UPDATE health_points
            SET total_health_points = total_health_points + character_cons_mod
            WHERE character_id = char_id;
            
            UPDATE health_points
            SET current_health_points = current_health_points + character_cons_mod
            WHERE character_id = char_id;
            
            SELECT total_health_points INTO char_total_health
            FROM health_points
            WHERE character_id = char_id;
            
            SELECT current_health_points INTO char_current_health
            FROM health_points
            WHERE character_id = char_id;
            
            IF char_current_health > total_health_points THEN
				UPDATE health_points
                SET current_health_points = total_health_points;
			END IF;
		
        IF sql_error = FALSE THEN
			COMMIT;
			SELECT CONCAT('You leveled up!  Attributes have increased, and Health Points have been increased.') as Message;
		ELSE
			ROLLBACK;
			SELECT 'Failed to Level Up' as Message;
	END IF;
            
	END IF;
END//
        
DELIMITER ;


/** read all players**/
DROP PROCEDURE IF EXISTS read_all_players;
DELIMITER //
CREATE PROCEDURE read_all_players()
BEGIN        
	SELECT *
	FROM players;
END //

DELIMITER ;

/** read all characters**/
DROP PROCEDURE IF EXISTS read_all_characters;
DELIMITER //
CREATE PROCEDURE read_all_characters
(
	player_email_param	VARCHAR(64)
)
BEGIN        
	SELECT character_name
	FROM characters, players WHERE players.player_id = characters.player_id AND players.player_email = player_email_param;
END //

DELIMITER ;

/** read players detail**/
DROP PROCEDURE IF EXISTS read_player_detail;
DELIMITER //
CREATE PROCEDURE read_player_detail
(
	player_email_param	VARCHAR(64)
)
BEGIN        
	SELECT *
	FROM players
    WHERE player_email = player_email_param;
END //

DELIMITER ;


/** read character detail**/
DROP PROCEDURE IF EXISTS read_character_detail;
DELIMITER //
CREATE PROCEDURE read_character_detail
(
	char_name_param	VARCHAR(64)
)
BEGIN        
	SELECT *
	FROM characters
    WHERE character_name = char_name_param;
END //

DELIMITER ;


/** read equipment detail**/
DROP PROCEDURE IF EXISTS read_equipment_detail;
DELIMITER //
CREATE PROCEDURE read_equipment_detail
(
	char_id_param	INT
)
BEGIN        
	SELECT *
	FROM character_equipment ce join equipment e join armor a join melee_weapons mw
		ON ce.char_id = char_id_param
			AND ce.equip_id = e.equipment_id
            AND e.equipment_id = a.equipment_id
            AND e.equipment_id = mw.equipment_id
    WHERE ce.char_id = char_id_param;
END //

DELIMITER ;

/** read spells detail**/
DROP PROCEDURE IF EXISTS read_spells_detail;
DELIMITER //
CREATE PROCEDURE read_spells_detail
(
	char_id_param	INT
)
BEGIN        
	SELECT *
	FROM class_spells cs join spells
		ON cs.spell_id = spells.spell_id
    WHERE cs.char_id = char_id_param;
END //

DELIMITER ;


/** read skills detail**/
DROP PROCEDURE IF EXISTS read_skills_detail;
DELIMITER //
CREATE PROCEDURE read_skills_detail
(
	char_id_param	INT
)
BEGIN        
	SELECT *
	FROM class_skills cs join skills
		ON cs.skill_id = skills.skill_id
    WHERE cs.char_id = char_id_param;
END //

DELIMITER ;

/**char name, level, health **/
DROP PROCEDURE IF EXISTS read_basic_char_info;
DELIMITER //
CREATE PROCEDURE read_basic_char_info
(
	char_id_param	INT
)
BEGIN        
	SELECT character_name, health_points, character_level
	FROM characters
    WHERE character_id = char_id_param;
END //

DELIMITER ;


