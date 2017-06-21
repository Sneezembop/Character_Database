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
	call update_attributes_level_up();
END//
        
DELIMITER ;


/** update procedures procedure helper**/
DROP PROCEDURE IF EXISTS update_attributes_level_up;
DELIMITER //
CREATE PROCEDURE update_attributes_level_up()
BEGIN        
	DECLARE sql_error INT DEFAULT FALSE;
    DECLARE old_level INT;
    DECLARE new_level INT;
    DECLARE primary1 VARCHAR(64);
    DECLARE primary2 VARCHAR(64);
    DECLARE character_cons_mod INT;
    DECLARE char_current_health INT;
    DECLARE char_total_health INT;
    DECLARE char_id INT;
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    SET sql_error = TRUE;
    
    
    IF new_level > old_level THEN
    
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
		ELSE
			ROLLBACK;
		END IF;
            
	END IF;
END //

DELIMITER ;