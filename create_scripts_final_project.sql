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
	FROM character_equipment ce join equipment e 
		ON ce.equip_id = e.equipment_id
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
	FROM class_spells cs join spells join characters c
		ON cs.spell_id = spells.spell_id
        AND c.class_id = cs.class_id
    WHERE c.character_id = char_id_param;
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
	FROM class_skills cs join skills join characters c
		ON cs.skill_id = skills.skill_id
        AND c.class_id = cs.class_id
    WHERE c.character_id = char_id_param;
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
	SELECT c.character_name, c.character_level, cl.class_name, h.current_health_points
	FROM characters c join class cl join health_points h
		on c.class_id = cl.class_id
        AND c.character_id = h.character_id
    WHERE c.character_id = char_id_param;
END //

DELIMITER ;


