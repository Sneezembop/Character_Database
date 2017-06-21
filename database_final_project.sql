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
INSERT INTO `character_equipment` VALUES (30,1,1),(30,7,1),(30,9,1),(30,13,1);
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
  `character_level` int(11) NOT NULL DEFAULT '1',
  `player_id` int(11) NOT NULL,
  `strength` int(11) NOT NULL DEFAULT '0',
  `dexterity` int(11) NOT NULL DEFAULT '0',
  `constitution` int(11) NOT NULL DEFAULT '0',
  `intelligence` int(11) NOT NULL DEFAULT '0',
  `wisdom` int(11) NOT NULL DEFAULT '0',
  `charisma` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`character_id`),
  UNIQUE KEY `character_name_UNIQUE` (`character_name`),
  KEY `class_id_fk_idx` (`class_id`),
  KEY `player_id_fk_idx` (`player_id`),
  CONSTRAINT `class_id_fk` FOREIGN KEY (`class_id`) REFERENCES `class` (`class_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `player_id_fk` FOREIGN KEY (`player_id`) REFERENCES `players` (`player_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `characters`
--

LOCK TABLES `characters` WRITE;
/*!40000 ALTER TABLE `characters` DISABLE KEYS */;
INSERT INTO `characters` VALUES (30,'Goku',1,2,1,10,8,10,8,8,8);
/*!40000 ALTER TABLE `characters` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER create_health_points
	AFTER INSERT ON characters
    FOR EACH ROW
BEGIN
    INSERT INTO health_points
    VALUES (NEW.character_id,5 + NEW.constitution,5 + NEW.constitution);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

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
INSERT INTO `class_equipment_loadout` VALUES (1,7,1),(1,9,1),(2,1,1),(2,13,1),(3,5,1),(3,11,1);
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
INSERT INTO `class_skills` VALUES (1,1,1),(1,2,1),(2,4,1),(3,6,1);
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
INSERT INTO `class_spells` VALUES (2,1,3),(2,2,8),(2,3,1),(2,4,6),(2,5,5),(3,1,1),(3,2,3);
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
-- Table structure for table `health_points`
--

DROP TABLE IF EXISTS `health_points`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `health_points` (
  `character_id` int(11) NOT NULL,
  `total_health_points` int(11) NOT NULL DEFAULT '5',
  `current_health_points` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`character_id`),
  CONSTRAINT `character_id_fk_hp` FOREIGN KEY (`character_id`) REFERENCES `characters` (`character_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `health_points`
--

LOCK TABLES `health_points` WRITE;
/*!40000 ALTER TABLE `health_points` DISABLE KEYS */;
INSERT INTO `health_points` VALUES (30,21,21);
/*!40000 ALTER TABLE `health_points` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER get_starter_equip
	AFTER INSERT ON health_points
    FOR EACH ROW
BEGIN
    INSERT INTO character_equipment
    SELECT c.character_id, equipment_id, quantity
    FROM class_equipment_loadout JOIN class join characters c
    ON class.class_id = class_equipment_loadout.class_id
    AND c.class_id = class.class_id
    WHERE class.class_id = (SELECT class_id FROM characters WHERE character_id = NEW.character_id);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER health_point_update
	BEFORE UPDATE ON health_points
    FOR EACH ROW
BEGIN
	IF NEW.current_health_points > NEW.total_health_points THEN
		SET NEW.current_health_points = NEW.total_health_points;
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

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
  `game_admin` enum('Y','N') NOT NULL DEFAULT 'N',
  PRIMARY KEY (`player_id`,`player_email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `players`
--

LOCK TABLES `players` WRITE;
/*!40000 ALTER TABLE `players` DISABLE KEYS */;
INSERT INTO `players` VALUES (1,'test_user@thebestgame.com','Test','User','N');
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
-- Dumping events for database 'mydb'
--
/*!50106 SET @save_time_zone= @@TIME_ZONE */ ;
/*!50106 DROP EVENT IF EXISTS `increase_health_event` */;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8 */ ;;
/*!50003 SET character_set_results = utf8 */ ;;
/*!50003 SET collation_connection  = utf8_general_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`root`@`localhost`*/ /*!50106 EVENT `increase_health_event` ON SCHEDULE EVERY 30 SECOND STARTS '2017-06-20 23:33:46' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
    UPDATE health_points
    SET health_points = health_points + 1;
END */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
DELIMITER ;
/*!50106 SET TIME_ZONE= @save_time_zone */ ;

--
-- Dumping routines for database 'mydb'
--
/*!50003 DROP FUNCTION IF EXISTS `calculate_attribute_value` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `calculate_attribute_value`(
	c_id INT,
    attribute ENUM('strength','dexterity','constitution','intelligence','wisdom','charisma'),
    char_level INT
) RETURNS int(11)
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `assign_armor_class` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `assign_armor_class`(
	class_name_param VARCHAR(64),
    armor_name_param VARCHAR(64),
    quantity_param INT
)
BEGIN
	DECLARE sql_error INT DEFAULT FALSE;
    
	DECLARE a_id INT;
    DECLARE class_prof ENUM('light','medium','heavy');
    DECLARE a_type ENUM('light','medium','heavy');
    DECLARE c_id INT;
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    SET sql_error = TRUE;
    
    SELECT equipment_id INTO a_id
    FROM equipment
    WHERE equipment_name = armor_name_param;
    
    SELECT class_id into c_id
    FROM class
    WHERE class_name = class_name_param;
    
    SELECT armor_proficiency INTO class_prof
	FROM class
    WHERE class_id = c_id;
    
    SELECT armor_type INTO a_type
    FROM armor
    WHERE a_id = equipment_id;
    
    IF sql_error = FALSE THEN
		CASE
			WHEN class_prof = 'light' THEN
				IF a_type = 'light' THEN
					INSERT INTO class_equipment_loadout
					VALUES(c_id,a_id,quantity_param);
					SELECT('Armor assignment successful') as Message;
				ELSE 
					SELECT('Armor assignment failed due to proficiency conflict') as Message;
				END IF;
			WHEN class_prof = 'medium' THEN
				IF a_type = 'heavy' THEN
					SELECT 'Armor assignment failed due to proficiency conflict' as Message;
				ELSE
					INSERT INTO class_equipment_loadout
					VALUES(c_id,a_id,quantity_param);
					SELECT('Armor assignment successful') as Message;
				END IF;
			WHEN class_prof = 'heavy' THEN
				INSERT INTO class_equipment_loadout
				VALUES(c_id,a_id,quantity_param);
				SELECT('Armor assignment successful') as Message;
		END CASE;
	ELSE
		SELECT 'Database error on armor assignment' as Message;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `assign_misc_equipment_class` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `assign_misc_equipment_class`(
	class_name_param VARCHAR(64),
    equipment_name_param VARCHAR(64),
    quantity_param INT
)
BEGIN
	DECLARE sql_error INT DEFAULT FALSE;
    
	DECLARE c_id INT;
    DECLARE e_id INT;
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    SET sql_error = TRUE;
    
    SELECT equipment_id INTO e_id
    FROM equipment
    WHERE equipment_name = equipment_name_param;
    
    SELECT class_id into c_id
    FROM class
    WHERE class_name = class_name_param;
    
    IF sql_error = FALSE THEN
		INSERT INTO class_equipment_loadout
		VALUES(c_id,e_id,quantity_param);
		SELECT('Equipment assignment successful') as Message;
	ELSE 
		SELECT('Equipment assignment failed') as Message;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `assign_skills_class` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `assign_skills_class`(
	class_name_param VARCHAR(64),
    skill_name_param VARCHAR(64),
    level_param INT
)
BEGIN
	DECLARE sql_error INT DEFAULT FALSE;
    
	DECLARE c_id INT;
    DECLARE s_id INT;
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    SET sql_error = TRUE;
    
    SELECT skill_id INTO s_id
    FROM skills
    WHERE skill_name = skill_name_param;
    
    SELECT class_id into c_id
    FROM class
    WHERE class_name = class_name_param;
    
    IF sql_error = FALSE THEN
		INSERT INTO class_skills
		VALUES(c_id,s_id,level_param);
		SELECT('Skill assignment successful') as Message;
	ELSE 
		SELECT('Skill assignment failed') as Message;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `assign_spells_class` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `assign_spells_class`(
	class_name_param VARCHAR(64),
    spell_name_param VARCHAR(64),
    level_param INT
)
BEGIN
	DECLARE sql_error INT DEFAULT FALSE;
    
	DECLARE c_id INT;
    DECLARE s_id INT;
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    SET sql_error = TRUE;
    
    SELECT spell_id INTO s_id
    FROM spells
    WHERE spell_name = spell_name_param;
    
    SELECT class_id into c_id
    FROM class
    WHERE class_name = class_name_param;
    
    IF sql_error = FALSE THEN
		INSERT INTO class_spells
		VALUES(c_id,s_id,level_param);
		SELECT('Spell assignment successful') as Message;
	ELSE 
		SELECT('Spell assignment failed') as Message;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `assign_weapon_class` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `assign_weapon_class`(
	class_name_param VARCHAR(64),
    weapon_name_param VARCHAR(64),
    quantity_param INT,
    ranged_melee ENUM('ranged','melee')
)
BEGIN
	DECLARE sql_error INT DEFAULT FALSE;
    
	DECLARE c_id INT;
    DECLARE class_prof ENUM('simple','martial','exotic');
    DECLARE w_type ENUM('simple','martial','exotic');
    DECLARE w_id INT;
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    SET sql_error = TRUE;
    
    SELECT equipment_id INTO w_id
    FROM equipment
    WHERE equipment_name = weapon_name_param;
    
    SELECT class_id into c_id
    FROM class
    WHERE class_name = class_name_param;
    
    IF ranged_melee = 'ranged' THEN
		SELECT weapon_type INTO w_type
		FROM ranged_weapons
		WHERE w_id = equipment_id;
	ELSE
		SELECT weapon_type INTO w_type
		FROM melee_weapons
		WHERE w_id = equipment_id;
	END IF;
    
	SELECT weapon_proficiency INTO class_prof
	FROM class
    WHERE class_id = c_id;
    
    IF sql_error = FALSE THEN
		CASE
			WHEN class_prof = 'simple' THEN
				IF w_type = 'simple' THEN
					INSERT INTO class_equipment_loadout
					VALUES(c_id,w_id,quantity_param);
					SELECT('Weapon assignment successful') as Message;
				ELSE 
					SELECT('Weapon assignment failed due to proficiency conflict') as Message;
				END IF;
			WHEN class_prof = 'martial' THEN
				IF w_type = 'exotic' THEN
					SELECT 'Weapon assignment failed due to proficiency conflict' as Message;
				ELSE
					INSERT INTO class_equipment_loadout
					VALUES(c_id,w_id,quantity_param);
					SELECT('Weapon assignment successful') as Message;
				END IF;
			WHEN class_prof = 'exotic' THEN
				INSERT INTO class_equipment_loadout
				VALUES(c_id,w_id,quantity_param);
				SELECT('Weapon assignment successful') as Message;
		END CASE;
	ELSE
		SELECT 'Database error on weapon assignment' as Message;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `change_char_name` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `change_char_name`(
    old_name_param	VARCHAR(64),
    new_name_param	VARCHAR(64)
)
BEGIN
	DECLARE sql_error INT DEFAULT FALSE;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    SET sql_error = TRUE;
        
	UPDATE characters
	SET character_name = new_name_param
	WHERE character_name = old_name_param;


	IF sql_error = FALSE THEN
		COMMIT;
		SELECT CONCAT(old_name_param, ', successfully changed to ', new_name_param) as Message;
	ELSE
		ROLLBACK;
		SELECT 'Character name change was not successful' as Message;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `change_class` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `change_class`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `character_level_up` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `character_level_up`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_armor`(
	a_name VARCHAR(64),
    a_weight INT,
    a_description VARCHAR(140),
    a_rating INT,
    a_type ENUM('light','medium','heavy')
)
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
    character_name_param	VARCHAR(64),
    class_name_param	VARCHAR(64),
    player_email_param VARCHAR(64)
)
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_melee_weapon`(
	mw_name VARCHAR(64),
    mw_weight INT, 
    mw_hit INT, 
    mw_damage INT, 
	mw_type ENUM('simple','martial','exotic'), 
    mw_reach INT, 
    mw_attribute ENUM('strength', 'dexterity'),
    mw_desc VARCHAR(140)
)
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_new_class`(
	c_name VARCHAR(64),
    armor_prof ENUM('light','medium','heavy'), 
    weapon_prof ENUM('simple','martial','exotic'),
	class_desc VARCHAR(140),
    c_attrb1 ENUM('strength','intelligence','dexterity','wisdom','charisma','constitution'), 
    c_attrb2 ENUM('strength','intelligence','dexterity','wisdom','charisma','constitution')
)
BEGIN
	DECLARE sql_error INT DEFAULT FALSE;
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    SET sql_error = TRUE;
		
	INSERT INTO class(class_name,armor_proficiency,weapon_proficiency,class_description,attribute1,attribute2)
	VALUES (c_name, armor_prof, weapon_prof, class_desc, c_attrb1, c_attrb2);
        
	IF sql_error = FALSE THEN
		SELECT CONCAT('Class, ',mw_name, ', successfully added to game.') as Message;
	ELSE
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
        
    INSERT INTO skills(skill_name,skill_description,attribute)
        VALUES (s_name,s_desc,s_attribute);
        
	IF sql_error = FALSE THEN
		SELECT CONCAT('Skill, ',s_name, ', successfully added to game.') as Message;
	ELSE
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_new_spell`(
	s_name VARCHAR(64),
    s_desc VARCHAR(128),
    s_damage INT,
	s_healing INT,
    s_hit INT,
    s_attribute ENUM('intelligence','wisdom','charisma')
)
BEGIN
	DECLARE sql_error INT DEFAULT FALSE;
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    SET sql_error = TRUE;

	INSERT INTO spells(spell_name,spell_description,spell_damage,spell_healing,spell_hit,attribute)
	VALUES (s_name,s_desc,s_damage,s_healing,s_hit,s_attribute);
        
	IF sql_error = FALSE THEN
		SELECT CONCAT('Spell, ',s_name, ', successfully added to game.') as Message;
	ELSE
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_ranged_weapon`(
	rw_name VARCHAR(64),
    rw_weight INT, rw_hit INT,
    rw_damage INT, 
    rw_type ENUM('simple','martial','exotic'), 
    rw_distance INT, rw_attribute ENUM('strength', 'dexterity'),
    rw_description VARCHAR(140), rw_projectile VARCHAR(64)
)
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
/*!50003 DROP PROCEDURE IF EXISTS `delete_character` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_character`(
    character_name_param	VARCHAR(64)
)
BEGIN
	DECLARE sql_error INT DEFAULT FALSE;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    SET sql_error = TRUE;
        
	DELETE FROM characters
	WHERE character_name = character_name_param;
	
	IF sql_error = FALSE THEN
		COMMIT;
		SELECT CONCAT('Character , ',character_name_param, ', successfully deleted from game.') as Message;
	ELSE
		ROLLBACK;
		SELECT 'Character deletion was not successful' as Message;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_class` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_class`(
    class_name_param	VARCHAR(64)
)
BEGIN
	DECLARE sql_error INT DEFAULT FALSE;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    SET sql_error = TRUE;
        
	DELETE FROM class
	WHERE class_name = class_name_param;
	
	IF sql_error = FALSE THEN
		COMMIT;
		SELECT CONCAT('Class , ',class_name_param, ', successfully deleted from game.') as Message;
	ELSE
		ROLLBACK;
		SELECT 'Class deletion was not successful' as Message;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_equipment` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_equipment`(
    equipment_name_param	VARCHAR(64)
)
BEGIN
	DECLARE sql_error INT DEFAULT FALSE;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    SET sql_error = TRUE;
        
	DELETE FROM equipment
	WHERE equipment_name = equipment_name_param;
	
	IF sql_error = FALSE THEN
		COMMIT;
		SELECT CONCAT('Equipment , ',equipment_name_param, ', successfully deleted from game.') as Message;
	ELSE
		ROLLBACK;
		SELECT 'Equipment deletion was not successful' as Message;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_player` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_player`(
    player_email_param	VARCHAR(64)
)
BEGIN
	DECLARE sql_error INT DEFAULT FALSE;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    SET sql_error = TRUE;
        
	DELETE FROM players
	WHERE player_email = player_email_param;
	
	IF sql_error = FALSE THEN
		COMMIT;
		SELECT CONCAT('Player , ',player_email_param, ', successfully deleted from game.') as Message;
	ELSE
		ROLLBACK;
		SELECT 'Player deletion was not successful' as Message;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_skills` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_skills`(
    skill_name_param	VARCHAR(64)
)
BEGIN
	DECLARE sql_error INT DEFAULT FALSE;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    SET sql_error = TRUE;
        
	DELETE FROM skills
	WHERE skill_name = skill_name_param;
	
	IF sql_error = FALSE THEN
		COMMIT;
		SELECT CONCAT('Skill , ',skill_name_param, ', successfully deleted from game.') as Message;
	ELSE
		ROLLBACK;
		SELECT 'Skill deletion was not successful' as Message;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_spells` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_spells`(
    spell_name_param	VARCHAR(64)
)
BEGIN
	DECLARE sql_error INT DEFAULT FALSE;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    SET sql_error = TRUE;
        
	DELETE FROM spells
	WHERE spell_name = spells_name_param;
	
	IF sql_error = FALSE THEN
		COMMIT;
		SELECT CONCAT('Spell , ',spell_name_param, ', successfully deleted from game.') as Message;
	ELSE
		ROLLBACK;
		SELECT 'Spell deletion was not successful' as Message;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `new_char_stats` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `new_char_stats`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `player_email_change` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `player_email_change`(
		old_email_param	VARCHAR(64),
		new_email_param	VARCHAR(64)
	)
BEGIN
	DECLARE sql_error INT DEFAULT FALSE;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    SET sql_error = TRUE;
        
	UPDATE players
	SET player_email = new_email_param
	WHERE player_email = old_email_param;

	IF sql_error = FALSE THEN
		COMMIT;
		SELECT CONCAT(old_email_param, ', successfully changed to ', new_email_param) as Message;
	ELSE
		ROLLBACK;
		SELECT 'Player email change was not successful' as Message;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `read_all_characters` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `read_all_characters`(
	player_email_param	VARCHAR(64)
)
BEGIN        
	SELECT character_name
	FROM characters, players WHERE players.player_id = characters.player_id AND players.player_email = player_email_param;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `read_all_players` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `read_all_players`()
BEGIN        
	SELECT *
	FROM players;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `read_basic_char_info` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `read_basic_char_info`(
	char_id_param	INT
)
BEGIN        
	SELECT c.character_name, c.character_level, cl.class_name, h.current_health_points, h.total_health_points
	FROM characters c join class cl join health_points h
		on c.class_id = cl.class_id
        AND c.character_id = h.character_id
    WHERE c.character_id = char_id_param;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `read_character_detail` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `read_character_detail`(
	char_name_param	VARCHAR(64)
)
BEGIN        
	SELECT *
	FROM characters
    WHERE character_name = char_name_param;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `read_equipment_detail` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `read_equipment_detail`(
	char_id_param	INT
)
BEGIN        
	SELECT *
	FROM character_equipment ce join equipment e 
		ON ce.equip_id = e.equipment_id
    WHERE ce.char_id = char_id_param;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `read_player_detail` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `read_player_detail`(
	player_email_param	VARCHAR(64)
)
BEGIN        
	SELECT *
	FROM players
    WHERE player_email = player_email_param;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `read_skills_detail` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `read_skills_detail`(
	char_id_param	INT
)
BEGIN        
	SELECT *
	FROM class_skills cs join skills join characters c
		ON cs.skill_id = skills.skill_id
        AND c.class_id = cs.class_id
    WHERE c.character_id = char_id_param;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `read_spells_detail` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `read_spells_detail`(
	char_id_param	INT
)
BEGIN        
	SELECT *
	FROM class_spells cs join spells join characters c
		ON cs.spell_id = spells.spell_id
        AND c.class_id = cs.class_id
    WHERE c.character_id = char_id_param;
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

-- Dump completed on 2017-06-21  0:33:44
