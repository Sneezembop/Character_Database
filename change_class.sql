USE mydb;

DROP PROCEDURE IF EXISTS change_class;

DELIMITER //
CREATE PROCEDURE change_class
(
	char_name VARCHAR(64),
    new_class_name VARCHAR(64)
)
BEGIN
	DECLARE sql_error INT DEFAULT FALSE;
    DECLARE c_id INT;
    DECLARE char_id INT;
    DECLARE char_level INT;
    DECLARE constitution_score INT;
    
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    SET sql_error = TRUE;
    
    START TRANSACTION;
		SELECT class_id INTO c_id
        FROM class
        WHERE class.class_name = new_class_name;
        
        SELECT character_id INTO char_id
        FROM characters
        WHERE char_name = characters.character_name;
        
        SELECT character_level INTO char_level
        FROM characters
        WHERE char_id = characters.character_id;
    
		UPDATE characters
        SET class_id = c_id, 
			strength =  calculate_attribute_value(c_id,'strength',char_level),
			dexterity = calculate_attribute_value(c_id,'dexterity',char_level),
            constitution = calculate_attribute_value(c_id,'constitution',char_level),
            intelligence =  calculate_attribute_value(c_id,'intelligence',char_level),
            wisdom =  calculate_attribute_value(c_id,'wisdom',char_level),
            charisma =  calculate_attribute_value(c_id,'charisma',char_level)
        WHERE char_id = characters.character_id;
        
        INSERT INTO character_equipment
		SELECT c.character_id, equipment_id, quantity
		FROM class_equipment_loadout JOIN class join characters c
		ON class.class_id = class_equipment_loadout.class_id
		AND c.class_id = class.class_id
		WHERE class.class_id = c_id;
	
    IF sql_error = FALSE THEN
		COMMIT;
		SELECT 'Character successfully changed class.' as Message;
	ELSE
		ROLLBACK;
		SELECT 'Character not successfully changed class.' as Message;
	END IF;
END //
DELIMITER ;