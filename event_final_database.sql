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
    SET health_points = health_points + 1;
END//

DELIMITER ;