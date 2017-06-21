DROP PROCEDURE IF EXISTS create_character;
DELIMITER //
CREATE PROCEDURE create_character
(
    character_name_param	VARCHAR(64),
    class_name_param	VARCHAR(64),
    player_email_param VARCHAR(64)
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
	CALL new_char_stats(character_name_param, (SELECT class_id FROM class WHERE class_name = class_name_param));
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS new_char_stats;

DELIMITER //
CREATE PROCEDURE new_char_stats
(
	character_name_param VARCHAR(64),
    class_id_param INT
)
BEGIN
	DECLARE sql_error INT DEFAULT FALSE;
    DECLARE prim_attrb1 ENUM('strength','dexterity','constitution','intelligence','wisdom','charisma');
    DECLARE prim_attrb2 ENUM('strength','dexterity','constitution','intelligence','wisdom','charisma');
    DECLARE char_id INT;
    DECLARE char_cons INT;
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    SET sql_error = TRUE;
    
    SELECT character_id into char_id
	FROM characters
	WHERE character_name = character_name_param;
        
	SELECT attribute1 into prim_attrb1
	FROM class
	WHERE class_id = class_id_param;
        
	SELECT attribute2 into prim_attrb2
	FROM class
	WHERE class_id = class_id_param;
        
    
	START TRANSACTION;
        CASE
			WHEN prim_attrb1 = 'strength' THEN
				UPDATE characters c
                SET c.strength = 1
                WHERE char_id = character_id;
                
			WHEN prim_attrb1 = 'dexterity' THEN
				UPDATE characters c
                SET c.dexterity = 1
                WHERE char_id = character_id;
                
			WHEN prim_attrb1 = 'constitution' THEN
				UPDATE characters c
                SET c.constitution = 1
                WHERE char_id = character_id;
                
			WHEN prim_attrb1 = 'intelligence' THEN
				UPDATE characters c
                SET c.intelligence = 1
                WHERE char_id = character_id;
                
			WHEN prim_attrb1 = 'wisdom' THEN
				UPDATE characters c
                SET c.wisdom = 1
                WHERE char_id = character_id;
                
			WHEN prim_attrb1 = 'charisma' THEN
				UPDATE characters c
                SET c.charisma = 1
                WHERE char_id = character_id;
                
		END CASE;
        
        CASE
			WHEN prim_attrb2 = 'strength' THEN
				UPDATE characters c
                SET c.strength = 1
                WHERE char_id = character_id;
                
			WHEN prim_attrb2 = 'dexterity' THEN
				UPDATE characters c
                SET c.dexterity = 1
                WHERE char_id = character_id;
                
			WHEN prim_attrb2 = 'constitution' THEN
				UPDATE characters c
                SET c.constitution = 1
                WHERE char_id = character_id;
                
			WHEN prim_attrb2 = 'intelligence' THEN
				UPDATE characters c
                SET c.intelligence = 1
                WHERE char_id = character_id;
                
			WHEN prim_attrb2 = 'wisdom' THEN
				UPDATE characters c
                SET c.wisdom = 1
                WHERE char_id = character_id;
                
			WHEN prim_attrb2 = 'charisma' THEN
				UPDATE characters c
                SET c.charisma = 1
                WHERE char_id = character_id;
                
		END CASE;
		
        SELECT constitution INTO char_cons
        FROM characters
        WHERE char_id = character_id;
        
        INSERT INTO health_points
        VALUES (char_id, (SELECT SUM(char_cons + 5)), (SELECT SUM(char_cons + 5)));
    
		IF sql_error = FALSE THEN
			COMMIT;
			SELECT CONCAT('Character, ',character_name_param, ', successfully create and adjusted for level 1.') as Message;
		ELSE
			ROLLBACK;
			SELECT 'Character not successfully created.' as Message;
		END IF;
END //
DELIMITER ;