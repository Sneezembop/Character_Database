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
    UPDATE health_points
    SET current_health_points = current_health_points + 1;
END//

DELIMITER ;

DROP TRIGGER IF EXISTS health_point_update;
DELIMITER //
CREATE TRIGGER health_point_update
	BEFORE UPDATE ON health_points
    FOR EACH ROW
BEGIN
	IF NEW.current_health_points > NEW.total_health_points THEN
		SET NEW.current_health_points = NEW.total_health_points;
	END IF;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS update_health;

DELIMITER //
CREATE PROCEDURE update_health
(
	char_name VARCHAR(64),
    down_up ENUM('down','up'),
    amount INT
)
BEGIN
	DECLARE char_id INT;
    
    SELECT character_id into char_id
    FROM characters
    WHERE char_name = characters.character_name;
    
    IF down_up = 'up' THEN
		UPDATE health_points
		SET current_health_points = current_health_points + amount
		WHERE char_id = character_id;
	ELSE
		UPDATE health_points
		SET current_health_points = current_health_points - amount
		WHERE char_id = character_id;
	END IF;
END //
DELIMITER ;
    