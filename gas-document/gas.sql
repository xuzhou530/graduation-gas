-- MySQL dump 10.13  Distrib 5.6.10, for Win32 (x86)
--
-- Host: localhost    Database: gas
-- ------------------------------------------------------
-- Server version	5.6.10

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
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `address` (
  `address_id` int(11) NOT NULL AUTO_INCREMENT,
  `address_district` varchar(15) NOT NULL,
  `address_area` varchar(15) NOT NULL,
  `address_location` varchar(45) NOT NULL,
  `address_buildings` int(11) NOT NULL,
  `address_customers` int(11) NOT NULL,
  `address_desicribe` varchar(45) NOT NULL,
  PRIMARY KEY (`address_id`),
  UNIQUE KEY `address_district` (`address_district`,`address_area`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address`
--

LOCK TABLES `address` WRITE;
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
INSERT INTO `address` VALUES (34,'利州区','黄金小区','利州区黄金东路222号',0,200,'利州区的小区之一'),(35,'利州区','和苑小区','利州区利州东路110',12,200,'兴建于1990年'),(36,'利州区','东风小区','利州区环城路10号',20,190,'无'),(37,'昭化区','九溪江南','昭化区昭化东路',14,280,'无'),(39,'利州区','常发豪郡','金阳东路',12,100,'无'),(40,'昭化区','智能小区','赵湖东路11号',12,222,'智能小区'),(41,'利州区','世纪之城','利州区环城路11号',23,300,'无'),(43,'朝天区','锦江花园','朝天区朝天路119号',23,222,'无');
/*!40000 ALTER TABLE `address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer` (
  `customer_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_name` varchar(15) NOT NULL,
  `customer_phone` varchar(15) NOT NULL,
  `address_district` varchar(15) NOT NULL,
  `address_area` varchar(20) NOT NULL,
  `address_building` int(11) NOT NULL,
  `address_layer` int(11) NOT NULL,
  `address_room` int(11) NOT NULL,
  `meter` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`customer_id`),
  KEY `address_district` (`address_district`,`address_area`)
) ENGINE=InnoDB AUTO_INCREMENT=1026 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1,'veyoung','123421312','利州区','和苑小区',13,23,100,NULL),(2,'余扬','132132131','利州区','和苑小区',17,121,21,NULL),(100,'dddd','312312','利州区','和苑小区',121,21,21,NULL),(101,'2312','312321','利州区','黄金小区',1,1,1,NULL),(200,'杨娜','323232','利州区','黄金小区',2,212,211,NULL),(201,'易翠','1212121','利州区','黄金小区',2,1111,1111,NULL),(202,'黄冬冬','3231232','利州区','黄金小区',1,11,111,NULL),(203,'刘俊','13311111111','利州区','和苑小区',1,12,222,NULL),(204,'范作伟','111111','利州区','和苑小区',1,2121,2121,NULL),(1006,'fhangs','321421321','利州区','黄金小区',1,12,31,NULL),(1007,'eeee','321421321','利州区','黄金小区',1,12,31,NULL),(1008,'fff','321421321','利州区','黄金小区',1,12,31,NULL),(1009,'gg','321421321','利州区','黄金小区',1,12,31,NULL),(1010,'vvvv','321421321','利州区','黄金小区',1,12,31,NULL),(1011,'ddd','321421321','利州区','黄金小区',1,12,31,NULL),(1012,'qqq','321421321','利州区','黄金小区',1,12,31,NULL),(1013,'ffff','321421321','利州区','黄金小区',1,12,31,NULL),(1014,'nnnnn','321421321','利州区','黄金小区',1,12,31,NULL),(1015,'fffffff','321421321','利州区','黄金小区',1,12,31,NULL),(1016,'ddd','321421321','利州区','黄金小区',1,12,31,NULL),(1017,'eee','321421321','利州区','黄金小区',1,12,31,NULL),(1018,'fff','321421321','利州区','黄金小区',1,12,31,NULL),(1019,'ggg','321421321','利州区','黄金小区',1,12,31,NULL),(1020,'qqqq','321421321','利州区','黄金小区',1,12,31,NULL),(1021,'ppp','321421321','利州区','黄金小区',1,21,33,NULL),(1022,'lll','321421321','利州区','黄金小区',1,2,3,NULL),(1023,'kkkkk','321421321','利州区','黄金小区',1,12,44,NULL),(1024,'jjjjjj','321421321','利州区','黄金小区',1,1,55,NULL),(1025,'mmmmmm','321421321','利州区','黄金小区',1,21,6,NULL);
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gas`
--

DROP TABLE IF EXISTS `gas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gas` (
  `gas_id` int(11) NOT NULL AUTO_INCREMENT,
  `collect_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `gas_value` int(11) NOT NULL,
  `previous_value` int(11) NOT NULL,
  `gas_money` int(11) NOT NULL,
  `flag` int(11) NOT NULL DEFAULT '0',
  `customer_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`gas_id`),
  KEY `fk_gas_meter1_idx` (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gas`
--

LOCK TABLES `gas` WRITE;
/*!40000 ALTER TABLE `gas` DISABLE KEYS */;
INSERT INTO `gas` VALUES (1,'2014-06-24 08:39:30',110,100,23,0,203),(2,'2014-06-24 08:39:31',210,200,13,0,204),(3,'2015-03-14 15:30:40',222,211,13,0,101),(4,'2015-03-14 15:30:53',444,333,1,0,202),(5,'2015-03-15 06:37:37',333,22,1,0,1006),(6,'2015-03-15 06:37:40',333,2,1,0,1007),(7,'2015-03-15 06:37:43',33,2,1,0,1008),(8,'2015-03-15 12:16:35',3,2,1,0,1009),(9,'2015-03-15 12:16:37',33,2,2,0,1010),(10,'2015-03-15 12:16:38',333,2,3,0,1011),(11,'2015-03-15 12:16:36',333,2,1,0,1012),(12,'2015-03-15 12:16:39',33,2,4,0,1013),(13,'2015-03-15 07:10:05',33,2,1,0,1014),(14,'2015-03-15 07:10:07',3,2,1,0,1015),(15,'2015-03-15 07:10:10',333,2,1,0,1016),(16,'2015-03-15 07:10:13',33,2,1,0,1017),(17,'2015-03-15 07:10:16',33,2,1,0,1018),(18,'2015-03-15 07:10:20',33,2,1,0,1019),(19,'2015-03-15 07:10:25',33,2,1,0,1020),(20,'2015-03-15 07:10:28',33,2,1,0,1021),(21,'2015-03-15 07:10:32',33,2,1,0,1022),(22,'2015-03-15 12:16:42',44,2,6,0,1023),(23,'2015-03-15 07:13:49',55,3,2,0,1024),(24,'2015-03-15 07:13:51',66,5,52,0,1025),(25,'2015-03-15 07:13:44',7,6,42,0,NULL);
/*!40000 ALTER TABLE `gas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `meter`
--

DROP TABLE IF EXISTS `meter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `meter` (
  `meter_id` int(11) NOT NULL,
  `address_district` varchar(45) NOT NULL,
  `address_area` varchar(45) NOT NULL,
  `address_building` int(11) NOT NULL,
  `address_layer` int(11) NOT NULL,
  `address_room` int(11) NOT NULL,
  `identify` varchar(45) NOT NULL,
  `meter_status` tinyint(4) NOT NULL,
  `backup` varchar(45) DEFAULT NULL,
  `customer_customer_id` int(11) NOT NULL,
  `address_address_id` int(11) NOT NULL,
  PRIMARY KEY (`meter_id`),
  KEY `fk_meter_customer1_idx` (`customer_customer_id`),
  KEY `fk_meter_address1_idx` (`address_address_id`),
  CONSTRAINT `fk_meter_address1` FOREIGN KEY (`address_address_id`) REFERENCES `address` (`address_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_meter_customer1` FOREIGN KEY (`customer_customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `meter`
--

LOCK TABLES `meter` WRITE;
/*!40000 ALTER TABLE `meter` DISABLE KEYS */;
INSERT INTO `meter` VALUES (1,'利州区','和苑小区',13,23,100,'1234567',0,NULL,1,35),(2,'利州区','和苑小区',17,121,21,'1234567',0,NULL,2,35),(100,'利州区','和苑小区',121,21,21,'1234567',0,NULL,100,35),(101,'利州区','黄金小区',1,1,1,'1234567',0,NULL,101,34),(200,'利州区','黄金小区',2,212,211,'1234567',0,NULL,200,34),(201,'利州区','黄金小区',2,1111,1111,'1234567',0,NULL,201,34),(202,'利州区','黄金小区',1,11,111,'1234567',0,NULL,202,34),(203,'利州区','和苑小区',1,12,222,'1234567',0,NULL,203,35),(204,'利州区','和苑小区',1,2121,2121,'1234567',0,NULL,204,35);
/*!40000 ALTER TABLE `meter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `money`
--

DROP TABLE IF EXISTS `money`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `money` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `result` int(11) NOT NULL,
  `previous` int(11) DEFAULT NULL,
  `operate` int(11) NOT NULL,
  `flag` int(11) DEFAULT NULL,
  `customer_id` int(11) NOT NULL,
  `operate_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `money`
--

LOCK TABLES `money` WRITE;
/*!40000 ALTER TABLE `money` DISABLE KEYS */;
INSERT INTO `money` VALUES (8,100,0,100,0,9999,'2015-03-16 05:21:28'),(9,31,0,31,1,202,'2015-03-16 07:46:23'),(10,63,31,32,1,202,'2015-03-16 07:59:39'),(11,863,63,800,1,202,'2015-03-16 08:10:17'),(12,963,863,100,1,202,'2015-03-16 08:27:46'),(13,1053,963,90,1,202,'2015-03-16 08:29:10'),(14,1143,1053,90,1,202,'2015-03-16 08:33:05'),(15,1153,1143,10,1,202,'2015-03-16 08:39:56'),(16,1197,1153,44,0,202,'2015-03-16 08:39:56'),(17,100,0,100,0,201,'2015-03-16 08:40:45');
/*!40000 ALTER TABLE `money` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `user_name` varchar(10) NOT NULL,
  `user_pwd` varchar(20) DEFAULT NULL,
  `user_grade` int(11) DEFAULT NULL,
  PRIMARY KEY (`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('admin','admin',0),('fish','fish',2),('vyoung','vyoung',1);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-03-19 23:32:33
