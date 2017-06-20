CREATE DATABASE  IF NOT EXISTS `mydb` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `mydb`;
-- MySQL dump 10.13  Distrib 5.7.17, for macos10.12 (x86_64)
--
-- Host: localhost    Database: mydb
-- ------------------------------------------------------
-- Server version	5.7.18

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `armor`
--

DROP TABLE IF EXISTS `armor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `armor` (
  `equipment_id` int(11) NOT NULL,
  `armor_rating` int(11) NOT NULL,
  `armor_type` enum('light','medium','heavy') NOT NULL,
  PRIMARY KEY (`equipment_id`),
  CONSTRAINT `armor_equip_id_fk` FOREIGN KEY (`equipment_id`) REFERENCES `equipment` (`equipment_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `armor`
--

LOCK TABLES `armor` WRITE;
/*!40000 ALTER TABLE `armor` DISABLE KEYS */;
INSERT INTO `armor` VALUES (1,1,'light'),(2,2,'light'),(3,3,'medium'),(4,4,'medium'),(5,5,'heavy'),(7,6,'heavy'),(18,10,'medium');
/*!40000 ALTER TABLE `armor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attributes`
--

DROP TABLE IF EXISTS `attributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attributes` (
  `attribute_id` int(11) NOT NULL,
  `strength` int(11) NOT NULL DEFAULT '8',
  `intelligence` int(11) NOT NULL DEFAULT '8',
  `dexterity` int(11) NOT NULL DEFAULT '8',
  `wisdom` int(11) NOT NULL DEFAULT '8',
  `charisma` int(11) NOT NULL DEFAULT '8',
  `constitution` int(11) NOT NULL DEFAULT '8',
  PRIMARY KEY (`attribute_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attributes`
--

LOCK TABLES `attributes` WRITE;
/*!40000 ALTER TABLE `attributes` DISABLE KEYS */;
/*!40000 ALTER TABLE `attributes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `character_equipment`
--

DROP TABLE IF EXISTS `character_equipment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `character_equipment` (
  `char_id` int(11) NOT NULL,
  `equip_id` int(11) NOT NULL,
  `ce_quantity` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`char_id`,`equip_id`),
  KEY `equip_equip_id_fk_idx` (`equip_id`),
  CONSTRAINT `equip_char_id_fk` FOREIGN KEY (`char_id`) REFERENCES `characters` (`character_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `equip_equip_id_fk` FOREIGN KEY (`equip_id`) REFERENCES `equipment` (`equipment_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `character_equipment`
--

LOCK TABLES `character_equipment` WRITE;
/*!40000 ALTER TABLE `character_equipment` DISABLE KEYS */;
/*!40000 ALTER TABLE `character_equipment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `characters`
--

DROP TABLE IF EXISTS `characters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `characters` (
  `character_id` int(11) NOT NULL AUTO_INCREMENT,
  `character_name` varchar(24) NOT NULL,
  `class_id` int(11) NOT NULL,
  `health_points` int(11) NOT NULL DEFAULT '10',
  `character_level` int(11) NOT NULL DEFAULT '1',
  `player_id` int(11) NOT NULL,
  `strength` int(11) NOT NULL DEFAULT '8',
  `dexterity` int(11) NOT NULL DEFAULT '8',
  `constitution` int(11) NOT NULL DEFAULT '8',
  `intelligence` int(11) NOT NULL DEFAULT '8',
  `wisdom` int(11) NOT NULL DEFAULT '8',
  `charisma` int(11) NOT NULL DEFAULT '8',
  PRIMARY KEY (`character_id`),
  UNIQUE KEY `character_name_UNIQUE` (`character_name`),
  KEY `class_id_fk_idx` (`class_id`),
  KEY `player_id_fk_idx` (`player_id`),
  CONSTRAINT `class_id_fk` FOREIGN KEY (`class_id`) REFERENCES `class` (`class_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `player_id_fk` FOREIGN KEY (`player_id`) REFERENCES `players` (`player_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `characters`
--

LOCK TABLES `characters` WRITE;
/*!40000 ALTER TABLE `characters` DISABLE KEYS */;
/*!40000 ALTER TABLE `characters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `class`
--

DROP TABLE IF EXISTS `class`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `class` (
  `class_id` int(11) NOT NULL AUTO_INCREMENT,
  `class_name` varchar(64) NOT NULL,
  `armor_proficiency` enum('light','medium','heavy') NOT NULL,
  `weapon_proficiency` enum('simple','martial','exotic') NOT NULL,
  `class_description` varchar(140) NOT NULL,
  `attribute1` enum('strength','intelligence','dexterity','wisdom','charisma','constitution') DEFAULT NULL,
  `attribute2` enum('strength','intelligence','dexterity','wisdom','charisma','constitution') DEFAULT NULL,
  PRIMARY KEY (`class_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `class`
--

LOCK TABLES `class` WRITE;
/*!40000 ALTER TABLE `class` DISABLE KEYS */;
INSERT INTO `class` VALUES (1,'Fighter','heavy','exotic','This is a standard fighter class','strength','constitution'),(2,'Wizard','light','simple','standard magic user','intelligence','wisdom'),(3,'Cleric','heavy','martial','standard tanky healer','wisdom','strength');
/*!40000 ALTER TABLE `class` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `class_equipment_loadout`
--

DROP TABLE IF EXISTS `class_equipment_loadout`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `class_equipment_loadout` (
  `class_id` int(11) NOT NULL,
  `equipment_id` int(11) NOT NULL,
  `quantity` int(11) DEFAULT NULL,
  PRIMARY KEY (`class_id`,`equipment_id`),
  KEY `loadout_equip_id_idx` (`equipment_id`),
  CONSTRAINT `loadout_class_id` FOREIGN KEY (`class_id`) REFERENCES `class` (`class_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `loadout_equip_id` FOREIGN KEY (`equipment_id`) REFERENCES `equipment` (`equipment_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `class_equipment_loadout`
--

LOCK TABLES `class_equipment_loadout` WRITE;
/*!40000 ALTER TABLE `class_equipment_loadout` DISABLE KEYS */;
/*!40000 ALTER TABLE `class_equipment_loadout` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `class_skills`
--

DROP TABLE IF EXISTS `class_skills`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `class_skills` (
  `class_id` int(11) NOT NULL,
  `skill_id` int(11) NOT NULL,
  `level` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`class_id`,`skill_id`),
  KEY `skill_id_fk_idx` (`skill_id`),
  CONSTRAINT `class_id_skills_fk` FOREIGN KEY (`class_id`) REFERENCES `class` (`class_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `skill_id_fk` FOREIGN KEY (`skill_id`) REFERENCES `skills` (`skill_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `class_skills`
--

LOCK TABLES `class_skills` WRITE;
/*!40000 ALTER TABLE `class_skills` DISABLE KEYS */;
/*!40000 ALTER TABLE `class_skills` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `class_spells`
--

DROP TABLE IF EXISTS `class_spells`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `class_spells` (
  `class_id` int(11) NOT NULL,
  `spell_id` int(11) NOT NULL,
  `level` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`class_id`,`spell_id`),
  KEY `spell_id_fk_idx` (`spell_id`),
  CONSTRAINT `class_id_spells_fk` FOREIGN KEY (`class_id`) REFERENCES `class` (`class_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `spell_id_fk` FOREIGN KEY (`spell_id`) REFERENCES `spells` (`spell_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `class_spells`
--

LOCK TABLES `class_spells` WRITE;
/*!40000 ALTER TABLE `class_spells` DISABLE KEYS */;
/*!40000 ALTER TABLE `class_spells` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `equipment`
--

DROP TABLE IF EXISTS `equipment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `equipment` (
  `equipment_id` int(11) NOT NULL AUTO_INCREMENT,
  `equipment_name` varchar(64) NOT NULL,
  `equipment_weight` int(11) NOT NULL DEFAULT '0',
  `equipment_description` varchar(140) NOT NULL,
  PRIMARY KEY (`equipment_id`),
  UNIQUE KEY `equipment_name_UNIQUE` (`equipment_name`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `equipment`
--

LOCK TABLES `equipment` WRITE;
/*!40000 ALTER TABLE `equipment` DISABLE KEYS */;
INSERT INTO `equipment` VALUES (1,'cloth armor',5,'robes typically worn by magic users'),(2,'heavy cloth armor',7,'sturdier robes for sturdier mages'),(3,'leather armor',10,'standard padded leather armor'),(4,'studded leather armor',13,'reinforced leather armor'),(5,'chain armor',15,'standard issue heavy armor'),(7,'plate armor',20,'beefy big boy armor'),(8,'short sword',2,'this is a short sword'),(9,'iron sword',3,'this is an iron sword'),(10,'steel sword',4,'this is a steel sword'),(11,'light club',3,'this is a light club'),(12,'heavy club',6,'this is a heavy club'),(13,'staff',2,'this is a staff'),(14,'light bow',3,'This is a light bow'),(15,'light crossbow',2,'This is a light crossbow'),(16,'light shield',3,'This is a light shield'),(17,'heavy shield',6,'This is a heavy shield'),(18,'nick armor',24,'nick\'s armor'),(21,'Nick Sword',5,'nick\'s sword is awesome'),(23,'stone',0,'This is a projectile used with slings'),(24,'sling',1,'this is a simple sling'),(25,'arrow',0,'this is an arrow for a bow'),(26,'bolt',0,'this is a bolt for a crossbow');
/*!40000 ALTER TABLE `equipment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `melee_weapons`
--

DROP TABLE IF EXISTS `melee_weapons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `melee_weapons` (
  `equipment_id` int(11) NOT NULL,
  `weapon_hit` int(11) NOT NULL,
  `weapon_damage` int(11) NOT NULL,
  `weapon_type` enum('simple','martial','exotic') NOT NULL,
  `weapon_reach` int(11) NOT NULL,
  `attribute` enum('strength','dexterity') NOT NULL,
  PRIMARY KEY (`equipment_id`),
  CONSTRAINT `equip_id_melee_fk` FOREIGN KEY (`equipment_id`) REFERENCES `equipment` (`equipment_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `melee_weapons`
--

LOCK TABLES `melee_weapons` WRITE;
/*!40000 ALTER TABLE `melee_weapons` DISABLE KEYS */;
INSERT INTO `melee_weapons` VALUES (8,1,1,'simple',1,'strength'),(9,2,3,'martial',1,'strength'),(10,3,5,'martial',1,'strength'),(11,2,2,'martial',1,'strength'),(12,4,4,'martial',1,'strength'),(13,2,2,'simple',2,'strength'),(21,5,5,'exotic',5,'strength');
/*!40000 ALTER TABLE `melee_weapons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `players`
--

DROP TABLE IF EXISTS `players`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `players` (
  `player_id` int(11) NOT NULL AUTO_INCREMENT,
  `player_email` varchar(64) NOT NULL,
  `player_fname` varchar(64) NOT NULL,
  `player_lname` varchar(64) NOT NULL,
  PRIMARY KEY (`player_id`,`player_email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `players`
--

LOCK TABLES `players` WRITE;
/*!40000 ALTER TABLE `players` DISABLE KEYS */;
INSERT INTO `players` VALUES (1,'test_user@thebestgame.com','Test','User');
/*!40000 ALTER TABLE `players` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ranged_weapons`
--

DROP TABLE IF EXISTS `ranged_weapons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ranged_weapons` (
  `equipment_id` int(11) NOT NULL,
  `weapon_hit` int(11) NOT NULL,
  `weapon_damage` int(11) NOT NULL,
  `weapon_distance` int(11) NOT NULL,
  `weapon_type` enum('simple','martial','exotic') NOT NULL,
  `weapon_projectile` int(11) NOT NULL,
  `attribute` enum('strength','dexterity') NOT NULL,
  PRIMARY KEY (`equipment_id`),
  KEY `weapon_projectile_fk_idx` (`weapon_projectile`),
  CONSTRAINT `equip_id_ranged_fk` FOREIGN KEY (`equipment_id`) REFERENCES `equipment` (`equipment_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `weapon_projectile_fk` FOREIGN KEY (`weapon_projectile`) REFERENCES `equipment` (`equipment_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ranged_weapons`
--

LOCK TABLES `ranged_weapons` WRITE;
/*!40000 ALTER TABLE `ranged_weapons` DISABLE KEYS */;
INSERT INTO `ranged_weapons` VALUES (14,2,2,30,'martial',25,'dexterity'),(15,3,1,30,'martial',26,'dexterity'),(24,1,1,20,'simple',23,'dexterity');
/*!40000 ALTER TABLE `ranged_weapons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `skills`
--

DROP TABLE IF EXISTS `skills`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `skills` (
  `skill_id` int(11) NOT NULL AUTO_INCREMENT,
  `skill_name` varchar(64) NOT NULL,
  `skill_description` varchar(140) NOT NULL,
  `attribute` enum('strength','dexterity','intelligence','wisdom','charisma','constitution') NOT NULL,
  PRIMARY KEY (`skill_id`),
  UNIQUE KEY `skill_name_UNIQUE` (`skill_name`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `skills`
--

LOCK TABLES `skills` WRITE;
/*!40000 ALTER TABLE `skills` DISABLE KEYS */;
INSERT INTO `skills` VALUES (1,'Cleave','Next attack hits 2 enemies','strength'),(2,'Charge','Character attempts to rush and stun enemy, roll 17 or above to hit','strength'),(3,'First Aid','Character heals for 1 damage, only usable once per day','intelligence'),(4,'Detect Magic','Character attempts to detect magic source, roll check','intelligence'),(5,'Disarm Trap','Character attempts to disarm trap','dexterity'),(6,'Perception','Character attempts to spot things in room','wisdom'),(7,'Persuade','Character attempts to coerce other character/npc, charisma save','charisma');
/*!40000 ALTER TABLE `skills` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spells`
--

DROP TABLE IF EXISTS `spells`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spells` (
  `spell_id` int(11) NOT NULL AUTO_INCREMENT,
  `spell_name` varchar(64) NOT NULL,
  `spell_description` varchar(140) NOT NULL,
  `spell_damage` int(11) DEFAULT NULL,
  `spell_healing` int(11) DEFAULT NULL,
  `spell_hit` varchar(8) NOT NULL,
  `attribute` enum('intelligence','wisdom','charisma') NOT NULL,
  PRIMARY KEY (`spell_id`),
  UNIQUE KEY `spell_name_UNIQUE` (`spell_name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spells`
--

LOCK TABLES `spells` WRITE;
/*!40000 ALTER TABLE `spells` DISABLE KEYS */;
INSERT INTO `spells` VALUES (1,'Heal I','This spell is a basic heal',0,1,'1','wisdom'),(2,'Heal II','This is a less basic heal',0,2,'2','wisdom'),(3,'Fire I','This is a basic fire damage spell',1,0,'1','intelligence'),(4,'Fire II','This is a less basic fire damage spell',2,0,'2','intelligence'),(5,'Magic Missile','Every mage should know this',3,0,'1','intelligence');
/*!40000 ALTER TABLE `spells` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'mydb'
--
/*!50003 DROP PROCEDURE IF EXISTS `create_armor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_armor`(a_name VARCHAR(64),a_weight INT,a_description VARCHAR(140),a_rating INT,a_type ENUM('light','medium','heavy'))
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_character` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_character`(
    character_name_param	VARCHAR(24),
    class_name_param	VARCHAR(64),
    player_email_param VARCHAR(24)
)
BEGIN
	INSERT INTO characters(character_name, class_id, player_id)
    VALUES (character_name_param, 
		(SELECT class_id FROM class WHERE class_name = class_name_param), 
        (SELECT player_id FROM players WHERE player_email = player_email_param));
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_melee_weapon` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_melee_weapon`(mw_name VARCHAR(64),mw_weight INT, mw_hit INT, mw_damage INT, 
	mw_type ENUM('simple','martial','exotic'), mw_reach INT, mw_attribute ENUM('strength', 'dexterity'),mw_desc VARCHAR(140))
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_new_class` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_new_class`(c_name VARCHAR(64),armor_prof ENUM('light','medium','heavy'), weapon_prof ENUM('simple','martial','exotic'),
	class_desc VARCHAR(140),c_attrb1 ENUM('strength','intelligence','dexterity','wisdom','charisma','constitution'), c_attrb2 ENUM('strength','intelligence','dexterity','wisdom','charisma','constitution'))
BEGIN
	DECLARE sql_error INT DEFAULT FALSE;
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    SET sql_error = TRUE;
    
    START TRANSACTION;
		
        INSERT INTO class(class_name,armor_proficiency,weapon_proficiency,class_description,attribute1,attribute2)
        VALUES (c_name, armor_prof, weapon_prof, class_desc, c_attrb1, c_attrb2);
        
        IF sql_error = FALSE THEN
			COMMIT;
            SELECT CONCAT('Class, ',mw_name, ', successfully added to game.') as Message;
		ELSE
			ROLLBACK;
            SELECT 'Class not successfully added to game' as Message;
		END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_new_skill` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_new_skill`(
	s_name VARCHAR(64), 
    s_desc VARCHAR(140), 
    s_attribute  ENUM('strength','intelligence','dexterity','wisdom','charisma','constitution')
)
BEGIN
	DECLARE sql_error INT DEFAULT FALSE;
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    SET sql_error = TRUE;
    
    START TRANSACTION;
    
    INSERT INTO skills(skill_name,skill_description,attribute)
        VALUES (s_name,s_desc,s_attribute);
        
        IF sql_error = FALSE THEN
			COMMIT;
            SELECT CONCAT('Skill, ',s_name, ', successfully added to game.') as Message;
		ELSE
			ROLLBACK;
            SELECT 'Skill not successfully added to game' as Message;
		END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_new_spell` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_new_spell`(s_name VARCHAR(64),s_desc VARCHAR(128),s_damage INT,
	s_healing INT,s_hit INT,s_attribute ENUM('intelligence','wisdom','charisma'))
BEGIN
	DECLARE sql_error INT DEFAULT FALSE;
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    SET sql_error = TRUE;
    
    START TRANSACTION;
		
        INSERT INTO spells(spell_name,spell_description,spell_damage,spell_healing,spell_hit,attribute)
        VALUES (s_name,s_desc,s_damage,s_healing,s_hit,s_attribute);
        
        IF sql_error = FALSE THEN
			COMMIT;
            SELECT CONCAT('Spell, ',s_name, ', successfully added to game.') as Message;
		ELSE
			ROLLBACK;
            SELECT 'Spell not successfully added to game' as Message;
		END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_player` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_player`(
    email_param	VARCHAR(64),
    fname_param	VARCHAR(64),
    lname_param	VARCHAR(64)
)
BEGIN
	INSERT INTO players (player_email, player_fname, player_lname)
    VALUES (email_param, fname_param, lname_param);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_ranged_weapon` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_ranged_weapon`(rw_name VARCHAR(64),rw_weight INT, rw_hit INT, rw_damage INT, 
	rw_type ENUM('simple','martial','exotic'), rw_distance INT, rw_attribute ENUM('strength', 'dexterity'),rw_description VARCHAR(140), rw_projectile VARCHAR(64))
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-06-20 12:46:46
