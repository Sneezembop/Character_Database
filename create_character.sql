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
    DECLARE c_id INT;
    
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    SET sql_error = TRUE;
    
    START TRANSACTION;
		SELECT class_id INTO c_id
        FROM class
        WHERE class_name = class_name_param;
    
		INSERT INTO characters(character_name, class_id, player_id,strength,dexterity,constitution,intelligence,wisdom,charisma)
		VALUES (character_name_param, 
			c_id, 
			(SELECT player_id FROM players WHERE player_email = player_email_param),
			calculate_attribute_value(c_id,'strength',1),
			calculate_attribute_value(c_id,'dexterity',1),
            calculate_attribute_value(c_id,'constitution',1),
            calculate_attribute_value(c_id,'intelligence',1),
            calculate_attribute_value(c_id,'wisdom',1),
            calculate_attribute_value(c_id,'charisma',1));
	
    IF sql_error = FALSE THEN
		COMMIT;
		SELECT 'Character successfully created.' as Message;
	ELSE
		ROLLBACK;
		SELECT 'Character not successfully created.' as Message;
	END IF;
END //
DELIMITER ;

DROP FUNCTION IF EXISTS calculate_attribute_value;
DELIMITER //
CREATE FUNCTION calculate_attribute_value
(
	c_id INT,
    attribute ENUM('strength','dexterity','constitution','intelligence','wisdom','charisma'),
    char_level INT
)
	RETURNS INT
BEGIN
	DECLARE class_attrb1 ENUM('strength','dexterity','constitution','intelligence','wisdom','charisma');
    DECLARE class_attrb2 ENUM('strength','dexterity','constitution','intelligence','wisdom','charisma');
    
    SELECT attribute1 INTO class_attrb1
    FROM class
    WHERE class_id = c_id;
    
    SELECT attribute2 INTO class_attrb2
    FROM class
    WHERE class_id = c_id;
    
    IF attribute = class_attrb1 OR attribute = class_attrb2 THEN
		RETURN 8 + char_level / 1;
	ELSE
		RETURN 8 + char_level / 2 - 1;
	END IF;
END //
DELIMITER ;

DROP TRIGGER IF EXISTS create_health_points;
DELIMITER //
CREATE TRIGGER create_health_points
	AFTER INSERT ON characters
    FOR EACH ROW
BEGIN
    INSERT INTO health_points
    VALUES (NEW.character_id,5 + NEW.constitution,5 + NEW.constitution);
END //
DELIMITER ;