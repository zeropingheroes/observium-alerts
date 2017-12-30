-- MySQL dump 10.13  Distrib 5.7.20, for Linux (x86_64)
--
-- Host: localhost    Database: observium
-- ------------------------------------------------------
-- Server version	5.7.20-0ubuntu0.16.04.1

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
-- Table structure for table `alert_tests`
--

DROP TABLE IF EXISTS `alert_tests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `alert_tests` (
  `alert_test_id` int(11) NOT NULL AUTO_INCREMENT,
  `entity_type` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `alert_name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `alert_message` text COLLATE utf8_unicode_ci NOT NULL,
  `conditions` text CHARACTER SET utf8 NOT NULL,
  `conditions_warn` text COLLATE utf8_unicode_ci,
  `and` tinyint(1) NOT NULL DEFAULT '1',
  `severity` enum('crit','err') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'crit',
  `delay` int(11) DEFAULT '0',
  `alerter` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `enable` tinyint(1) NOT NULL DEFAULT '1',
  `show_frontpage` int(1) NOT NULL DEFAULT '1',
  `suppress_recovery` tinyint(1) DEFAULT '0',
  `ignore_until` datetime DEFAULT NULL,
  PRIMARY KEY (`alert_test_id`),
  UNIQUE KEY `alert_name` (`alert_name`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alert_tests`
--

LOCK TABLES `alert_tests` WRITE;
/*!40000 ALTER TABLE `alert_tests` DISABLE KEYS */;
INSERT INTO `alert_tests` VALUES (1,'sensor','Current above threshold','','[{\"value\":\"alert\",\"condition\":\"eq\",\"metric\":\"sensor_event\"},{\"value\":\"warning\",\"condition\":\"eq\",\"metric\":\"sensor_event\"}]',NULL,0,'crit',0,'',1,1,0,NULL),(2,'device','Device down','','[{\"value\":\"0\",\"condition\":\"equals\",\"metric\":\"device_status\"}]',NULL,1,'crit',0,'',1,1,0,NULL),(3,'processor','CPU usage above 80%','','[{\"value\":\"80\",\"condition\":\"greater\",\"metric\":\"processor_usage\"}]',NULL,1,'crit',0,'',1,1,0,NULL),(5,'storage','Storage usage above 80%','','[{\"value\":\"80\",\"condition\":\"ge\",\"metric\":\"storage_perc\"}]',NULL,1,'crit',0,'',1,1,0,NULL),(6,'port','Port errors','','[{\"value\":\"1\",\"condition\":\"gt\",\"metric\":\"ifInErrors_rate\"},{\"value\":\"1\",\"condition\":\"gt\",\"metric\":\"ifOutErrors_rate\"}]',NULL,0,'crit',0,'',1,1,0,NULL),(7,'sensor','Fan speed outside threshold','','[{\"value\":\"@sensor_limit\",\"condition\":\"greater\",\"metric\":\"sensor_value\"},{\"value\":\"@sensor_limit_low\",\"condition\":\"less\",\"metric\":\"sensor_value\"}]',NULL,0,'crit',0,'',1,1,0,NULL),(8,'sensor','Temperature outside threshold','','[{\"value\":\"@sensor_limit\",\"condition\":\"greater\",\"metric\":\"sensor_value\"},{\"value\":\"@sensor_limit_low\",\"condition\":\"less\",\"metric\":\"sensor_value\"}]',NULL,0,'crit',0,'',1,1,0,NULL),(9,'port','Traffic above 80%','','[{\"metric\":\"ifInOctets_perc\",\"condition\":\"ge\",\"value\":\"90\"},{\"metric\":\"ifOutOctets_perc\",\"condition\":\"ge\",\"value\":\"90\"}]',NULL,0,'crit',0,'',1,1,0,NULL),(10,'port','Port MTU below 1500','','[{\"metric\":\"ifMtu\",\"condition\":\"lt\",\"value\":\"1500\"}]',NULL,1,'crit',0,'',1,1,0,NULL),(11,'device','Device rebooted','','[{\"metric\":\"device_uptime\",\"condition\":\"le\",\"value\":\"300\"}]',NULL,1,'crit',0,'',1,1,0,NULL),(12,'mempool','RAM usage above 80%','','[{\"metric\":\"mempool_perc\",\"condition\":\"ge\",\"value\":\"80\"}]',NULL,1,'crit',0,'',1,1,0,NULL);
/*!40000 ALTER TABLE `alert_tests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alert_assoc`
--

DROP TABLE IF EXISTS `alert_assoc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `alert_assoc` (
  `alert_assoc_id` int(11) NOT NULL AUTO_INCREMENT,
  `alert_test_id` int(11) NOT NULL,
  `entity_type` varchar(64) CHARACTER SET utf8 NOT NULL,
  `device_attribs` text COLLATE utf8_unicode_ci,
  `entity_attribs` text CHARACTER SET utf8,
  `enable` tinyint(1) NOT NULL DEFAULT '1',
  `alerter` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `severity` int(11) DEFAULT NULL,
  `count` int(11) DEFAULT NULL,
  PRIMARY KEY (`alert_assoc_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alert_assoc`
--

LOCK TABLES `alert_assoc` WRITE;
/*!40000 ALTER TABLE `alert_assoc` DISABLE KEYS */;
INSERT INTO `alert_assoc` VALUES (1,1,'sensor','[{\"attrib\":\"*\",\"condition\":null,\"value\":null}]','[{\"attrib\":\"sensor_class\",\"condition\":\"equals\",\"value\":\"current\"}]',1,NULL,NULL,NULL),(2,2,'device','[{\"value\":null,\"condition\":null,\"metric\":\"device_status\",\"attrib\":\"*\"}]','[{\"value\":null,\"condition\":null,\"metric\":\"device_status\",\"attrib\":\"*\"}]',1,NULL,NULL,NULL),(3,3,'processor','[{\"attrib\":\"*\",\"condition\":null,\"value\":null}]','[{\"attrib\":\"processor_descr\",\"condition\":\"match\",\"value\":\"*average*\"}]',1,NULL,NULL,NULL),(5,5,'storage','[{\"attrib\":\"*\",\"condition\":null,\"value\":null}]','[{\"attrib\":\"storage_type\",\"condition\":\"equals\",\"value\":\"hrStorageFixedDisk\"},{\"attrib\":\"storage_descr\",\"condition\":\"notmatch\",\"value\":\"*boot*\"}]',1,NULL,NULL,NULL),(6,6,'port','[{\"value\":null,\"condition\":null,\"metric\":\"ifOutErrors_rate\",\"attrib\":\"*\"}]','[{\"value\":\"ethernetCsmacd\",\"condition\":\"equals\",\"metric\":\"ifOutErrors_rate\",\"attrib\":\"ifType\"}]',1,NULL,NULL,NULL),(7,7,'sensor','[{\"value\":null,\"condition\":null,\"metric\":\"sensor_value\",\"attrib\":\"*\"}]','[{\"value\":\"fanspeed\",\"condition\":\"equals\",\"metric\":\"sensor_value\",\"attrib\":\"sensor_class\"}]',1,NULL,NULL,NULL),(8,8,'sensor','[{\"value\":null,\"condition\":null,\"metric\":\"sensor_value\",\"attrib\":\"*\"}]','[{\"value\":\"temperature\",\"condition\":\"equals\",\"metric\":\"sensor_value\",\"attrib\":\"sensor_class\"}]',1,NULL,NULL,NULL),(9,9,'port','[{\"metric\":\"ifOutOctets_perc\",\"condition\":null,\"value\":null,\"attrib\":\"*\"}]','[{\"metric\":\"ifOutOctets_perc\",\"condition\":null,\"value\":null,\"attrib\":\"*\"}]',1,NULL,NULL,NULL),(10,10,'port','[{\"metric\":\"ifMtu\",\"condition\":null,\"value\":null,\"attrib\":\"*\"}]','[{\"metric\":\"ifMtu\",\"condition\":\"equals\",\"value\":\"ethernetCsmacd\",\"attrib\":\"ifType\"}]',1,NULL,NULL,NULL),(11,11,'device','[{\"metric\":\"device_rebooted\",\"condition\":null,\"value\":null,\"attrib\":\"*\"}]','[{\"metric\":\"device_rebooted\",\"condition\":null,\"value\":null,\"attrib\":\"*\"}]',1,NULL,NULL,NULL),(12,12,'mempool','[{\"metric\":\"mempool_perc\",\"condition\":null,\"value\":null,\"attrib\":\"*\"}]','[{\"metric\":\"mempool_perc\",\"condition\":\"match\",\"value\":\"*physical*\",\"attrib\":\"mempool_descr\"}]',1,NULL,NULL,NULL),(14,5,'storage','[{\"attrib\":\"os\",\"condition\":\"is\",\"value\":\"pfsense\"}]','[{\"attrib\":\"storage_descr\",\"condition\":\"match\",\"value\":\"*default*\"}]',1,NULL,NULL,NULL);
/*!40000 ALTER TABLE `alert_assoc` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-12-30  0:13:12
