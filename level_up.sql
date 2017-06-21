/***
*************************************
*************************************
*************************************
LEVEL UP 
*************************************
*************************************
***/

DROP PROCEDURE IF EXISTS character_level_up;

DELIMITER //
CREATE PROCEDURE character_level_up
(
	character_name_param VARCHAR(64)
)
BEGIN
	DECLARE sql_error INT DEFAULT FALSE;
    DECLARE c_id INT;
    DECLARE char_id INT;
    DECLARE new_level INT;
    DECLARE constitution_score INT;
    
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    SET sql_error = TRUE;
    
    START TRANSACTION;
		SELECT class_id INTO c_id
        FROM characters
        WHERE character_name_param = characters.character_name;
        
        SELECT character_id INTO char_id
        FROM characters
        WHERE character_name_param = characters.character_name;
        
        SELECT character_level + 1 INTO new_level
        FROM characters
        WHERE char_id = characters.character_id;
        
        SELECT  calculate_attribute_value(c_id,'constitution',new_level) INTO constitution_score;
    
		UPDATE characters
        SET character_level = new_level, 
			strength =  calculate_attribute_value(c_id,'strength',new_level),
			dexterity = calculate_attribute_value(c_id,'dexterity',new_level),
            constitution = constitution_score,
            intelligence =  calculate_attribute_value(c_id,'intelligence',new_level),
            wisdom =  calculate_attribute_value(c_id,'wisdom',new_level),
            charisma =  calculate_attribute_value(c_id,'charisma',new_level)
        WHERE char_id = characters.character_id;
        
        UPDATE health_points
        SET total_health_points = total_health_points + constitution_score,
			current_health_points = current_health_points + constitution_score
		WHERE char_id = health_points.character_id;
	
    IF sql_error = FALSE THEN
		COMMIT;
		SELECT 'Character successfully updated.' as Message;
	ELSE
		ROLLBACK;
		SELECT 'Character not successfully updated.' as Message;
	END IF;
END //
DELIMITER ;