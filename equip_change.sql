/** character name change **/
DROP PROCEDURE IF EXISTS change_equip;
DELIMITER //
CREATE PROCEDURE change_equip
(
	char_id_param	INT,
    old_equip_param	VARCHAR(64),
    new_equip_param	VARCHAR(64)
)
BEGIN
	DECLARE sql_error INT DEFAULT FALSE;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    SET sql_error = TRUE;
        
	UPDATE character_equipment
	SET equip_id = new_equip_param
	WHERE char_id = char_id_param
		AND old_equip_param = equip_id;


	IF sql_error = FALSE THEN
		COMMIT;
		SELECT CONCAT(old_name_param, ', successfully changed to ', new_name_param) as Message;
	ELSE
		ROLLBACK;
		SELECT 'Character name change was not successful' as Message;
	END IF;
END //

DELIMITER ;

