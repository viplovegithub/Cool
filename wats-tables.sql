-- MySQL dump 10.11
--
-- Host: localhost    Database: wats
-- ------------------------------------------------------
-- Server version	5.0.60-log

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
-- Table structure for table `assignment`
--

DROP TABLE IF EXISTS `assignment`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `assignment` (
  `assignmentID` bigint(20) unsigned NOT NULL auto_increment,
  `deviceID` varchar(50) NOT NULL,
  `personID` varchar(20) default NULL,
  `roomID` varchar(20) default NULL,
  `dateAssigned` datetime NOT NULL,
  `dateRemoved` datetime default NULL,
  PRIMARY KEY  (`assignmentID`),
  KEY `deviceID` (`deviceID`),
  KEY `roomID` (`roomID`),
  KEY `personID` (`personID`),
  CONSTRAINT `assignment_ibfk_1` FOREIGN KEY (`deviceID`) REFERENCES `device` (`deviceID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `assignment_ibfk_2` FOREIGN KEY (`roomID`) REFERENCES `room` (`roomID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `assignment_ibfk_3` FOREIGN KEY (`personID`) REFERENCES `person` (`personID`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=756 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `building`
--

DROP TABLE IF EXISTS `building`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `building` (
  `buildingID` bigint(20) unsigned NOT NULL auto_increment,
  `buildingName` varchar(50) default NULL,
  PRIMARY KEY  (`buildingID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `config`
--

DROP TABLE IF EXISTS `config`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `config` (
  `key` varchar(100) NOT NULL,
  `value` text,
  PRIMARY KEY  (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `device`
--

DROP TABLE IF EXISTS `device`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `device` (
  `deviceID` varchar(50) NOT NULL,
  `assetTag` int(10) unsigned default NULL,
  `deviceName` varchar(50) NOT NULL default '',
  `modelID` bigint(20) unsigned default '0',
  `value` decimal(10,2) default NULL,
  `dateInventoried` date NOT NULL,
  `inventoriedBy` varchar(20) NOT NULL default 'E777',
  `datePurchased` date default NULL,
  `dateRemoved` date default NULL,
  `statusID` bigint(20) unsigned default '1',
  PRIMARY KEY  (`deviceID`),
  KEY `modelID` (`modelID`),
  KEY `statusID` (`statusID`),
  KEY `inventoriedBy` (`inventoriedBy`),
  CONSTRAINT `device_ibfk_1` FOREIGN KEY (`modelID`) REFERENCES `model` (`modelID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `device_ibfk_2` FOREIGN KEY (`statusID`) REFERENCES `status` (`statusID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `device_ibfk_3` FOREIGN KEY (`inventoriedBy`) REFERENCES `person` (`personID`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `device_fetch_queue`
--

DROP TABLE IF EXISTS `device_fetch_queue`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `device_fetch_queue` (
  `deviceID` varchar(50) NOT NULL,
  `dateAdded` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`deviceID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `log`
--

DROP TABLE IF EXISTS `log`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `log` (
  `logID` bigint(20) unsigned NOT NULL auto_increment,
  `incidentDate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `level` enum('fatal','error','warning','notice','info','debug') default NULL,
  `user` varchar(100) NOT NULL default '',
  `subsystem` varchar(100) NOT NULL default '',
  `remoteAddress` varchar(100) NOT NULL default '',
  `error` text NOT NULL,
  PRIMARY KEY  (`logID`)
) ENGINE=InnoDB AUTO_INCREMENT=6507 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `model`
--

DROP TABLE IF EXISTS `model`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `model` (
  `modelID` bigint(20) unsigned NOT NULL auto_increment,
  `modelName` varchar(50) NOT NULL,
  `defaultValue` decimal(10,2) NOT NULL,
  `typeID` bigint(20) unsigned NOT NULL default '0',
  `vendorID` bigint(20) unsigned NOT NULL default '0',
  PRIMARY KEY  (`modelID`),
  KEY `typeID` (`typeID`),
  KEY `vendorID` (`vendorID`),
  CONSTRAINT `model_ibfk_1` FOREIGN KEY (`typeID`) REFERENCES `type` (`typeID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `model_ibfk_2` FOREIGN KEY (`vendorID`) REFERENCES `vendor` (`vendorID`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `person`
--

DROP TABLE IF EXISTS `person`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `person` (
  `personID` varchar(20) NOT NULL,
  `username` varchar(41) default NULL,
  `password` char(40) NOT NULL default '*',
  `email` varchar(100) NOT NULL default '',
  `nameFirst` varchar(40) NOT NULL default '',
  `nameLast` varchar(40) NOT NULL default '',
  `roomID` varchar(20) default NULL,
  `isCurrent` tinyint(1) NOT NULL default '1',
  PRIMARY KEY  (`personID`),
  KEY `roomID` (`roomID`),
  CONSTRAINT `person_ibfk_1` FOREIGN KEY (`roomID`) REFERENCES `room` (`roomID`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `person_role`
--

DROP TABLE IF EXISTS `person_role`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `person_role` (
  `personID` varchar(20) NOT NULL,
  `roleID` varchar(20) NOT NULL,
  PRIMARY KEY  (`personID`,`roleID`),
  CONSTRAINT `person_role_ibfk_1` FOREIGN KEY (`personID`) REFERENCES `person` (`personID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `preference`
--

DROP TABLE IF EXISTS `preference`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `preference` (
  `personID` varchar(20) NOT NULL,
  `preference` varchar(30) NOT NULL,
  `value` text,
  PRIMARY KEY  (`personID`,`preference`),
  CONSTRAINT `preference_ibfk_1` FOREIGN KEY (`personID`) REFERENCES `person` (`personID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `room`
--

DROP TABLE IF EXISTS `room`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `room` (
  `roomID` varchar(20) NOT NULL,
  `roomName` text,
  `floor` int(10) unsigned NOT NULL default '1',
  `buildingID` bigint(20) unsigned NOT NULL,
  PRIMARY KEY  (`roomID`),
  KEY `buildingID` (`buildingID`),
  CONSTRAINT `room_ibfk_1` FOREIGN KEY (`buildingID`) REFERENCES `building` (`buildingID`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `status`
--

DROP TABLE IF EXISTS `status`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `status` (
  `statusID` bigint(20) unsigned NOT NULL auto_increment,
  `statusName` varchar(50) NOT NULL,
  PRIMARY KEY  (`statusID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `type`
--

DROP TABLE IF EXISTS `type`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `type` (
  `typeID` bigint(20) unsigned NOT NULL auto_increment,
  `typeName` varchar(50) NOT NULL,
  PRIMARY KEY  (`typeID`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `vendor`
--

DROP TABLE IF EXISTS `vendor`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `vendor` (
  `vendorID` bigint(20) unsigned NOT NULL auto_increment,
  `vendorName` varchar(50) NOT NULL,
  `vendorPhone` varchar(30) NOT NULL default '',
  `supportPhone` varchar(30) NOT NULL default '',
  `supportURL` text,
  PRIMARY KEY  (`vendorID`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2008-09-29 17:27:20



---Some initial data to get the party started:

INSERT INTO `person` values (1, 'admin', SHA1('hackme'), "admin@localhost", "Administrative", "User", NULL, 1 );


INSERT INTO `config` VALUES 
	('unixroot', '/var/www/localhost/htdocs/wats'),
	('webroot', 'http://localhost/wats'),
	('themedir', 'http://localhost/wats/themes'),
	('theme', 'example1');
