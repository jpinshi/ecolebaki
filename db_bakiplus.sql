-- MySQL dump 10.13  Distrib 5.7.17, for macos10.12 (x86_64)
--
-- Host: localhost    Database: db_baki
-- ------------------------------------------------------
-- Server version	5.7.20

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
-- Table structure for table `t_agent`
--

DROP TABLE IF EXISTS `t_agent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_agent` (
  `_MATR` int(11) NOT NULL,
  `_NAME` varchar(50) NOT NULL,
  `_SEX` varchar(50) NOT NULL,
  `_PHONE` varchar(50) NOT NULL,
  `_ADRESS` varchar(50) NOT NULL,
  `_BIRTHDAY` varchar(50) NOT NULL,
  `_BIRTHPLACE` varchar(50) NOT NULL,
  `_CHILD_SCHOOL` varchar(50) NOT NULL,
  `_DATEWORK` varchar(50) NOT NULL,
  `_PROVINCE` varchar(50) NOT NULL,
  `_TOWN` varchar(50) NOT NULL,
  `_FUNCTION` varchar(50) NOT NULL,
  `_CODE_DIRECTION` varchar(10) NOT NULL,
  `_PICTURE` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_agent`
--

LOCK TABLES `t_agent` WRITE;
/*!40000 ALTER TABLE `t_agent` DISABLE KEYS */;
INSERT INTO `t_agent` VALUES (1111,'LAMA HORNEL','MASCULIN','0894731682','10,KILOMBWE C/LEMBA','12/10/1978','KINSHASA','2','12/12/2001','KATANGA','KINSHASA','CAISSIER','YOLO','');
/*!40000 ALTER TABLE `t_agent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_category`
--

DROP TABLE IF EXISTS `t_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_category` (
  `_CODE_CATEGORY` varchar(20) NOT NULL,
  `_LABEL_CATEGROT` varchar(70) NOT NULL,
  PRIMARY KEY (`_CODE_CATEGORY`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_category`
--

LOCK TABLES `t_category` WRITE;
/*!40000 ALTER TABLE `t_category` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_courses`
--

DROP TABLE IF EXISTS `t_courses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_courses` (
  `_ID_COURSE` varchar(10) NOT NULL,
  `_LABEL_COURSE` varchar(100) NOT NULL,
  `_CODE_POND` int(11) NOT NULL,
  PRIMARY KEY (`_ID_COURSE`),
  KEY `_CODE_POND` (`_CODE_POND`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_courses`
--

LOCK TABLES `t_courses` WRITE;
/*!40000 ALTER TABLE `t_courses` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_courses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_direction`
--

DROP TABLE IF EXISTS `t_direction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_direction` (
  `_CODE_DIR` varchar(10) NOT NULL,
  `_LABEL_DIR` varchar(100) NOT NULL,
  `_ADRESS` int(11) NOT NULL,
  `_PHONE` int(11) NOT NULL,
  PRIMARY KEY (`_CODE_DIR`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_direction`
--

LOCK TABLES `t_direction` WRITE;
/*!40000 ALTER TABLE `t_direction` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_direction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_dispense`
--

DROP TABLE IF EXISTS `t_dispense`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_dispense` (
  `_ID` int(11) NOT NULL AUTO_INCREMENT,
  `_CODE_COURS` varchar(10) NOT NULL,
  `_MATR_AGENT` varchar(10) NOT NULL,
  `_LEVEL_SCHOOL` varchar(100) NOT NULL,
  PRIMARY KEY (`_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_dispense`
--

LOCK TABLES `t_dispense` WRITE;
/*!40000 ALTER TABLE `t_dispense` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_dispense` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_level`
--

DROP TABLE IF EXISTS `t_level`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_level` (
  `_LABEL_LEVEL` varchar(20) NOT NULL,
  `_OPTION_LEVEL` varchar(10) NOT NULL,
  PRIMARY KEY (`_LABEL_LEVEL`),
  KEY `_OPTION_LEVEL` (`_OPTION_LEVEL`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_level`
--

LOCK TABLES `t_level` WRITE;
/*!40000 ALTER TABLE `t_level` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_level` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_login`
--

DROP TABLE IF EXISTS `t_login`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_login` (
  `_ID` int(11) NOT NULL AUTO_INCREMENT,
  `_USERNAME` varchar(50) NOT NULL,
  `_PWD` varchar(200) NOT NULL,
  `_PRIORITY` varchar(50) NOT NULL,
  `_MATR_AGENT` varchar(50) NOT NULL,
  `_ANASCO` varchar(50) NOT NULL,
  PRIMARY KEY (`_ID`),
  UNIQUE KEY `_USERNAME` (`_USERNAME`),
  KEY `_MATR_AGENT` (`_MATR_AGENT`),
  KEY `YEARS` (`_ANASCO`),
  CONSTRAINT `key_years-anasco` FOREIGN KEY (`_ANASCO`) REFERENCES `t_years_school` (`year`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_login`
--

LOCK TABLES `t_login` WRITE;
/*!40000 ALTER TABLE `t_login` DISABLE KEYS */;
INSERT INTO `t_login` VALUES (1,'@hornel','fcea920f7412b5da7be0cf42b8c93759','admin','1111','2017-2018');
/*!40000 ALTER TABLE `t_login` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_options`
--

DROP TABLE IF EXISTS `t_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_options` (
  `_CODE_OPT` varchar(10) NOT NULL,
  `_LABEL_OPT` varchar(100) NOT NULL,
  `_CODE_SECTION` varchar(10) NOT NULL,
  PRIMARY KEY (`_CODE_OPT`),
  KEY `_CODE_SECTION` (`_CODE_SECTION`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_options`
--

LOCK TABLES `t_options` WRITE;
/*!40000 ALTER TABLE `t_options` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_payment`
--

DROP TABLE IF EXISTS `t_payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_payment` (
  `_IDPAY` varchar(100) NOT NULL,
  `_MATR` varchar(50) NOT NULL,
  `_CODE_SLICE` varchar(50) NOT NULL,
  `_OBJECT` varchar(100) NOT NULL,
  `_DATEPAY` varchar(50) NOT NULL,
  `_TIMEPAY` varchar(50) NOT NULL,
  `_AMOUNT` int(11) NOT NULL,
  `_ANASCO` varchar(50) NOT NULL,
  `_USER_AGENT` varchar(50) NOT NULL,
  `_DEPARTMENT` varchar(25) NOT NULL,
  PRIMARY KEY (`_IDPAY`),
  KEY `_MATR` (`_MATR`,`_CODE_SLICE`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_payment`
--

LOCK TABLES `t_payment` WRITE;
/*!40000 ALTER TABLE `t_payment` DISABLE KEYS */;
INSERT INTO `t_payment` VALUES ('PAY-1451623239','CSB/YOLO1482320696','FRSCO','1TRF','01/01/2016','05:40:39',200,'2016-2017','@hornel','YOLO'),('PAY-1451642207','CSB/YOLO1451642207','SUB','SUB','01/01/2016','10:56:46',10,'2016-2017','@hornel','YOLO'),('PAY-1451642427','CSB/YOLO1451642207','FRSCO','1TRF','01/01/2016','11:00:27',260,'2016-2017','@hornel','YOLO'),('PAY-1482234620','CSB/YOLO1482234620','SUB','SUB','20/12/2016','12:50:20',10,'2016-2017','@hornel','YOLO'),('PAY-1482234864','CSB/YOLO1482234864','SUB','SUB','20/12/2016','12:54:24',10,'2016-2017','@hornel','YOLO'),('PAY-1482282346','CSB/YOLO1482234620','FRSCO','1TRF','21/12/2016','02:05:46',100,'2016-2017','@hornel','YOLO'),('PAY-1482287535','CSB/YOLO1482234620','FRSCO','1TRF','21/12/2016','03:32:15',50,'2016-2017','@hornel','YOLO'),('PAY-1482287820','CSB/YOLO1482234620','FRSCO','1TRF','21/12/2016','03:37:00',20,'2016-2017','@hornel','YOLO'),('PAY-1482287998','CSB/YOLO1482234620','FRSCO','1TRF','21/12/2016','03:39:58',70,'2016-2017','@hornel','YOLO'),('PAY-1482288198','CSB/YOLO1482234620','FRSCO','1TRF','21/12/2016','03:43:18',50,'2016-2017','@hornel','YOLO'),('PAY-1482319022','CSB/YOLO1482234864','FRSCO','1TRF','21/12/2016','12:17:02',200,'2016-2017','@hornel','YOLO'),('PAY-1482320696','CSB/YOLO1482320696','SUB','SUB','21/12/2016','12:44:56',10,'2016-2017','@hornel','YOLO'),('PAY-1482321164','CSB/YOLO1482234864','FRSCO','1TRF','21/12/2016','12:52:44',75,'2016-2017','@hornel','YOLO'),('PAY-1482321194','CSB/YOLO1482234864','FRSCO','1TRF','21/12/2016','12:53:14',15,'2016-2017','@hornel','YOLO'),('PAY-1482859646','CSB/YOLO1482859646','SUB','SUB','27/12/2016','18:27:26',10,'2016-2017','@hornel','YOLO'),('PAY-1482859648','CSB/YOLO1482859648','SUB','SUB','27/12/2016','18:27:28',10,'2016-2017','@hornel','YOLO'),('PAY-1482859740','CSB/YOLO1482859740','SUB','SUB','27/12/2016','18:29:00',10,'2016-2017','@hornel','YOLO'),('PAY-1482859743','CSB/YOLO1482859743','SUB','SUB','27/12/2016','18:29:03',10,'2016-2017','@hornel','YOLO'),('PAY-1482859744','CSB/YOLO1482859744','SUB','SUB','27/12/2016','18:29:04',10,'2016-2017','@hornel','YOLO'),('PAY-1482859747','CSB/YOLO1482859747','SUB','SUB','27/12/2016','18:29:07',10,'2016-2017','@hornel','YOLO'),('PAY-1482859748','CSB/YOLO1482859748','SUB','SUB','27/12/2016','18:29:08',10,'2016-2017','@hornel','YOLO'),('PAY-1482861740','CSB/YOLO1482860903','FRSCO','1TRF','27/12/2016','19:02:20',200,'2015-2016','@hornel','YOLO'),('PAY-1482921635','CSB/YOLO1482921634','SUB','SUB','28/12/2016','11:40:34',10,'2016-2017','@hornel','YOLO'),('PAY-1482926827','CSB/YOLO1482860903','SUB','SUB','27/12/2016','18:48:23',10,'2015-2016','@hornel','YOLO'),('PAY-1482928110','CSB/YOLO1482928110','SUB','SUB','28/12/2016','13:28:30',10,'2016-2017','@hornel','YOLO'),('PAY-1482928816','CSB/YOLO1482860903','RESUB','RESUB','28/12/2016','13:40:16',10,'2016-2017','@hornel','YOLO'),('PAY-1482929053','CSB/YOLO1482928110','FRSCO','1TRF','28/12/2016','13:44:13',100,'2016-2017','@hornel','YOLO'),('PAY-1512822628','CSB/YOLO1512822627','SUB','SUB','09/12/2017','13:30:27',10,'2016-2017','@hornel','YOLO'),('PAY-1512822943','CSB/YOLO1512822627','FRSCO','1TRF','09/12/2017','13:35:43',100,'2016-2017','@hornel','YOLO'),('PAY-1512823556','CSB/YOLO1512823556','SUB','SUB','09/12/2017','13:45:56',10,'2016-2017','@hornel','YOLO'),('PAY-1512823910','CSB/YOLO1512823910','SUB','SUB','09/12/2017','13:51:50',10,'2016-2017','@hornel','YOLO'),('PAY-1512824024','CSB/YOLO1512824024','SUB','SUB','09/12/2017','13:53:44',10,'2016-2017','@hornel','YOLO'),('PAY-1512824271','CSB/YOLO1512824271','SUB','SUB','09/12/2017','13:57:51',10,'2016-2017','@hornel','YOLO'),('PAY-1512824460','CSB/YOLO1512824460','SUB','SUB','09/12/2017','14:01:00',10,'2016-2017','@hornel','YOLO'),('PAY-1512824738','CSB/YOLO1512824737','SUB','SUB','09/12/2017','14:05:37',10,'2016-2017','@hornel','YOLO'),('PAY-1512824800','CSB/YOLO1512824800','SUB','SUB','09/12/2017','14:06:40',10,'2016-2017','@hornel','YOLO'),('PAY-1512824967','CSB/YOLO1512824967','SUB','SUB','09/12/2017','14:09:27',10,'2016-2017','@hornel','YOLO'),('PAY-1512824968','CSB/YOLO1512824968','SUB','SUB','09/12/2017','14:09:28',10,'2016-2017','@hornel','YOLO'),('PAY-1512824970','CSB/YOLO1512824970','SUB','SUB','09/12/2017','14:09:30',10,'2016-2017','@hornel','YOLO'),('PAY-1512825072','CSB/YOLO1512825072','SUB','SUB','09/12/2017','14:11:12',10,'2016-2017','@hornel','YOLO'),('PAY-1512832694','CSB/YOLO1512832693','SUB','SUB','09/12/2017','16:18:13',10,'2016-2017','@hornel','YOLO'),('PAY-1513100729','YOLO1513100728','SUB','SUB','','',10,'2016-2017','@hornel','YOLO'),('PAY-1513619831','YOLO1513619831','SUB','SUB','','',10,'2017-2018','@hornel','YOLO'),('PAY-1513620939','YOLO1513620939','SUB','SUB','','',10,'2017-2018','@hornel','YOLO'),('PAY-1513634446','YOLO1513634445','SUB','SUB','','',10,'2017-2018','@hornel','YOLO');
/*!40000 ALTER TABLE `t_payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_payment_agent`
--

DROP TABLE IF EXISTS `t_payment_agent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_payment_agent` (
  `_CODE_PAY` int(11) NOT NULL,
  `_MATR_AGENT` int(11) NOT NULL,
  `_DATE_PAY` int(11) NOT NULL,
  `_TIME_PAY` int(11) NOT NULL,
  `_ACCOUNT_PAY` int(11) NOT NULL,
  `_PRIME_PAY` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_payment_agent`
--

LOCK TABLES `t_payment_agent` WRITE;
/*!40000 ALTER TABLE `t_payment_agent` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_payment_agent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_ponderation`
--

DROP TABLE IF EXISTS `t_ponderation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_ponderation` (
  `_ID_POND` int(11) NOT NULL,
  `_CODE_OPT` varchar(10) NOT NULL,
  PRIMARY KEY (`_ID_POND`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_ponderation`
--

LOCK TABLES `t_ponderation` WRITE;
/*!40000 ALTER TABLE `t_ponderation` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_ponderation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_school_fees`
--

DROP TABLE IF EXISTS `t_school_fees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_school_fees` (
  `_CODE` varchar(5) NOT NULL,
  `_LABEL` varchar(100) NOT NULL,
  `_SOLD` int(11) NOT NULL,
  PRIMARY KEY (`_CODE`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_school_fees`
--

LOCK TABLES `t_school_fees` WRITE;
/*!40000 ALTER TABLE `t_school_fees` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_school_fees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_section`
--

DROP TABLE IF EXISTS `t_section`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_section` (
  `_ID_SECT` varchar(10) NOT NULL,
  `_LABEL_SECT` varchar(100) NOT NULL,
  PRIMARY KEY (`_ID_SECT`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_section`
--

LOCK TABLES `t_section` WRITE;
/*!40000 ALTER TABLE `t_section` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_section` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_slice_payment`
--

DROP TABLE IF EXISTS `t_slice_payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_slice_payment` (
  `_CODESLICE` varchar(5) NOT NULL,
  `_LABELSLICE` varchar(50) NOT NULL,
  `_AMOUNT` int(11) NOT NULL,
  `_CODE_FEES` varchar(11) NOT NULL,
  PRIMARY KEY (`_CODESLICE`),
  KEY `_CODE_FEES` (`_CODE_FEES`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_slice_payment`
--

LOCK TABLES `t_slice_payment` WRITE;
/*!40000 ALTER TABLE `t_slice_payment` DISABLE KEYS */;
INSERT INTO `t_slice_payment` VALUES ('1TRF','1ERE TRANCHE',400,'FRSCO'),('2TRF','2EME TRANCHE',150,'FRSCO'),('3TRF','3EME TRANCHE',50,'FRSCO'),('RESUB','REINSCRIPTION',15,'RESUB'),('SUB','INSCRIPTION',10,'SUB');
/*!40000 ALTER TABLE `t_slice_payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_status_health`
--

DROP TABLE IF EXISTS `t_status_health`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_status_health` (
  `_ID` int(11) NOT NULL AUTO_INCREMENT,
  `_MATR` varchar(20) NOT NULL,
  `_INFO` varchar(20) NOT NULL,
  `_DATEINSERT` varchar(20) NOT NULL,
  PRIMARY KEY (`_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_status_health`
--

LOCK TABLES `t_status_health` WRITE;
/*!40000 ALTER TABLE `t_status_health` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_status_health` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_students`
--

DROP TABLE IF EXISTS `t_students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_students` (
  `_ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `_MAT` varchar(50) NOT NULL,
  `_NAME` varchar(50) NOT NULL,
  `_SEX` varchar(50) NOT NULL,
  `_ADRESS` varchar(50) NOT NULL,
  `_PROVINCE` varchar(50) NOT NULL,
  `_BIRTHDAY` varchar(50) NOT NULL,
  `_BIRTHPLACE` varchar(50) NOT NULL,
  `_PHONE` varchar(50) NOT NULL,
  `_PICTURE` longtext NOT NULL,
  PRIMARY KEY (`_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_students`
--

LOCK TABLES `t_students` WRITE;
/*!40000 ALTER TABLE `t_students` DISABLE KEYS */;
INSERT INTO `t_students` VALUES (1,'CSB-YOLO1451642207','makanda','Masculin','ebola 638','KINSHASA','1990','kinshasa','0822587393','1513100728.png'),(2,'CSB-YOLO1482234620','LAMA HORNEL','Masculin','89,KILOMBWE C/LEMBA','KINSHASA','12/2/2010','KINSHASA','08977589404','1513100728.png'),(3,'CSB-YOLO1482234864','BOPAMU FRANCKY','Masculin','99383','KINSHASA','12/12/2014','KINSHASA','0930939390','1513100728.png'),(4,'CSB-YOLO1482320696','KALALA TEDDY','Masculin','192,KILOMBWE C/LEMBA','KINSHASA','12/10/1980','KINSHASA','0930939390','1513100728.png'),(5,'CSB-YOLO1482860903','ANAHENDO LYDIA','Feminin','90,KILOMBWE C/LEMBA','KINSHASA','12/12/2000','KINSHASA','098585858','1513100728.png'),(6,'CSB/YOLO1482921634','dsdssd','Masculin','ssss','BANDUNDU','12/12/2010','dddd','sdsddd','1513100728.png'),(7,'CSB/YOLO1482928110','MATONDO JEAN','Masculin','90,KILOMBWE','KINSHASA','12/12/2000','kinshasa','098776543','1513100728.png'),(8,'CSB/YOLO1512822627','Krystel Tambwe','Feminin','10,kilindja','KINSHASA','12/12/2010','Kinshasa','0987890009','1513100728.png'),(9,'CSB/YOLO1512823556','Rodrick Bope','Masculin','10,Kilangwe','KINSHASA','12/10/2000','Kinshasa','993939393','1513100728.png'),(10,'CSB/YOLO1512823910','Ludovic Matamba','Masculin','23, Kilangwe','KINSHASA','12/12/2011','Kinshasa','4884848498','1513100728.png'),(11,'CSB/YOLO1512824024','Talia Boula','Feminin','10,Kilangwe','KINSHASA','12/12/2011','Kinshasa','83389389383','1513100728.png'),(12,'CSB/YOLO1512824271','Tolia Ngenge','Feminin','10,Kilangwe','KINSHASA','12/10/2000','Kinshasa','089899008','1513100728.png'),(13,'CSB/YOLO1512824460','Antony Kabala','Masculin','10,Kilangwe','KINSHASA','10/10/2000','Kinshasa','83838389','1513100728.png'),(14,'CSB/YOLO1512824737','Lower Snol','Masculin','10,Kilangwe','KINSHASA','10/10/2010','Kinshasa','3939390','1513100728.png'),(15,'CSB/YOLO1512824800','JSJHDHDJ','Masculin','DJDJDJ','KINSHASA','29329292022','Kinshasa','839923883','1513100728.png'),(16,'CSB/YOLO1512824967','JSJHDHDJ','Masculin','DJDJDJ','KINSHASA','29329292022','Kinshasa','839923883','1513100728.png'),(17,'CSB/YOLO1512824968','JSJHDHDJ','Masculin','DJDJDJ','KINSHASA','29329292022','Kinshasa','839923883','1513100728.png'),(18,'CSB/YOLO1512824970','JSJHDHDJ','Masculin','DJDJDJ','KINSHASA','29329292022','Kinshasa','839923883','1513100728.png'),(19,'CSB/YOLO1512825072','cjfjkfkjew','Masculin','jjkfekwj','KINSHASA','jfjfgjjker','Kinshasa','04505','1513100728.png'),(20,'CSB/YOLO1512832693','Malamba Jean','Masculin','10,Kilangwe','KINSHASA','10/10/2019','Kinshasa','8389383398','1513100728.png'),(21,'YOLO1513100728','Hornel LAMA','M','10,Kilangwe','Haut-Lomami','20/01/2000','Kinsahsa','3390290','1513100728.png'),(22,'YOLO1513619831','Matondo Nsita Glody','M','10, KILOMBWE C/LEMBA','Kwilu','12/12/2010','Kinshasa','0994601031','1513619831.png'),(23,'YOLO1513620939','Kisamba Kutule Paul','M','10, KILOMBWE C/LEMBA','Nord-Kivu','12/12/2010','Kinshasa','0098789009','1513620939.png'),(24,'YOLO1513634445','Mwema Levi','M','10, KILOMBWE C/LEMBA','Sud-Kivu','10/09/2017','Kinshasa','0098789009','1513634445.png');
/*!40000 ALTER TABLE `t_students` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_subscription`
--

DROP TABLE IF EXISTS `t_subscription`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_subscription` (
  `_ID_SUB` int(11) NOT NULL AUTO_INCREMENT,
  `_MATR_PUPIL` varchar(50) NOT NULL,
  `_CODE_CLASS` varchar(10) NOT NULL,
  `_CODE_SECTION` varchar(50) NOT NULL,
  `_DATE_SUB` varchar(20) NOT NULL,
  `_CODE_PAY` varchar(100) NOT NULL,
  `_CODE_AGENT` varchar(10) NOT NULL,
  PRIMARY KEY (`_ID_SUB`),
  KEY `_CODE_PAY` (`_CODE_PAY`),
  KEY `_MATR_PUPIL` (`_MATR_PUPIL`),
  KEY `_CODE_CLASS` (`_CODE_CLASS`)
) ENGINE=InnoDB AUTO_INCREMENT=86 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_subscription`
--

LOCK TABLES `t_subscription` WRITE;
/*!40000 ALTER TABLE `t_subscription` DISABLE KEYS */;
INSERT INTO `t_subscription` VALUES (52,'CSB/YOLO1482234620','2','PRIMAIRE','20/12/2016','PAY-1482234620','@hornel'),(53,'CSB/YOLO1482234864','2','PRIMAIRE','20/12/2016','PAY-1482234864','@hornel'),(54,'CSB/YOLO1482320696','2','PRIMAIRE','21/12/2016','PAY-1482320696','@hornel'),(55,'CSB/YOLO1482859646','1','PRIMAIRE','27/12/2016','PAY-1482859646','@hornel'),(56,'CSB/YOLO1482859648','5','PRIMAIRE','27/12/2016','PAY-1482859648','@hornel'),(57,'CSB/YOLO1482859740','3','MATERNELLE','27/12/2016','PAY-1482859740','@hornel'),(58,'CSB/YOLO1482859743','3','MATERNELLE','27/12/2016','PAY-1482859743','@hornel'),(59,'CSB/YOLO1482859744','3','MATERNELLE','27/12/2016','PAY-1482859744','@hornel'),(60,'CSB/YOLO1482859747','3','MATERNELLE','27/12/2016','PAY-1482859747','@hornel'),(61,'CSB/YOLO1482859748','3','MATERNELLE','27/12/2016','PAY-1482859748','@hornel'),(63,'CSB/YOLO1482921634','4','PRIMAIRE','28/12/2016','PAY-1482921635','@hornel'),(65,'CSB/YOLO1482860903','5','PRIMAIRE','28/12/2016','PAY-1482926827','@hornel'),(66,'CSB/YOLO1482928110','4','PRIMAIRE','28/12/2016','PAY-1482928110','@hornel'),(68,'CSB/YOLO1451642207','6','PRIMAIRE','01/01/2016','PAY-1451642207','@hornel'),(69,'CSB/YOLO1512822627','3','PRIMAIRE','09/12/2017','PAY-1512822628','@hornel'),(70,'CSB/YOLO1512823556','5','PRIMAIRE','09/12/2017','PAY-1512823556','@hornel'),(71,'CSB/YOLO1512823910','2','PRIMAIRE','09/12/2017','PAY-1512823910','@hornel'),(72,'CSB/YOLO1512824024','3','PRIMAIRE','09/12/2017','PAY-1512824024','@hornel'),(73,'CSB/YOLO1512824271','5','PRIMAIRE','09/12/2017','PAY-1512824271','@hornel'),(74,'CSB/YOLO1512824460','6','PRIMAIRE','09/12/2017','PAY-1512824460','@hornel'),(75,'CSB/YOLO1512824737','5','PRIMAIRE','09/12/2017','PAY-1512824738','@hornel'),(76,'CSB/YOLO1512824800','3','PRIMAIRE','09/12/2017','PAY-1512824800','@hornel'),(77,'CSB/YOLO1512824967','3','PRIMAIRE','09/12/2017','PAY-1512824967','@hornel'),(78,'CSB/YOLO1512824968','3','PRIMAIRE','09/12/2017','PAY-1512824968','@hornel'),(79,'CSB/YOLO1512824970','3','PRIMAIRE','09/12/2017','PAY-1512824970','@hornel'),(80,'CSB/YOLO1512825072','5','PRIMAIRE','09/12/2017','PAY-1512825072','@hornel'),(81,'CSB/YOLO1512832693','3','PRIMAIRE','09/12/2017','PAY-1512832694','@hornel'),(82,'YOLO1513100728','2','MATERNELLE','','PAY-1513100729','@hornel'),(83,'YOLO1513619831','2eme','PRIMAIRE','','PAY-1513619831','@hornel'),(84,'YOLO1513620939','3eme','PRIMAIRE','','PAY-1513620939','@hornel'),(85,'YOLO1513634445','1ere','MATERNELLE','','PAY-1513634446','@hornel');
/*!40000 ALTER TABLE `t_subscription` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_years_school`
--

DROP TABLE IF EXISTS `t_years_school`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_years_school` (
  `year` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`year`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_years_school`
--

LOCK TABLES `t_years_school` WRITE;
/*!40000 ALTER TABLE `t_years_school` DISABLE KEYS */;
INSERT INTO `t_years_school` VALUES ('2015-2016'),('2016-2017'),('2017-2018');
/*!40000 ALTER TABLE `t_years_school` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-01-10 21:44:27
