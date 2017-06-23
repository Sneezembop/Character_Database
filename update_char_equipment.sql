USE mydb;

-- Update character_equipment: Drop Equipment

DROP PROCEDURE IF EXISTS remove_char_equipment;
DELIMITER //
CREATE PROCEDURE remove_char_equipment
(
	char_name VARCHAR(64),
    eq_name VARCHAR(64)
)
BEGIN
	DECLARE sql_error INT DEFAULT FALSE;
	DECLARE eq_id INT;
    DECLARE cr_id INT;
    DECLARE current_quantity INT;
    DECLARE new_quantity INT;
    
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    SET sql_error = TRUE;
    
    START TRANSACTION;
    
    SELECT character_id INTO cr_id
    FROM characters
    WHERE character_name = char_name;
    
    SELECT equipment_id INTO eq_id
    FROM equipment
    WHERE equipment_name = eq_name;
    
    SELECT ce_quantity INTO current_quantity
    FROM character_equipment
    WHERE equip_id = eq_id AND char_id = cr_id;
    
    IF current_quantity - 1 = 0 THEN
		DELETE FROM character_equipment WHERE char_id = cr_id AND equip_id = eq_id;
	ELSE
		UPDATE character_equipment SET ce_quantity = current_quantity - 1 WHERE char_id = cr_id AND equip_id = eq_id;
	END IF;
    
    IF sql_error = FALSE THEN
		COMMIT;
		SELECT 'Equipment removed from character.' as Message;
	ELSE
		ROLLBACK;
		SELECT 'Equipment not removed from character.' as Message;
	END IF;
END //
DELIMITER ;

-- Update character_equipment: Add Equipment

DROP PROCEDURE IF EXISTS add_equip_to_char;

DELIMITER //
CREATE PROCEDURE add_equip_to_char
(
	char_name VARCHAR(64),
    eq_name VARCHAR(64)
)
BEGIN
	DECLARE sql_error INT DEFAULT FALSE;
	DECLARE eq_id INT;
    DECLARE cr_id INT;
    DECLARE equip_exists INT;
    
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    SET sql_error = TRUE;
    
    SELECT character_id INTO cr_id
    FROM characters
    WHERE character_name = char_name;
    
    SELECT equipment_id INTO eq_id
    FROM equipment
    WHERE equipment_name = eq_name;
    
    SELECT COUNT(*) INTO equip_exists
    FROM character_equipment
    WHERE cr_id = char_id AND eq_id = equip_id;
    
    IF equip_exists = 0 THEN
		INSERT INTO character_equipment VALUES(cr_id,eq_id,1);
    ELSE
		UPDATE character_equipment
		SET ce_quantity = ce_quantity + 1
		WHERE char_id = cr_id AND eq_id = equip_id;
	END IF;
    
    IF sql_error = FALSE THEN
		SELECT 'Equipment added to character.' as Message;
	ELSE
		ROLLBACK;
		SELECT 'Equipment not added to character.' as Message;
	END IF;
END //
DELIMITER ;
    