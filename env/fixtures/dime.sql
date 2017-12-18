-- MySQL dump 10.13  Distrib 5.5.58, for debian-linux-gnu (x86_64)
--
-- Host: mysql    Database: dime
-- ------------------------------------------------------
-- Server version	5.6.33

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
-- Table structure for table `WorkingPeriods`
--

DROP TABLE IF EXISTS `WorkingPeriods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `WorkingPeriods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `employee_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `start` date DEFAULT NULL,
  `end` date DEFAULT NULL,
  `pensum` decimal(10,2) DEFAULT NULL,
  `holidays` int(11) DEFAULT NULL,
  `last_year_holiday_balance` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `realTime` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_57C1BB888C03F15C` (`employee_id`),
  KEY `IDX_57C1BB88A76ED395` (`user_id`),
  CONSTRAINT `FK_57C1BB888C03F15C` FOREIGN KEY (`employee_id`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_57C1BB88A76ED395` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `WorkingPeriods`
--

LOCK TABLES `WorkingPeriods` WRITE;
/*!40000 ALTER TABLE `WorkingPeriods` DISABLE KEYS */;
INSERT INTO `WorkingPeriods` VALUES (1,7,2,'2017-01-25','2017-06-07',0.80,177629,'28',210880,'2017-12-18 11:30:35','2017-12-18 11:30:35'),(2,7,1,'2017-07-31','2018-04-18',0.30,129742,'94',6040,'2017-12-18 11:30:35','2017-12-18 11:30:35'),(3,15,4,'2017-07-05','2018-09-14',1.00,724103,'13',146918008,'2017-12-18 11:30:35','2017-12-18 11:30:35'),(4,25,3,'2017-02-02','2018-05-06',0.20,152111,'13',34265150,'2017-12-18 11:30:35','2017-12-18 11:30:35'),(5,11,2,'2017-08-07','2018-02-09',0.70,215740,'72',6900506,'2017-12-18 11:30:35','2017-12-18 11:30:35'),(6,20,2,'2017-05-22','2018-08-25',0.40,305548,'57',82,'2017-12-18 11:30:35','2017-12-18 11:30:35'),(7,11,2,'2017-02-20','2018-07-19',1.00,851691,'95',7,'2017-12-18 11:30:35','2017-12-18 11:30:35'),(8,17,2,'2017-05-25','2018-08-18',0.50,373650,'23',476016,'2017-12-18 11:30:35','2017-12-18 11:30:35'),(9,10,5,'2017-08-04','2018-06-23',0.20,107041,'41',87450342,'2017-12-18 11:30:35','2017-12-18 11:30:35'),(10,25,6,'2017-09-21','2017-12-30',0.90,149129,'62',56797,'2017-12-18 11:30:35','2017-12-18 11:30:35'),(11,12,3,'2017-12-12','2018-08-10',0.10,39933,'1',2660981,'2017-12-18 11:30:35','2017-12-18 11:30:35'),(12,22,2,'2017-11-08','2018-11-13',0.60,367851,'4',68816,'2017-12-18 11:30:35','2017-12-18 11:30:35'),(13,18,6,'2017-03-05','2018-02-06',0.30,168018,'21',41246257,'2017-12-18 11:30:35','2017-12-18 11:30:35'),(14,24,6,'2017-04-13','2018-05-25',0.10,67439,'97',25,'2017-12-18 11:30:35','2017-12-18 11:30:35'),(15,13,2,'2017-02-23','2018-09-15',0.00,NULL,'14',49784287,'2017-12-18 11:30:35','2017-12-18 11:30:35'),(16,16,5,'2017-08-22','2018-09-28',0.50,333054,'84',51122,'2017-12-18 11:30:35','2017-12-18 11:30:35'),(17,16,2,'2017-10-29','2018-05-01',0.10,30654,'26',499,'2017-12-18 11:30:35','2017-12-18 11:30:35'),(18,8,4,'2017-04-06','2018-02-28',0.40,218059,'10',959807,'2017-12-18 11:30:35','2017-12-18 11:30:35'),(19,14,1,'2017-10-31','2018-06-29',0.40,159733,'93',277343,'2017-12-18 11:30:35','2017-12-18 11:30:35'),(20,25,5,'2017-08-29','2018-02-04',0.80,210769,'41',49590601,'2017-12-18 11:30:35','2017-12-18 11:30:35'),(21,9,3,'2017-11-18','2018-10-09',0.50,270089,'58',55784958,'2017-12-18 11:30:35','2017-12-18 11:30:35'),(22,16,4,'2017-01-09','2018-09-14',0.90,915651,'93',4,'2017-12-18 11:30:35','2017-12-18 11:30:35'),(23,13,2,'2017-05-03','2018-04-28',0.60,357909,'35',3533,'2017-12-18 11:30:35','2017-12-18 11:30:35'),(24,15,6,'2017-05-19','2017-12-31',0.80,300909,'6',376,'2017-12-18 11:30:35','2017-12-18 11:30:35'),(25,9,3,'2017-04-10','2018-05-09',0.90,587567,'59',4048018,'2017-12-18 11:30:35','2017-12-18 11:30:35'),(26,7,1,'2017-06-24','2018-06-29',0.80,490468,'45',210,'2017-12-18 11:30:35','2017-12-18 11:30:35'),(27,25,2,'2017-04-18','2018-06-02',0.50,340511,'100',1,'2017-12-18 11:30:35','2017-12-18 11:30:35'),(28,17,4,'2017-12-19','2018-11-27',1.00,570003,'84',4,'2017-12-18 11:30:35','2017-12-18 11:30:35'),(29,15,1,'2017-11-19','2018-11-18',0.30,180943,'44',347921,'2017-12-18 11:30:35','2017-12-18 11:30:35'),(30,26,3,'2017-06-08','2018-10-23',0.90,748626,'5',941743286,'2017-12-18 11:30:35','2017-12-18 11:30:35'),(31,14,3,'2017-08-06','2018-08-04',0.70,422200,'27',96,'2017-12-18 11:30:35','2017-12-18 11:30:35'),(32,26,1,'2017-11-02','2018-01-02',0.70,70753,'85',858883,'2017-12-18 11:30:35','2017-12-18 11:30:35'),(33,24,6,'2017-03-05','2018-05-24',0.90,663623,'27',569103,'2017-12-18 11:30:35','2017-12-18 11:30:35'),(34,18,4,'2017-12-01','2018-12-02',0.10,60811,'70',78668,'2017-12-18 11:30:35','2017-12-18 11:30:35'),(35,19,2,'2017-08-15','2018-05-27',0.30,142169,'19',46763,'2017-12-18 11:30:35','2017-12-18 11:30:35'),(36,24,4,'2017-04-16','2018-07-18',0.00,NULL,'90',4,'2017-12-18 11:30:35','2017-12-18 11:30:35'),(37,10,1,'2017-08-28','2018-07-30',0.40,223362,'64',126449,'2017-12-18 11:30:35','2017-12-18 11:30:35'),(38,23,1,'2017-05-02','2018-04-15',0.20,115326,'2',658554,'2017-12-18 11:30:35','2017-12-18 11:30:35'),(39,26,1,'2017-02-26','2018-03-07',0.20,123943,'18',85,'2017-12-18 11:30:35','2017-12-18 11:30:35'),(40,19,1,'2017-01-24','2018-03-20',0.40,278374,'38',2427113,'2017-12-18 11:30:35','2017-12-18 11:30:35'),(41,8,6,'2017-08-25','2018-04-08',0.30,112841,'39',82,'2017-12-18 11:30:35','2017-12-18 11:30:35'),(42,16,2,'2017-01-27','2018-01-29',0.90,547303,'43',51057,'2017-12-18 11:30:35','2017-12-18 11:30:35'),(43,26,1,'2017-04-30','2018-10-17',0.00,NULL,'90',4520052,'2017-12-18 11:30:35','2017-12-18 11:30:35'),(44,21,1,'2017-06-28','2018-10-27',0.10,80530,'98',16979,'2017-12-18 11:30:35','2017-12-18 11:30:35'),(45,19,5,'2017-04-25','2018-03-05',1.00,520294,'92',3239,'2017-12-18 11:30:35','2017-12-18 11:30:35'),(46,22,1,'2017-10-19','2018-05-27',0.50,182268,'41',0,'2017-12-18 11:30:35','2017-12-18 11:30:35'),(47,9,2,'2017-09-21','2018-05-28',0.10,41425,'26',24318,'2017-12-18 11:30:35','2017-12-18 11:30:35'),(48,10,2,'2017-03-04','2018-01-10',0.10,51864,'83',9341,'2017-12-18 11:30:35','2017-12-18 11:30:35'),(49,26,4,'2017-11-12','2018-02-07',0.50,72079,'92',9292198,'2017-12-18 11:30:35','2017-12-18 11:30:35'),(50,19,5,'2016-12-30','2018-04-24',0.90,715818,'90',515,'2017-12-18 11:30:35','2017-12-18 11:30:35');
/*!40000 ALTER TABLE `WorkingPeriods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `activities`
--

DROP TABLE IF EXISTS `activities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `activities` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(11) DEFAULT NULL,
  `service_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `description` longtext COLLATE utf8_unicode_ci,
  `rate_value` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `chargeable` tinyint(1) DEFAULT NULL,
  `cargeable_reference` smallint(6) NOT NULL,
  `vat` decimal(10,3) DEFAULT NULL,
  `rate_unit` longtext COLLATE utf8_unicode_ci,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `rateUnitType_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_B5F1AFE5166D1F9C` (`project_id`),
  KEY `IDX_B5F1AFE5ED5CA9E6` (`service_id`),
  KEY `IDX_B5F1AFE52BE78CCE` (`rateUnitType_id`),
  KEY `IDX_B5F1AFE5A76ED395` (`user_id`),
  CONSTRAINT `FK_B5F1AFE5166D1F9C` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_B5F1AFE52BE78CCE` FOREIGN KEY (`rateUnitType_id`) REFERENCES `rateunittypes` (`id`),
  CONSTRAINT `FK_B5F1AFE5A76ED395` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_B5F1AFE5ED5CA9E6` FOREIGN KEY (`service_id`) REFERENCES `services` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activities`
--

LOCK TABLES `activities` WRITE;
/*!40000 ALTER TABLE `activities` DISABLE KEYS */;
INSERT INTO `activities` VALUES (1,9,1,2,'DimERP Programmieren','CHF 10000',1,1,0.080,'CHF/h','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL,'h'),(2,1,6,4,'Molestias est in sed.','CHF 18000',1,1,0.025,'CHF/h','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL,'h'),(3,10,13,5,'Cum ducimus vitae quam.','CHF 8100',1,1,0.025,'CHF/h','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL,'h'),(4,2,14,1,'Est officia voluptatibus corrupti commodi deserunt.','CHF 2800',1,1,0.080,'CHF/h','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL,'h'),(5,16,6,5,'Aut numquam a harum aliquam est.','CHF 18000',1,1,0.025,'CHF/h','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL,'h'),(6,5,2,5,'Ratione sunt ut officia est.','CHF 10300',1,1,0.080,'CHF/h','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL,'h'),(7,19,8,2,'Eius necessitatibus qui.','CHF 2800',1,1,0.080,'CHF/h','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL,'h'),(8,19,20,1,'Eum repellendus enim eum.','CHF 10300',1,1,0.080,'CHF/h','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL,'h'),(9,12,19,2,'Explicabo odit similique nihil numquam est.','CHF 18000',1,1,0.080,'CHF/h','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL,'h'),(10,20,9,5,'Sit quas quo totam quia.','CHF 18000',0,1,0.025,'CHF/h','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL,'h'),(11,12,16,6,'Quidem dolorum neque repudiandae.','CHF 8100',1,1,0.080,'CHF/h','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL,'h'),(12,5,38,3,'Occaecati ut et soluta.','CHF 16900',0,1,0.080,'CHF/d','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL,'t'),(13,9,35,5,'Et nihil voluptates dolores consectetur quo.','CHF 3100',1,1,0.080,'CHF/d','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL,'t'),(14,9,28,6,'Perspiciatis aspernatur nemo.','CHF 10800',0,1,0.025,'CHF/d','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL,'t'),(15,1,35,4,'Dolorem consequatur rerum suscipit.','CHF 3100',1,1,0.080,'CHF/d','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL,'t'),(16,20,40,4,'Et eos blanditiis.','CHF 10800',1,1,0.080,'CHF/d','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL,'t'),(17,12,40,3,'Iste repellat qui ipsum sit illum.','CHF 10800',1,1,0.080,'CHF/d','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL,'t'),(18,14,24,6,'Commodi modi quia culpa corrupti autem.','CHF 1500',1,1,0.025,'CHF/d','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL,'t'),(19,5,27,1,'Consequuntur provident beatae culpa consequatur aut.','CHF 10800',1,1,0.080,'CHF/d','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL,'t'),(20,16,30,5,'Excepturi magni qui at et inventore.','CHF 1500',1,1,0.080,'CHF/d','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL,'t'),(21,9,25,6,'Corporis molestias nam maxime qui dolorem.','CHF 16900',1,1,0.025,'CHF/d','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL,'t'),(22,16,58,1,'Ex occaecati dolorem.','CHF 18300',1,1,0.080,'Pauschal','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL,'a'),(23,6,48,6,'Odio in vero reiciendis modi.','CHF 18300',1,1,0.080,'Pauschal','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL,'a'),(24,1,50,5,'Labore minus iste corrupti.','CHF 18300',1,1,0.080,'Pauschal','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL,'a'),(25,20,42,6,'Consectetur omnis eaque nobis qui recusandae.','CHF 18500',1,1,0.025,'Einheit','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL,'a'),(26,3,58,5,'Aut delectus laudantium.','CHF 18300',1,1,0.080,'Pauschal','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL,'a'),(27,9,45,3,'Omnis possimus numquam nostrum officiis.','CHF 13700',1,1,0.080,'Km','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL,'a'),(28,7,52,3,'Sit aut temporibus dolorem occaecati.','CHF 18500',1,1,0.025,'Einheit','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL,'a'),(29,12,54,4,'Molestias quod error.','CHF 13700',0,1,0.025,'Km','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL,'a'),(30,2,59,1,'Temporibus et et veritatis quia.','CHF 18500',1,1,0.080,'Einheit','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL,'a'),(31,7,49,4,'Dolore accusamus qui similique et aliquam.','CHF 5500',1,1,0.025,'Einheit','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL,'a'),(32,15,68,6,'Commodi qui voluptate quia rerum ut.','CHF 6700',1,1,0.080,'Pauschal','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL,'a'),(33,19,74,6,'Totam saepe nihil mollitia consequatur et.','CHF 18300',0,1,0.025,'Pauschal','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL,'a'),(34,16,62,1,'Totam cupiditate odio asperiores.','CHF 18300',1,1,0.080,'Pauschal','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL,'a'),(35,10,79,1,'Qui ipsam similique quaerat.','CHF 10700',1,1,0.025,'Pauschal','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL,'a'),(36,13,72,2,'Ratione maiores et et ut.','CHF 18300',1,1,0.080,'Pauschal','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL,'a'),(37,8,64,2,'Sed ipsa nam minus qui.','CHF 2700',1,1,0.080,'Pauschal','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL,'a'),(38,16,78,2,'Eaque eos temporibus optio.','CHF 14500',1,1,0.025,'Pauschal','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL,'a'),(39,1,71,5,'Officia fugit et voluptatibus quam.','CHF 18300',1,1,0.080,'Pauschal','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL,'a'),(40,16,63,1,'Ut ratione ea aperiam quae nam.','CHF 14500',1,1,0.025,'Pauschal','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL,'a'),(41,9,66,2,'Quis sed autem et velit dolores.','CHF 14500',0,1,0.080,'Pauschal','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL,'a');
/*!40000 ALTER TABLE `activities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `activity_tags`
--

DROP TABLE IF EXISTS `activity_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `activity_tags` (
  `activity_id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL,
  PRIMARY KEY (`activity_id`,`tag_id`),
  KEY `IDX_6C784FB481C06096` (`activity_id`),
  KEY `IDX_6C784FB4BAD26311` (`tag_id`),
  CONSTRAINT `FK_6C784FB481C06096` FOREIGN KEY (`activity_id`) REFERENCES `activities` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_6C784FB4BAD26311` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activity_tags`
--

LOCK TABLES `activity_tags` WRITE;
/*!40000 ALTER TABLE `activity_tags` DISABLE KEYS */;
/*!40000 ALTER TABLE `activity_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `address` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `street` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `streetnumber` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `city` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `plz` int(11) DEFAULT NULL,
  `state` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `country` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address`
--

LOCK TABLES `address` WRITE;
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
INSERT INTO `address` VALUES (1,'Bahnhhofstrasse','25','Zürich',8000,'ZH','Switzerland'),(2,'Valentin-Kessler-Straße','880','Wernigerode',77023,'Niedersachsen','St. Lucia'),(3,'Hankeplatz','6a','Weyhe',77761,'Bremen','Jamaika'),(4,'Jansenring','95a','Ellwangen (Jagst)',26971,'Niedersachsen','Äußeres Ozeanien'),(5,'Heinz-Dieter-Jacob-Ring','33c','Ottobrunn',87718,'Brandenburg','Pitcairn'),(6,'Bärstr.','018','Burg',56797,'Niedersachsen','Schweden'),(7,'Wilkering','5','Wertheim',21953,'Niedersachsen','Neukaledonien'),(8,'Reinhard-Gross-Platz','6','Oldenburg',69117,'Bremen','Slowenien'),(9,'Friedrich-Wilhelm-Knoll-Allee','25','Groß-Umstadt',78734,'Hamburg','Finnland'),(10,'Sophie-Bernhardt-Allee','04a','Gevelsberg',61295,'Bayern','Dominica'),(11,'Hans Georg-Kolb-Platz','04','Walsrode',91011,'Berlin','Norwegen'),(12,'Henry-Langer-Straße','1/4','Troisdorf',67366,'Sachsen-Anhalt','Russische Föderation'),(13,'Klemmplatz','09','Wülfrath',67969,'Niedersachsen','Botsuana'),(14,'Burkhard-Scherer-Ring','077','Emmerich am Rhein',39921,'Bremen','China'),(15,'Freitaggasse','876','Übach-Palenberg',65836,'Nordrhein-Westfalen','Mexiko'),(16,'Marius-Hempel-Ring','748','Leichlingen (Rheinland)',22335,'Nordrhein-Westfalen','Malta'),(17,'Jenny-Jahn-Straße','0','Delmenhorst',43286,'Baden-Württemberg','Sierra Leone'),(18,'Metzstraße','7','Delmenhorst',92870,'Hamburg','Turkmenistan'),(19,'Irmhild-Reimer-Platz','21','Wermelskirchen',77211,'Rheinland-Pfalz','Ungarn'),(20,'Krebsstr.','68b','Werl',64496,'Bayern','Britisches Territorium im Indischen Ozean'),(21,'Löfflerweg','41a','Lahr/Schwarzwald',26449,'Saarland','Serbien'),(22,'Willibald-Nagel-Gasse','116','Frankenthal (Pfalz)',31315,'Hamburg','Dänemark'),(23,'Singerstraße','9/8','Obertshausen',86641,'Sachsen-Anhalt','Ungarn'),(24,'Fridolin-Wittmann-Platz','82b','Königswinter',92979,'Bayern','Europäische Union'),(25,'Wunderlichplatz','052','Oldenburg',62080,'Brandenburg','Uganda');
/*!40000 ALTER TABLE `address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `costgroups`
--

DROP TABLE IF EXISTS `costgroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `costgroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `number` int(11) DEFAULT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_21D763E8A76ED395` (`user_id`),
  CONSTRAINT `FK_21D763E8A76ED395` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `costgroups`
--

LOCK TABLES `costgroups` WRITE;
/*!40000 ALTER TABLE `costgroups` DISABLE KEYS */;
/*!40000 ALTER TABLE `costgroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_phones`
--

DROP TABLE IF EXISTS `customer_phones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_phones` (
  `customer_id` int(11) NOT NULL,
  `phone_id` int(11) NOT NULL,
  PRIMARY KEY (`customer_id`,`phone_id`),
  UNIQUE KEY `UNIQ_52EDF2A43B7323CB` (`phone_id`),
  KEY `IDX_52EDF2A49395C3F3` (`customer_id`),
  CONSTRAINT `FK_52EDF2A43B7323CB` FOREIGN KEY (`phone_id`) REFERENCES `phone` (`id`),
  CONSTRAINT `FK_52EDF2A49395C3F3` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_phones`
--

LOCK TABLES `customer_phones` WRITE;
/*!40000 ALTER TABLE `customer_phones` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer_phones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_tags`
--

DROP TABLE IF EXISTS `customer_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_tags` (
  `customer_id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL,
  PRIMARY KEY (`customer_id`,`tag_id`),
  KEY `IDX_3B2D30519395C3F3` (`customer_id`),
  KEY `IDX_3B2D3051BAD26311` (`tag_id`),
  CONSTRAINT `FK_3B2D30519395C3F3` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_3B2D3051BAD26311` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_tags`
--

LOCK TABLES `customer_tags` WRITE;
/*!40000 ALTER TABLE `customer_tags` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rate_group_id` int(11) DEFAULT NULL,
  `address_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `alias` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `company` varchar(60) COLLATE utf8_unicode_ci DEFAULT NULL,
  `department` varchar(60) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fullname` varchar(60) COLLATE utf8_unicode_ci DEFAULT NULL,
  `salutation` varchar(60) COLLATE utf8_unicode_ci DEFAULT NULL,
  `chargeable` tinyint(1) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_customer_alias_user` (`alias`,`user_id`),
  KEY `IDX_62534E212983C9E6` (`rate_group_id`),
  KEY `IDX_62534E21F5B7AF75` (`address_id`),
  KEY `IDX_62534E21A76ED395` (`user_id`),
  CONSTRAINT `FK_62534E212983C9E6` FOREIGN KEY (`rate_group_id`) REFERENCES `rate_groups` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_62534E21A76ED395` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_62534E21F5B7AF75` FOREIGN KEY (`address_id`) REFERENCES `address` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES (1,1,1,5,'StiftungSWO','stiftungswo',NULL,NULL,NULL,NULL,1,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(2,2,2,2,'Heck KG','recusandae-nam-quia-non-vitae-','Hübner Thiele OHG mbH','eaque','Stefan Hirsch','Herr',1,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(3,2,3,1,'Kern','commodi-nihil-ut-ratione-ea-ap','Held AG & Co. OHG','ipsum','Wally Breuer-Bader','Frau',0,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(4,2,4,3,'Unger AG','dignissimos-enim-maxime-tempor','Hentschel','placeat','Harald Schenk','Herr',1,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(5,2,5,2,'Braun','quod-exercitationem-numquam-qu','Mai','voluptatem','Silke Krauß','Frau',1,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(6,1,6,3,'Adler','qui-quisquam-facere-esse-quia-','Wiesner Bernhardt e.V.','dicta','Walburga Ackermann','Frau',1,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(7,1,7,3,'Voigt Stiftung & Co. KG','et-molestias-culpa-et-facilis-','Lorenz Eberhardt GmbH','nobis','Adam Fink','Herr',1,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(8,1,8,6,'Neubauer e.G.','eveniet-sint-provident-magni-e','Becker','quia','Klara Wimmer','Herr',1,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(9,2,9,2,'Lange Seidel e.V.','reiciendis-sunt-molestias-iure','Fuhrmann e.V.','suscipit','Henny Geisler','Herr',1,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(10,2,10,2,'Heinze','adipisci-temporibus-labore-lib','Hermann Hammer AG & Co. OHG','modi','Cindy Esser B.Eng.','Frau',1,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(11,2,11,3,'Römer GmbH & Co. KG','beatae-et-et-quis-illum-molest','Brandt KG','repellat','Frau Dr. Anny Völker B.Eng.','Frau',0,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(12,1,12,2,'Wolff AG & Co. KGaA','possimus-itaque-et-vel-qui-eos','Geisler GmbH & Co. KG','architecto','Reinhilde Lindemann','Frau',1,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(13,1,13,2,'Klose GmbH','enim-voluptatum-laboriosam-vit','Pietsch Meyer GbR','voluptas','Heidemarie Weiß','Herr',1,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(14,2,14,6,'Rothe Günther e.V.','maiores-dolore-et-at-debitis','Moser Friedrich GmbH','mollitia','Frau Veronika Unger','Herr',1,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(15,1,15,3,'Maier','ut-sint-est-quo-quas-eius-quam','Nowak KGaA','quisquam','Frau Prof. Edith Dietz','Frau',1,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(16,2,16,2,'Wolter','dolores-veritatis-illo-eveniet','Stumpf','omnis','Marcus Gabriel','Herr',1,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(17,1,17,1,'Geißler','officia-id-quidem-commodi-ulla','Bender','soluta','Cordula Wenzel','Herr',1,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(18,1,18,4,'Schumann Heine Stiftung & Co. KGaA','dolores-ut-tempore-modi-molest','Voß','dolorem','Lutz Barth','Frau',1,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(19,2,19,6,'Jürgens Stiftung & Co. KG','aliquid-quasi-sit-ipsa-sequi-i','Jost','alias','Hans-Günther Kellner','Herr',1,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(20,2,20,4,'Lenz GbR','cum-autem-nesciunt-et-numquam-','Huber','est','Andree Göbel','Frau',1,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(21,1,21,6,'Schlegel Preuß AG','quibusdam-reprehenderit-omnis-','Jansen','aut','Margarethe Bruns MBA.','Herr',1,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(22,1,22,1,'Reimer','dolores-est-dolores-neque-face','Thiel AG','quo','Edelgard Heinze','Frau',1,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(23,1,23,1,'Bernhardt Philipp AG','quia-possimus-sed-veritatis-mo','Krug','enim','Boris Winkler','Herr',0,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(24,1,24,5,'Dörr','ea-nihil-est-sed-rerum','Strobel AG','nostrum','Hans-Günter Scherer','Herr',1,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(25,1,25,1,'Barth','ut-quibusdam-sit-enim','Bär Wolter AG','atque','Herr Dr. Ewald Körner MBA.','Frau',1,'2017-12-18 11:30:36','2017-12-18 11:30:36');
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `holidays`
--

DROP TABLE IF EXISTS `holidays`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `holidays` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `duration` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_3A66A10CA76ED395` (`user_id`),
  CONSTRAINT `FK_3A66A10CA76ED395` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `holidays`
--

LOCK TABLES `holidays` WRITE;
/*!40000 ALTER TABLE `holidays` DISABLE KEYS */;
INSERT INTO `holidays` VALUES (1,1,'2017-02-14',30240,'2017-12-18 11:30:35','2017-12-18 11:30:35'),(2,3,'2017-02-19',30240,'2017-12-18 11:30:35','2017-12-18 11:30:35'),(3,5,'2017-06-22',3600,'2017-12-18 11:30:35','2017-12-18 11:30:35'),(4,4,'2017-07-26',16200,'2017-12-18 11:30:35','2017-12-18 11:30:35'),(5,4,'2017-10-08',3600,'2017-12-18 11:30:35','2017-12-18 11:30:35'),(6,4,'2017-08-19',30240,'2017-12-18 11:30:35','2017-12-18 11:30:35'),(7,5,'2017-06-07',30240,'2017-12-18 11:30:35','2017-12-18 11:30:35'),(8,5,'2017-03-16',30240,'2017-12-18 11:30:35','2017-12-18 11:30:35'),(9,3,'2017-06-27',16200,'2017-12-18 11:30:35','2017-12-18 11:30:35'),(10,4,'2017-04-09',16200,'2017-12-18 11:30:35','2017-12-18 11:30:35'),(11,5,'2017-10-29',16200,'2017-12-18 11:30:35','2017-12-18 11:30:35'),(12,2,'2017-11-07',30240,'2017-12-18 11:30:35','2017-12-18 11:30:35'),(13,5,'2017-10-23',30240,'2017-12-18 11:30:35','2017-12-18 11:30:35'),(14,1,'2017-10-22',30240,'2017-12-18 11:30:35','2017-12-18 11:30:35'),(15,5,'2016-12-22',30240,'2017-12-18 11:30:35','2017-12-18 11:30:35'),(16,4,'2017-02-14',30240,'2017-12-18 11:30:35','2017-12-18 11:30:35'),(17,6,'2017-01-06',30240,'2017-12-18 11:30:35','2017-12-18 11:30:35'),(18,5,'2017-07-20',30240,'2017-12-18 11:30:35','2017-12-18 11:30:35'),(19,1,'2017-03-11',30240,'2017-12-18 11:30:35','2017-12-18 11:30:35'),(20,5,'2017-09-14',30240,'2017-12-18 11:30:35','2017-12-18 11:30:35');
/*!40000 ALTER TABLE `holidays` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoiceDiscounts`
--

DROP TABLE IF EXISTS `invoiceDiscounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `invoiceDiscounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `invoice_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `value` decimal(10,2) DEFAULT NULL,
  `percentage` tinyint(1) DEFAULT NULL,
  `minus` tinyint(1) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_4F4E9F232989F1FD` (`invoice_id`),
  KEY `IDX_4F4E9F23A76ED395` (`user_id`),
  CONSTRAINT `FK_4F4E9F232989F1FD` FOREIGN KEY (`invoice_id`) REFERENCES `invoices` (`id`),
  CONSTRAINT `FK_4F4E9F23A76ED395` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoiceDiscounts`
--

LOCK TABLES `invoiceDiscounts` WRITE;
/*!40000 ALTER TABLE `invoiceDiscounts` DISABLE KEYS */;
INSERT INTO `invoiceDiscounts` VALUES (1,49,2,'10% Off',0.10,1,1,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(2,47,1,'10% Off',0.10,1,1,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(3,50,3,'10% Off',0.10,1,1,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(4,45,3,'10% Off',0.10,1,1,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(5,49,1,'10% Off',0.10,1,1,'2017-12-18 11:30:36','2017-12-18 11:30:36');
/*!40000 ALTER TABLE `invoiceDiscounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoice_costgroups`
--

DROP TABLE IF EXISTS `invoice_costgroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `invoice_costgroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `invoice_id` int(11) DEFAULT NULL,
  `costgroup_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `weight` double NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_D80B13762989F1FD` (`invoice_id`),
  KEY `IDX_D80B1376CC72B005` (`costgroup_id`),
  KEY `IDX_D80B1376A76ED395` (`user_id`),
  CONSTRAINT `FK_D80B13762989F1FD` FOREIGN KEY (`invoice_id`) REFERENCES `invoices` (`id`),
  CONSTRAINT `FK_D80B1376A76ED395` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_D80B1376CC72B005` FOREIGN KEY (`costgroup_id`) REFERENCES `costgroups` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoice_costgroups`
--

LOCK TABLES `invoice_costgroups` WRITE;
/*!40000 ALTER TABLE `invoice_costgroups` DISABLE KEYS */;
/*!40000 ALTER TABLE `invoice_costgroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoice_items`
--

DROP TABLE IF EXISTS `invoice_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `invoice_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `invoice_id` int(11) DEFAULT NULL,
  `activity_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `rate_value` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `rateUnit` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `vat` decimal(10,3) DEFAULT NULL,
  `amount` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `order_no` decimal(10,0) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_DCC4B9F82989F1FD` (`invoice_id`),
  KEY `IDX_DCC4B9F881C06096` (`activity_id`),
  KEY `IDX_DCC4B9F8A76ED395` (`user_id`),
  CONSTRAINT `FK_DCC4B9F82989F1FD` FOREIGN KEY (`invoice_id`) REFERENCES `invoices` (`id`),
  CONSTRAINT `FK_DCC4B9F881C06096` FOREIGN KEY (`activity_id`) REFERENCES `activities` (`id`),
  CONSTRAINT `FK_DCC4B9F8A76ED395` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoice_items`
--

LOCK TABLES `invoice_items` WRITE;
/*!40000 ALTER TABLE `invoice_items` DISABLE KEYS */;
INSERT INTO `invoice_items` VALUES (1,1,1,2,'Zivi (Tagespauschale)','CHF 88000','CHF/h',0.080,'28',1,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(2,25,5,1,'molestias','CHF 64300','CHF/h',0.025,'40',48,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(3,30,8,4,'possimus','CHF 45500','CHF/h',0.080,'8',38,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(4,17,9,4,'odio','CHF 45600','CHF/h',0.025,'50',24,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(5,12,5,1,'minima','CHF 39500','CHF/h',0.025,'6',53,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(6,3,3,5,'harum','CHF 70600','CHF/h',0.025,'82',24,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(7,21,11,5,'ratione','CHF 58700','CHF/h',0.080,'87',90,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(8,7,10,1,'voluptatem','CHF 15000','CHF/h',0.080,'16',3,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(9,22,11,1,'neque','CHF 32600','CHF/h',0.025,'42',98,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(10,37,10,6,'et','CHF 3200','CHF/h',0.025,'97',65,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(11,39,9,6,'est','CHF 83700','CHF/h',0.080,'81',55,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(12,4,21,3,'quo','CHF 2600','CHF/h',0.025,'16',11,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(13,45,17,2,'quidem','CHF 37800','CHF/h',0.025,'57',17,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(14,5,21,5,'nihil','CHF 50200','CHF/h',0.080,'25',66,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(15,49,16,3,'omnis','CHF 62500','CHF/h',0.025,'87',69,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(16,12,15,5,'illo','CHF 14800','CHF/h',0.025,'22',29,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(17,45,17,5,'officia','CHF 70000','CHF/h',0.080,'99',81,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(18,1,20,2,'suscipit','CHF 70800','CHF/h',0.080,'7',47,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(19,32,20,2,'blanditiis','CHF 35200','CHF/h',0.080,'43',58,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(20,14,14,3,'qui','CHF 95700','CHF/h',0.025,'1',62,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(21,14,21,5,'quia','CHF 36600','CHF/h',0.080,'58',49,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(22,10,31,6,'perferendis','CHF 72500','CHF/h',0.080,'24',26,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(23,15,27,4,'consequatur','CHF 65400','CHF/h',0.080,'33',68,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(24,20,22,5,'magni','CHF 34000','CHF/h',0.080,'76',42,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(25,22,28,1,'autem','CHF 87600','CHF/h',0.080,'18',40,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(26,9,23,6,'quam','CHF 77500','CHF/h',0.025,'10',38,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(27,35,27,3,'ab','CHF 48500','CHF/h',0.025,'71',70,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(28,29,22,1,'reiciendis','CHF 33500','CHF/h',0.080,'34',8,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(29,21,22,3,'minus','CHF 27700','CHF/h',0.025,'21',99,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(30,41,26,5,'consectetur','CHF 29600','CHF/h',0.025,'86',47,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(31,20,24,4,'expedita','CHF 14000','CHF/h',0.025,'96',79,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(32,21,39,4,'quia','CHF 82100','CHF/h',0.080,'83',77,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(33,40,39,5,'dolor','CHF 86600','CHF/h',0.025,'3',11,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(34,9,33,2,'dolorem','CHF 23000','CHF/h',0.080,'68',92,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(35,40,33,1,'quod','CHF 83700','CHF/h',0.025,'63',37,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(36,23,38,2,'et','CHF 46700','CHF/h',0.025,'64',63,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(37,47,38,4,'nobis','CHF 49900','CHF/h',0.080,'49',16,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(38,17,38,4,'at','CHF 24600','CHF/h',0.080,'54',99,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(39,46,40,2,'rerum','CHF 30300','CHF/h',0.080,'85',72,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(40,17,39,3,'saepe','CHF 36200','CHF/h',0.080,'13',41,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(41,44,33,4,'aut','CHF 49000','CHF/h',0.025,'82',49,'2017-12-18 11:30:36','2017-12-18 11:30:36');
/*!40000 ALTER TABLE `invoice_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoice_standard_discounts`
--

DROP TABLE IF EXISTS `invoice_standard_discounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `invoice_standard_discounts` (
  `invoice_id` int(11) NOT NULL,
  `standard_discount_id` int(11) NOT NULL,
  PRIMARY KEY (`invoice_id`,`standard_discount_id`),
  UNIQUE KEY `UNIQ_A1BE84207EAA7D27` (`standard_discount_id`),
  KEY `IDX_A1BE84202989F1FD` (`invoice_id`),
  CONSTRAINT `FK_A1BE84202989F1FD` FOREIGN KEY (`invoice_id`) REFERENCES `invoices` (`id`),
  CONSTRAINT `FK_A1BE84207EAA7D27` FOREIGN KEY (`standard_discount_id`) REFERENCES `standard_discounts` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoice_standard_discounts`
--

LOCK TABLES `invoice_standard_discounts` WRITE;
/*!40000 ALTER TABLE `invoice_standard_discounts` DISABLE KEYS */;
/*!40000 ALTER TABLE `invoice_standard_discounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoice_tags`
--

DROP TABLE IF EXISTS `invoice_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `invoice_tags` (
  `invoice_id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL,
  PRIMARY KEY (`invoice_id`,`tag_id`),
  KEY `IDX_6D79F6432989F1FD` (`invoice_id`),
  KEY `IDX_6D79F643BAD26311` (`tag_id`),
  CONSTRAINT `FK_6D79F6432989F1FD` FOREIGN KEY (`invoice_id`) REFERENCES `invoices` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_6D79F643BAD26311` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoice_tags`
--

LOCK TABLES `invoice_tags` WRITE;
/*!40000 ALTER TABLE `invoice_tags` DISABLE KEYS */;
/*!40000 ALTER TABLE `invoice_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoices`
--

DROP TABLE IF EXISTS `invoices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `invoices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(11) DEFAULT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `accountant_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `alias` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8_unicode_ci,
  `start` date DEFAULT NULL,
  `end` date DEFAULT NULL,
  `fixed_price` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_6A2F2F95166D1F9C` (`project_id`),
  KEY `IDX_6A2F2F959395C3F3` (`customer_id`),
  KEY `IDX_6A2F2F959582AA74` (`accountant_id`),
  KEY `IDX_6A2F2F95A76ED395` (`user_id`),
  CONSTRAINT `FK_6A2F2F95166D1F9C` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`),
  CONSTRAINT `FK_6A2F2F959395C3F3` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_6A2F2F959582AA74` FOREIGN KEY (`accountant_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_6A2F2F95A76ED395` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoices`
--

LOCK TABLES `invoices` WRITE;
/*!40000 ALTER TABLE `invoices` DISABLE KEYS */;
INSERT INTO `invoices` VALUES (1,1,1,2,2,'Default Invoice','default-invoice','This is a detailed description','2016-08-23','2017-07-01',NULL,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(2,12,19,4,3,'Test Invoice 2','test-invoice-2','Velit possimus cum ducimus vitae quam omnis ea. Odio quis est officia voluptatibus corrupti commodi. Minima reprehenderit laborum cumque molestiae aut numquam. Harum aliquam est quod. Laudantium qui ipsa ratione sunt ut officia. Reprehenderit autem voluptatem perspiciatis eius necessitatibus qui. Quis saepe neque quia eum repellendus enim eum. Ea et harum ut explicabo odit similique nihil numquam. Sit suscipit libero nisi sunt sit quas quo totam. Numquam itaque magnam voluptas quidem dolorum neque. Totam non dolor voluptatibus nihil occaecati ut.','2017-04-06','2017-07-20','CHF 2170800','2017-12-18 11:30:36','2017-12-18 11:30:36'),(3,12,22,5,4,'Test Invoice 3','test-invoice-3','Ullam iste repellat qui ipsum sit illum. Distinctio et doloremque quia commodi modi quia. Corrupti autem quae perferendis enim. Consequuntur provident beatae culpa consequatur aut ducimus dignissimos. Consequatur accusantium excepturi magni qui at et. Voluptas soluta eaque autem veritatis. Nam maxime qui dolorem quam cumque eius. Vel ex occaecati dolorem ab. Eius quia iusto odio in. Reiciendis modi magni perferendis iure suscipit labore. Minus iste corrupti rerum necessitatibus aut totam sit. Eaque nobis qui recusandae tempore molestias. Fugit delectus aut delectus laudantium. Iure quia illo neque omnis possimus numquam nostrum.','2016-12-29','2017-12-08',NULL,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(4,7,17,6,4,'Test Invoice 4','test-invoice-4','Est commodi qui voluptate quia rerum. Enim rem provident voluptas harum totam. Nihil mollitia consequatur et at magni nihil aut. Totam cupiditate odio asperiores perspiciatis. Natus optio qui ipsam similique quaerat. Perspiciatis et placeat autem. Maiores et et ut beatae rerum assumenda et. Sed ipsa nam minus qui recusandae nam. Vitae eaque eos temporibus optio nisi sequi et. Esse officia fugit et voluptatibus quam quaerat. Id commodi nihil ut. Aperiam quae nam id repellat et. Ipsum quis sed autem et velit dolores. Optio quos quia molestiae dignissimos enim maxime tempore.','2016-07-04','2017-08-07',NULL,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(5,12,4,2,5,'Test Invoice 5','test-invoice-5','Aut culpa illo quisquam accusamus distinctio. Aut aut et molestias. Et facilis est ut qui fugit sed saepe. Ut cupiditate nemo rem. Voluptas dignissimos molestiae neque culpa. Sint provident magni eius nulla distinctio qui quia. Et magnam qui officia. Expedita ratione et sit reiciendis sunt molestias iure. Et molestiae laborum sequi laborum distinctio suscipit aut. Assumenda soluta aut magni accusantium voluptatem adipisci. Labore libero repudiandae non. Autem unde est eaque et. Incidunt exercitationem et reiciendis vel facilis sed facere. Est laboriosam beatae et. Quis illum molestiae rerum omnis exercitationem velit repellat. Cum vitae sunt vel ut molestiae.','2016-01-07','2017-08-08',NULL,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(6,18,25,6,2,'Test Invoice 6','test-invoice-6','Sit labore rem voluptas quasi aut. Ea libero veritatis rerum ad incidunt voluptatem facere. Dolore et at debitis reprehenderit sequi occaecati rerum. Occaecati et quod deserunt dignissimos repudiandae eos adipisci dolores. Ut sint est quo quas eius quam architecto enim. Est quo eveniet quisquam iste dolorem. Praesentium autem qui sed sed cupiditate. Veritatis illo eveniet est non qui. Repellendus natus omnis assumenda eaque vel modi nisi. Ipsum praesentium cumque officia id quidem commodi. Aut fuga praesentium et.','2016-03-01','2017-06-03',NULL,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(7,13,15,4,6,'Test Invoice 7','test-invoice-7','Sed atque occaecati error. Labore sit a qui omnis doloribus pariatur. Est dignissimos cum autem nesciunt. Numquam aspernatur alias odio magni est. Asperiores optio adipisci corporis qui. Corporis placeat adipisci quibusdam reprehenderit. Voluptas sed ut et aut minima quos est. Facere numquam eius numquam nemo. Dolores est dolores neque facere fugit sint consequatur et. Quos id quo laudantium dolorem voluptatibus iure. Provident neque est inventore minima laboriosam quia possimus.','2017-04-22','2017-11-11',NULL,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(8,4,18,1,3,'Test Invoice 8','test-invoice-8','Aliquam repellat quia sequi. Nihil beatae est et dolores et. Sunt accusamus et occaecati similique. Iusto dignissimos sit aut repellendus. Sapiente autem non ut fuga voluptatibus atque dolore. Impedit eius ut alias quisquam at qui incidunt. Maxime adipisci et saepe esse. Sed aperiam rerum nemo animi necessitatibus. Quam aut iusto harum reiciendis magnam voluptatum neque molestiae. Dolorum velit ipsam beatae. Reprehenderit earum nulla consequatur occaecati sit. Et est quia ex. Explicabo libero placeat ex aperiam. Dolorum facilis enim omnis consectetur nihil ipsum velit. Sit tenetur totam ad ut consequuntur. Veniam minima a numquam sed repellat ea atque.','2017-04-13','2017-12-14',NULL,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(9,11,13,5,3,'Test Invoice 9','test-invoice-9','Neque sequi qui cum maiores voluptate aperiam. Aut at natus voluptas est aut placeat. Optio itaque qui vel qui quasi autem. Quis odit sapiente aliquid veritatis est fuga cumque. Ipsam eum amet qui et veniam est. Quibusdam aut omnis labore molestiae consequuntur explicabo sint sequi. Facere recusandae aliquam voluptatem quia hic. Rem enim eos necessitatibus omnis ullam maxime hic et. Expedita est id dolor aliquid officia perspiciatis autem. Et et nihil officia sit sed et pariatur et. Beatae ut hic est quo et. Aut harum reprehenderit qui voluptates voluptatibus numquam dolores suscipit. Fugiat est saepe suscipit nulla. Aut ullam tempore aspernatur.','2016-10-11','2017-06-10','CHF 4526100','2017-12-18 11:30:36','2017-12-18 11:30:36'),(10,NULL,20,1,4,'Test Invoice 10','test-invoice-10','Quisquam molestiae incidunt a aut tempore eos quam. Ducimus accusamus id molestias labore. Error consequatur modi et vel assumenda. Excepturi ipsam est magni similique. Asperiores dolores praesentium id porro tempora. Id occaecati voluptatem rerum optio sint voluptatem libero. Commodi at modi assumenda. Tempore ex mollitia vel quasi facilis eveniet. Cupiditate sed rem omnis consequatur ullam. Quia et in dolorem quidem id enim aspernatur. Est voluptatem officia provident velit laboriosam ut eum. Ea ut error unde eos blanditiis animi. Et quidem ut ut est inventore velit. Dignissimos est enim tenetur. Dolores laborum commodi quis sit eveniet. Dolor est voluptatum cum veniam.','2016-04-10','2017-10-27','CHF 7349800','2017-12-18 11:30:36','2017-12-18 11:30:36'),(11,NULL,3,1,2,'Test Invoice 11','test-invoice-11','Architecto esse iusto vero praesentium quam vitae aut. Est nam quae debitis ut quia eum. In dignissimos quia nam aut explicabo. Fuga deserunt error consequatur error. Modi eveniet est quis enim. Adipisci explicabo molestias provident totam voluptatibus cumque. Fuga voluptas cupiditate voluptas sit sit incidunt aliquid libero. Temporibus ut ad sint pariatur eos. Sint sunt et aspernatur sapiente necessitatibus blanditiis tempora laborum. Eaque aliquam ea adipisci animi aut possimus. Provident qui magnam atque eaque laudantium reiciendis. Doloremque ratione quisquam ducimus velit eligendi delectus possimus.','2017-01-23','2017-06-24',NULL,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(12,14,25,4,2,'Test Invoice 12','test-invoice-12','Cum corrupti rerum consequatur ea expedita et voluptatibus. Voluptatem et in neque quos ut qui saepe. Tempore labore quia nesciunt culpa cupiditate temporibus nulla. Omnis sed ullam ut deserunt magni. Voluptate quidem eaque ut distinctio. Quis est ratione rerum ipsa culpa. Eos velit quia adipisci amet. Voluptatem consequatur quasi perferendis provident dicta sed esse. Ex voluptates quidem eos vel voluptas non. Iure et commodi quidem dicta. Similique voluptatem ratione et rerum temporibus voluptas. Non ea voluptatem doloribus. Et dolor et recusandae exercitationem velit est ipsa. Tempore quia atque natus. Est nesciunt aliquam aspernatur repellendus pariatur modi illo.','2017-05-27','2017-10-15','CHF 9443500','2017-12-18 11:30:36','2017-12-18 11:30:36'),(13,NULL,9,1,5,'Test Invoice 13','test-invoice-13','Sunt nam aut placeat nisi reiciendis. Eos voluptate dolorem qui cupiditate perspiciatis voluptatem. Corporis ea quia error molestias rerum. Quia sapiente eum molestiae optio doloribus magni est. Et magni voluptatem temporibus qui repellat officia. Voluptatem similique qui ipsam itaque rerum aut. Quas eius sint deserunt. Recusandae modi minus vel consequatur eum enim nihil. Consectetur voluptatem architecto voluptatem qui occaecati. Sed voluptates et libero voluptates. Autem aut tempore vitae unde doloremque fugiat et. Dignissimos quia repudiandae consequatur impedit magnam quaerat sint nihil. In eaque commodi modi optio. Ut nisi est similique.','2016-10-09','2017-11-28',NULL,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(14,NULL,16,5,4,'Test Invoice 14','test-invoice-14','A cum ut et eius ut et vel. Nesciunt dolores officia ut. Eum quasi ut est molestiae error minus. Repudiandae quae non ad eos maiores exercitationem. Sunt pariatur nulla et dolor at soluta. Autem sed et sunt praesentium. Sint voluptatibus ipsa ipsum omnis consequatur. Cupiditate quisquam corporis laboriosam repudiandae itaque. Alias sint et dolorem doloribus occaecati commodi quisquam. Provident ex recusandae aliquid beatae nihil. Eum praesentium tenetur expedita nam sint pariatur in. Voluptas sit ea delectus. Aspernatur dolor ut veniam est repudiandae. Modi quo maxime voluptates suscipit illum velit laborum. Voluptatem fugit qui molestiae reprehenderit sint.','2016-11-23','2017-09-27',NULL,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(15,NULL,3,3,6,'Test Invoice 15','test-invoice-15','Omnis est eaque dolorem beatae. Ipsa vel est ad voluptatem illum eum eligendi reprehenderit. Non et fugiat animi quibusdam labore numquam maxime modi. Architecto deserunt qui sit tenetur inventore. Error occaecati enim aperiam dicta eaque id sit. Molestiae placeat nulla quia a et. Incidunt nulla aperiam officia eaque error cumque ullam. Ab qui minus ut sint. Autem eius mollitia perferendis dicta esse porro aut. Et et quia et enim dolor praesentium optio eveniet. Sed nesciunt quisquam nihil magni eaque nostrum. Atque ipsam et id amet distinctio molestiae non. Sequi excepturi et deleniti asperiores quia. Accusamus praesentium ratione nihil. Sunt modi exercitationem voluptas est.','2016-02-08','2017-10-18',NULL,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(16,NULL,1,6,6,'Test Invoice 16','test-invoice-16','Eos mollitia fugit perferendis. Non et necessitatibus sit repudiandae dolorum. Quo sunt eaque et asperiores animi voluptatem in ut. Et quae vero quas eum quae vitae harum. Rerum quis dolor perferendis. Sit iste hic eos laborum. Accusantium et quas nihil quam id autem. Hic consequatur consectetur eaque aut. Sit nam qui id et. Et aliquam minima corporis aut sequi qui. Sed provident aperiam vel impedit quos. Nesciunt odit esse repellat aliquid animi. Quia error libero nostrum quas illum quia. Occaecati consequuntur facere quo quam architecto et aut.','2017-03-31','2017-10-05',NULL,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(17,NULL,10,2,2,'Test Invoice 17','test-invoice-17','Odit qui doloribus a aut et. Esse dolorem cumque sunt vel. Accusamus laudantium possimus laboriosam optio et. Accusantium dolorem dolores beatae est eos modi. Sit numquam voluptatibus cupiditate. Ipsa occaecati similique consequuntur voluptatum expedita. Facilis repellendus iste est fugiat ab accusamus nam. Est totam qui est omnis accusamus. In eaque asperiores ad officia quo. Voluptatem cum dicta quod totam. Dicta vel quasi molestiae. Vero expedita autem sint cumque quia. Impedit est distinctio praesentium sit quis dolorem. Voluptatum ut rerum excepturi a repellendus ex et praesentium. Eum sint dolorem in.','2017-05-24','2017-10-20',NULL,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(18,10,19,2,2,'Test Invoice 18','test-invoice-18','Provident quae quia ex reprehenderit eum. Cum quod dolor dolores voluptatum esse pariatur et. Veritatis iusto quia delectus consectetur eveniet. Cupiditate consectetur at quam officia mollitia eum consequatur corporis. Voluptate quo doloremque quis vel. Eveniet debitis dolores iusto quidem. Rerum ad eligendi omnis alias qui nisi. Aliquid dolorem neque officiis impedit eveniet ducimus. Sapiente earum quia eius quo similique. Illo unde soluta molestiae tempore et laboriosam. Qui et et tenetur qui nihil. Voluptatum accusamus rem aut quia. Commodi amet vel aliquam et sunt ut qui quae. Perferendis animi quis dolores tenetur totam sunt ut.','2017-01-25','2017-12-13',NULL,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(19,NULL,21,4,5,'Test Invoice 19','test-invoice-19','Fuga aspernatur cupiditate itaque deserunt est repellendus repellat. Quo laboriosam qui quae voluptas earum. Sunt quos aliquid temporibus voluptatem repellendus blanditiis ea. Sunt tempore doloremque ullam labore dignissimos quaerat molestiae. Commodi fugit qui iste ab non dolorem et. Rem culpa et provident quisquam corporis perspiciatis aliquam. Molestiae sit quis autem sequi debitis dolor error nobis. Porro maiores quidem dolor et explicabo. Sunt voluptatum sed excepturi accusamus. Omnis quas odit deserunt perferendis odit. Repellat praesentium rerum est et. Temporibus consequuntur nulla assumenda aut laboriosam.','2017-03-10','2017-10-10',NULL,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(20,NULL,10,2,3,'Test Invoice 20','test-invoice-20','Est molestiae nulla non earum. Non consequatur possimus tenetur consequuntur laborum temporibus natus. Impedit omnis sint explicabo exercitationem porro. Repudiandae recusandae quisquam ipsa veritatis. Accusantium sit modi consectetur est accusantium assumenda molestiae nihil. Ratione quia dolores quisquam rerum et debitis officia. Et officiis at minus veniam magnam qui mollitia. Vel consequatur ducimus corporis excepturi. Ut harum et aliquid quas. Aut fugiat odio aut consequuntur vero praesentium incidunt. Quae voluptatem mollitia voluptas architecto ipsa.','2016-02-28','2017-06-19',NULL,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(21,7,15,1,5,'Test Invoice 21','test-invoice-21','Voluptas neque qui alias sed exercitationem excepturi numquam. Modi sed placeat odio ut ullam velit rem. Eum eum quis eaque ipsa dolorum reiciendis. Molestiae libero fugit corporis. Fuga ab quo temporibus rerum. Non nisi fuga quia deleniti unde minima. Doloremque nihil quia cum occaecati magnam hic expedita. Est iste fugit explicabo alias accusamus quo ratione. Perferendis provident provident aliquam sit eligendi. Omnis delectus possimus harum ullam laudantium. Blanditiis cumque esse qui et qui laboriosam. Laboriosam beatae enim sunt quaerat. Laudantium similique aut quia vel repudiandae doloribus.','2016-06-23','2017-08-26',NULL,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(22,20,24,2,5,'Test Invoice 22','test-invoice-22','Magnam odit adipisci saepe consequatur perferendis voluptas. Recusandae repudiandae molestias quisquam earum animi aut. Porro nam excepturi odit eius voluptatum. Reprehenderit eligendi totam temporibus tempora et. Minima mollitia odit modi possimus eveniet. Culpa iste aliquid ipsam commodi blanditiis ipsam. Soluta dolore magni temporibus illum ex eveniet enim. Voluptatem perspiciatis consequatur repellendus eligendi. Doloremque ut dolores velit repellendus blanditiis. Quisquam autem sunt blanditiis maiores et. Nihil enim atque voluptas id eaque modi. Hic aliquid corporis est eos aut. Non molestias aut ut et sunt consectetur laboriosam.','2016-09-03','2017-09-12',NULL,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(23,6,15,1,3,'Test Invoice 23','test-invoice-23','Tempore maiores eius voluptatem ut aspernatur. Omnis dolore consequatur recusandae asperiores. Nobis animi consequatur eligendi laudantium. Aut et vel fugiat fuga. In rerum maxime consequuntur iusto ipsa. Harum nemo laborum cupiditate sint. Facilis ut numquam vel tempore et eius fugit. Sunt sequi sed ad quibusdam sequi. Ea pariatur incidunt aspernatur impedit nisi. Nisi officia perspiciatis reiciendis aperiam est nobis ipsa. Nobis veritatis accusantium est pariatur aut eos. Voluptatibus sit ad beatae eligendi debitis quam. Minus sit ea ipsa non neque atque saepe.','2017-04-26','2017-06-30',NULL,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(24,20,13,5,4,'Test Invoice 24','test-invoice-24','Quam rerum laboriosam in dolores id suscipit. Assumenda in velit modi aliquid repudiandae facere perferendis. Quaerat et delectus aut dolores. Odio molestiae et dolor officia. Dignissimos est ullam eligendi fugit fuga numquam. Ad vel officiis dolores dolor natus animi. Est nisi illum impedit aut est veniam dicta. Est et a corrupti quia aut ut cumque. Error natus impedit commodi sed cupiditate porro. Dolorum accusantium laborum consequatur quia. Odit ipsam est qui sit recusandae repellendus qui. Quam voluptatem aut commodi soluta ut laudantium. Aspernatur suscipit optio quia culpa ab.','2016-09-03','2017-08-30',NULL,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(25,14,19,6,6,'Test Invoice 25','test-invoice-25','Molestiae nihil molestiae eos sint rem. Qui quae minima qui. Maiores quae quo excepturi. Minima et odio voluptatibus est qui enim. Odit est et fuga corporis suscipit dolores. Eos tempore est ullam voluptas et fugiat. Aut assumenda dolorum alias sit. Earum porro ullam ducimus molestias fuga. Velit iste sunt aut ad molestiae officia ex. Aliquam minima et porro omnis temporibus odio quam. Omnis quia deleniti ullam eum iure. Sunt odit quia inventore. Perspiciatis quas non facere eligendi maiores provident quas vel.','2016-01-06','2017-07-11',NULL,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(26,6,3,5,2,'Test Invoice 26','test-invoice-26','Sit hic sit at ex temporibus dolorem eveniet. Aut eligendi et doloribus dolore quae maxime hic. Harum est eius tenetur et ducimus ut. Maiores laboriosam expedita est neque. Veniam modi dolores aut provident deserunt sunt. Nihil cumque id nihil quidem quia consectetur. Vero voluptatem quis consequatur alias voluptatem. Provident cupiditate harum quos dolorem perspiciatis odio. Dolorum incidunt minus maiores molestiae nulla maiores. Et dignissimos minus nulla ut excepturi a fugit. Est maiores tempora quos laboriosam. Quam suscipit ducimus iste a repellendus.','2016-03-02','2017-06-23',NULL,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(27,12,1,4,1,'Test Invoice 27','test-invoice-27','Tempora quia qui ut ut quod. Quis est qui ad et placeat eaque itaque. Occaecati eos labore in est recusandae quaerat facilis. Aut consequuntur optio expedita ipsa incidunt debitis. Inventore voluptas voluptatem quia porro omnis ducimus eos. Nemo omnis cum et sunt fugiat. Illo officia perspiciatis consectetur aut ab. Hic earum fugiat est voluptatem sit rerum fuga. Praesentium a autem enim ullam. Et voluptatem eum omnis esse. Debitis id fugit neque voluptatem error. Delectus quae qui deleniti doloribus modi quia. Molestiae accusamus et praesentium quia quo in aut. Ipsum magnam consectetur non modi.','2016-09-25','2017-11-16',NULL,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(28,17,21,6,2,'Test Invoice 28','test-invoice-28','Suscipit repellendus velit enim nostrum. Nemo et ut quisquam nemo fugiat vel optio voluptatem. Eligendi vitae iusto minima a debitis saepe sit. Nostrum consequatur ipsa et accusamus. Consequatur sint voluptatum id molestiae. Et non quam sint quae. Eligendi quam cum accusamus eveniet quae. Eaque voluptatibus corrupti molestiae dolorem error facilis et. Et voluptas dicta facere vero molestias. Repudiandae temporibus quia perspiciatis commodi eligendi alias. Repellendus sint veniam explicabo sequi maiores qui. Excepturi provident rerum corporis in. Itaque reiciendis recusandae sit ad magnam distinctio aut.','2016-04-12','2017-11-15',NULL,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(29,10,6,1,6,'Test Invoice 29','test-invoice-29','Consequatur sit consectetur aliquid ad nihil quas dignissimos et. Voluptatem qui maiores vel quis tempora quia voluptatem. Explicabo qui reiciendis ut atque est hic et. Nostrum sunt quasi qui. Nostrum cupiditate provident aperiam esse recusandae. Et ab omnis vitae quod et. Ut assumenda expedita quia rem et rerum qui. Dolores quisquam nam unde expedita quos doloribus numquam. Qui saepe incidunt quaerat magnam excepturi. Est pariatur consequatur eveniet debitis consectetur. Delectus dolores eius quibusdam laudantium blanditiis enim explicabo consectetur. Reprehenderit facilis qui eum. Neque nulla enim praesentium rerum deleniti.','2016-04-08','2017-08-05',NULL,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(30,3,1,4,2,'Test Invoice 30','test-invoice-30','Nam nobis eum temporibus tempore sit. Reiciendis voluptas consequatur placeat quod. Debitis fuga et vel velit illum nisi. Voluptas beatae qui dolor rem eligendi veniam sint. Temporibus qui iure occaecati est beatae voluptate. Cupiditate amet fuga nobis et. Non voluptas quae veritatis velit et repellat tenetur eum. Et libero beatae omnis enim fugiat est ut vero. Aut cumque repudiandae aut totam. Beatae omnis incidunt magnam expedita aut voluptas earum. Dolor ipsam qui doloribus. Magnam iusto quasi cum sed. Rerum error hic accusantium debitis excepturi odit fugit fuga. Aliquam voluptate amet adipisci modi veritatis.','2016-04-19','2017-11-05',NULL,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(31,16,7,1,3,'Test Invoice 31','test-invoice-31','Dolores doloremque unde eaque dolorum. Commodi magnam dolorem et doloribus ipsum. Hic ut cum nostrum corrupti qui dignissimos. Pariatur et nihil earum. Eaque facere qui est possimus omnis omnis occaecati nesciunt. Delectus sed beatae unde architecto non eum numquam molestiae. Illum et sed dolor et labore. Perferendis similique numquam nihil aut. Sint fugiat est nemo quasi. Expedita consequuntur dolores ad. Et incidunt nesciunt voluptas ratione tempore nobis. Quo est vel qui iure. Vero ea aut rem ipsum itaque voluptas. Praesentium ratione deleniti et aut. Sed aliquam velit rerum in et. Fugiat dolorem molestiae sit quis quo. Nemo deserunt quam dolor animi.','2016-07-03','2017-08-15',NULL,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(32,15,22,5,2,'Test Invoice 32','test-invoice-32','Quia saepe ullam corrupti molestiae natus assumenda impedit. Consequatur ullam nam est in ipsa. Eius quo ut labore molestias harum. Non modi sit libero velit molestiae rerum. Qui a quas aut. Commodi iste voluptatem nobis quibusdam itaque quo dolorum. Exercitationem totam praesentium fugiat quod quas repellendus quam. Blanditiis doloribus eum eum porro ea recusandae autem. Voluptatem dignissimos reprehenderit est. Et nesciunt est aut qui. Quidem perspiciatis placeat necessitatibus id laborum facilis dicta incidunt. Odio sapiente laborum sed natus delectus nesciunt.','2016-12-03','2017-10-09',NULL,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(33,18,2,5,3,'Test Invoice 33','test-invoice-33','Unde nulla sed quas amet beatae modi accusamus. Qui accusantium provident expedita ut. Laboriosam provident aut sed sit rerum. Non quasi eos illo tempore. Odio natus temporibus et et aspernatur quaerat unde. Harum nam reiciendis id nesciunt sit. Cumque molestiae voluptatem ut repellat. Adipisci qui at quis numquam et mollitia. Reprehenderit ex quasi doloribus voluptatum nemo sit. Suscipit ut impedit saepe. Voluptates vitae autem vero officia ab repudiandae at. Est ex magnam nesciunt. Adipisci corporis qui doloribus esse. Nisi in reprehenderit molestiae vero.','2016-08-05','2017-12-09',NULL,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(34,14,22,1,1,'Test Invoice 34','test-invoice-34','Nihil explicabo libero eaque dolore sunt ea. Voluptate cupiditate animi recusandae quod doloremque maiores autem. Ad excepturi velit ratione earum pariatur. Sed ratione quasi optio sunt. A rem quia unde tempore voluptate quia. Libero nobis explicabo autem. Harum et est iusto perspiciatis consequatur. Minus qui sit beatae vero ut hic vero quidem. Culpa voluptas repudiandae iste atque. Nesciunt aut necessitatibus id molestiae sed maiores omnis. Sit modi nihil ipsum hic eum autem temporibus. Atque repellat sapiente autem. Voluptatem aut id porro nisi vero voluptatem nihil. Voluptatum asperiores fuga earum. Quo libero enim dolore rerum.','2016-01-17','2017-11-17','CHF 9495800','2017-12-18 11:30:36','2017-12-18 11:30:36'),(35,NULL,24,1,4,'Test Invoice 35','test-invoice-35','Ipsum voluptas est doloribus laborum dolores eos necessitatibus. Quia voluptatem dolor aut voluptatem. Doloremque id magnam labore voluptas rem officiis magnam. Velit est magnam nulla cupiditate. In rem consequatur quidem et debitis nisi. Iste cupiditate nobis quisquam cumque. Quisquam quaerat quia ipsa enim voluptatem quas. Et ut ut tenetur optio et. Qui rerum maxime qui quibusdam repellendus. Occaecati rerum consequuntur dolores et rerum aut. Ullam distinctio ea dolores ad tenetur. Dolorum reiciendis quia sit eos minus. Harum totam cum sit consequatur. Cumque est sequi architecto aut. Ex provident pariatur molestiae facilis fugit quos. Quia magnam voluptates et earum esse sequi.','2017-05-15','2017-07-26',NULL,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(36,9,4,2,2,'Test Invoice 36','test-invoice-36','Dicta dolores veritatis rerum quo. Voluptas eligendi ut perferendis. Et quo dolores omnis doloremque qui. A rerum maxime aut autem aut. Commodi explicabo ratione sed veniam sunt nulla quis. Repellendus incidunt eum nihil voluptatem voluptatum. Rerum perspiciatis dolorem libero non aspernatur aut iure perspiciatis. Voluptatem veritatis debitis eum vel enim enim officiis. Architecto rerum eos magni sit. Vitae provident quisquam ratione. Ipsam hic explicabo corrupti in. In eveniet dolore qui qui excepturi fugiat. Illo dignissimos ipsum modi nulla nemo ea. Aut corrupti dolores voluptatem voluptatem.','2016-08-20','2017-10-26','CHF 9010100','2017-12-18 11:30:36','2017-12-18 11:30:36'),(37,NULL,11,2,2,'Test Invoice 37','test-invoice-37','Ea eos cupiditate repudiandae sint ipsa sint qui. Amet sit quia error dolorem. Qui consequatur dolorem nam rerum vero porro natus. Aut rerum quia voluptatum consequatur ea asperiores. Dolor harum deserunt nulla quia enim. Dolorem accusantium impedit aliquam perferendis. Consequuntur culpa suscipit omnis et eius et modi quis. Quia dolorem libero ut occaecati a iure. Saepe accusamus et perferendis quo. Ipsa ut voluptatum mollitia quis reiciendis vero explicabo. Suscipit ex aliquam debitis. Laborum expedita consectetur possimus vel non ex non. Neque repellendus ut repellat nihil ab occaecati dolorem.','2016-11-28','2017-11-19',NULL,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(38,NULL,22,3,5,'Test Invoice 38','test-invoice-38','Aliquid consequatur et maiores sint architecto. Dolor consequatur sint repudiandae asperiores. In rerum rerum libero delectus magni provident. Illum porro nesciunt voluptas. Sint est molestias ducimus iusto. Ut labore nihil qui ea et. Et eum aut illo quas sit totam non consequatur. Doloremque tenetur sed velit laboriosam. Nihil iure qui voluptatum odio soluta blanditiis. Illum maiores incidunt aut asperiores. Fugiat necessitatibus nesciunt tempore consequatur et magnam. Explicabo molestiae distinctio totam adipisci consequatur quam ratione. Illum dignissimos et incidunt eius rerum aut. Consequuntur aut magni in quia excepturi facere sit. Cum harum quia enim.','2017-02-15','2017-10-08',NULL,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(39,16,8,5,5,'Test Invoice 39','test-invoice-39','Error quasi et voluptatum aut quis non quaerat. Nulla suscipit architecto dignissimos asperiores rerum dolores ratione. Aut id aut rerum quis cumque. Sapiente et rerum velit omnis officia aut velit. Neque commodi aliquam aperiam et et. Officiis sapiente sed sed error ex aut error. Quo ut atque numquam amet aliquam quis. Porro accusamus odit rerum hic neque velit. Est deleniti ad et officiis. Exercitationem porro molestias illum blanditiis ipsam rerum maiores. Dolores nostrum et voluptas consequatur tempora nostrum voluptas. Enim eum ab qui reprehenderit quia ab dicta. Ab accusantium officia omnis eveniet architecto qui aut omnis.','2017-03-26','2017-06-22','CHF 6675700','2017-12-18 11:30:36','2017-12-18 11:30:36'),(40,11,20,6,5,'Test Invoice 40','test-invoice-40','Consequatur quia odit et veniam. Non laborum sit voluptatum. Neque non dolor repellendus blanditiis eos aperiam neque. Vel qui debitis et enim. Ratione iste omnis ut similique est alias id. Omnis similique minima aut repellat pariatur quia at. Temporibus expedita reiciendis aspernatur qui aut quia. Et non non molestiae est repellendus consequatur nostrum. Facilis occaecati consequatur voluptatem aperiam dicta autem. Pariatur expedita voluptates laborum aut ratione cum. Ipsum alias praesentium ut culpa nesciunt omnis eligendi expedita.','2016-04-09','2017-08-16',NULL,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(41,2,3,3,4,'Test Invoice 41','test-invoice-41','Maiores et molestiae aliquam eveniet sed in voluptas nostrum. Temporibus illum atque qui aperiam dolores sunt. Sit qui odit ut vel. Aut eligendi dolorum qui debitis. Eum voluptatem quia possimus molestiae qui ad. Fuga est unde nostrum quis aut. Dicta velit enim porro nobis iusto et beatae et. Consectetur delectus accusantium totam molestiae. Quaerat vel magni vel consectetur earum voluptas voluptatum. Maxime ab et fuga voluptatibus. Iste iure culpa enim laudantium dolor ab aut. Ipsa ducimus debitis hic similique eum. Dolor corrupti et impedit odit dolorum dicta est. Id qui provident vel velit tempora rerum qui.','2016-03-03','2017-09-02',NULL,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(42,20,12,2,6,'Test Invoice 42','test-invoice-42','Animi quas dolor neque magni. Aut sed officiis qui impedit aliquam repudiandae harum. Nemo doloremque quis quia quam aut et sed. Autem ut consequatur laborum asperiores pariatur consequatur. Et maiores ex debitis sit enim. A consequuntur vel dolore illum ab adipisci. Aut eum nihil totam temporibus. Exercitationem tempore sunt est repudiandae illum. Ut reiciendis quidem distinctio quia esse officia sint officia. Officiis sit deleniti voluptatem recusandae officiis excepturi. Et laudantium tempore ea nihil vitae rerum doloribus. Nobis architecto aut error. Incidunt mollitia sed enim molestias et doloremque. Eos aut numquam eum quia.','2016-09-22','2017-08-08',NULL,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(43,20,20,3,4,'Test Invoice 43','test-invoice-43','Eligendi laborum aut quo vel deserunt et. Quis autem ut incidunt aut harum. Enim et aperiam et. Officiis distinctio reprehenderit quae et. Error veritatis sunt doloribus dolor debitis odio. Deleniti fuga nostrum sit voluptatem vitae non. Corporis voluptatem exercitationem ut non molestias et dolores. Tenetur placeat ut reiciendis recusandae rerum. Atque voluptas voluptatibus unde sed. Facere quisquam inventore ut reprehenderit. Temporibus enim reiciendis et illum ullam. Qui aut ut praesentium dicta dicta voluptates nostrum qui.','2016-08-06','2017-06-27',NULL,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(44,NULL,8,4,1,'Test Invoice 44','test-invoice-44','Est dolorem nihil perferendis sequi. Velit odio est sequi. Placeat rerum placeat laboriosam numquam id voluptas voluptas. Enim et vero quo. Eius omnis illo dolorem odio qui quia error. Commodi iste omnis aut placeat facere. Dolor et vel nesciunt dolor suscipit quibusdam itaque. Quam qui qui eos repellendus molestias quibusdam laudantium. Minima voluptatum placeat eos. Sint tempora enim et ut optio quidem laborum. Est voluptatem repellat ut sit et reprehenderit. Rerum tenetur consequuntur nihil et culpa. Facilis consequatur ex unde provident iure molestiae enim distinctio. Numquam aliquid dolores repellendus maiores. Beatae qui vero inventore.','2016-01-27','2017-07-19',NULL,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(45,17,4,1,2,'Test Invoice 45','test-invoice-45','Praesentium vero quasi aut quod sit quam. Doloremque est adipisci et ut laboriosam. Qui ex et quam. Quae neque sed nobis consequatur quas pariatur magni. In et placeat est vel sint pariatur dolorum qui. Sunt dicta qui consequatur tenetur quaerat illo cupiditate. Ut quia sunt velit ex eos. Consequuntur repudiandae voluptas doloremque animi corporis officiis. Et voluptas voluptatibus omnis mollitia sed enim enim. Quia expedita eaque explicabo quisquam accusantium quos. Voluptatem repudiandae sequi nisi similique est quisquam saepe.','2017-03-14','2017-12-11',NULL,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(46,17,10,6,4,'Test Invoice 46','test-invoice-46','Voluptates et expedita qui nobis. Quo porro perferendis pariatur qui consequuntur. Aliquid aliquid nemo optio quae distinctio. Quisquam rerum laborum laudantium cum corrupti sed est. Doloribus in delectus quia ut id. Inventore numquam quidem sequi laborum. Nam aut voluptatem dolores dolore. Facere est qui illo cumque. Et ducimus ullam asperiores nostrum necessitatibus voluptatem. Fugiat blanditiis est reprehenderit eveniet. Odio maxime laborum nihil officiis voluptatem itaque. Sit et quaerat fugiat earum. Dolorem voluptatem deleniti odio enim aut eius aut. Neque temporibus sint aut asperiores eligendi.','2016-05-18','2017-07-20',NULL,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(47,13,20,4,6,'Test Invoice 47','test-invoice-47','Sed eum et neque aperiam nulla. Illum et debitis quam illo in amet quis deserunt. Nostrum voluptatem minima quo omnis. Delectus sit dolores quis dicta et labore. Et optio harum ipsa quae maiores officia. Quis sint omnis vero officia et. Dicta sint rem cum praesentium ea non qui. Iste tempora inventore quia eligendi enim odio sunt expedita. Tempora distinctio quasi blanditiis eos doloribus sed et nemo. Dolores enim asperiores sunt tempora voluptas voluptas. At ab aut rerum adipisci. Animi quia cupiditate vel possimus qui dolor ut ut. Qui qui hic sunt ut dolores sed. Sed non exercitationem blanditiis ducimus temporibus nihil sunt.','2016-10-27','2017-11-20',NULL,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(48,6,2,6,1,'Test Invoice 48','test-invoice-48','Vitae sint est rerum nostrum velit maiores et facilis. Quaerat eaque magnam accusamus velit. Quasi quisquam sapiente ipsa et ut aliquid in. Quasi aut aut reiciendis porro velit a. Mollitia ab minus ullam voluptatibus eum consequatur molestiae. Consequatur omnis possimus qui enim. Consequatur dolorem illo optio quo. Delectus est assumenda omnis assumenda. Sit distinctio dolores ad ut aspernatur voluptatem aut hic. Commodi aut quo tempore quas omnis. Qui explicabo aut fugit consequatur. Quia repudiandae ipsam hic dolor. Quisquam sed et et vel. Laboriosam similique voluptatem in. Aut possimus minus ut labore odit a quo numquam. Autem nihil mollitia illum aut.','2016-11-14','2017-11-05',NULL,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(49,12,13,6,3,'Test Invoice 49','test-invoice-49','Voluptatum tempore ea libero quis qui. Ipsum dolorum unde alias amet. Aut ut natus sunt quisquam fugiat. Velit a reprehenderit dolorem illo voluptatem ipsam. Dolorum facilis aliquid sed quo dolor natus. Dolor sed id consequatur autem hic. Ut quia consequuntur non nesciunt qui quia. Repellendus in qui molestiae iusto occaecati aut. Ratione quo quae reprehenderit quod. Soluta eum dolorem minima deserunt fuga labore. Labore aut totam aspernatur dolorem. Commodi esse dolorum sed repellendus. Dolores consectetur in et necessitatibus.','2016-09-25','2017-10-23',NULL,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(50,NULL,5,2,5,'Test Invoice 50','test-invoice-50','Atque quae temporibus ex eos aut voluptatem molestiae. Qui atque esse qui. Debitis facilis assumenda velit dolores. Magni corrupti quia possimus rem nulla sit doloribus. Qui enim rerum dolorum velit tempore. Molestiae aut autem aut quae suscipit quo. Ab ut aperiam nesciunt ducimus. Qui doloremque tenetur perferendis non quas modi. Iusto minus doloribus eum molestias. Tempora ut modi nobis velit et. Fugit ut doloribus quas magnam porro qui. Corporis iste molestiae modi quaerat et. Cupiditate est ut aspernatur consequatur sunt reprehenderit omnis neque. Veniam qui tenetur sed repudiandae pariatur ut. Consequatur eum voluptatem facere est maxime non sequi. In culpa qui exercitationem et quia.','2016-09-21','2017-06-23',NULL,'2017-12-18 11:30:36','2017-12-18 11:30:36');
/*!40000 ALTER TABLE `invoices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `offer_discounts`
--

DROP TABLE IF EXISTS `offer_discounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `offer_discounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `offer_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `value` decimal(10,2) DEFAULT NULL,
  `percentage` tinyint(1) DEFAULT NULL,
  `minus` tinyint(1) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_5F927F7C53C674EE` (`offer_id`),
  KEY `IDX_5F927F7CA76ED395` (`user_id`),
  CONSTRAINT `FK_5F927F7C53C674EE` FOREIGN KEY (`offer_id`) REFERENCES `offers` (`id`),
  CONSTRAINT `FK_5F927F7CA76ED395` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `offer_discounts`
--

LOCK TABLES `offer_discounts` WRITE;
/*!40000 ALTER TABLE `offer_discounts` DISABLE KEYS */;
INSERT INTO `offer_discounts` VALUES (1,47,2,'10% Off',0.10,1,1,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(2,50,1,'10% Off',0.10,1,1,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(3,49,3,'10% Off',0.10,1,1,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(4,48,3,'10% Off',0.10,1,1,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(5,50,1,'10% Off',0.10,1,1,'2017-12-18 11:30:36','2017-12-18 11:30:36');
/*!40000 ALTER TABLE `offer_discounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `offer_positions`
--

DROP TABLE IF EXISTS `offer_positions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `offer_positions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `offer_id` int(11) NOT NULL,
  `service_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `order_no` int(11) DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `rate_value` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `rate_unit` longtext COLLATE utf8_unicode_ci,
  `vat` decimal(10,3) DEFAULT NULL,
  `discountable` tinyint(1) NOT NULL,
  `chargeable` tinyint(1) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `rateUnitType_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_755A98B853C674EE` (`offer_id`),
  KEY `IDX_755A98B8ED5CA9E6` (`service_id`),
  KEY `IDX_755A98B82BE78CCE` (`rateUnitType_id`),
  KEY `IDX_755A98B8A76ED395` (`user_id`),
  CONSTRAINT `FK_755A98B82BE78CCE` FOREIGN KEY (`rateUnitType_id`) REFERENCES `rateunittypes` (`id`),
  CONSTRAINT `FK_755A98B853C674EE` FOREIGN KEY (`offer_id`) REFERENCES `offers` (`id`),
  CONSTRAINT `FK_755A98B8A76ED395` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_755A98B8ED5CA9E6` FOREIGN KEY (`service_id`) REFERENCES `services` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `offer_positions`
--

LOCK TABLES `offer_positions` WRITE;
/*!40000 ALTER TABLE `offer_positions` DISABLE KEYS */;
INSERT INTO `offer_positions` VALUES (1,1,19,2,1,20.00,'CHF 18000','CHF/h',0.080,1,1,'2017-12-18 11:30:36','2017-12-18 11:30:36','h'),(2,4,69,5,324,42.00,'CHF 2700','Pauschal',0.025,1,1,'2017-12-18 11:30:36','2017-12-18 11:30:36','a'),(3,9,25,6,648,29.00,'CHF 16900','CHF/d',0.025,1,1,'2017-12-18 11:30:36','2017-12-18 11:30:36','t'),(4,3,81,4,216,38.00,'CHF 14500','Pauschal',0.080,1,1,'2017-12-18 11:30:36','2017-12-18 11:30:36','a'),(5,1,61,4,850,47.00,'CHF 5500','Einheit',0.025,1,1,'2017-12-18 11:30:36','2017-12-18 11:30:36','a'),(6,3,5,4,395,24.00,'CHF 18000','CHF/h',0.080,1,1,'2017-12-18 11:30:36','2017-12-18 11:30:36','h'),(7,5,80,2,982,6.00,'CHF 18300','Pauschal',0.025,1,1,'2017-12-18 11:30:36','2017-12-18 11:30:36','a'),(8,10,53,6,133,87.00,'CHF 18500','Einheit',0.025,0,1,'2017-12-18 11:30:36','2017-12-18 11:30:36','a'),(9,2,32,1,198,26.00,'CHF 3100','CHF/d',0.025,1,1,'2017-12-18 11:30:36','2017-12-18 11:30:36','t'),(10,7,76,3,171,98.00,'CHF 10700','Pauschal',0.080,1,1,'2017-12-18 11:30:36','2017-12-18 11:30:36','a'),(11,8,74,2,598,86.00,'CHF 18300','Pauschal',0.025,0,1,'2017-12-18 11:30:36','2017-12-18 11:30:36','a'),(12,3,62,6,218,65.00,'CHF 18300','Pauschal',0.080,1,1,'2017-12-18 11:30:36','2017-12-18 11:30:36','a'),(13,3,50,2,479,7.00,'CHF 18300','Pauschal',0.080,1,1,'2017-12-18 11:30:36','2017-12-18 11:30:36','a'),(14,5,29,6,26,76.00,'CHF 10800','CHF/d',0.080,0,1,'2017-12-18 11:30:36','2017-12-18 11:30:36','t'),(15,8,27,6,257,78.00,'CHF 10800','CHF/d',0.080,1,0,'2017-12-18 11:30:36','2017-12-18 11:30:36','t'),(16,10,63,2,95,25.00,'CHF 14500','Pauschal',0.025,1,0,'2017-12-18 11:30:36','2017-12-18 11:30:36','a'),(17,1,41,6,228,73.00,'CHF 7600','CHF/d',0.080,0,1,'2017-12-18 11:30:36','2017-12-18 11:30:36','t'),(18,9,76,5,811,50.00,'CHF 10700','Pauschal',0.080,1,1,'2017-12-18 11:30:36','2017-12-18 11:30:36','a'),(19,10,18,6,29,44.00,'CHF 8100','CHF/h',0.080,1,1,'2017-12-18 11:30:36','2017-12-18 11:30:36','h'),(20,5,1,2,295,81.00,'CHF 10000','CHF/h',0.080,1,1,'2017-12-18 11:30:36','2017-12-18 11:30:36','h'),(21,10,51,2,679,78.00,'CHF 18500','Einheit',0.025,1,1,'2017-12-18 11:30:36','2017-12-18 11:30:36','a'),(22,4,3,3,352,11.00,'CHF 18000','CHF/h',0.080,1,1,'2017-12-18 11:30:36','2017-12-18 11:30:36','h'),(23,3,73,3,601,57.00,'CHF 18300','Pauschal',0.025,0,1,'2017-12-18 11:30:36','2017-12-18 11:30:36','a'),(24,10,8,4,999,58.00,'CHF 2800','CHF/h',0.080,1,1,'2017-12-18 11:30:36','2017-12-18 11:30:36','h'),(25,4,74,4,831,71.00,'CHF 18300','Pauschal',0.025,1,1,'2017-12-18 11:30:36','2017-12-18 11:30:36','a'),(26,5,39,6,864,69.00,'CHF 7600','CHF/d',0.025,1,1,'2017-12-18 11:30:36','2017-12-18 11:30:36','t'),(27,7,39,3,868,19.00,'CHF 7600','CHF/d',0.025,0,1,'2017-12-18 11:30:36','2017-12-18 11:30:36','t'),(28,4,73,1,800,42.00,'CHF 18300','Pauschal',0.025,1,1,'2017-12-18 11:30:36','2017-12-18 11:30:36','a'),(29,10,66,5,365,6.00,'CHF 14500','Pauschal',0.080,1,1,'2017-12-18 11:30:36','2017-12-18 11:30:36','a'),(30,5,66,5,775,36.00,'CHF 14500','Pauschal',0.080,1,1,'2017-12-18 11:30:36','2017-12-18 11:30:36','a'),(31,1,27,4,371,85.00,'CHF 10800','CHF/d',0.080,1,1,'2017-12-18 11:30:36','2017-12-18 11:30:36','t'),(32,1,33,4,411,34.00,'CHF 1500','CHF/d',0.025,1,1,'2017-12-18 11:30:36','2017-12-18 11:30:36','t'),(33,9,21,2,336,83.00,'CHF 2800','CHF/h',0.025,1,0,'2017-12-18 11:30:36','2017-12-18 11:30:36','h'),(34,7,78,3,40,80.00,'CHF 14500','Pauschal',0.025,0,1,'2017-12-18 11:30:36','2017-12-18 11:30:36','a'),(35,7,13,5,847,69.00,'CHF 8100','CHF/h',0.025,0,1,'2017-12-18 11:30:36','2017-12-18 11:30:36','h'),(36,9,14,4,612,79.00,'CHF 2800','CHF/h',0.080,0,1,'2017-12-18 11:30:36','2017-12-18 11:30:36','h'),(37,9,42,4,73,7.00,'CHF 18500','Einheit',0.025,0,1,'2017-12-18 11:30:36','2017-12-18 11:30:36','a'),(38,9,50,4,866,50.00,'CHF 18300','Pauschal',0.080,1,1,'2017-12-18 11:30:36','2017-12-18 11:30:36','a'),(39,3,10,2,668,30.00,'CHF 10300','CHF/h',0.080,1,1,'2017-12-18 11:30:36','2017-12-18 11:30:36','h'),(40,2,75,5,640,63.00,'CHF 6700','Pauschal',0.080,1,1,'2017-12-18 11:30:36','2017-12-18 11:30:36','a'),(41,7,73,4,941,16.00,'CHF 18300','Pauschal',0.025,1,1,'2017-12-18 11:30:36','2017-12-18 11:30:36','a'),(42,10,48,2,146,27.00,'CHF 18300','Pauschal',0.080,1,1,'2017-12-18 11:30:36','2017-12-18 11:30:36','a'),(43,5,26,6,116,16.00,'CHF 16900','CHF/d',0.025,1,1,'2017-12-18 11:30:36','2017-12-18 11:30:36','t'),(44,6,27,2,576,99.00,'CHF 10800','CHF/d',0.080,0,1,'2017-12-18 11:30:36','2017-12-18 11:30:36','t'),(45,1,70,5,37,98.00,'CHF 18300','Pauschal',0.025,0,1,'2017-12-18 11:30:36','2017-12-18 11:30:36','a'),(46,4,73,6,362,17.00,'CHF 18300','Pauschal',0.025,1,1,'2017-12-18 11:30:36','2017-12-18 11:30:36','a'),(47,10,22,2,382,90.00,'CHF 3100','CHF/d',0.080,1,1,'2017-12-18 11:30:36','2017-12-18 11:30:36','t'),(48,5,16,3,489,57.00,'CHF 8100','CHF/h',0.080,1,1,'2017-12-18 11:30:36','2017-12-18 11:30:36','h'),(49,9,58,1,58,88.00,'CHF 18300','Pauschal',0.080,1,0,'2017-12-18 11:30:36','2017-12-18 11:30:36','a'),(50,1,15,2,112,9.00,'CHF 8100','CHF/h',0.025,1,1,'2017-12-18 11:30:36','2017-12-18 11:30:36','h');
/*!40000 ALTER TABLE `offer_positions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `offer_standard_discounts`
--

DROP TABLE IF EXISTS `offer_standard_discounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `offer_standard_discounts` (
  `offer_id` int(11) NOT NULL,
  `standard_discount_id` int(11) NOT NULL,
  PRIMARY KEY (`offer_id`,`standard_discount_id`),
  KEY `IDX_84D719D953C674EE` (`offer_id`),
  KEY `IDX_84D719D97EAA7D27` (`standard_discount_id`),
  CONSTRAINT `FK_84D719D953C674EE` FOREIGN KEY (`offer_id`) REFERENCES `offers` (`id`),
  CONSTRAINT `FK_84D719D97EAA7D27` FOREIGN KEY (`standard_discount_id`) REFERENCES `standard_discounts` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `offer_standard_discounts`
--

LOCK TABLES `offer_standard_discounts` WRITE;
/*!40000 ALTER TABLE `offer_standard_discounts` DISABLE KEYS */;
/*!40000 ALTER TABLE `offer_standard_discounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `offer_status_uc`
--

DROP TABLE IF EXISTS `offer_status_uc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `offer_status_uc` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `text` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `active` tinyint(1) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_B021B587A76ED395` (`user_id`),
  CONSTRAINT `FK_B021B587A76ED395` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `offer_status_uc`
--

LOCK TABLES `offer_status_uc` WRITE;
/*!40000 ALTER TABLE `offer_status_uc` DISABLE KEYS */;
INSERT INTO `offer_status_uc` VALUES (1,NULL,'Potential',1,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(2,NULL,'Offered',1,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(3,NULL,'Ordered',1,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(4,NULL,'Lost',1,'2017-12-18 11:30:36','2017-12-18 11:30:36');
/*!40000 ALTER TABLE `offer_status_uc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `offer_tags`
--

DROP TABLE IF EXISTS `offer_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `offer_tags` (
  `offer_id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL,
  PRIMARY KEY (`offer_id`,`tag_id`),
  KEY `IDX_9144BA3153C674EE` (`offer_id`),
  KEY `IDX_9144BA31BAD26311` (`tag_id`),
  CONSTRAINT `FK_9144BA3153C674EE` FOREIGN KEY (`offer_id`) REFERENCES `offers` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_9144BA31BAD26311` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `offer_tags`
--

LOCK TABLES `offer_tags` WRITE;
/*!40000 ALTER TABLE `offer_tags` DISABLE KEYS */;
/*!40000 ALTER TABLE `offer_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `offers`
--

DROP TABLE IF EXISTS `offers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `offers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(11) DEFAULT NULL,
  `status_id` int(11) DEFAULT NULL,
  `rate_group_id` int(11) DEFAULT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `accountant_id` int(11) DEFAULT NULL,
  `address_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `valid_to` date DEFAULT NULL,
  `short_description` longtext COLLATE utf8_unicode_ci,
  `description` longtext COLLATE utf8_unicode_ci,
  `fixed_price` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_DA460427166D1F9C` (`project_id`),
  KEY `IDX_DA4604276BF700BD` (`status_id`),
  KEY `IDX_DA4604272983C9E6` (`rate_group_id`),
  KEY `IDX_DA4604279395C3F3` (`customer_id`),
  KEY `IDX_DA4604279582AA74` (`accountant_id`),
  KEY `IDX_DA460427F5B7AF75` (`address_id`),
  KEY `IDX_DA460427A76ED395` (`user_id`),
  CONSTRAINT `FK_DA460427166D1F9C` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_DA4604272983C9E6` FOREIGN KEY (`rate_group_id`) REFERENCES `rate_groups` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_DA4604276BF700BD` FOREIGN KEY (`status_id`) REFERENCES `offer_status_uc` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_DA4604279395C3F3` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_DA4604279582AA74` FOREIGN KEY (`accountant_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_DA460427A76ED395` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_DA460427F5B7AF75` FOREIGN KEY (`address_id`) REFERENCES `address` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `offers`
--

LOCK TABLES `offers` WRITE;
/*!40000 ALTER TABLE `offers` DISABLE KEYS */;
INSERT INTO `offers` VALUES (1,NULL,1,1,25,1,2,5,'Default Offer','2017-10-18','This is a default offer','This is a longer description with more details',NULL,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(2,9,4,2,17,5,17,6,'Possimus cum.','2017-07-03','Est officia voluptatibus corrupti commodi deserunt minima reprehenderit laborum. Molestiae aut numquam a harum. Est quod expedita laudantium qui ipsa.','Et harum ut explicabo odit similique nihil numquam. Sit suscipit libero nisi sunt sit quas quo totam. Doloremque numquam itaque magnam. Quidem dolorum neque repudiandae totam non. Voluptatibus nihil occaecati ut et soluta. Dignissimos omnis eveniet et nihil. Dolores consectetur quo illo molestiae quis et. Perspiciatis aspernatur nemo officia debitis. Earum praesentium dolorem consequatur rerum. Ea sunt cumque qui. Eos blanditiis ipsam ut excepturi. Ullam iste repellat qui ipsum sit illum. Distinctio et doloremque quia commodi modi quia. Autem quae perferendis enim id. Consequuntur provident beatae culpa consequatur aut ducimus dignissimos. Consequatur accusantium excepturi magni qui at et.',NULL,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(3,NULL,1,2,21,3,9,6,'Magni perferendis.','2017-11-28','Necessitatibus aut totam sit consectetur omnis. Nobis qui recusandae tempore molestias expedita fugit delectus. Delectus laudantium sed iure quia illo neque omnis. Numquam nostrum officiis dolor.','Aliquam et at quod consequatur. Commodi qui voluptate quia rerum ut enim rem. Voluptas harum totam saepe. Consequatur et at magni nihil aut. Totam cupiditate odio asperiores perspiciatis. Et natus optio qui ipsam similique quaerat commodi. Et placeat autem ratione. Et ut beatae rerum assumenda et. Sed ipsa nam minus qui recusandae nam. Non vitae eaque eos temporibus optio. Et eaque esse officia fugit et voluptatibus. Quaerat aut id commodi nihil. Ratione ea aperiam quae nam id repellat. Nihil ipsum quis sed autem et velit dolores. Optio quos quia molestiae dignissimos enim maxime tempore.',NULL,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(4,10,4,1,13,1,1,5,'In vel neque.','2017-12-06','Quo aut aut et molestias culpa et. Est ut qui fugit sed saepe maxime. Ut cupiditate nemo rem. Voluptas dignissimos molestiae neque culpa.','Assumenda soluta aut magni accusantium voluptatem adipisci. Labore libero repudiandae non. Autem unde est eaque et. Incidunt exercitationem et reiciendis vel facilis sed facere. Est laboriosam beatae et. Quis illum molestiae rerum omnis exercitationem velit repellat. Cum vitae sunt vel ut molestiae. Nobis non veniam possimus itaque et vel qui. Corrupti et deserunt sunt. Architecto id officiis odio perferendis. Qui dolore natus quidem enim. Laboriosam vitae nihil aperiam saepe nihil. Labore rem voluptas quasi aut a ea libero veritatis. Ad incidunt voluptatem facere.',NULL,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(5,1,1,2,12,4,15,2,'Sed sed.','2017-10-10','Qui soluta repellendus natus omnis assumenda eaque vel. Nisi fuga ipsum praesentium cumque officia id quidem commodi. Aut fuga praesentium et. Magnam soluta laudantium neque id sunt omnis.','Aliquid quasi sit ipsa sequi id ea quae sed. Occaecati error alias labore sit. Qui omnis doloribus pariatur sint est dignissimos. Autem nesciunt et numquam aspernatur alias odio. Est voluptatum asperiores optio adipisci corporis qui. Corporis placeat adipisci quibusdam reprehenderit. Voluptas sed ut et aut minima quos est. Facere numquam eius numquam nemo. Dolores est dolores neque facere fugit sint consequatur et. Quos id quo laudantium dolorem voluptatibus iure. Provident neque est inventore minima laboriosam quia possimus.',NULL,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(6,20,4,2,6,1,24,5,'Debitis ut.','2017-09-20','Nihil beatae est et dolores et. Sunt accusamus et occaecati similique. Iusto dignissimos sit aut repellendus. Voluptas sapiente autem non ut fuga voluptatibus atque.','Molestiae iste dolorum velit ipsam. Quia reprehenderit earum nulla consequatur occaecati. Dolores et est quia ex sit. Explicabo libero placeat ex aperiam. Dolorum facilis enim omnis consectetur nihil ipsum velit. Tenetur totam ad ut. Corporis veniam minima a numquam. Repellat ea atque veniam pariatur quos nulla ipsa dolorem. Eum necessitatibus et aut explicabo voluptatem quam. Voluptas inventore et perspiciatis optio neque dolor. Rem aut blanditiis rerum placeat enim. Facere dolor optio voluptates qui nam et repellendus. Qui aut voluptas sunt voluptatum qui neque. Qui cum maiores voluptate aperiam. Aut at natus voluptas est aut placeat. Optio itaque qui vel qui quasi autem.',NULL,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(7,NULL,3,2,24,3,4,2,'Rem enim eos.','2017-09-22','Est id dolor aliquid officia perspiciatis autem. Et et nihil officia sit sed et pariatur et. Beatae ut hic est quo et. Minus aut harum reprehenderit qui.','Ab iste non quia fuga ducimus tempore. Enim placeat et aut laborum. Id mollitia sit accusamus architecto eius. Molestiae incidunt a aut tempore. Quam libero ducimus accusamus id molestias labore provident error. Modi et vel assumenda quos. Ipsam est magni similique qui repellendus asperiores dolores. Porro tempora iste id. Voluptatem rerum optio sint voluptatem libero dolore. At modi assumenda et tempore ex. Vel quasi facilis eveniet repellat facere cupiditate sed rem. Ullam temporibus quia et in dolorem quidem. Enim aspernatur sed est voluptatem officia. Velit laboriosam ut eum nulla ea ut error. Eos blanditiis animi provident omnis et quidem.',NULL,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(8,6,3,2,16,5,16,2,'Eaque hic velit.','2017-06-15','Non architecto blanditiis temporibus quibusdam libero eveniet architecto. Iusto vero praesentium quam vitae aut. Est nam quae debitis ut quia eum. In dignissimos quia nam aut explicabo.','Sit sit incidunt aliquid libero. Temporibus ut ad sint pariatur eos. Sint sunt et aspernatur sapiente necessitatibus blanditiis tempora laborum. Eaque aliquam ea adipisci animi aut possimus. Provident qui magnam atque eaque laudantium reiciendis. Doloremque ratione quisquam ducimus velit eligendi delectus possimus. Molestias sit exercitationem consequuntur. Quia molestiae ad est facere aut. Voluptatem esse et soluta ab voluptatem odio. Vel a vel totam minus rerum. Consequatur autem quia adipisci rem dolores et. In fugit doloribus numquam amet dolor temporibus. Ducimus ipsam quo cum corrupti rerum consequatur ea. Et voluptatibus aut voluptatem et. Neque quos ut qui saepe in.','CHF 8490600','2017-12-18 11:30:36','2017-12-18 11:30:36'),(9,3,1,2,23,2,6,3,'Esse dolorum.','2017-11-21','Iure et commodi quidem dicta. Similique voluptatem ratione et rerum temporibus voluptas. Vel non ea voluptatem doloribus quisquam et. Et recusandae exercitationem velit est ipsa sit tempore.','Ratione illum omnis quia. Laborum sed officia temporibus id molestias non perferendis. Ad facilis error consequatur dolore deserunt dignissimos aliquam modi. Omnis eos molestias autem non sunt nam aut. Reiciendis nihil eos voluptate dolorem qui cupiditate. Voluptatem consequuntur corporis ea quia. Rerum iusto quia sapiente. Molestiae optio doloribus magni est quidem dolores et magni. Temporibus qui repellat officia ratione voluptatem similique. Ipsam itaque rerum aut quibusdam consectetur. Eius sint deserunt adipisci.',NULL,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(10,17,2,2,20,3,10,3,'Rerum in eaque.','2017-07-01','Nulla et possimus deserunt omnis maxime et. Architecto aut quia eius deserunt eius voluptas est. Vero ab omnis sunt recusandae dolorem non.','Sunt pariatur nulla et dolor at soluta. Autem sed et sunt praesentium. Sint voluptatibus ipsa ipsum omnis consequatur. Cupiditate quisquam corporis laboriosam repudiandae itaque. Alias sint et dolorem doloribus occaecati commodi quisquam. Provident ex recusandae aliquid beatae nihil. Eum praesentium tenetur expedita nam sint pariatur in. Voluptas sit ea delectus. Aspernatur dolor ut veniam est repudiandae. Modi quo maxime voluptates suscipit illum velit laborum. Voluptatem fugit qui molestiae reprehenderit sint. Qui corrupti odit doloribus quia occaecati doloribus. Expedita incidunt velit porro beatae sit et autem. Sunt sit voluptatem et deleniti totam quae et.','CHF 1660600','2017-12-18 11:30:36','2017-12-18 11:30:36'),(11,7,1,1,13,5,13,5,'Occaecati enim aperiam.','2017-10-30','Quia a et dolores molestias. Nulla aperiam officia eaque error cumque ullam. Ab qui minus ut sint.','Et id amet distinctio molestiae non. Sequi excepturi et deleniti asperiores quia. Accusamus praesentium ratione nihil. Sunt modi exercitationem voluptas est. Accusamus quae sit dolore impedit et voluptas. Et necessitatibus iure assumenda nemo vel. Sequi aut aliquam non iste. Impedit aut aliquam nisi quia. Pariatur inventore impedit tempora non eos mollitia fugit. Provident non et necessitatibus sit repudiandae dolorum magnam. Eaque et asperiores animi voluptatem in ut. Culpa et quae vero quas. Quae vitae harum quod rerum. Dolor perferendis numquam sit iste hic eos laborum. Sit accusantium et quas nihil quam id autem.',NULL,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(12,NULL,2,1,9,4,21,6,'Odit esse.','2017-06-23','Quas illum quia qui occaecati consequuntur. Quo quam architecto et. Officia nam exercitationem aut quaerat. Labore quam ea quaerat ratione aspernatur.','Et dolores eos voluptas consequatur commodi odit qui. A aut et veritatis esse dolorem cumque. Vel minus accusamus laudantium possimus laboriosam optio et. Accusantium dolorem dolores beatae est eos modi. Et sit numquam voluptatibus cupiditate aut ipsa occaecati. Voluptatum expedita nesciunt facilis repellendus iste est. Ab accusamus nam dolorem est. Est omnis accusamus optio enim in. Asperiores ad officia quo quis voluptatem cum dicta. Totam nam dicta vel quasi molestiae consequatur. Autem sint cumque quia velit quo impedit est. Praesentium sit quis dolorem. Voluptatum ut rerum excepturi a repellendus ex et praesentium.',NULL,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(13,NULL,1,1,7,6,2,1,'Ut quos et.','2017-09-05','Aperiam rem tenetur consequuntur sit tempora. Officiis ipsa quod nihil aperiam provident quae quia. Reprehenderit eum consequatur cum quod dolor dolores.','Eligendi rerum ad eligendi omnis alias qui nisi sint. Dolorem neque officiis impedit eveniet. Optio sapiente earum quia eius quo similique. Illo unde soluta molestiae tempore et laboriosam. Qui et et tenetur qui nihil. Voluptatum accusamus rem aut quia. Commodi amet vel aliquam et sunt ut qui quae. Perferendis animi quis dolores tenetur totam sunt ut. Vel molestiae nostrum quod qui harum et vero. Illo nulla eius eum dolorum quaerat omnis. Enim sit repellat aut. Quae voluptatem est beatae ipsum hic sint. Dolor id tempora quas modi fugit eius illo. Aliquid repellendus fuga aspernatur cupiditate itaque deserunt est. Repellat rerum quo laboriosam qui quae voluptas earum.',NULL,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(14,13,1,1,8,3,19,1,'Error nobis.','2017-10-06','Sunt voluptatum sed excepturi accusamus. Doloremque omnis quas odit deserunt. Odit eligendi repellat praesentium. Est et aut temporibus consequuntur.','Molestiae nulla non earum sed. Consequatur possimus tenetur consequuntur laborum. Natus est impedit omnis sint explicabo exercitationem porro. Recusandae quisquam ipsa veritatis nam sequi accusantium. Modi consectetur est accusantium assumenda. Nihil provident ratione quia dolores quisquam rerum et. Labore et officiis at minus veniam magnam. Mollitia a aut vel consequatur ducimus. Excepturi eos ut harum et aliquid quas odio. Fugiat odio aut consequuntur vero praesentium incidunt ipsam. Mollitia voluptas architecto ipsa iure deserunt libero facilis. Voluptatibus consequatur rerum vitae consectetur vero enim inventore sed.',NULL,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(15,19,4,2,25,2,6,5,'Excepturi numquam tempora.','2017-07-07','Eum eum eum quis eaque. Dolorum reiciendis dolore quo molestiae libero fugit. Sed fuga ab quo temporibus. Ad non nisi fuga quia deleniti unde minima eaque.','Esse qui et qui laboriosam a laboriosam. Enim sunt quaerat eligendi. Similique aut quia vel repudiandae doloribus deserunt cumque. Dignissimos maxime et placeat molestias. Sint quo nesciunt exercitationem vel et ea. Ad ipsa quis non omnis enim. Cupiditate voluptatem facilis quo minus dolor. Soluta mollitia corrupti magnam odit adipisci. Consequatur perferendis voluptas corporis recusandae repudiandae. Earum animi aut quisquam. Nam excepturi odit eius voluptatum officia reprehenderit eligendi. Temporibus tempora et facilis dignissimos. Odit modi possimus eveniet ipsam culpa. Aliquid ipsam commodi blanditiis. Esse soluta dolore magni.',NULL,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(16,20,1,1,10,1,10,6,'Consectetur laboriosam.','2017-07-13','Temporibus labore quae earum nihil recusandae facere. Similique id magnam eveniet enim delectus animi quo. Dignissimos voluptatem accusantium illum perferendis suscipit. Aut suscipit dolore ut eos voluptatem reiciendis soluta.','Rerum maxime consequuntur iusto. Consectetur harum nemo laborum cupiditate. Sit soluta facilis ut numquam vel tempore et eius. Sunt sequi sed ad quibusdam sequi. Ea pariatur incidunt aspernatur impedit nisi. Nisi officia perspiciatis reiciendis aperiam est nobis ipsa. Magnam nobis veritatis accusantium est pariatur. Laboriosam voluptatibus sit ad beatae eligendi debitis quam. Minus sit ea ipsa non neque atque saepe. Laboriosam autem dolores repellendus iste tenetur quia facere. Rem aut quia voluptatem velit. Hic mollitia ipsa recusandae odio rerum. Voluptatem debitis excepturi qui a voluptas. Corrupti totam non aliquid fuga velit sed id et.',NULL,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(17,8,1,2,9,2,6,6,'Fugit fuga numquam.','2017-09-06','Labore est nisi illum impedit. Est veniam dicta qui. Est et a corrupti quia aut ut cumque. Error natus impedit commodi sed cupiditate porro.','Aspernatur suscipit optio quia culpa ab. Cupiditate provident autem omnis reiciendis. Et aut fugiat laborum maiores fuga dignissimos corporis ex. Nemo fugit sit nobis iure quae dolores quos voluptas. Et quis sed nobis et ullam quae sit. Molestiae nihil molestiae eos sint rem. Qui quae minima qui. Quae quo excepturi at quasi. Et odio voluptatibus est qui. Odit est et fuga corporis suscipit dolores. Eos tempore est ullam voluptas et fugiat. Architecto aut assumenda dolorum alias sit deserunt earum porro. Ducimus molestias fuga et. Sunt aut ad molestiae officia. Nihil aliquam minima et porro omnis temporibus odio quam. Omnis quia deleniti ullam eum iure. Nemo sunt odit quia.',NULL,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(18,18,2,2,25,4,14,5,'Et dolores.','2017-06-22','Repellendus aliquam voluptatem ut amet. Rerum beatae sit hic sit at ex temporibus. Eveniet voluptas aut eligendi et. Quae maxime hic qui harum est eius tenetur et. Ut nihil dolorem maiores laboriosam expedita est.','Dolorum incidunt minus maiores molestiae nulla maiores. Et dignissimos minus nulla ut excepturi a fugit. Est maiores tempora quos laboriosam. Quam suscipit ducimus iste a repellendus. Est repellendus molestias cupiditate blanditiis. Incidunt magnam architecto sit eum tempora dolorum fugit. Laboriosam accusantium deleniti et deserunt debitis sunt. Ea molestiae quia optio sed placeat. Voluptatum qui aliquam voluptatem molestiae. Earum ullam quo ab dolor alias tempora quia. Ut ut quod sed quis est. Ad et placeat eaque itaque eaque occaecati. In est recusandae quaerat facilis ut aut. Optio expedita ipsa incidunt debitis iure quia. Voluptas voluptatem quia porro omnis.','CHF 8036300','2017-12-18 11:30:36','2017-12-18 11:30:36'),(19,NULL,1,2,13,5,17,1,'Eum omnis esse.','2017-08-28','Delectus quae qui deleniti doloribus modi quia. Molestiae accusamus et praesentium quia quo in aut. Ipsum magnam consectetur non modi. Id neque facere quo illum quae sapiente ut est.','Quis placeat saepe ex et. Maiores nihil saepe voluptatem. Eveniet repudiandae assumenda voluptate suscipit. Enim nostrum vero nemo et ut quisquam nemo. Vel optio voluptatem et eligendi vitae. Minima a debitis saepe sit earum. Consequatur ipsa et accusamus ea consequatur sint voluptatum. Aliquam et et non quam sint quae. Eligendi quam cum accusamus eveniet quae. Eaque voluptatibus corrupti molestiae dolorem error facilis et. Voluptas dicta facere vero molestias cum. Repudiandae temporibus quia perspiciatis commodi eligendi alias. Repellendus sint veniam explicabo sequi maiores qui.',NULL,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(20,4,3,2,14,1,21,5,'Reprehenderit dolorum.','2017-06-20','Ullam fuga autem harum quos et sit. Maiores eveniet voluptas tempora et dolor. Dolore dolorum atque atque enim. Similique molestiae quibusdam consequatur.','Nostrum sunt quasi qui. Nihil nostrum cupiditate provident aperiam. Recusandae dolore et ab omnis vitae quod et. Assumenda expedita quia rem et rerum qui facere. Dolores quisquam nam unde expedita quos doloribus numquam. Qui saepe incidunt quaerat magnam excepturi. Est pariatur consequatur eveniet debitis consectetur. Delectus dolores eius quibusdam laudantium blanditiis enim explicabo consectetur. Reprehenderit facilis qui eum. Neque nulla enim praesentium rerum deleniti. Error animi quaerat similique omnis tenetur sapiente voluptatem. Nemo voluptate perspiciatis quaerat iure. Quia modi hic saepe. Sit accusamus animi et ipsam adipisci ut aut.','CHF 2368500','2017-12-18 11:30:36','2017-12-18 11:30:36'),(21,1,1,2,23,4,15,3,'Eligendi veniam sint.','2017-08-08','Quia cupiditate amet fuga. Et totam non voluptas quae veritatis. Et repellat tenetur eum magni quis.','Cum sed laborum rerum error hic. Debitis excepturi odit fugit fuga eos aliquam voluptate. Adipisci modi veritatis iste tempora. Explicabo debitis officiis ullam. Maxime consequatur nemo fugiat alias assumenda necessitatibus ex. Id est ex labore aut. Alias iusto sed quae ea porro et. Molestias inventore autem quam rerum quod. Iusto molestiae optio incidunt ut quisquam dolores doloremque. Dolorum et commodi magnam dolorem et doloribus ipsum. Hic ut cum nostrum corrupti qui dignissimos. Fugiat pariatur et nihil earum.',NULL,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(22,5,4,1,9,3,3,2,'Incidunt nesciunt.','2017-11-07','Qui iure veniam vero ea aut rem. Itaque voluptas nam praesentium ratione deleniti et aut. Maxime sed aliquam velit rerum in. Et fugiat dolorem molestiae sit.','Praesentium impedit esse consequatur aperiam sapiente molestias repudiandae. Cupiditate reprehenderit ea aut. Dolorum eveniet sunt unde ex sit. Saepe ullam corrupti molestiae natus assumenda impedit aspernatur. Nam est in ipsa earum eius quo. Labore molestias harum praesentium est non. Sit libero velit molestiae rerum laboriosam qui a quas. Praesentium commodi iste voluptatem nobis quibusdam. Dolorum temporibus exercitationem totam praesentium fugiat quod. Repellendus quam sequi fugit blanditiis doloribus eum. Porro ea recusandae autem laborum voluptatem. Est voluptate et nesciunt est. Qui et quidem perspiciatis placeat. Id laborum facilis dicta incidunt et.',NULL,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(23,1,1,2,23,3,2,2,'Amet a.','2017-10-18','Non id animi eius error nobis delectus. Aut nihil aut voluptatibus sed ut. Nulla sed quas amet beatae modi. Qui qui accusantium provident.','Adipisci qui at quis numquam et mollitia. Quisquam reprehenderit ex quasi doloribus. Nemo sit est suscipit. Saepe hic voluptates vitae autem vero officia. Repudiandae at sed soluta est ex magnam. Quia adipisci corporis qui doloribus esse facilis. Reprehenderit molestiae vero quos excepturi occaecati in. Vel sit est consectetur cumque qui a. Quia labore magni est. Culpa nobis eius perspiciatis quis voluptas. Et quam temporibus nostrum commodi dolorem. Culpa eos est ullam voluptatem molestiae. Nobis non veniam quis. Enim similique dolor qui rerum sit velit nesciunt iure.',NULL,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(24,20,1,2,10,5,17,4,'Rem quia.','2017-08-28','Atque repellat sapiente autem. Voluptatem aut id porro nisi vero voluptatem nihil. Voluptatum asperiores fuga earum. Quo libero enim dolore rerum.','Vero iste vitae id molestias. Necessitatibus possimus earum autem inventore voluptatem. Voluptas est doloribus laborum dolores eos. Quia voluptatem dolor aut voluptatem. Neque doloremque id magnam labore. Officiis magnam laudantium velit. Magnam nulla cupiditate qui in. Consequatur quidem et debitis nisi voluptas maiores iste. Quisquam cumque et quisquam quaerat. Ipsa enim voluptatem quas nemo. Ut tenetur optio et ea repellat qui rerum. Qui quibusdam repellendus quas occaecati. Consequuntur dolores et rerum aut. Distinctio ea dolores ad tenetur. Nulla dolorum reiciendis quia sit eos minus veniam harum. Cum sit consequatur quo cumque est.',NULL,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(25,NULL,3,2,19,6,8,6,'Non consequatur.','2017-06-19','Corporis nesciunt doloremque qui et nesciunt. Laborum aspernatur repudiandae aut qui et. Distinctio modi ut itaque in dicta dolores veritatis rerum. Et voluptas eligendi ut perferendis et. Quo dolores omnis doloremque qui et a.','Aut iure perspiciatis quas ut voluptatem veritatis debitis. Vel enim enim officiis quia. Rerum eos magni sit ipsa vitae. Quisquam ratione nisi ipsam hic explicabo corrupti in. Recusandae in eveniet dolore qui. Fugiat sequi illo dignissimos ipsum modi nulla. Ea repudiandae aut corrupti dolores voluptatem voluptatem. Qui inventore sit vitae perferendis quia sit et. Non hic quibusdam omnis et. Explicabo suscipit fuga et porro dignissimos repellat. Ipsa id blanditiis et in delectus. Provident aut autem explicabo. Atque velit et eligendi explicabo ea eos. Sint ipsa sint qui ut amet sit. Error dolorem veritatis et qui consequatur dolorem nam rerum.',NULL,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(26,NULL,3,1,6,5,17,6,'Suscipit omnis.','2017-09-10','Libero ut occaecati a iure maiores saepe accusamus et. Quo sit corporis ipsa ut voluptatum mollitia quis reiciendis. Explicabo sunt suscipit ex aliquam. Molestiae laborum expedita consectetur possimus.','Quos non dolore neque voluptate rerum sunt. Error unde exercitationem eum quibusdam voluptas voluptas similique. Inventore nihil corporis eos voluptas. Dolores aliquid consequatur et maiores sint. Dolor consequatur sint repudiandae asperiores. In rerum rerum libero delectus magni provident. Omnis illum porro nesciunt voluptas vel sint est. Ducimus iusto tempora ut labore nihil qui ea et. Eum aut illo quas sit totam. Consequatur soluta qui doloremque tenetur. Velit laboriosam aut nihil iure qui voluptatum. Soluta blanditiis nihil illum maiores incidunt aut asperiores. Fugiat necessitatibus nesciunt tempore consequatur et magnam.',NULL,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(27,8,4,2,11,2,9,1,'Corporis aliquam natus.','2017-10-30','Nulla consequuntur vel doloremque sint inventore praesentium et. Tenetur in vero nam voluptatem. Aliquid natus error quasi et voluptatum. Quis non quaerat sit nulla. Architecto dignissimos asperiores rerum dolores ratione est aut.','Neque officiis sapiente sed sed error ex. Error voluptate quo ut atque. Aliquam quis eius alias porro accusamus. Rerum hic neque velit itaque est. Ad et officiis labore in exercitationem porro. Blanditiis ipsam rerum maiores ut dolores nostrum et. Consequatur tempora nostrum voluptas tenetur enim eum ab. Reprehenderit quia ab dicta nihil ab. Omnis eveniet architecto qui aut omnis fugit veniam. Eius rem saepe et nam quo culpa. Dolores aut repudiandae modi debitis repudiandae mollitia. Accusamus omnis tempora aliquid molestiae iusto amet consequuntur. Non quibusdam voluptatem soluta rerum odit quia et. Quia odit et veniam est non laborum.',NULL,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(28,4,4,2,9,6,12,6,'Est alias.','2017-10-10','Pariatur quia at veniam temporibus. Reiciendis aspernatur qui aut. Eum et non non molestiae est.','Asperiores enim aliquam nihil omnis possimus ipsam. Pariatur ut reiciendis esse. Laborum enim natus enim nam a dolorum necessitatibus. Eaque rem odit ipsam sit earum nam. Ut minus corporis cumque voluptas aperiam autem in. Distinctio ducimus explicabo maiores et molestiae aliquam. Sed in voluptas nostrum sit. Atque qui aperiam dolores sunt porro. Qui odit ut vel ratione reiciendis aut eligendi dolorum. Debitis facilis eum voluptatem quia possimus molestiae. Ullam fuga est unde nostrum quis aut tempora. Dicta velit enim porro nobis iusto et beatae et. Consectetur delectus accusantium totam molestiae. Quaerat vel magni vel consectetur earum voluptas voluptatum.',NULL,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(29,14,2,2,20,2,18,5,'Est omnis.','2017-11-10','Modi aut porro itaque nemo ut sint occaecati. Quo suscipit tenetur qui voluptas et debitis porro. Quaerat rem fugiat magnam autem tempora aut omnis.','Officiis qui impedit aliquam repudiandae. Quis nemo doloremque quis quia. Aut et sed ipsa autem ut consequatur laborum. Pariatur consequatur consectetur consequatur et maiores. Sit enim qui a consequuntur vel. Illum ab adipisci voluptatem aut eum nihil totam. Commodi sit exercitationem tempore sunt est repudiandae illum. Reiciendis quidem distinctio quia esse. Sint officia eaque officiis sit. Voluptatem recusandae officiis excepturi dolorem. Laudantium tempore ea nihil vitae rerum doloribus. Perspiciatis nobis architecto aut error fugit. Sed enim molestias et doloremque soluta eos aut numquam. Quia ut quisquam molestiae voluptatem inventore ad.',NULL,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(30,NULL,3,1,16,5,18,4,'Tenetur est.','2017-11-03','Vel deserunt et beatae. Autem ut incidunt aut harum aut enim et.','Placeat ut reiciendis recusandae rerum id. Atque voluptas voluptatibus unde sed. Facere quisquam inventore ut reprehenderit. Enim reiciendis et illum ullam. Qui aut ut praesentium dicta dicta voluptates nostrum qui. Quia itaque reiciendis ea corrupti ut enim voluptas. Itaque harum nobis sed sit. Cumque molestiae repellat modi commodi. Aliquam labore est fuga inventore. Et earum doloremque esse voluptatum est quae illum vel. Nemo iure eaque soluta nostrum. Tenetur similique est dolorem nihil perferendis sequi et. Est sequi iusto placeat rerum placeat laboriosam. Id voluptas voluptas quod enim et vero quo. In eius omnis illo dolorem odio qui quia error. Commodi iste omnis aut placeat facere.','CHF 3808900','2017-12-18 11:30:36','2017-12-18 11:30:36'),(31,18,4,2,24,5,13,3,'Ut sit et.','2017-08-06','Culpa voluptas facilis consequatur ex unde. Iure molestiae enim distinctio. Numquam aliquid dolores repellendus maiores. Beatae qui vero inventore.','Velit est quidem dolores nemo non et. Excepturi et suscipit voluptatem praesentium vero. Aut quod sit quam alias. Adipisci et ut laboriosam id qui ex et. Perferendis quae neque sed. Consequatur quas pariatur magni beatae ad. Et placeat est vel sint pariatur dolorum qui quidem. Qui consequatur tenetur quaerat illo cupiditate sequi. Quia sunt velit ex eos minima consequuntur repudiandae voluptas. Animi corporis officiis culpa non et voluptas. Mollitia sed enim enim et quia expedita eaque. Quisquam accusantium quos nisi voluptatem repudiandae sequi nisi. Est quisquam saepe id corporis et.','CHF 8328100','2017-12-18 11:30:36','2017-12-18 11:30:36'),(32,17,2,1,13,6,5,5,'Delectus quia quis.','2017-10-10','Expedita qui nobis tempore quo. Perferendis pariatur qui consequuntur dolorem aliquid aliquid nemo. Quae distinctio nesciunt quisquam rerum laborum. Cum corrupti sed est velit aut doloribus in. Quia ut id temporibus inventore numquam quidem.','Maxime laborum nihil officiis voluptatem itaque. Quasi sit et quaerat fugiat earum. Dolorem voluptatem deleniti odio enim aut eius aut. Neque temporibus sint aut asperiores eligendi. Et nihil illo aperiam repellendus quos dolor. Magni rerum eligendi reiciendis tempore perspiciatis nisi architecto. Praesentium et voluptatem necessitatibus dolorem velit. Animi voluptatem omnis deleniti eos. Consequatur quae perspiciatis ex voluptas sed eum et neque. Nulla debitis illum et debitis quam illo. Quis deserunt occaecati nostrum voluptatem. Quo omnis quia cupiditate delectus sit dolores quis. Et labore enim et optio harum.','CHF 3880400','2017-12-18 11:30:36','2017-12-18 11:30:36'),(33,19,4,1,4,3,16,4,'Enim odio.','2017-11-15','Doloribus sed et nemo voluptatem dolores. Asperiores sunt tempora voluptas voluptas quibusdam. Ab aut rerum adipisci eaque accusamus. Quia cupiditate vel possimus qui dolor ut ut dignissimos.','Modi voluptas fuga odit iste dolor. Cumque voluptatem fugiat distinctio praesentium. Voluptatibus quaerat commodi inventore dolorem officiis sit. Culpa atque deserunt aut est omnis aut. Sint est rerum nostrum velit maiores et facilis. Eaque magnam accusamus velit incidunt quasi quisquam. Ipsa et ut aliquid in vero debitis quasi. Aut reiciendis porro velit a rem. Minus ullam voluptatibus eum. Molestiae ad consequatur omnis possimus qui enim accusantium. Dolorem illo optio quo iste modi. Assumenda omnis assumenda illo sit distinctio. Ad ut aspernatur voluptatem. Hic accusamus commodi aut quo. Quas omnis nostrum corporis qui. Aut fugit consequatur voluptas quia repudiandae ipsam hic dolor.',NULL,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(34,3,3,2,11,1,5,2,'Aut blanditiis.','2017-09-12','Similique facere et non accusamus qui nostrum dolorem. Animi maxime ipsa natus culpa. Quae optio voluptates consequatur sapiente ab. Dolor dolor omnis dignissimos voluptatum tempore.','Sed id consequatur autem hic. Ut quia consequuntur non nesciunt qui quia. Sit repellendus in qui. Occaecati aut enim ratione quo. Reprehenderit quod rerum omnis soluta eum. Minima deserunt fuga labore. Labore aut totam aspernatur dolorem. Esse dolorum sed repellendus dolores dolores. In et necessitatibus sit quia voluptatem. Aut repudiandae cumque inventore iure dolores rerum. Ut laboriosam et aliquam consequatur saepe atque rerum. Minima illum officiis enim incidunt nobis aut. Enim omnis atque sunt recusandae nostrum. Quia omnis quae commodi natus. Qui laboriosam earum doloremque. Accusamus recusandae atque quae temporibus ex eos.',NULL,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(35,9,3,1,6,1,13,1,'Quo vero.','2017-07-04','Doloremque tenetur perferendis non quas modi a iusto. Doloribus eum molestias harum tempora ut modi. Velit et asperiores molestias fugit ut doloribus. Magnam porro qui exercitationem corporis iste molestiae modi quaerat.','Doloribus aut sed impedit quia non veniam nobis. Enim numquam numquam sed commodi iure sit voluptatum. Corrupti assumenda ut vitae eum. Et unde hic dolorem sit ut. Sunt aliquid ipsam omnis sequi possimus. Hic id consequatur ea esse. Delectus nihil et labore qui sequi modi iste est. Nemo omnis quis rerum reprehenderit assumenda. Possimus perferendis et est et vel. Ipsum numquam quis ipsum sapiente tenetur at quia consectetur. Accusamus modi impedit reiciendis consequuntur commodi autem. Est quia porro ut qui in. Quis odit aut non ut rerum similique sit. Ad qui et consectetur fuga quia. Quia expedita numquam velit atque. Sint facere porro maxime labore voluptatem minus excepturi.',NULL,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(36,6,2,1,23,2,4,5,'Expedita eum nihil.','2017-08-08','Fugiat maiores totam et error excepturi quaerat aut. Itaque autem possimus qui est aliquam culpa ad. Molestiae necessitatibus doloremque voluptates fugiat voluptatem. Repellat est ullam debitis consequatur nihil ut non.','Minus maxime delectus quae. Veniam nihil perferendis veniam cupiditate velit est itaque. Ducimus voluptas cupiditate dolorum laborum modi aut. Consequatur facere corrupti suscipit. Atque et quibusdam repellendus deserunt commodi ad unde consequatur. Dolor non magni sed et similique. Quo vel saepe sint laudantium incidunt voluptas. Non nulla porro dolores non. Itaque necessitatibus et dolorem. Earum animi quaerat et libero nemo. Voluptatem quo sed placeat modi corrupti hic. Temporibus laboriosam suscipit occaecati ut aperiam labore. Est eaque molestiae et dolorum dolorem eaque. Alias deserunt id praesentium autem et facere.','CHF 9936400','2017-12-18 11:30:36','2017-12-18 11:30:36'),(37,13,4,2,2,3,6,1,'Ut sunt.','2017-06-15','Suscipit quia doloribus quaerat. Perspiciatis eius architecto soluta enim fugiat. Sit nobis laboriosam molestiae consequatur. Consequatur et dolorem repellendus sapiente voluptas qui.','Consequatur aspernatur ad unde nobis odit dignissimos. Quia eveniet sit aut nisi velit nulla. Facilis laudantium beatae eveniet illum error sunt qui et. Vel sed placeat sed natus natus quas. Sit eveniet sint eius recusandae nulla perferendis. Ducimus vero sapiente officiis sequi qui. Repellat facere et quia vel nesciunt facere et. Nihil architecto alias aut. Quis perspiciatis possimus facilis animi quod earum soluta. Vero facilis optio iure. Aut eum et amet fugit. Earum placeat dolorum voluptas cum cumque. Nobis suscipit error quos voluptatem rerum et. Eum tempore non dolor impedit. Mollitia temporibus voluptatum odio incidunt. Sed placeat mollitia qui hic.',NULL,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(38,12,1,1,7,5,20,1,'Nesciunt alias ut.','2017-08-18','Omnis reprehenderit eum et delectus sit quia aut. Sit rerum qui nihil. Non eum est et. Incidunt unde nihil ullam est soluta omnis.','Aut dolor excepturi qui quaerat ipsam exercitationem. Et id iusto aut ut ea. Voluptas ex iste ut ipsam ullam ex non est. Fugit nam error quo eum dolores. Laborum voluptas asperiores ullam voluptatem. Saepe nostrum enim a optio iste distinctio. Labore reiciendis nulla sunt minima fuga. Eveniet eligendi ut illo et. Est architecto quia at optio quisquam aut expedita. Esse esse nam qui sed molestiae. Ut temporibus qui sit iste quaerat placeat. Saepe et quod neque aliquam. Neque quo nisi est est voluptates. Qui dolores voluptatem consequuntur ea nesciunt.',NULL,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(39,NULL,3,1,19,3,19,4,'Sit quos.','2017-08-05','Et quae voluptas suscipit et exercitationem est est saepe. Reiciendis accusantium qui exercitationem officia. Velit qui eius ducimus explicabo. Et ex debitis labore sequi. Laudantium rerum quidem tenetur quaerat cumque repellendus alias.','Nemo ullam quae odio. Maiores quisquam dolor aliquid atque est modi minus. Velit repellat similique dicta modi eaque. Repudiandae explicabo pariatur voluptates enim laborum. Quia tempora suscipit voluptas. Id accusantium perferendis eveniet laborum. Quisquam modi totam quas non ullam. Eaque et non tenetur aut odio cupiditate id. Iure unde magnam vel vel. Officiis cupiditate fugit temporibus ut voluptates sequi cum. Doloribus at magni nihil magni ut enim. Qui asperiores quam dolore eum dicta quia. Sunt voluptatem est dolores voluptatem. Accusamus quidem ullam pariatur ut. Molestiae sit omnis distinctio ut. Asperiores explicabo qui rerum explicabo.','CHF 4862100','2017-12-18 11:30:36','2017-12-18 11:30:36'),(40,6,1,1,5,5,2,2,'Architecto dolore.','2017-07-24','Facilis consectetur praesentium sapiente consequuntur voluptas. Molestiae dolorem odio sed sunt minus et fugiat. Inventore itaque fugiat accusantium dolore. Ex corrupti dolorum excepturi laborum sequi.','Ratione veniam occaecati vel velit consectetur. Modi nisi eos ea illo corporis eveniet reprehenderit. Beatae dolores labore exercitationem. Earum sed animi repudiandae nulla. Dolorem velit animi laboriosam soluta in. Voluptatem sint asperiores accusamus vero maiores. Neque nemo nihil est maiores. Quasi consectetur iure quia culpa delectus odit et. Error quo illo sit. Voluptas ipsam dolorem exercitationem fugiat rerum nihil. Eum nihil dicta consequatur aut debitis nemo et. In rerum laborum aut quidem nihil. Natus deleniti vero exercitationem.',NULL,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(41,10,4,2,9,1,22,1,'Incidunt sunt est.','2017-09-20','Quaerat ut qui esse eum omnis. Aliquam maxime itaque ea blanditiis accusantium. Corrupti assumenda illo fugiat est et.','Eius quis non quasi et qui autem. Qui reprehenderit tempora nam dolore nisi aliquam aperiam. Voluptas nulla eius in harum commodi id omnis. Maiores minima qui voluptas ullam odio beatae ipsum. Sed quaerat eaque quaerat in doloremque enim ipsa. Quo similique reiciendis vel voluptate rem sit. Illo aut molestiae impedit sint. Iusto laboriosam omnis suscipit quidem iste aspernatur molestiae. Et eos similique sed et. Pariatur distinctio accusantium porro et. Vel voluptate earum ducimus velit consequatur quam eos. Iusto omnis alias quibusdam dicta sit laborum perspiciatis optio. Sed qui repudiandae perspiciatis officia iste praesentium et.',NULL,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(42,NULL,4,1,18,2,21,6,'Voluptatem nostrum.','2017-07-10','Enim totam rerum officiis deserunt autem accusamus aut. Aut assumenda dolorem quaerat distinctio labore. Qui in qui animi rerum nihil. Cupiditate odio dolor earum nihil hic.','Et corporis molestiae voluptatem et aliquam voluptatum veniam itaque. Laudantium voluptatem est veniam quis. Qui et in eum dolores omnis numquam. Odio repellendus velit doloribus rerum. Quos voluptatem consequatur voluptas minima suscipit accusamus. Quibusdam temporibus nihil et repudiandae qui dolor et. Voluptatibus ab omnis eos ullam exercitationem non. Praesentium dolorem asperiores accusamus aut. Praesentium voluptas rerum dolorem eos est. Et et sit distinctio iste quia magnam. Iusto blanditiis consequuntur minima est exercitationem eos dolorem fugiat. Corporis error ut commodi mollitia nostrum quod tempora.',NULL,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(43,7,4,1,5,4,17,2,'Libero repellendus.','2017-06-03','Molestias molestiae facilis exercitationem. Provident rerum tempora iste adipisci et voluptatibus error quibusdam. Doloremque animi veritatis deserunt temporibus eum vel. Id inventore cupiditate repudiandae recusandae qui.','Aperiam quia sapiente et illum. Nihil quasi modi aut quo neque facere. Veniam deserunt commodi voluptatem est. Sunt voluptates sit dicta animi possimus dolorem. Nisi nobis nostrum consequatur sapiente rerum iste. Sint incidunt sapiente dolor voluptas. Autem ut animi omnis optio molestiae ducimus earum voluptate. Voluptates atque provident corrupti enim placeat. Hic sed dolores illo quia. Dolor exercitationem fugit aperiam impedit recusandae. Consequuntur unde sapiente natus molestiae cumque in ullam. Voluptatem ut et ipsa aut.','CHF 5115300','2017-12-18 11:30:36','2017-12-18 11:30:36'),(44,4,3,2,9,3,14,4,'Omnis inventore.','2017-08-31','Omnis facilis dolores cumque minus eos. Laboriosam aut aut voluptatum magnam autem sit. Magnam quidem molestias quo atque vel est repellendus necessitatibus.','Voluptas repellendus assumenda est autem numquam qui. Ad eaque quo soluta sunt possimus perferendis. Consectetur praesentium velit pariatur ullam beatae. Quia consequuntur excepturi et maiores qui sed dolor omnis. Autem sed accusamus itaque. Expedita cum qui doloremque aut. Consequatur voluptate deserunt quis qui quos at voluptas. Molestias odit vitae accusamus natus mollitia maxime voluptatem voluptas. Et molestiae voluptatibus autem laboriosam perferendis. Voluptatem modi voluptatem voluptatem quo. Cumque quis est ut et reiciendis. Consequuntur blanditiis et dolorem illo dolore itaque saepe harum. Id fuga aut assumenda iure quia vel. Consectetur in autem harum deserunt et a culpa non.',NULL,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(45,18,3,1,21,5,25,4,'Qui voluptas.','2017-09-21','Sit recusandae consequatur quis. Dignissimos dolorem maiores veritatis nihil sunt.','Vero nobis praesentium culpa rerum est quam. Modi quaerat quam ab consequatur. Velit aut dolorem odit odio laudantium voluptatem. Ratione dolore sed minus voluptatum sunt velit. Voluptate molestiae magnam sint qui rerum. Aut quaerat qui pariatur non vitae veniam quo voluptas. Ut aliquid animi asperiores recusandae quam porro possimus dolorem. Sequi perferendis placeat quo perspiciatis fugiat. Quia fuga occaecati voluptas laboriosam. Porro libero et consequatur. Sed voluptates corrupti debitis ducimus saepe dolore. Cupiditate quia delectus fugiat ea repellat est.',NULL,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(46,14,1,1,2,1,4,3,'Tempore quisquam.','2017-07-14','Est consectetur voluptatem temporibus explicabo fuga. Molestiae omnis et sequi eligendi. Tempore asperiores beatae commodi tempora hic sunt.','Qui totam et commodi odio aut rerum. Occaecati et molestiae culpa. Reiciendis voluptatem id explicabo non assumenda dolore. Qui facere dolorem non. Laboriosam ut est expedita perspiciatis perferendis vel. Et ut ut quo. Quidem numquam blanditiis omnis inventore totam qui magnam. Est velit voluptas excepturi eaque non id. Voluptatum illum debitis eos accusantium. Recusandae et enim illo quod tempore. Nisi vero numquam eligendi. Aut hic et necessitatibus repellat. Nihil inventore voluptatum tempora eos ex possimus quia. Qui aut nam aut aliquam.',NULL,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(47,3,2,1,23,3,10,4,'Blanditiis suscipit voluptates.','2017-07-12','Vero neque inventore vel omnis sunt. Quia odio placeat dolorem. Minus qui fugit temporibus debitis fugiat. Officia at atque totam distinctio doloremque. Earum ut consectetur est.','Quisquam eos provident ipsam consequatur voluptates temporibus. Et debitis laborum nulla enim qui ad. Officia minus qui corrupti cupiditate velit. Voluptate ea quidem distinctio aspernatur perferendis rerum esse. Soluta cum enim maxime iusto pariatur. Odio odio odio ut voluptas quibusdam omnis. Minus aut ducimus aliquam dicta rerum deserunt vel. Nulla optio ut aperiam illum ut molestiae dolore. Consequatur tempore molestias sunt. Ipsam iusto sunt ratione. Voluptatem voluptas error et corporis. Quis dolore exercitationem rerum natus qui atque. Qui qui quis illo eveniet exercitationem quasi.','CHF 7030400','2017-12-18 11:30:36','2017-12-18 11:30:36'),(48,NULL,3,2,7,6,11,1,'Magnam natus qui.','2017-10-14','Eligendi mollitia doloribus quis similique. Ipsum ad repudiandae itaque doloremque reiciendis numquam. Voluptatem voluptatibus est exercitationem error alias. Aut et sit autem cupiditate expedita.','Et minima harum molestias ullam et ab. Quia omnis molestiae tenetur nihil. Repellat veniam laborum sint quisquam. Quae at voluptate praesentium deserunt adipisci commodi pariatur consectetur. Dicta alias dolores nesciunt vel. Blanditiis iure a quisquam voluptas. Inventore quo voluptatem qui illum. At in magni ut sed sunt optio. Voluptas similique a minima et rerum. Eius autem laboriosam molestias quia est est incidunt. Impedit provident voluptate delectus laboriosam voluptatem. Enim sit quis excepturi vel sit aliquid laboriosam. Et sed libero aut inventore doloribus odit. Ducimus facere dicta modi aut accusamus. Ad delectus sequi nam similique omnis qui.',NULL,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(49,NULL,2,1,9,4,9,3,'Et voluptates ut.','2017-09-22','Porro et aut atque doloribus. Est enim eius consequatur tenetur ut. Aliquam aut corrupti odio error repellendus. Hic enim est enim perferendis a. Id incidunt vero iusto. Porro vel est vitae rerum consectetur eius velit.','Voluptate est ut dolorum architecto eaque nihil. Et veritatis hic sunt. Quasi ut necessitatibus quo. Doloribus consequatur mollitia cupiditate neque tempora illum incidunt laborum. Porro rerum et nobis iste aut. Nobis est voluptas corrupti sed in. Nemo tempore ducimus sapiente cupiditate laboriosam nobis nihil. Eveniet saepe inventore vitae enim. Minima consectetur iusto accusamus hic. Aspernatur hic voluptatem consequuntur modi saepe. Quisquam adipisci sed odio. Omnis debitis quia doloribus ullam doloremque. Et similique at voluptas est.',NULL,'2017-12-18 11:30:36','2017-12-18 11:30:36'),(50,8,4,2,5,1,18,2,'Minima ut nihil.','2017-08-02','Quo voluptas asperiores ea eos odio quisquam sint. Aut blanditiis ut mollitia minus. Odio sequi exercitationem facilis ut minima ea autem. Ut optio hic ut corporis possimus. Modi qui natus facilis nihil rerum.','Qui nihil minus recusandae excepturi similique ipsa recusandae. Dignissimos minus fugiat autem quia. At a qui perspiciatis laudantium autem laudantium quisquam. Saepe cumque modi soluta. Velit quo nulla et tempora laborum vero illo vel. Aut non et facere repudiandae pariatur illum enim. Ut id ut omnis qui. Tempora asperiores cupiditate quia voluptatem odit. Libero fugiat aspernatur quia laborum quis corporis facilis. Ut illo autem laudantium quia quod exercitationem et laboriosam. Magnam blanditiis nam sit debitis consequatur. Harum magni et magnam id. Assumenda ut non voluptatem quia quos consequatur dolores qui. Suscipit culpa reprehenderit similique inventore voluptas et.',NULL,'2017-12-18 11:30:36','2017-12-18 11:30:36');
/*!40000 ALTER TABLE `offers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phone`
--

DROP TABLE IF EXISTS `phone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phone` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `number` varchar(35) COLLATE utf8_unicode_ci NOT NULL COMMENT '(DC2Type:phone_number)',
  `type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phone`
--

LOCK TABLES `phone` WRITE;
/*!40000 ALTER TABLE `phone` DISABLE KEYS */;
/*!40000 ALTER TABLE `phone` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_categories`
--

DROP TABLE IF EXISTS `project_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_categories`
--

LOCK TABLES `project_categories` WRITE;
/*!40000 ALTER TABLE `project_categories` DISABLE KEYS */;
INSERT INTO `project_categories` VALUES (1,'projectCategory1','2017-12-18 11:30:36','2017-12-18 11:30:36'),(2,'perspiciatis','2017-12-18 11:30:36','2017-12-18 11:30:36'),(3,'voluptas','2017-12-18 11:30:36','2017-12-18 11:30:36'),(4,'dolor','2017-12-18 11:30:36','2017-12-18 11:30:36'),(5,'veritatis','2017-12-18 11:30:36','2017-12-18 11:30:36'),(6,'molestias','2017-12-18 11:30:36','2017-12-18 11:30:36'),(7,'est','2017-12-18 11:30:36','2017-12-18 11:30:36'),(8,'in','2017-12-18 11:30:36','2017-12-18 11:30:36'),(9,'sed','2017-12-18 11:30:36','2017-12-18 11:30:36'),(10,'qui','2017-12-18 11:30:36','2017-12-18 11:30:36');
/*!40000 ALTER TABLE `project_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_tags`
--

DROP TABLE IF EXISTS `project_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_tags` (
  `project_id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL,
  PRIMARY KEY (`project_id`,`tag_id`),
  KEY `IDX_562D5C3E166D1F9C` (`project_id`),
  KEY `IDX_562D5C3EBAD26311` (`tag_id`),
  CONSTRAINT `FK_562D5C3E166D1F9C` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_562D5C3EBAD26311` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_tags`
--

LOCK TABLES `project_tags` WRITE;
/*!40000 ALTER TABLE `project_tags` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projects`
--

DROP TABLE IF EXISTS `projects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `projects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) DEFAULT NULL,
  `rate_group_id` int(11) DEFAULT NULL,
  `project_category_id` int(11) DEFAULT NULL,
  `accountant_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `alias` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `started_at` datetime DEFAULT NULL,
  `stopped_at` datetime DEFAULT NULL,
  `deadline` datetime DEFAULT NULL,
  `description` longtext COLLATE utf8_unicode_ci,
  `budget_price` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fixed_price` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `budget_time` int(11) DEFAULT NULL,
  `chargeable` tinyint(1) DEFAULT NULL,
  `archived` tinyint(1) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_5C93B3A49395C3F3` (`customer_id`),
  KEY `IDX_5C93B3A42983C9E6` (`rate_group_id`),
  KEY `IDX_5C93B3A4DA896A19` (`project_category_id`),
  KEY `IDX_5C93B3A49582AA74` (`accountant_id`),
  KEY `IDX_5C93B3A4A76ED395` (`user_id`),
  CONSTRAINT `FK_5C93B3A42983C9E6` FOREIGN KEY (`rate_group_id`) REFERENCES `rate_groups` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_5C93B3A49395C3F3` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_5C93B3A49582AA74` FOREIGN KEY (`accountant_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_5C93B3A4A76ED395` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_5C93B3A4DA896A19` FOREIGN KEY (`project_category_id`) REFERENCES `project_categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projects`
--

LOCK TABLES `projects` WRITE;
/*!40000 ALTER TABLE `projects` DISABLE KEYS */;
INSERT INTO `projects` VALUES (1,1,1,1,7,2,'Büro','project-1','2016-08-23 04:57:24','2017-07-01 02:59:48',NULL,'Eine Beschreibung zum Büro Projekt',NULL,NULL,NULL,1,0,'2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(2,25,1,2,7,4,'Test Project 2','test-project-2','2016-05-13 05:08:02','2017-10-25 01:54:47','2017-11-18 10:17:11','Cum ducimus vitae quam omnis ea. Odio quis est officia voluptatibus corrupti commodi. Minima reprehenderit laborum cumque molestiae aut numquam. Aliquam est quod expedita laudantium qui ipsa ratione. Ut officia est rerum reprehenderit autem voluptatem.','CHF 9303200','CHF 9303200',NULL,1,0,'2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(3,19,2,9,18,1,'Test Project 3','test-project-3','2016-05-11 18:11:45','2017-07-24 01:36:51',NULL,'Quas quo totam quia doloremque numquam itaque. Voluptas quidem dolorum neque repudiandae. Non dolor voluptatibus nihil occaecati ut. Soluta sequi ut dignissimos omnis eveniet et nihil.','CHF 7734300','CHF 7734300',NULL,1,0,'2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(4,12,1,9,20,3,'Test Project 4','test-project-4','2016-06-26 01:15:54','2017-12-10 03:32:37',NULL,'Et doloremque quia commodi modi quia culpa. Autem quae perferendis enim id. Consequuntur provident beatae culpa consequatur aut ducimus dignissimos. Consequatur accusantium excepturi magni qui at et.','CHF 6237100','CHF 6237100',NULL,1,0,'2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(5,17,2,1,15,1,'Test Project 5','test-project-5','2017-05-09 23:25:37','2017-06-16 23:02:22',NULL,'Labore labore minus iste corrupti rerum. Aut totam sit consectetur omnis. Nobis qui recusandae tempore molestias expedita fugit delectus. Delectus laudantium sed iure quia illo neque omnis.','CHF 3631200','CHF 3631200',NULL,1,0,'2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(6,14,2,7,8,6,'Test Project 6','test-project-6','2015-12-31 22:44:01','2017-08-07 15:14:49','2017-11-06 00:29:01','Placeat et similique delectus nobis dolore accusamus qui. Et aliquam et at quod consequatur. Commodi qui voluptate quia rerum ut enim rem. Voluptas harum totam saepe.','CHF 2899400','CHF 2899400',NULL,1,0,'2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(7,10,1,10,7,6,'Test Project 7','test-project-7','2017-01-08 01:29:57','2017-07-16 18:19:45',NULL,'Qui recusandae nam quia non vitae eaque. Temporibus optio nisi sequi et eaque esse officia fugit. Voluptatibus quam quaerat aut.','CHF 2102000','CHF 2102000',NULL,1,0,'2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(8,11,1,6,24,3,'Test Project 8','test-project-8','2017-03-12 03:09:39','2017-06-09 12:05:41',NULL,'Illo aut quod exercitationem numquam quia. Aut hic autem voluptatem placeat. Explicabo est et modi aut. Deleniti qui quisquam facere esse quia et et.','CHF 9369500','CHF 9369500',NULL,1,0,'2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(9,3,1,7,25,3,'Test Project 9','test-project-9','2016-05-04 23:53:25','2017-09-28 03:21:04',NULL,'Provident magni eius nulla distinctio qui. Ut et magnam qui officia ea. Expedita ratione et sit reiciendis sunt molestias iure. Et molestiae laborum sequi laborum distinctio suscipit aut.','CHF 2996200','CHF 2996200',NULL,1,0,'2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(10,2,1,7,13,2,'Test Project 10','test-project-10','2017-03-07 18:02:13','2017-11-01 01:47:53',NULL,'Beatae et et quis illum molestiae. Omnis exercitationem velit repellat sit cum vitae sunt vel. Molestiae sit nihil nobis non.','CHF 79329800',NULL,334,0,0,'2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(11,25,1,7,15,3,'Test Project 11','test-project-11','2016-12-23 13:55:13','2017-06-26 01:59:31',NULL,'Facere maiores dolore et. Debitis reprehenderit sequi occaecati rerum occaecati mollitia occaecati et. Deserunt dignissimos repudiandae eos. Dolores debitis ut sint est quo.','CHF 28360300',NULL,843,1,0,'2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(12,9,2,5,24,4,'Test Project 12','test-project-12','2016-04-24 08:46:02','2017-08-19 21:28:57',NULL,'Cumque officia id quidem commodi ullam. Fuga praesentium et sunt magnam soluta. Neque id sunt omnis deleniti error. Voluptates ea in dolores ut tempore modi. Aperiam repudiandae mollitia molestiae voluptate cum dolorem reprehenderit.','CHF 18515900',NULL,940,1,0,'2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(13,23,2,4,16,1,'Test Project 13','test-project-13','2017-04-06 20:58:14','2017-08-30 13:40:18','2017-12-14 11:48:13','Odio magni est voluptatum. Optio adipisci corporis qui quis molestiae corporis. Adipisci quibusdam reprehenderit omnis voluptas. Ut et aut minima quos est cumque facere numquam.','CHF 15807000',NULL,432,1,0,'2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(14,21,2,7,24,5,'Test Project 14','test-project-14','2016-05-22 14:59:31','2017-09-04 06:30:19','2017-12-09 19:05:23','Reiciendis autem inventore harum animi ea nihil. Sed rerum perferendis aut saepe et nostrum consectetur. Odit est dolorem facere et. Recusandae ut quibusdam sit enim aspernatur.','CHF 54257400',NULL,863,1,0,'2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(15,22,2,7,23,6,'Test Project 15','test-project-15','2016-07-20 23:36:48','2017-11-26 20:00:05',NULL,'Ut alias quisquam at qui. Molestias maxime adipisci et saepe esse. Sed aperiam rerum nemo animi necessitatibus.','CHF 89397300',NULL,327,1,0,'2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(16,22,2,6,17,5,'Test Project 16','test-project-16','2016-10-06 04:30:53','2017-07-07 02:40:09','2017-12-02 06:47:46','Ipsum velit labore sit tenetur totam. Ut consequuntur corporis veniam minima a numquam sed repellat. Atque veniam pariatur quos nulla ipsa dolorem. Eum eum necessitatibus et aut explicabo voluptatem. Reiciendis voluptas inventore et perspiciatis.','CHF 65604800',NULL,953,1,0,'2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(17,10,1,5,23,4,'Test Project 17','test-project-17','2016-03-10 14:07:56','2017-10-04 21:15:18','2017-12-09 03:15:45','Quasi autem molestias quis odit. Aliquid veritatis est fuga cumque unde. Ipsam eum amet qui et veniam est. Quibusdam aut omnis labore molestiae consequuntur explicabo sint sequi.','CHF 69012200',NULL,883,1,0,'2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(18,21,2,7,9,3,'Test Project 18','test-project-18','2017-05-15 01:22:53','2017-08-05 00:47:41',NULL,'Est quo et culpa minus. Harum reprehenderit qui voluptates voluptatibus numquam dolores suscipit molestiae. Est saepe suscipit nulla voluptate aut. Tempore aspernatur sit eius est distinctio asperiores.','CHF 90811900',NULL,207,1,0,'2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(19,10,1,10,8,6,'Test Project 19','test-project-19','2017-01-21 15:16:59','2017-08-11 20:59:06',NULL,'Architecto eius voluptate quisquam molestiae incidunt a aut. Eos quam libero ducimus accusamus. Molestias labore provident error consequatur modi.','CHF 49896700',NULL,165,1,0,'2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(20,17,1,7,23,6,'Test Project 20','test-project-20','2017-05-01 20:47:19','2017-11-05 15:50:40',NULL,'Rem omnis consequatur ullam temporibus. Et in dolorem quidem. Enim aspernatur sed est voluptatem officia. Velit laboriosam ut eum nulla ea ut error. Eos blanditiis animi provident omnis et quidem.','CHF 72104700',NULL,757,1,0,'2017-12-18 11:30:36','2017-12-18 11:30:36',NULL);
/*!40000 ALTER TABLE `projects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rate_groups`
--

DROP TABLE IF EXISTS `rate_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rate_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `description` longtext COLLATE utf8_unicode_ci,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_529A081BA76ED395` (`user_id`),
  CONSTRAINT `FK_529A081BA76ED395` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rate_groups`
--

LOCK TABLES `rate_groups` WRITE;
/*!40000 ALTER TABLE `rate_groups` DISABLE KEYS */;
INSERT INTO `rate_groups` VALUES (1,1,'Tarifgruppe für kantonale Einsätze','Kanton','2017-12-18 11:30:35','2017-12-18 11:30:35'),(2,1,'Tarifgruppe für die restlichen Einsätze','Gemeinde und Private','2017-12-18 11:30:35','2017-12-18 11:30:35');
/*!40000 ALTER TABLE `rate_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rates`
--

DROP TABLE IF EXISTS `rates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rate_group_id` int(11) DEFAULT NULL,
  `service_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `rate_unit` longtext COLLATE utf8_unicode_ci,
  `rate_value` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `rateUnitType_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_44D4AB3C2983C9E6` (`rate_group_id`),
  KEY `IDX_44D4AB3C2BE78CCE` (`rateUnitType_id`),
  KEY `IDX_44D4AB3CED5CA9E6` (`service_id`),
  KEY `IDX_44D4AB3CA76ED395` (`user_id`),
  CONSTRAINT `FK_44D4AB3C2983C9E6` FOREIGN KEY (`rate_group_id`) REFERENCES `rate_groups` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_44D4AB3C2BE78CCE` FOREIGN KEY (`rateUnitType_id`) REFERENCES `rateunittypes` (`id`),
  CONSTRAINT `FK_44D4AB3CA76ED395` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_44D4AB3CED5CA9E6` FOREIGN KEY (`service_id`) REFERENCES `services` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rates`
--

LOCK TABLES `rates` WRITE;
/*!40000 ALTER TABLE `rates` DISABLE KEYS */;
INSERT INTO `rates` VALUES (1,1,1,2,'CHF/h','CHF 10000','2017-12-18 11:30:35','2017-12-18 11:30:35','h'),(2,1,16,3,'CHF/h','CHF 8100','2017-12-18 11:30:35','2017-12-18 11:30:35','h'),(3,2,21,5,'CHF/h','CHF 10300','2017-12-18 11:30:35','2017-12-18 11:30:35','h'),(4,1,20,4,'CHF/h','CHF 18000','2017-12-18 11:30:35','2017-12-18 11:30:35','h'),(5,2,18,4,'CHF/h','CHF 8100','2017-12-18 11:30:35','2017-12-18 11:30:35','h'),(6,1,21,4,'CHF/h','CHF 2800','2017-12-18 11:30:35','2017-12-18 11:30:35','h'),(7,1,40,5,'CHF/d','CHF 10800','2017-12-18 11:30:35','2017-12-18 11:30:35','t'),(8,2,40,5,'CHF/d','CHF 1500','2017-12-18 11:30:35','2017-12-18 11:30:35','t'),(9,1,41,3,'CHF/d','CHF 3100','2017-12-18 11:30:35','2017-12-18 11:30:35','t'),(10,1,41,4,'CHF/d','CHF 7600','2017-12-18 11:30:35','2017-12-18 11:30:35','t'),(11,1,39,5,'CHF/d','CHF 16900','2017-12-18 11:30:35','2017-12-18 11:30:35','t'),(12,2,61,4,'Einheit','CHF 18500','2017-12-18 11:30:35','2017-12-18 11:30:35','a'),(13,2,61,1,'Einheit','CHF 5500','2017-12-18 11:30:35','2017-12-18 11:30:35','a'),(14,2,54,5,'Km','CHF 13700','2017-12-18 11:30:35','2017-12-18 11:30:35','a'),(15,2,59,2,'Pauschal','CHF 18300','2017-12-18 11:30:35','2017-12-18 11:30:35','a'),(16,2,60,5,'Km','CHF 6000','2017-12-18 11:30:35','2017-12-18 11:30:35','a'),(17,1,79,3,'Pauschal','CHF 10700','2017-12-18 11:30:35','2017-12-18 11:30:35','a'),(18,1,81,6,'Pauschal','CHF 14500','2017-12-18 11:30:35','2017-12-18 11:30:35','a'),(19,2,81,6,'Pauschal','CHF 18300','2017-12-18 11:30:35','2017-12-18 11:30:35','a'),(20,1,73,3,'Pauschal','CHF 2700','2017-12-18 11:30:35','2017-12-18 11:30:35','a'),(21,1,80,6,'Pauschal','CHF 6700','2017-12-18 11:30:35','2017-12-18 11:30:35','a');
/*!40000 ALTER TABLE `rates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rateunittypes`
--

DROP TABLE IF EXISTS `rateunittypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rateunittypes` (
  `id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `doTransform` tinyint(1) NOT NULL,
  `factor` decimal(10,3) DEFAULT NULL,
  `scale` int(11) NOT NULL,
  `roundMode` int(11) NOT NULL,
  `symbol` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_71C44DB0A76ED395` (`user_id`),
  CONSTRAINT `FK_71C44DB0A76ED395` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rateunittypes`
--

LOCK TABLES `rateunittypes` WRITE;
/*!40000 ALTER TABLE `rateunittypes` DISABLE KEYS */;
INSERT INTO `rateunittypes` VALUES ('a',4,'Anderes',0,1.000,3,1,'a','2017-12-18 11:30:35','2017-12-18 11:30:35'),('h',1,'Stunden',1,3600.000,2,1,'h','2017-12-18 11:30:35','2017-12-18 11:30:35'),('m',1,'Minuten',1,60.000,2,1,'m','2017-12-18 11:30:35','2017-12-18 11:30:35'),('t',3,'Tage',1,30240.000,2,1,'d','2017-12-18 11:30:35','2017-12-18 11:30:35'),('zt',3,'Zivitage',1,30240.000,2,1,'zt','2017-12-18 11:30:35','2017-12-18 11:30:35');
/*!40000 ALTER TABLE `rateunittypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service_tags`
--

DROP TABLE IF EXISTS `service_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `service_tags` (
  `service_id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL,
  PRIMARY KEY (`service_id`,`tag_id`),
  KEY `IDX_A1FF20CAED5CA9E6` (`service_id`),
  KEY `IDX_A1FF20CABAD26311` (`tag_id`),
  CONSTRAINT `FK_A1FF20CABAD26311` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_A1FF20CAED5CA9E6` FOREIGN KEY (`service_id`) REFERENCES `services` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_tags`
--

LOCK TABLES `service_tags` WRITE;
/*!40000 ALTER TABLE `service_tags` DISABLE KEYS */;
/*!40000 ALTER TABLE `service_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `services`
--

DROP TABLE IF EXISTS `services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `services` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `alias` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8_unicode_ci,
  `chargeable` tinyint(1) NOT NULL,
  `vat` decimal(10,4) DEFAULT NULL,
  `archived` tinyint(1) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_service_alias_user` (`alias`,`user_id`),
  KEY `IDX_7332E169A76ED395` (`user_id`),
  CONSTRAINT `FK_7332E169A76ED395` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=82 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `services`
--

LOCK TABLES `services` WRITE;
/*!40000 ALTER TABLE `services` DISABLE KEYS */;
INSERT INTO `services` VALUES (1,2,'consulting','consulting','This is a detailed description',1,0.0800,0,'2017-12-18 11:30:35','2017-12-18 11:30:35',NULL),(2,4,'voluptas','veritatis-molestias-est-in-sed','Cum ducimus vitae quam omnis ea. Odio quis est officia voluptatibus corrupti commodi. Minima reprehenderit laborum cumque molestiae aut numquam. Aliquam est quod expedita laudantium qui ipsa ratione. Ut officia est rerum reprehenderit autem voluptatem.',1,0.0800,0,'2017-12-18 11:30:35','2017-12-18 11:30:35',NULL),(3,5,'nihil','est-sit-suscipit-libero-nisi','Quo totam quia doloremque numquam itaque. Voluptas quidem dolorum neque repudiandae. Non dolor voluptatibus nihil occaecati ut. Soluta sequi ut dignissimos omnis eveniet et nihil.',1,0.0800,0,'2017-12-18 11:30:35','2017-12-18 11:30:35',NULL),(4,3,'ullam','repellat-qui-ipsum-sit-illum','Doloremque quia commodi modi quia culpa corrupti autem. Perferendis enim id beatae consequuntur provident beatae culpa consequatur. Ducimus dignissimos est consequatur accusantium excepturi. Qui at et inventore voluptas.',1,0.0250,0,'2017-12-18 11:30:35','2017-12-18 11:30:35',NULL),(5,5,'qui','tempore-molestias-expedita-fug','Quia illo neque omnis possimus numquam nostrum. Dolor mollitia repudiandae velit velit sit aut temporibus. Occaecati consectetur eos expedita tempora deserunt molestias quod. Repellendus voluptatum perferendis totam esse.',1,0.0800,0,'2017-12-18 11:30:35','2017-12-18 11:30:35',NULL),(6,4,'harum','saepe-nihil-mollitia-consequat','Odio asperiores perspiciatis saepe et natus optio qui. Similique quaerat commodi perspiciatis et placeat autem ratione. Et et ut beatae rerum.',1,0.0250,0,'2017-12-18 11:30:35','2017-12-18 11:30:35',NULL),(7,2,'nihil','ratione-ea-aperiam-quae-nam-id','Quis sed autem et velit dolores expedita optio quos. Molestiae dignissimos enim maxime tempore mollitia dolorem. In placeat error dolor assumenda enim aperiam sequi. Illo aut quod exercitationem numquam quia.',1,0.0250,0,'2017-12-18 11:30:35','2017-12-18 11:30:35',NULL),(8,2,'dicta','aut-culpa-illo-quisquam-accusa','Et molestias culpa et facilis est ut. Fugit sed saepe maxime nobis ut cupiditate. Rem repellat voluptas dignissimos molestiae neque culpa.',0,0.0800,0,'2017-12-18 11:30:35','2017-12-18 11:30:35',NULL),(9,1,'aut','accusantium-voluptatem-adipisc','Autem unde est eaque et. Modi incidunt exercitationem et reiciendis vel facilis sed. Quo est laboriosam beatae et.',1,0.0250,0,'2017-12-18 11:30:35','2017-12-18 11:30:35',NULL),(10,5,'qui','natus-quidem-enim-voluptatum-l','Sit labore rem voluptas quasi aut. Ea libero veritatis rerum ad incidunt voluptatem facere. Dolore et at debitis reprehenderit sequi occaecati rerum.',1,0.0800,0,'2017-12-18 11:30:35','2017-12-18 11:30:35',NULL),(11,1,'eveniet','non-qui-soluta-repellendus-nat','Fuga ipsum praesentium cumque officia id quidem commodi. Aut fuga praesentium et. Magnam soluta laudantium neque id sunt omnis. Error omnis voluptates ea in. Ut tempore modi molestiae aperiam.',1,0.0800,0,'2017-12-18 11:30:35','2017-12-18 11:30:35',NULL),(12,1,'error','labore-sit-a-qui-omnis-dolorib','Cum autem nesciunt et numquam aspernatur. Odio magni est voluptatum. Optio adipisci corporis qui quis molestiae corporis. Adipisci quibusdam reprehenderit omnis voluptas.',1,0.0800,0,'2017-12-18 11:30:36','2017-12-18 11:30:35',NULL),(13,6,'quia','sed-veritatis-molestiae-dolore','Magni quia maiores reiciendis autem inventore. Animi ea nihil est sed rerum perferendis. Saepe et nostrum consectetur eos odit est dolorem facere. A recusandae ut quibusdam sit enim. Quibusdam rerum vero eos atque voluptatem debitis ut autem.',1,0.0250,0,'2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(14,1,'non','fuga-voluptatibus-atque-dolore','Qui incidunt molestias maxime adipisci et saepe. Ipsum sed aperiam rerum. Animi necessitatibus necessitatibus facilis quam aut. Harum reiciendis magnam voluptatum neque.',1,0.0800,0,'2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(15,4,'consectetur','ipsum-velit-labore-sit-tenetur','Corporis veniam minima a numquam. Repellat ea atque veniam pariatur quos nulla ipsa dolorem. Eum eum necessitatibus et aut explicabo voluptatem.',1,0.0250,0,'2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(16,3,'voluptas','voluptatum-qui-neque-sequi','Voluptate aperiam et aut at natus voluptas est aut. Odio optio itaque qui vel qui quasi. Molestias quis odit sapiente aliquid veritatis est fuga.',1,0.0800,0,'2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(17,2,'quia','sit-qui-rem-enim-eos','Maxime hic et fuga expedita est id dolor. Officia perspiciatis autem et et et nihil officia. Sed et pariatur et sapiente beatae ut hic.',1,0.0250,0,'2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(18,6,'eius','distinctio-asperiores-laborum-','Iure eaque aliquam qui consequatur neque ut debitis. Explicabo id enim ab. Non quia fuga ducimus tempore necessitatibus. Placeat et aut laborum eligendi. Mollitia sit accusamus architecto eius.',0,0.0800,0,'2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(19,3,'iste','occaecati-voluptatem-rerum-opt','At modi assumenda et tempore ex. Vel quasi facilis eveniet repellat facere cupiditate sed rem.',1,0.0800,0,'2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(20,3,'velit','dignissimos-est-enim-tenetur','Commodi quis sit eveniet accusamus dolor. Voluptatum cum veniam tempora blanditiis sit vero quo. Quo laudantium necessitatibus et pariatur nesciunt ut tempora. Hic velit rerum quis accusamus sed.',1,0.0800,0,'2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(21,5,'consequatur','maxime-soluta-modi-eveniet-est','Molestias provident totam voluptatibus cumque. Fuga voluptas cupiditate voluptas sit sit incidunt aliquid libero. Temporibus ut ad sint pariatur eos. Sint sunt et aspernatur sapiente necessitatibus blanditiis tempora laborum.',1,0.0250,0,'2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(22,4,'exercitationem','amet-quia-molestiae-ad-est-fac','Esse et soluta ab voluptatem odio dicta. A vel totam minus rerum harum consequatur autem. Adipisci rem dolores et. Velit in fugit doloribus numquam amet dolor temporibus.',1,0.0800,0,'2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(23,6,'similique','omnis-sed-ullam-ut-deserunt-ma','Eaque ut distinctio quo. Est ratione rerum ipsa culpa voluptatem eos. Quia adipisci amet consequatur dolorum. Consequatur quasi perferendis provident dicta sed esse dolorum.',1,0.0250,0,'2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(24,2,'et','exercitationem-velit-est-ipsa-','Natus aut est nesciunt aliquam aspernatur. Pariatur modi illo sit accusantium. Est quia sequi nostrum.',1,0.0250,0,'2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(25,1,'eos','dolorem-qui-cupiditate-perspic','Error molestias rerum iusto quia. Eum molestiae optio doloribus. Est quidem dolores et magni voluptatem temporibus. Repellat officia ratione voluptatem similique qui ipsam itaque.',1,0.0250,0,'2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(26,4,'et','aut-dignissimos-quia-repudiand','Sint nihil rerum in eaque. Modi optio qui ut nisi. Similique nulla et possimus deserunt.',1,0.0250,0,'2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(27,4,'minima','cum-ut-et-eius-ut-et-vel-a','Ut vel eum quasi ut est molestiae error minus. Neque repudiandae quae non ad eos. Voluptatem sunt pariatur nulla. Dolor at soluta molestias autem sed et sunt. Velit aut sint voluptatibus ipsa ipsum omnis consequatur.',1,0.0800,0,'2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(28,3,'expedita','sint-pariatur-in-eaque','Delectus doloribus perspiciatis aspernatur dolor ut. Est repudiandae quis modi quo maxime voluptates suscipit.',1,0.0250,0,'2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(29,3,'quae','qui-nobis-asperiores-corporis-','Odit quo et omnis. Eaque dolorem beatae quasi ipsa vel. Ad voluptatem illum eum eligendi reprehenderit. Quas non et fugiat animi quibusdam labore.',1,0.0800,0,'2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(30,3,'eaque','cumque-ullam-velit-ab-qui-minu','Perferendis dicta esse porro aut. Et et quia et enim dolor praesentium optio eveniet. Laborum sed nesciunt quisquam nihil magni eaque nostrum facere. Ipsam et id amet distinctio molestiae non. Sequi excepturi et deleniti asperiores quia.',1,0.0800,0,'2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(31,6,'iure','nemo-vel-vel-sequi-aut-aliquam','Impedit aut aliquam nisi quia. Pariatur inventore impedit tempora non eos mollitia fugit. Provident non et necessitatibus sit repudiandae dolorum magnam.',1,0.0800,0,'2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(32,4,'eaque','quasi-sit-nam-qui-id','Aliquam minima corporis aut sequi qui consectetur quo. Provident aperiam vel impedit quos. Nesciunt odit esse repellat aliquid animi. Quia error libero nostrum quas illum quia.',1,0.0250,0,'2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(33,2,'qui','repellendus-dolor-vitae-illo-m','Consequatur commodi odit qui doloribus a. Et veritatis esse dolorem cumque sunt. Minus accusamus laudantium possimus laboriosam optio et.',0,0.0250,0,'2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(34,1,'est','accusamus-optio-enim-in-eaque-','Quis voluptatem cum dicta quod totam nam. Vel quasi molestiae consequatur vero expedita autem. Quia velit quo impedit est. Praesentium sit quis dolorem. Voluptatum ut rerum excepturi a repellendus ex et praesentium. Eum sint dolorem in.',0,0.0250,0,'2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(35,2,'tenetur','sit-tempora-excepturi-officiis','Ex reprehenderit eum consequatur cum quod. Dolores voluptatum esse pariatur et molestias. Iusto quia delectus consectetur eveniet maxime. Cupiditate consectetur at quam officia mollitia eum consequatur corporis.',1,0.0800,0,'2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(36,6,'ducimus','sapiente-earum-quia-eius-quo-s','Soluta molestiae tempore et laboriosam sunt qui et. Tenetur qui nihil et. Voluptatum accusamus rem aut quia.',1,0.0250,0,'2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(37,3,'aut','quae-voluptatem-est-beatae-ips','Id tempora quas modi fugit eius illo provident. Repellendus fuga aspernatur cupiditate. Deserunt est repellendus repellat rerum. Laboriosam qui quae voluptas earum placeat facilis sunt.',1,0.0800,0,'2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(38,3,'provident','corporis-perspiciatis-aliquam-','Quis autem sequi debitis dolor error nobis placeat porro. Quidem dolor et explicabo dolor sunt. Sed excepturi accusamus consequuntur doloremque omnis quas. Deserunt perferendis odit eligendi repellat praesentium rerum est et.',1,0.0800,0,'2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(39,5,'nesciunt','itaque-libero-maxime-sit-minus','Qui quas est molestiae nulla non earum sed. Consequatur possimus tenetur consequuntur laborum. Natus est impedit omnis sint explicabo exercitationem porro. Repudiandae recusandae quisquam ipsa veritatis.',1,0.0250,0,'2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(40,1,'ducimus','excepturi-eos-ut-harum-et-aliq','Aut consequuntur vero praesentium incidunt ipsam quae. Mollitia voluptas architecto ipsa iure deserunt libero facilis. Voluptatibus consequatur rerum vitae consectetur vero enim inventore sed. Natus enim quis nemo aut voluptatem.',0,0.0800,0,'2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(41,1,'ipsa','reiciendis-dolore-quo-molestia','Sed fuga ab quo temporibus. Ad non nisi fuga quia deleniti unde minima eaque. Doloremque nihil quia cum occaecati magnam hic expedita.',0,0.0800,0,'2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(42,1,'qui','a-laboriosam-beatae-enim-sunt-','Vel repudiandae doloribus deserunt cumque. Reprehenderit dignissimos maxime et placeat. Nostrum sint quo nesciunt exercitationem vel et.',1,0.0250,0,'2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(43,6,'voluptas','recusandae-repudiandae-molesti','Excepturi odit eius voluptatum officia reprehenderit eligendi totam temporibus. Et facilis dignissimos minima mollitia odit modi possimus eveniet. Culpa iste aliquid ipsam commodi blanditiis ipsam. Soluta dolore magni temporibus illum ex eveniet enim.',0,0.0250,0,'2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(44,5,'sunt','maiores-et-aliquam-nihil-enim-','Modi natus hic aliquid corporis est eos aut. Non molestias aut ut et sunt consectetur laboriosam. Aliquid voluptatibus commodi vero sint dolores numquam temporibus. Quae earum nihil recusandae facere voluptatem similique.',0,0.0800,0,'2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(45,1,'eligendi','voluptatem-pariatur-aut-et-vel','Iusto ipsa consectetur harum nemo laborum cupiditate sint sit. Facilis ut numquam vel tempore et eius fugit. Sunt sequi sed ad quibusdam sequi. Ea pariatur incidunt aspernatur impedit nisi.',1,0.0800,0,'2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(46,1,'neque','saepe-quia-laboriosam-autem-do','Aut rem aut quia voluptatem velit accusantium hic. Ipsa recusandae odio rerum. Voluptatem debitis excepturi qui a voluptas. Corrupti totam non aliquid fuga velit sed id et.',0,0.0250,0,'2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(47,1,'dignissimos','ullam-eligendi-fugit-fuga-numq','Officiis dolores dolor natus animi labore est nisi. Impedit aut est veniam dicta qui nihil. Et a corrupti quia aut.',1,0.0800,0,'2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(48,4,'soluta','laudantium-vel-aspernatur-susc','Ab dolorum cupiditate provident autem omnis reiciendis. Et aut fugiat laborum maiores fuga dignissimos corporis ex. Iure nemo fugit sit nobis iure quae.',1,0.0800,0,'2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(49,1,'et','voluptatibus-est-qui-enim-nequ','Fuga corporis suscipit dolores inventore eos tempore. Ullam voluptas et fugiat magni. Assumenda dolorum alias sit deserunt. Porro ullam ducimus molestias fuga et. Iste sunt aut ad molestiae officia ex.',1,0.0250,0,'2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(50,4,'nam','facere-molestiae-nisi-et-ab','Perspiciatis similique temporibus odit quasi cum perspiciatis. Dolores tenetur ea adipisci molestiae et. Iusto mollitia sed id voluptates. Velit ut repellendus aliquam.',1,0.0800,0,'2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(51,4,'expedita','neque-velit-veniam-modi','Deserunt sunt consequatur nihil cumque. Nihil quidem quia consectetur occaecati vero voluptatem. Consequatur alias voluptatem molestiae provident cupiditate. Quos dolorem perspiciatis odio.',1,0.0250,0,'2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(52,2,'molestias','blanditiis-ex-incidunt-magnam','Tempora dolorum fugit maiores. Accusantium deleniti et deserunt debitis sunt qui. Molestiae quia optio sed placeat iusto illo. Qui aliquam voluptatem molestiae eum earum ullam. Ab dolor alias tempora quia qui.',1,0.0250,0,'2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(53,4,'optio','ipsa-incidunt-debitis-iure-qui','Ducimus eos voluptate nemo omnis cum et. Fugiat eaque illo officia perspiciatis consectetur aut. Perspiciatis hic earum fugiat. Sit rerum fuga accusamus praesentium a autem enim. Dicta qui et voluptatem eum. Esse sapiente debitis id.',0,0.0250,0,'2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(54,3,'est','facere-et-ut-et-consequuntur','Et vero quo tempore commodi maiores est. Totam qui saepe modi qui aut. Dolorem quis placeat saepe ex. Aut maiores nihil saepe voluptatem.',1,0.0250,0,'2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(55,2,'saepe','earum-nostrum-consequatur-ipsa','Voluptatum id molestiae aliquam et. Non quam sint quae animi eligendi quam. Accusamus eveniet quae atque eaque. Corrupti molestiae dolorem error facilis.',0,0.0250,0,'2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(56,4,'explicabo','maiores-qui-expedita-excepturi','In sunt itaque reiciendis recusandae sit ad magnam distinctio. Laborum aperiam ducimus provident et dolorem aliquam. Autem facere minima eius sed qui sit. Aut voluptatem praesentium rerum reprehenderit dolorum non consequatur.',1,0.0800,0,'2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(57,2,'consequatur','consectetur-aliquid-ad-nihil-q','Qui maiores vel quis. Quia voluptatem non explicabo qui reiciendis ut atque. Hic et ducimus nostrum sunt quasi. Sed nihil nostrum cupiditate provident aperiam.',1,0.0250,0,'2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(58,4,'magnam','aut-est-pariatur-consequatur-e','Illum delectus dolores eius quibusdam laudantium. Enim explicabo consectetur nihil reprehenderit. Qui eum sed neque nulla.',1,0.0800,0,'2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(59,2,'animi','ipsam-adipisci-ut-aut-odit-nih','At nam non nihil nostrum est doloribus dolor. Nam nobis eum temporibus tempore sit. Reiciendis voluptas consequatur placeat quod. Debitis fuga et vel velit illum nisi.',1,0.0800,0,'2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(60,1,'beatae','enim-fugiat-est-ut-vero-unde-a','Numquam beatae omnis incidunt magnam expedita aut voluptas earum. Inventore dolor ipsam qui doloribus sed magnam iusto. Cum sed laborum rerum error hic. Debitis excepturi odit fugit fuga eos aliquam voluptate. Adipisci modi veritatis iste tempora.',1,0.0250,0,'2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(61,5,'sunt','iusto-sed-quae-ea-porro-et-arc','Quam rerum quod voluptas iusto molestiae optio. Ut quisquam dolores doloremque unde eaque dolorum et. Magnam dolorem et doloribus ipsum. Hic ut cum nostrum corrupti qui dignissimos.',1,0.0250,0,'2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(62,5,'sed','et-labore-quasi-perferendis-si','Fugiat est nemo quasi perferendis expedita. Dolores ad natus et et incidunt nesciunt voluptas. Tempore nobis saepe quo est vel. Veniam vero ea aut rem ipsum. Voluptas nam praesentium ratione deleniti et aut aliquam. Sed aliquam velit rerum in et.',0,0.0800,0,'2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(63,4,'omnis','saepe-animi-optio-laborum-aut-','Aperiam sapiente molestias repudiandae ea. Reprehenderit ea aut tempora dolorum eveniet sunt. Ex sit quia saepe ullam corrupti molestiae natus assumenda. Aspernatur consequatur ullam nam est.',1,0.0250,0,'2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(64,5,'fugiat','quas-repellendus-quam-sequi-fu','Eum porro ea recusandae autem laborum voluptatem dignissimos. Est voluptate et nesciunt est. Qui et quidem perspiciatis placeat. Id laborum facilis dicta incidunt et.',1,0.0800,0,'2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(65,4,'rem','ex-non-amet-a-cum-aut-quam-quo','Possimus non id animi eius error nobis. Molestiae aut nihil aut. Sed ut unde nulla sed quas. Beatae modi accusamus qui qui accusantium.',1,0.0800,0,'2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(66,6,'reiciendis','nesciunt-sit-et-cumque-molesti','Qui at quis numquam. Mollitia ea quisquam reprehenderit. Quasi doloribus voluptatum nemo sit est suscipit ut. Saepe hic voluptates vitae autem vero officia.',1,0.0800,0,'2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(67,3,'consectetur','qui-a-voluptas-quia-labore-mag','Nobis eius perspiciatis quis voluptas. Et quam temporibus nostrum commodi dolorem. Culpa eos est ullam voluptatem molestiae. Non veniam quis itaque enim similique dolor. Rerum sit velit nesciunt iure.',1,0.0800,0,'2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(68,5,'sunt','totam-a-rem-quia-unde-tempore-','Explicabo autem voluptatibus harum et est iusto perspiciatis consequatur. Minus qui sit beatae vero ut hic vero quidem. Aliquam culpa voluptas repudiandae iste atque.',1,0.0800,0,'2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(69,5,'quo','enim-dolore-rerum-sint-dolores','Debitis dolores vel corrupti vel numquam at. Id provident assumenda deserunt aspernatur possimus illum quasi velit. Iste vitae id molestias accusamus necessitatibus possimus earum autem. Voluptatem ipsum voluptas est.',1,0.0250,0,'2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(70,2,'voluptas','iste-cupiditate-nobis-quisquam','Quia ipsa enim voluptatem quas. Et ut ut tenetur optio et. Repellat qui rerum maxime qui quibusdam.',1,0.0250,0,'2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(71,3,'quia','voluptates-et-earum-esse-sequi','Facere possimus et enim dolores dolor et ut reiciendis. Pariatur dolores nemo non consequatur. Dolor vitae non pariatur cupiditate.',1,0.0800,0,'2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(72,3,'aut','suscipit-commodi-explicabo-rat','Quis tempore repellendus incidunt eum nihil voluptatem. Dignissimos rerum perspiciatis dolorem libero. Aspernatur aut iure perspiciatis quas ut voluptatem veritatis debitis.',1,0.0800,0,'2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(73,5,'eveniet','qui-qui-excepturi-fugiat-sequi','Modi nulla nemo ea repudiandae aut corrupti dolores. Voluptatem commodi qui inventore sit vitae perferendis quia sit. Illo non hic quibusdam omnis et aliquam est. Suscipit fuga et porro dignissimos.',1,0.0250,0,'2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(74,1,'sint','ut-amet-sit-quia-error-dolorem','Dolorem nam rerum vero porro. Cupiditate aut rerum quia voluptatum consequatur ea asperiores dolorem. Harum deserunt nulla quia enim iure eum. Accusantium impedit aliquam perferendis non consequuntur culpa suscipit.',1,0.0250,0,'2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(75,1,'explicabo','suscipit-ex-aliquam-debitis','Consectetur possimus vel non ex. Tempore neque repellendus ut repellat nihil. Occaecati dolorem iure consectetur in.',1,0.0800,0,'2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(76,5,'similique','inventore-nihil-corporis-eos-v','Consequatur et maiores sint architecto dolorum. Consequatur sint repudiandae asperiores odio in rerum. Libero delectus magni provident error omnis illum.',1,0.0800,0,'2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(77,1,'soluta','nihil-illum-maiores-incidunt-a','Necessitatibus nesciunt tempore consequatur et magnam praesentium et explicabo. Distinctio totam adipisci consequatur quam. Odio illum dignissimos et incidunt eius rerum. Laudantium consequuntur aut magni in.',1,0.0800,0,'2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(78,5,'consequuntur','doloremque-sint-inventore-prae','Nam voluptatem nemo aliquid natus error quasi. Voluptatum aut quis non quaerat sit nulla suscipit. Dignissimos asperiores rerum dolores ratione est aut id. Rerum quis cumque et sapiente et rerum velit.',1,0.0250,0,'2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(79,4,'labore','exercitationem-porro-molestias','Et voluptas consequatur tempora nostrum. Tenetur enim eum ab qui reprehenderit quia ab. Nihil ab accusantium officia omnis eveniet architecto. Aut omnis fugit veniam ut eius rem.',1,0.0250,0,'2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(80,4,'veniam','non-laborum-sit-voluptatum','Dolor repellendus blanditiis eos. Neque maxime vel qui debitis. Enim aliquam ratione iste omnis ut similique est.',1,0.0250,0,'2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(81,5,'quo','facilis-occaecati-consequatur-','Voluptates laborum aut ratione cum autem ipsum. Praesentium ut culpa nesciunt omnis eligendi expedita beatae. At asperiores enim aliquam nihil omnis possimus. Quam pariatur ut reiciendis esse. Laborum enim natus enim nam a dolorum necessitatibus.',1,0.0800,0,'2017-12-18 11:30:36','2017-12-18 11:30:36',NULL);
/*!40000 ALTER TABLE `services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings`
--

DROP TABLE IF EXISTS `settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `namespace` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `value` longtext COLLATE utf8_unicode_ci,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_setting_name_namespace_user` (`name`,`namespace`,`user_id`),
  KEY `IDX_E545A0C5A76ED395` (`user_id`),
  CONSTRAINT `FK_E545A0C5A76ED395` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings`
--

LOCK TABLES `settings` WRITE;
/*!40000 ALTER TABLE `settings` DISABLE KEYS */;
INSERT INTO `settings` VALUES (1,1,'activity','/etc/defaults/timeslice','action:byName:Zivi*','2017-12-18 11:30:35','2017-12-18 11:30:35'),(2,1,'value','/etc/defaults/timeslice','30240','2017-12-18 11:30:35','2017-12-18 11:30:35'),(3,1,'startedAt','/etc/defaults/timeslice','action:nextDate','2017-12-18 11:30:35','2017-12-18 11:30:35'),(4,3,'name','/etc/defaults/1','New perspiciatis','2017-12-18 11:30:35','2017-12-18 11:30:35'),(5,1,'name','/etc/defaults/2','New dolor','2017-12-18 11:30:35','2017-12-18 11:30:35'),(6,5,'name','/etc/defaults/3','New molestias','2017-12-18 11:30:35','2017-12-18 11:30:35'),(7,3,'name','/etc/defaults/4','New in','2017-12-18 11:30:35','2017-12-18 11:30:35'),(8,5,'name','/etc/defaults/5','New qui','2017-12-18 11:30:35','2017-12-18 11:30:35');
/*!40000 ALTER TABLE `settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `standard_discounts`
--

DROP TABLE IF EXISTS `standard_discounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `standard_discounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `value` decimal(10,2) NOT NULL,
  `percentage` tinyint(1) DEFAULT NULL,
  `minus` tinyint(1) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_57041CB0A76ED395` (`user_id`),
  CONSTRAINT `FK_57041CB0A76ED395` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `standard_discounts`
--

LOCK TABLES `standard_discounts` WRITE;
/*!40000 ALTER TABLE `standard_discounts` DISABLE KEYS */;
INSERT INTO `standard_discounts` VALUES (1,1,'Skonto 2%',0.02,1,1,'2017-12-18 11:30:35','2017-12-18 11:30:35'),(2,1,'Flat Rate 10 CHF',10.00,0,1,'2017-12-18 11:30:35','2017-12-18 11:30:35'),(3,1,'Flat Rate 11 CHF',11.00,0,1,'2017-12-18 11:30:35','2017-12-18 11:30:35'),(4,1,'Flat Rate 12 CHF',12.00,0,1,'2017-12-18 11:30:35','2017-12-18 11:30:35'),(5,1,'Flat Rate 13 CHF',13.00,0,1,'2017-12-18 11:30:35','2017-12-18 11:30:35'),(6,1,'Flat Rate 14 CHF',14.00,0,1,'2017-12-18 11:30:35','2017-12-18 11:30:35');
/*!40000 ALTER TABLE `standard_discounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `system` tinyint(1) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_tag_name_user` (`name`,`user_id`),
  KEY `IDX_6FBC9426A76ED395` (`user_id`),
  CONSTRAINT `FK_6FBC9426A76ED395` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
INSERT INTO `tags` VALUES (1,NULL,'perspiciatis',0,'2017-12-18 11:30:35','2017-12-18 11:30:35'),(2,NULL,'voluptas',0,'2017-12-18 11:30:35','2017-12-18 11:30:35'),(3,NULL,'dolor',0,'2017-12-18 11:30:35','2017-12-18 11:30:35'),(4,NULL,'veritatis',0,'2017-12-18 11:30:35','2017-12-18 11:30:35'),(5,NULL,'molestias',0,'2017-12-18 11:30:35','2017-12-18 11:30:35'),(6,NULL,'est',0,'2017-12-18 11:30:35','2017-12-18 11:30:35'),(7,NULL,'in',0,'2017-12-18 11:30:35','2017-12-18 11:30:35'),(8,NULL,'sed',0,'2017-12-18 11:30:35','2017-12-18 11:30:35'),(9,NULL,'qui',0,'2017-12-18 11:30:35','2017-12-18 11:30:35'),(10,NULL,'officiis',0,'2017-12-18 11:30:35','2017-12-18 11:30:35'),(11,NULL,'perspiciatis',0,'2017-12-18 11:30:35','2017-12-18 11:30:35'),(12,NULL,'velit',0,'2017-12-18 11:30:35','2017-12-18 11:30:35'),(13,NULL,'possimus',0,'2017-12-18 11:30:35','2017-12-18 11:30:35'),(14,NULL,'cum',0,'2017-12-18 11:30:35','2017-12-18 11:30:35'),(15,NULL,'ducimus',0,'2017-12-18 11:30:35','2017-12-18 11:30:35'),(16,NULL,'vitae',0,'2017-12-18 11:30:35','2017-12-18 11:30:35'),(17,NULL,'quam',0,'2017-12-18 11:30:35','2017-12-18 11:30:35'),(18,NULL,'omnis',0,'2017-12-18 11:30:35','2017-12-18 11:30:35'),(19,NULL,'ea',0,'2017-12-18 11:30:35','2017-12-18 11:30:35'),(20,NULL,'dolores',0,'2017-12-18 11:30:35','2017-12-18 11:30:35');
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbbc_money_doctrine_storage_ratios`
--

DROP TABLE IF EXISTS `tbbc_money_doctrine_storage_ratios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbbc_money_doctrine_storage_ratios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `currency_code` varchar(3) COLLATE utf8_unicode_ci NOT NULL,
  `ratio` double NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_1168A609FDA273EC` (`currency_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbbc_money_doctrine_storage_ratios`
--

LOCK TABLES `tbbc_money_doctrine_storage_ratios` WRITE;
/*!40000 ALTER TABLE `tbbc_money_doctrine_storage_ratios` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbbc_money_doctrine_storage_ratios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbbc_money_ratio_history`
--

DROP TABLE IF EXISTS `tbbc_money_ratio_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbbc_money_ratio_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `currency_code` varchar(3) COLLATE utf8_unicode_ci NOT NULL,
  `reference_currency_code` varchar(3) COLLATE utf8_unicode_ci NOT NULL,
  `ratio` double NOT NULL,
  `saved_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbbc_money_ratio_history`
--

LOCK TABLES `tbbc_money_ratio_history` WRITE;
/*!40000 ALTER TABLE `tbbc_money_ratio_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbbc_money_ratio_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `timeslice_tags`
--

DROP TABLE IF EXISTS `timeslice_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `timeslice_tags` (
  `timeslice_id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL,
  PRIMARY KEY (`timeslice_id`,`tag_id`),
  KEY `IDX_4231EEB94FB5678C` (`timeslice_id`),
  KEY `IDX_4231EEB9BAD26311` (`tag_id`),
  CONSTRAINT `FK_4231EEB94FB5678C` FOREIGN KEY (`timeslice_id`) REFERENCES `timeslices` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_4231EEB9BAD26311` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `timeslice_tags`
--

LOCK TABLES `timeslice_tags` WRITE;
/*!40000 ALTER TABLE `timeslice_tags` DISABLE KEYS */;
/*!40000 ALTER TABLE `timeslice_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `timeslices`
--

DROP TABLE IF EXISTS `timeslices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `timeslices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `activity_id` int(11) NOT NULL,
  `employee_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `value` decimal(10,4) NOT NULL,
  `started_at` datetime DEFAULT NULL,
  `stopped_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_72C53BF481C06096` (`activity_id`),
  KEY `IDX_72C53BF48C03F15C` (`employee_id`),
  KEY `IDX_72C53BF4A76ED395` (`user_id`),
  CONSTRAINT `FK_72C53BF481C06096` FOREIGN KEY (`activity_id`) REFERENCES `activities` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_72C53BF48C03F15C` FOREIGN KEY (`employee_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_72C53BF4A76ED395` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=402 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `timeslices`
--

LOCK TABLES `timeslices` WRITE;
/*!40000 ALTER TABLE `timeslices` DISABLE KEYS */;
INSERT INTO `timeslices` VALUES (1,2,7,2,7200.0000,'2017-10-26 05:57:59','2017-10-26 07:57:59','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(2,4,7,4,22072.0000,'2016-07-11 13:07:54','2016-07-11 19:15:46','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(3,5,16,5,6988.0000,'2016-03-17 05:08:14','2016-03-17 07:04:42','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(4,10,22,4,4716.0000,'2017-05-01 22:20:06','2017-05-01 23:38:42','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(5,8,19,4,10966.0000,'2016-09-16 21:53:13','2016-09-17 00:55:59','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(6,2,11,2,10094.0000,'2015-10-14 14:57:16','2015-10-14 17:45:30','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(7,6,22,5,21934.0000,'2015-12-31 07:20:27','2015-12-31 13:26:01','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(8,5,9,3,26661.0000,'2017-01-15 19:49:17','2017-01-16 03:13:38','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(9,8,18,5,25935.0000,'2017-02-10 04:39:18','2017-02-10 11:51:33','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(10,8,14,4,24318.0000,'2015-09-29 19:08:04','2015-09-30 01:53:22','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(11,11,13,5,19100.0000,'2015-12-03 19:00:39','2015-12-04 00:18:59','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(12,8,18,1,13178.0000,'2015-07-05 19:39:29','2015-07-05 23:19:07','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(13,3,25,1,21823.0000,'2015-05-08 19:36:19','2015-05-09 01:40:02','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(14,10,25,6,19892.0000,'2016-08-23 03:05:08','2016-08-23 08:36:40','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(15,3,19,2,10452.0000,'2016-11-26 13:25:45','2016-11-26 16:19:57','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(16,7,18,5,20524.0000,'2016-04-17 17:32:38','2016-04-17 23:14:42','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(17,9,14,2,14539.0000,'2016-11-09 02:12:17','2016-11-09 06:14:36','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(18,4,23,2,20016.0000,'2017-06-27 08:08:16','2017-06-27 13:41:52','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(19,11,21,6,16838.0000,'2017-06-06 10:55:30','2017-06-06 15:36:08','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(20,9,9,5,20465.0000,'2016-09-21 10:30:24','2016-09-21 16:11:29','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(21,6,22,5,16269.0000,'2015-09-12 14:47:42','2015-09-12 19:18:51','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(22,11,13,2,13902.0000,'2015-10-05 15:24:45','2015-10-05 19:16:27','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(23,5,12,2,13316.0000,'2017-04-20 08:36:09','2017-04-20 12:18:05','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(24,11,17,6,25400.0000,'2015-04-27 23:54:44','2015-04-28 06:58:04','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(25,10,10,1,22500.0000,'2015-06-08 08:14:44','2015-06-08 14:29:44','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(26,2,26,6,14647.0000,'2016-06-06 04:41:33','2016-06-06 08:45:40','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(27,7,17,6,19032.0000,'2015-04-26 01:19:54','2015-04-26 06:37:06','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(28,9,26,3,9291.0000,'2015-08-01 09:31:30','2015-08-01 12:06:21','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(29,3,8,2,9075.0000,'2015-10-08 16:49:48','2015-10-08 19:21:03','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(30,3,25,5,19834.0000,'2017-12-05 06:55:24','2017-12-05 12:25:58','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(31,7,24,4,10195.0000,'2016-07-17 12:09:33','2016-07-17 14:59:28','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(32,4,9,4,4891.0000,'2017-07-27 15:42:03','2017-07-27 17:03:34','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(33,8,26,4,6954.0000,'2015-03-31 06:58:49','2015-03-31 08:54:43','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(34,3,11,4,29842.0000,'2015-04-15 01:59:25','2015-04-15 10:16:47','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(35,11,11,1,27481.0000,'2017-06-02 16:01:26','2017-06-02 23:39:27','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(36,5,24,1,26931.0000,'2017-11-18 23:21:28','2017-11-19 06:50:19','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(37,11,23,5,17427.0000,'2017-02-21 01:43:54','2017-02-21 06:34:21','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(38,7,9,3,8132.0000,'2015-04-17 12:41:31','2015-04-17 14:57:03','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(39,5,23,1,4495.0000,'2016-08-10 02:32:51','2016-08-10 03:47:46','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(40,2,26,5,6427.0000,'2015-04-10 21:54:28','2015-04-10 23:41:35','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(41,7,8,5,15529.0000,'2017-10-20 08:32:38','2017-10-20 12:51:27','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(42,10,18,1,29308.0000,'2017-04-08 05:46:08','2017-04-08 13:54:36','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(43,7,15,5,10842.0000,'2016-06-10 15:03:43','2016-06-10 18:04:25','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(44,6,8,6,27588.0000,'2017-09-06 10:26:08','2017-09-06 18:05:56','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(45,2,10,3,14222.0000,'2017-09-21 07:54:27','2017-09-21 11:51:29','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(46,10,26,3,11491.0000,'2017-07-30 09:04:12','2017-07-30 12:15:43','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(47,6,23,3,16842.0000,'2017-11-02 07:24:07','2017-11-02 12:04:49','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(48,9,10,6,23946.0000,'2017-11-22 12:28:34','2017-11-22 19:07:40','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(49,2,19,1,6302.0000,'2015-09-12 20:57:59','2015-09-12 22:43:01','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(50,9,10,3,18759.0000,'2015-06-01 21:10:13','2015-06-02 02:22:52','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(51,9,16,6,13111.0000,'2017-11-06 10:53:59','2017-11-06 14:32:30','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(52,5,17,3,18773.0000,'2017-07-19 16:33:20','2017-07-19 21:46:13','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(53,10,11,2,25206.0000,'2016-03-03 02:56:20','2016-03-03 09:56:26','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(54,3,19,2,21292.0000,'2016-06-17 21:53:35','2016-06-18 03:48:27','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(55,2,24,6,9475.0000,'2017-11-03 18:14:49','2017-11-03 20:52:44','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(56,9,8,5,27957.0000,'2015-09-04 17:50:41','2015-09-05 01:36:38','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(57,9,23,3,13147.0000,'2017-07-20 10:33:27','2017-07-20 14:12:34','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(58,9,16,3,5734.0000,'2017-04-15 15:48:49','2017-04-15 17:24:23','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(59,8,23,1,22214.0000,'2016-05-29 18:51:07','2016-05-30 01:01:21','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(60,6,16,5,15001.0000,'2017-06-25 22:24:49','2017-06-26 02:34:50','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(61,7,22,2,8116.0000,'2017-03-16 20:52:39','2017-03-16 23:07:55','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(62,9,19,1,11196.0000,'2017-04-24 09:18:06','2017-04-24 12:24:42','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(63,3,9,4,12944.0000,'2016-06-01 09:30:10','2016-06-01 13:05:54','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(64,3,22,6,23526.0000,'2017-06-25 10:17:09','2017-06-25 16:49:15','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(65,2,18,5,6968.0000,'2017-01-25 03:29:21','2017-01-25 05:25:29','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(66,2,24,2,8773.0000,'2016-01-08 17:24:12','2016-01-08 19:50:25','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(67,6,24,4,21099.0000,'2017-03-04 06:40:05','2017-03-04 12:31:44','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(68,4,15,1,27248.0000,'2017-05-26 23:28:59','2017-05-27 07:03:07','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(69,4,25,2,23030.0000,'2017-04-05 21:52:27','2017-04-06 04:16:17','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(70,9,19,5,24836.0000,'2016-04-26 09:17:44','2016-04-26 16:11:40','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(71,11,14,6,14111.0000,'2017-08-22 01:43:30','2017-08-22 05:38:41','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(72,7,12,3,14496.0000,'2016-01-08 02:10:25','2016-01-08 06:12:01','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(73,8,24,6,4022.0000,'2017-11-15 22:24:10','2017-11-15 23:31:12','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(74,11,25,2,27410.0000,'2017-05-09 02:54:05','2017-05-09 10:30:55','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(75,3,25,6,9788.0000,'2017-07-02 21:39:37','2017-07-03 00:22:45','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(76,3,10,1,20469.0000,'2015-08-31 13:18:58','2015-08-31 19:00:07','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(77,5,7,3,27725.0000,'2017-07-16 08:14:28','2017-07-16 15:56:33','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(78,10,19,5,21410.0000,'2016-11-15 19:11:24','2016-11-16 01:08:14','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(79,10,18,4,10725.0000,'2017-04-16 02:27:42','2017-04-16 05:26:27','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(80,8,26,3,21522.0000,'2017-08-25 07:35:06','2017-08-25 13:33:48','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(81,9,7,3,14041.0000,'2017-04-23 05:54:24','2017-04-23 09:48:25','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(82,6,24,4,29059.0000,'2017-07-15 19:37:38','2017-07-16 03:41:57','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(83,7,15,3,6366.0000,'2017-03-17 02:09:54','2017-03-17 03:56:00','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(84,8,24,2,20695.0000,'2017-12-16 04:40:34','2017-12-16 10:25:29','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(85,11,24,3,26465.0000,'2015-07-05 10:31:33','2015-07-05 17:52:38','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(86,2,21,4,14585.0000,'2015-08-26 12:59:18','2015-08-26 17:02:23','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(87,11,25,5,9492.0000,'2017-05-12 16:22:58','2017-05-12 19:01:10','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(88,6,10,3,16809.0000,'2016-11-27 14:22:50','2016-11-27 19:02:59','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(89,11,16,2,9552.0000,'2017-02-26 07:27:35','2017-02-26 10:06:47','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(90,5,22,1,4902.0000,'2017-09-11 01:10:17','2017-09-11 02:31:59','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(91,7,21,3,25074.0000,'2017-12-02 21:19:15','2017-12-03 04:17:09','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(92,11,21,3,6643.0000,'2017-03-29 21:07:22','2017-03-29 22:58:05','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(93,2,13,5,3681.0000,'2015-07-05 14:55:16','2015-07-05 15:56:37','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(94,7,12,2,8562.0000,'2015-08-25 06:16:46','2015-08-25 08:39:28','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(95,3,7,2,21528.0000,'2015-12-28 08:11:23','2015-12-28 14:10:11','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(96,10,18,3,12428.0000,'2017-08-13 17:45:52','2017-08-13 21:13:00','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(97,2,19,3,19300.0000,'2016-03-22 06:29:41','2016-03-22 11:51:21','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(98,9,15,3,23420.0000,'2017-05-03 17:06:28','2017-05-03 23:36:48','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(99,9,13,6,7382.0000,'2017-03-04 06:03:26','2017-03-04 08:06:28','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(100,5,21,2,26241.0000,'2017-07-17 19:55:35','2017-07-18 03:12:56','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(101,11,23,5,19878.0000,'2017-09-19 18:37:26','2017-09-20 00:08:44','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(102,21,19,4,30240.0000,'2017-07-24 18:54:50','2017-07-25 03:18:50','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(103,16,18,6,30240.0000,'2017-05-10 02:58:26','2017-05-10 11:22:26','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(104,15,11,4,30240.0000,'2016-09-15 09:42:34','2016-09-15 18:06:34','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(105,15,9,4,30240.0000,'2016-05-04 14:00:17','2016-05-04 22:24:17','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(106,13,23,1,30240.0000,'2017-11-28 08:33:53','2017-11-28 16:57:53','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(107,16,15,3,30240.0000,'2016-01-31 07:31:05','2016-01-31 15:55:05','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(108,17,16,2,30240.0000,'2016-12-18 15:45:50','2016-12-19 00:09:50','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(109,21,16,5,30240.0000,'2017-06-13 13:17:12','2017-06-13 21:41:12','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(110,14,13,5,30240.0000,'2016-07-21 09:51:18','2016-07-21 18:15:18','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(111,15,19,6,30240.0000,'2015-12-15 17:39:18','2015-12-16 02:03:18','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(112,12,8,1,30240.0000,'2016-06-11 23:58:56','2016-06-12 08:22:56','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(113,14,24,3,30240.0000,'2017-04-29 10:10:52','2017-04-29 18:34:52','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(114,16,22,5,30240.0000,'2016-10-07 08:49:22','2016-10-07 17:13:22','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(115,13,20,2,30240.0000,'2016-09-11 06:35:51','2016-09-11 14:59:51','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(116,17,16,5,30240.0000,'2015-05-03 06:48:21','2015-05-03 15:12:21','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(117,20,18,1,30240.0000,'2015-05-15 17:37:39','2015-05-16 02:01:39','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(118,13,13,6,30240.0000,'2017-12-17 20:47:42','2017-12-18 05:11:42','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(119,21,13,6,30240.0000,'2016-01-28 06:49:49','2016-01-28 15:13:49','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(120,19,11,1,30240.0000,'2015-05-24 15:49:33','2015-05-25 00:13:33','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(121,15,7,1,30240.0000,'2015-07-07 23:58:03','2015-07-08 08:22:03','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(122,19,21,2,30240.0000,'2017-08-24 14:04:05','2017-08-24 22:28:05','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(123,18,12,2,30240.0000,'2017-10-30 17:45:02','2017-10-31 02:09:02','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(124,19,21,4,30240.0000,'2015-11-29 11:50:48','2015-11-29 20:14:48','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(125,13,8,1,30240.0000,'2015-07-14 21:09:48','2015-07-15 05:33:48','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(126,20,26,1,30240.0000,'2017-09-19 08:24:41','2017-09-19 16:48:41','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(127,18,25,5,30240.0000,'2017-07-19 15:34:37','2017-07-19 23:58:37','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(128,19,8,4,30240.0000,'2015-08-11 21:55:36','2015-08-12 06:19:36','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(129,21,15,2,30240.0000,'2017-04-24 11:45:14','2017-04-24 20:09:14','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(130,21,13,3,30240.0000,'2017-01-05 13:36:54','2017-01-05 22:00:54','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(131,17,19,4,30240.0000,'2017-02-22 02:28:17','2017-02-22 10:52:17','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(132,12,19,4,30240.0000,'2017-09-01 02:43:34','2017-09-01 11:07:34','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(133,18,16,3,30240.0000,'2015-07-27 18:02:35','2015-07-28 02:26:35','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(134,16,12,4,30240.0000,'2015-12-18 14:03:57','2015-12-18 22:27:57','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(135,17,11,6,30240.0000,'2017-06-25 12:08:09','2017-06-25 20:32:09','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(136,15,22,3,30240.0000,'2016-02-02 19:27:08','2016-02-03 03:51:08','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(137,20,7,3,30240.0000,'2016-02-20 19:54:38','2016-02-21 04:18:38','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(138,12,21,4,30240.0000,'2015-05-11 12:59:40','2015-05-11 21:23:40','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(139,12,19,6,30240.0000,'2015-08-18 03:25:00','2015-08-18 11:49:00','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(140,12,15,5,30240.0000,'2016-01-08 14:12:00','2016-01-08 22:36:00','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(141,19,12,5,30240.0000,'2016-07-27 17:06:16','2016-07-28 01:30:16','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(142,15,10,6,30240.0000,'2016-11-05 22:01:48','2016-11-06 06:25:48','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(143,21,24,5,30240.0000,'2017-03-22 16:38:50','2017-03-23 01:02:50','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(144,13,18,5,30240.0000,'2017-04-06 09:10:44','2017-04-06 17:34:44','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(145,13,13,4,30240.0000,'2016-11-29 06:20:27','2016-11-29 14:44:27','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(146,16,21,6,30240.0000,'2015-07-12 08:55:47','2015-07-12 17:19:47','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(147,12,10,6,30240.0000,'2015-11-17 05:39:38','2015-11-17 14:03:38','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(148,15,23,3,30240.0000,'2015-07-04 15:32:55','2015-07-04 23:56:55','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(149,18,17,1,30240.0000,'2015-09-01 14:56:00','2015-09-01 23:20:00','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(150,20,9,6,30240.0000,'2017-11-09 04:12:39','2017-11-09 12:36:39','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(151,15,12,1,30240.0000,'2015-04-14 14:22:35','2015-04-14 22:46:35','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(152,21,21,5,30240.0000,'2015-07-26 05:44:53','2015-07-26 14:08:53','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(153,20,20,2,30240.0000,'2015-11-10 06:53:08','2015-11-10 15:17:08','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(154,16,22,5,30240.0000,'2015-06-11 03:34:07','2015-06-11 11:58:07','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(155,20,8,6,30240.0000,'2016-12-12 02:30:58','2016-12-12 10:54:58','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(156,18,24,5,30240.0000,'2017-03-22 09:04:45','2017-03-22 17:28:45','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(157,14,19,3,30240.0000,'2015-10-04 21:10:26','2015-10-05 05:34:26','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(158,21,22,4,30240.0000,'2017-06-05 19:06:50','2017-06-06 03:30:50','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(159,13,25,4,30240.0000,'2015-12-12 16:22:21','2015-12-13 00:46:21','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(160,12,8,3,30240.0000,'2015-06-09 05:31:03','2015-06-09 13:55:03','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(161,12,24,6,30240.0000,'2015-11-01 08:29:39','2015-11-01 16:53:39','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(162,19,16,4,30240.0000,'2017-04-30 20:02:02','2017-05-01 04:26:02','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(163,13,13,4,30240.0000,'2016-12-20 19:03:26','2016-12-21 03:27:26','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(164,14,17,4,30240.0000,'2015-11-14 01:30:01','2015-11-14 09:54:01','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(165,21,24,5,30240.0000,'2017-12-06 05:06:15','2017-12-06 13:30:15','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(166,15,11,4,30240.0000,'2016-01-07 03:51:40','2016-01-07 12:15:40','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(167,12,20,4,30240.0000,'2016-01-11 02:30:41','2016-01-11 10:54:41','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(168,15,25,5,30240.0000,'2015-04-28 07:14:02','2015-04-28 15:38:02','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(169,17,9,2,30240.0000,'2016-06-16 20:09:32','2016-06-17 04:33:32','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(170,16,8,6,30240.0000,'2017-09-13 13:03:26','2017-09-13 21:27:26','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(171,18,15,6,30240.0000,'2016-06-18 11:22:19','2016-06-18 19:46:19','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(172,20,26,2,30240.0000,'2017-07-13 21:36:11','2017-07-14 06:00:11','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(173,12,24,5,30240.0000,'2015-12-29 13:38:56','2015-12-29 22:02:56','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(174,20,16,4,30240.0000,'2016-10-14 15:09:35','2016-10-14 23:33:35','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(175,14,9,6,30240.0000,'2017-01-13 17:37:32','2017-01-14 02:01:32','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(176,15,14,5,30240.0000,'2015-07-19 08:07:36','2015-07-19 16:31:36','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(177,16,24,1,30240.0000,'2016-08-25 05:57:55','2016-08-25 14:21:55','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(178,14,23,4,30240.0000,'2015-11-26 15:43:21','2015-11-27 00:07:21','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(179,14,17,3,30240.0000,'2017-06-19 23:16:42','2017-06-20 07:40:42','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(180,17,23,6,30240.0000,'2016-09-13 05:38:13','2016-09-13 14:02:13','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(181,14,23,3,30240.0000,'2015-10-26 09:32:53','2015-10-26 17:56:53','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(182,15,17,1,30240.0000,'2016-01-09 19:21:04','2016-01-10 03:45:04','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(183,18,11,6,30240.0000,'2017-02-10 16:17:20','2017-02-11 00:41:20','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(184,18,9,1,30240.0000,'2015-12-01 14:22:59','2015-12-01 22:46:59','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(185,18,23,4,30240.0000,'2015-06-01 02:18:01','2015-06-01 10:42:01','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(186,13,21,1,30240.0000,'2015-11-15 18:26:54','2015-11-16 02:50:54','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(187,18,23,5,30240.0000,'2017-09-16 19:47:59','2017-09-17 04:11:59','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(188,18,20,5,30240.0000,'2017-05-11 14:48:34','2017-05-11 23:12:34','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(189,15,25,2,30240.0000,'2016-11-20 23:06:11','2016-11-21 07:30:11','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(190,19,19,4,30240.0000,'2015-12-22 02:02:31','2015-12-22 10:26:31','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(191,15,24,6,30240.0000,'2015-10-10 16:07:50','2015-10-11 00:31:50','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(192,18,12,4,30240.0000,'2015-12-18 06:27:28','2015-12-18 14:51:28','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(193,20,14,6,30240.0000,'2017-06-29 09:46:44','2017-06-29 18:10:44','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(194,21,25,5,30240.0000,'2016-06-03 19:37:01','2016-06-04 04:01:01','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(195,19,8,6,30240.0000,'2017-09-08 03:38:22','2017-09-08 12:02:22','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(196,17,7,5,30240.0000,'2017-09-05 18:50:43','2017-09-06 03:14:43','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(197,12,19,4,30240.0000,'2015-08-31 18:00:24','2015-09-01 02:24:24','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(198,19,21,4,30240.0000,'2015-06-27 08:00:35','2015-06-27 16:24:35','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(199,13,23,6,30240.0000,'2016-07-03 18:10:36','2016-07-04 02:34:36','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(200,15,16,2,30240.0000,'2017-04-04 12:53:00','2017-04-04 21:17:00','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(201,12,18,6,30240.0000,'2017-10-13 12:16:27','2017-10-13 20:40:27','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(202,24,7,6,153.0000,'2015-09-27 02:44:56','2015-09-27 02:47:29','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(203,27,10,1,189.0000,'2017-04-18 10:47:17','2017-04-18 10:50:26','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(204,31,17,6,22.0000,'2017-07-03 21:24:04','2017-07-03 21:24:26','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(205,27,22,6,66.0000,'2016-06-16 05:07:20','2016-06-16 05:08:26','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(206,27,9,1,188.0000,'2015-05-19 15:20:58','2015-05-19 15:24:06','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(207,26,25,5,145.0000,'2015-11-30 08:47:50','2015-11-30 08:50:15','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(208,26,26,4,42.0000,'2017-06-28 02:53:52','2017-06-28 02:54:34','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(209,25,19,1,150.0000,'2016-01-10 09:04:37','2016-01-10 09:07:07','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(210,28,9,4,91.0000,'2016-08-29 18:35:56','2016-08-29 18:37:27','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(211,29,11,4,153.0000,'2015-04-01 02:54:41','2015-04-01 02:57:14','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(212,27,17,3,197.0000,'2017-03-04 22:20:30','2017-03-04 22:23:47','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(213,24,24,1,137.0000,'2016-10-09 04:41:14','2016-10-09 04:43:31','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(214,30,16,3,63.0000,'2017-06-23 23:53:33','2017-06-23 23:54:36','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(215,28,7,2,4.0000,'2016-03-01 13:02:17','2016-03-01 13:02:21','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(216,28,19,5,160.0000,'2017-06-09 12:32:10','2017-06-09 12:34:50','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(217,25,20,1,125.0000,'2016-10-12 18:24:00','2016-10-12 18:26:05','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(218,31,20,5,18.0000,'2017-07-05 08:03:00','2017-07-05 08:03:18','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(219,22,26,3,147.0000,'2017-09-25 12:57:58','2017-09-25 13:00:25','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(220,23,9,6,81.0000,'2015-03-30 10:43:22','2015-03-30 10:44:43','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(221,25,26,1,146.0000,'2016-05-03 12:20:32','2016-05-03 12:22:58','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(222,29,26,1,122.0000,'2015-07-21 12:36:28','2015-07-21 12:38:30','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(223,28,12,3,25.0000,'2016-10-14 05:56:42','2016-10-14 05:57:07','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(224,29,7,2,125.0000,'2016-12-17 01:34:50','2016-12-17 01:36:55','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(225,30,17,4,195.0000,'2017-02-26 13:49:23','2017-02-26 13:52:38','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(226,30,26,5,59.0000,'2017-01-16 15:18:29','2017-01-16 15:19:28','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(227,22,12,2,41.0000,'2017-04-07 19:03:08','2017-04-07 19:03:49','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(228,30,15,2,4.0000,'2016-03-01 23:54:45','2016-03-01 23:54:49','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(229,26,23,1,141.0000,'2015-07-08 09:29:48','2015-07-08 09:32:09','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(230,27,8,3,6.0000,'2015-08-24 04:08:41','2015-08-24 04:08:47','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(231,27,17,3,78.0000,'2015-05-14 13:13:19','2015-05-14 13:14:37','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(232,30,17,1,76.0000,'2015-06-13 05:36:57','2015-06-13 05:38:13','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(233,28,7,5,14.0000,'2016-12-18 15:11:54','2016-12-18 15:12:08','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(234,27,26,5,195.0000,'2017-06-08 09:06:56','2017-06-08 09:10:11','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(235,30,20,1,6.0000,'2016-01-12 08:43:22','2016-01-12 08:43:28','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(236,30,18,2,1.0000,'2016-03-29 23:50:56','2016-03-29 23:50:57','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(237,30,17,5,26.0000,'2017-08-29 11:47:21','2017-08-29 11:47:47','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(238,31,25,3,75.0000,'2016-03-03 06:47:06','2016-03-03 06:48:21','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(239,22,19,5,114.0000,'2017-10-14 09:35:29','2017-10-14 09:37:23','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(240,22,12,3,135.0000,'2017-03-15 10:57:00','2017-03-15 10:59:15','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(241,23,20,4,67.0000,'2016-01-14 11:23:12','2016-01-14 11:24:19','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(242,28,10,4,70.0000,'2016-09-14 22:25:49','2016-09-14 22:26:59','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(243,27,13,6,123.0000,'2016-09-23 05:29:48','2016-09-23 05:31:51','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(244,22,19,4,183.0000,'2017-03-20 04:12:17','2017-03-20 04:15:20','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(245,22,21,1,117.0000,'2015-09-13 13:55:12','2015-09-13 13:57:09','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(246,29,18,6,67.0000,'2015-11-05 18:40:19','2015-11-05 18:41:26','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(247,24,17,2,18.0000,'2016-02-21 22:49:33','2016-02-21 22:49:51','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(248,24,9,1,62.0000,'2017-10-09 23:44:27','2017-10-09 23:45:29','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(249,31,23,6,3.0000,'2017-11-05 04:12:49','2017-11-05 04:12:52','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(250,27,8,2,118.0000,'2017-08-19 13:38:01','2017-08-19 13:39:59','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(251,31,25,3,124.0000,'2016-08-03 03:38:57','2016-08-03 03:41:01','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(252,29,26,3,192.0000,'2015-05-13 14:26:00','2015-05-13 14:29:12','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(253,22,10,5,138.0000,'2016-01-04 18:07:41','2016-01-04 18:09:59','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(254,28,11,3,153.0000,'2016-12-10 01:30:34','2016-12-10 01:33:07','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(255,26,13,2,94.0000,'2016-12-13 04:32:05','2016-12-13 04:33:39','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(256,29,11,3,8.0000,'2015-05-11 01:37:52','2015-05-11 01:38:00','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(257,31,15,3,110.0000,'2015-08-08 14:50:09','2015-08-08 14:51:59','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(258,31,15,4,93.0000,'2017-02-11 08:30:58','2017-02-11 08:32:31','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(259,28,9,5,86.0000,'2016-08-07 03:48:54','2016-08-07 03:50:20','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(260,23,21,2,143.0000,'2017-11-23 18:19:19','2017-11-23 18:21:42','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(261,24,15,1,54.0000,'2016-06-06 21:50:24','2016-06-06 21:51:18','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(262,25,14,2,142.0000,'2016-04-13 05:10:54','2016-04-13 05:13:16','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(263,26,24,6,130.0000,'2016-05-02 06:36:19','2016-05-02 06:38:29','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(264,29,10,1,199.0000,'2015-09-30 09:31:44','2015-09-30 09:35:03','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(265,24,15,1,125.0000,'2015-11-27 01:47:37','2015-11-27 01:49:42','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(266,31,8,4,110.0000,'2017-05-16 11:26:18','2017-05-16 11:28:08','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(267,24,8,1,131.0000,'2016-05-29 10:55:56','2016-05-29 10:58:07','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(268,26,12,3,142.0000,'2015-06-22 23:33:35','2015-06-22 23:35:57','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(269,23,23,5,168.0000,'2016-08-29 05:18:30','2016-08-29 05:21:18','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(270,25,15,2,97.0000,'2017-08-21 04:28:07','2017-08-21 04:29:44','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(271,30,8,4,63.0000,'2017-03-14 22:27:17','2017-03-14 22:28:20','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(272,27,8,4,55.0000,'2017-08-20 05:12:21','2017-08-20 05:13:16','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(273,25,9,1,192.0000,'2017-02-14 06:11:46','2017-02-14 06:14:58','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(274,28,24,3,37.0000,'2016-01-10 02:06:03','2016-01-10 02:06:40','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(275,29,26,6,75.0000,'2015-12-22 04:08:39','2015-12-22 04:09:54','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(276,26,23,6,133.0000,'2015-08-07 14:43:52','2015-08-07 14:46:05','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(277,27,24,4,146.0000,'2017-03-04 16:07:34','2017-03-04 16:10:00','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(278,25,22,6,13.0000,'2016-07-29 13:47:48','2016-07-29 13:48:01','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(279,23,13,6,181.0000,'2016-05-29 05:25:23','2016-05-29 05:28:24','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(280,27,8,4,93.0000,'2016-03-29 04:07:23','2016-03-29 04:08:56','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(281,24,23,2,185.0000,'2016-12-26 16:04:12','2016-12-26 16:07:17','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(282,25,22,1,80.0000,'2015-12-16 06:04:08','2015-12-16 06:05:28','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(283,23,23,4,62.0000,'2016-03-26 14:48:58','2016-03-26 14:50:00','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(284,22,14,6,158.0000,'2016-03-27 23:26:35','2016-03-27 23:29:13','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(285,22,24,3,143.0000,'2016-05-02 06:41:39','2016-05-02 06:44:02','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(286,30,7,3,185.0000,'2015-10-18 01:52:13','2015-10-18 01:55:18','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(287,23,21,2,99.0000,'2015-09-20 19:25:11','2015-09-20 19:26:50','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(288,29,13,2,43.0000,'2017-08-30 18:25:23','2017-08-30 18:26:06','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(289,31,15,5,175.0000,'2015-05-29 23:28:12','2015-05-29 23:31:07','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(290,29,18,6,187.0000,'2016-12-06 12:43:31','2016-12-06 12:46:38','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(291,29,22,3,97.0000,'2015-08-29 20:20:33','2015-08-29 20:22:10','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(292,25,17,6,83.0000,'2015-11-23 08:44:10','2015-11-23 08:45:33','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(293,30,24,2,17.0000,'2017-08-20 14:16:52','2017-08-20 14:17:09','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(294,27,12,3,149.0000,'2017-05-03 01:05:33','2017-05-03 01:08:02','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(295,24,15,5,17.0000,'2016-04-26 17:15:09','2016-04-26 17:15:26','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(296,30,22,5,120.0000,'2017-04-16 04:27:12','2017-04-16 04:29:12','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(297,24,10,6,27.0000,'2016-06-16 05:22:04','2016-06-16 05:22:31','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(298,27,12,3,14.0000,'2016-05-17 13:57:35','2016-05-17 13:57:49','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(299,24,22,4,155.0000,'2017-11-20 02:11:23','2017-11-20 02:13:58','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(300,26,16,3,83.0000,'2015-05-25 06:18:06','2015-05-25 06:19:29','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(301,26,19,1,140.0000,'2017-07-02 01:59:54','2017-07-02 02:02:14','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(302,40,21,1,1.0000,'2017-03-24 10:03:27','2017-03-24 10:03:28','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(303,38,16,3,1.0000,'2017-07-21 06:46:23','2017-07-21 06:46:24','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(304,33,22,4,1.0000,'2016-12-16 10:08:53','2016-12-16 10:08:54','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(305,39,12,3,1.0000,'2017-02-08 13:40:59','2017-02-08 13:41:00','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(306,37,16,1,1.0000,'2017-04-21 04:23:07','2017-04-21 04:23:08','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(307,34,7,1,1.0000,'2017-05-28 03:50:39','2017-05-28 03:50:40','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(308,37,12,5,1.0000,'2015-06-04 10:20:46','2015-06-04 10:20:47','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(309,36,24,1,1.0000,'2015-12-17 12:00:03','2015-12-17 12:00:04','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(310,40,26,5,1.0000,'2016-08-13 13:28:05','2016-08-13 13:28:06','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(311,32,10,2,1.0000,'2017-05-13 02:59:05','2017-05-13 02:59:06','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(312,37,12,6,1.0000,'2017-09-14 16:45:54','2017-09-14 16:45:55','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(313,34,21,6,1.0000,'2017-04-28 15:32:28','2017-04-28 15:32:29','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(314,39,19,4,1.0000,'2017-11-20 04:13:41','2017-11-20 04:13:42','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(315,38,17,5,1.0000,'2016-06-25 07:49:21','2016-06-25 07:49:22','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(316,32,25,5,1.0000,'2016-04-26 21:49:22','2016-04-26 21:49:23','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(317,38,19,2,1.0000,'2015-10-18 21:45:19','2015-10-18 21:45:20','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(318,38,14,1,1.0000,'2016-10-17 18:13:28','2016-10-17 18:13:29','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(319,34,24,3,1.0000,'2017-06-10 09:48:30','2017-06-10 09:48:31','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(320,38,26,1,1.0000,'2017-01-05 05:31:24','2017-01-05 05:31:25','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(321,37,22,5,1.0000,'2016-11-02 19:30:55','2016-11-02 19:30:56','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(322,38,19,5,1.0000,'2017-12-17 21:48:02','2017-12-17 21:48:03','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(323,33,9,5,1.0000,'2015-05-30 18:27:16','2015-05-30 18:27:17','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(324,40,26,2,1.0000,'2016-12-05 22:38:24','2016-12-05 22:38:25','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(325,33,24,4,1.0000,'2016-11-24 14:50:29','2016-11-24 14:50:30','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(326,39,23,1,1.0000,'2015-08-05 10:16:54','2015-08-05 10:16:55','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(327,32,23,3,1.0000,'2016-07-22 06:00:28','2016-07-22 06:00:29','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(328,35,17,5,1.0000,'2015-10-11 16:42:30','2015-10-11 16:42:31','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(329,34,7,2,1.0000,'2015-11-23 17:20:50','2015-11-23 17:20:51','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(330,33,9,3,1.0000,'2017-02-12 10:24:02','2017-02-12 10:24:03','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(331,32,8,3,1.0000,'2017-09-08 19:00:08','2017-09-08 19:00:09','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(332,32,21,3,1.0000,'2017-09-26 20:47:20','2017-09-26 20:47:21','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(333,38,9,1,1.0000,'2016-11-11 13:02:40','2016-11-11 13:02:41','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(334,32,25,6,1.0000,'2015-07-20 22:40:02','2015-07-20 22:40:03','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(335,38,17,1,1.0000,'2017-01-21 04:57:32','2017-01-21 04:57:33','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(336,38,14,5,1.0000,'2016-01-04 03:54:06','2016-01-04 03:54:07','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(337,36,26,1,1.0000,'2016-01-01 04:00:30','2016-01-01 04:00:31','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(338,38,21,2,1.0000,'2015-06-17 14:40:04','2015-06-17 14:40:05','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(339,34,22,2,1.0000,'2016-04-12 10:04:28','2016-04-12 10:04:29','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(340,41,13,3,1.0000,'2017-03-03 15:34:21','2017-03-03 15:34:22','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(341,32,11,3,1.0000,'2016-12-06 15:50:27','2016-12-06 15:50:28','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(342,33,11,2,1.0000,'2017-11-21 19:55:49','2017-11-21 19:55:50','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(343,41,22,5,1.0000,'2016-01-01 08:29:38','2016-01-01 08:29:39','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(344,35,25,3,1.0000,'2017-08-15 07:13:07','2017-08-15 07:13:08','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(345,41,22,3,1.0000,'2017-09-04 13:22:28','2017-09-04 13:22:29','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(346,33,20,2,1.0000,'2016-04-09 23:57:53','2016-04-09 23:57:54','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(347,35,22,5,1.0000,'2017-10-31 03:13:45','2017-10-31 03:13:46','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(348,38,26,4,1.0000,'2017-07-01 12:59:32','2017-07-01 12:59:33','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(349,39,21,1,1.0000,'2016-06-19 04:44:42','2016-06-19 04:44:43','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(350,37,13,5,1.0000,'2015-12-30 17:57:36','2015-12-30 17:57:37','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(351,38,17,4,1.0000,'2017-02-02 11:05:09','2017-02-02 11:05:10','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(352,32,25,6,1.0000,'2015-05-15 17:42:43','2015-05-15 17:42:44','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(353,38,10,4,1.0000,'2016-09-26 11:23:24','2016-09-26 11:23:25','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(354,35,14,2,1.0000,'2015-10-25 08:15:04','2015-10-25 08:15:05','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(355,37,25,5,1.0000,'2017-10-10 13:27:44','2017-10-10 13:27:45','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(356,39,10,1,1.0000,'2015-09-18 05:23:59','2015-09-18 05:24:00','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(357,32,7,3,1.0000,'2017-05-05 02:41:19','2017-05-05 02:41:20','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(358,32,22,3,1.0000,'2017-03-02 21:43:49','2017-03-02 21:43:50','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(359,38,13,4,1.0000,'2017-02-15 13:06:14','2017-02-15 13:06:15','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(360,39,9,2,1.0000,'2016-05-03 15:40:44','2016-05-03 15:40:45','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(361,39,8,1,1.0000,'2017-08-04 02:49:52','2017-08-04 02:49:53','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(362,41,23,5,1.0000,'2015-06-29 03:33:04','2015-06-29 03:33:05','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(363,41,14,5,1.0000,'2016-03-31 20:11:26','2016-03-31 20:11:27','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(364,32,19,1,1.0000,'2017-11-29 16:38:01','2017-11-29 16:38:02','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(365,34,19,1,1.0000,'2016-09-02 07:28:24','2016-09-02 07:28:25','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(366,41,11,6,1.0000,'2016-12-20 09:10:02','2016-12-20 09:10:03','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(367,35,23,1,1.0000,'2015-05-13 07:06:37','2015-05-13 07:06:38','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(368,39,21,4,1.0000,'2015-09-28 12:47:37','2015-09-28 12:47:38','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(369,33,18,2,1.0000,'2016-11-11 15:28:53','2016-11-11 15:28:54','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(370,41,16,1,1.0000,'2015-08-23 18:34:42','2015-08-23 18:34:43','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(371,41,25,1,1.0000,'2015-07-03 04:49:46','2015-07-03 04:49:47','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(372,32,9,1,1.0000,'2016-08-17 05:42:46','2016-08-17 05:42:47','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(373,34,16,6,1.0000,'2017-01-24 21:27:59','2017-01-24 21:28:00','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(374,40,17,2,1.0000,'2017-11-10 22:30:16','2017-11-10 22:30:17','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(375,36,16,6,1.0000,'2016-08-07 16:29:05','2016-08-07 16:29:06','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(376,35,16,4,1.0000,'2016-07-01 15:20:43','2016-07-01 15:20:44','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(377,32,8,3,1.0000,'2015-07-13 14:25:47','2015-07-13 14:25:48','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(378,38,13,6,1.0000,'2015-06-06 02:32:22','2015-06-06 02:32:23','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(379,38,24,5,1.0000,'2015-11-05 12:03:13','2015-11-05 12:03:14','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(380,33,9,3,1.0000,'2016-09-11 01:59:59','2016-09-11 02:00:00','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(381,38,13,1,1.0000,'2017-10-29 08:23:05','2017-10-29 08:23:06','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(382,34,9,3,1.0000,'2017-01-25 01:34:36','2017-01-25 01:34:37','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(383,41,24,3,1.0000,'2016-04-01 16:02:41','2016-04-01 16:02:42','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(384,37,26,1,1.0000,'2015-08-21 23:36:04','2015-08-21 23:36:05','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(385,35,8,4,1.0000,'2015-07-06 11:22:40','2015-07-06 11:22:41','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(386,40,20,4,1.0000,'2016-09-20 16:06:36','2016-09-20 16:06:37','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(387,36,14,1,1.0000,'2016-04-26 03:53:15','2016-04-26 03:53:16','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(388,33,13,4,1.0000,'2017-09-14 22:08:57','2017-09-14 22:08:58','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(389,39,11,4,1.0000,'2016-04-04 04:58:15','2016-04-04 04:58:16','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(390,33,19,1,1.0000,'2016-07-24 20:51:37','2016-07-24 20:51:38','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(391,38,10,2,1.0000,'2016-09-06 03:28:53','2016-09-06 03:28:54','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(392,33,11,5,1.0000,'2016-08-02 13:16:16','2016-08-02 13:16:17','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(393,40,16,6,1.0000,'2017-08-29 04:32:30','2017-08-29 04:32:31','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(394,41,17,2,1.0000,'2016-03-18 09:05:44','2016-03-18 09:05:45','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(395,35,12,6,1.0000,'2017-04-26 15:00:45','2017-04-26 15:00:46','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(396,34,26,4,1.0000,'2017-07-07 16:38:19','2017-07-07 16:38:20','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(397,41,14,5,1.0000,'2015-07-06 01:06:42','2015-07-06 01:06:43','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(398,37,15,6,1.0000,'2017-02-13 05:24:27','2017-02-13 05:24:28','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(399,35,16,4,1.0000,'2017-03-20 13:51:10','2017-03-20 13:51:11','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(400,40,14,6,1.0000,'2017-05-19 17:14:12','2017-05-19 17:14:13','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL),(401,36,11,6,1.0000,'2015-04-10 12:32:29','2015-04-10 12:32:30','2017-12-18 11:30:36','2017-12-18 11:30:36',NULL);
/*!40000 ALTER TABLE `timeslices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(180) COLLATE utf8_unicode_ci NOT NULL,
  `username_canonical` varchar(180) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(180) COLLATE utf8_unicode_ci NOT NULL,
  `email_canonical` varchar(180) COLLATE utf8_unicode_ci NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `salt` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `last_login` datetime DEFAULT NULL,
  `confirmation_token` varchar(180) COLLATE utf8_unicode_ci DEFAULT NULL,
  `password_requested_at` datetime DEFAULT NULL,
  `roles` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT '(DC2Type:array)',
  `firstname` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lastname` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `employeeholiday` int(11) DEFAULT NULL,
  `discr` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `extend_timetrack` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_1483A5E992FC23A8` (`username_canonical`),
  UNIQUE KEY `UNIQ_1483A5E9A0D96FBF` (`email_canonical`),
  UNIQUE KEY `UNIQ_1483A5E9C05FB297` (`confirmation_token`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin','admin','admin@example.com','admin@example.com',1,'uy9I5rZ5p3iGferOeweHK.gv3lpQIJHQ564I3EqGifY','ft9f/KCnJfWTrCz7LgcAoOckDrMrxu3nQqfg1KqhB0DdGNVich2xOseHfR5Ksa5NgWtuzUoeKARyf2qiRJ5clQ==',NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}','Default','User','2017-12-18 11:30:34','2017-12-18 11:30:34',20,'employee',1),(2,'otto.albrecht','otto.albrecht','berthold.albrecht@schubert.com','berthold.albrecht@schubert.com',1,'3IkjQ9MuEo3komN7Fc2tJ4PUL79rUR6FozZa3pVy4bI','oGFyHiNkwx91P6RUuO8/sRgPe2H7fzDF0srkiptgUrnfib5a81Gnpe1DCIQKE47UgQ9anWhoFKOOcRjjDjOEHw==',NULL,NULL,NULL,'a:0:{}','Helge','Reimann','2017-12-18 11:30:34','2017-12-18 11:30:34',20,'employee',1),(3,'karlwilhelm.albert','karlwilhelm.albert','viktor58@bar.de','viktor58@bar.de',0,'kZedeTA3LJDyRzzZHilWgT20AkhCqwhwZAalVSEWIKY','EI+B5q8D+CcXRfcD45HTLUXgegtDiXLbJY2F3YduXPpnjX3GjeqyrvBgXqS0MbA63H+4SZvi01QNCkoBQOev/w==',NULL,NULL,NULL,'a:0:{}','Max','Henke','2017-12-18 11:30:34','2017-12-18 11:30:34',20,'employee',1),(4,'nschade','nschade','iarnold@wetzel.net','iarnold@wetzel.net',1,'bqCmjRU1OLAf0gu42az7Gg9tfJn2Yw4IWRglVqBwq.8','AJZHXGdBWkI/IyGa45BdCiGeiN3trm4xwdIQBaA+pDWsCbCCbpzpa/P1B0abk5q4RYz809FQ66uD14EEQ+Fxiw==',NULL,NULL,NULL,'a:0:{}','Madeleine','Bayer','2017-12-18 11:30:34','2017-12-18 11:30:34',20,'employee',1),(5,'hansjosef17','hansjosef17','benz.hermine@beier.de','benz.hermine@beier.de',0,'Yl2EBeBb4j.dn6c11ta7DVcILf5T7WdCQlmi.mrLUog','tBKfkj9RTZ4DnkpXK7yuknbkWIU3FgDHE9OI6bntHL+yG+rPLgAPFzypojLyE3S10fBqCIOxzMV2cfuqBhR3qQ==',NULL,NULL,NULL,'a:0:{}','Julian','Beckmann','2017-12-18 11:30:35','2017-12-18 11:30:35',20,'employee',1),(6,'liselotte07','liselotte07','karina99@walter.de','karina99@walter.de',1,'hHcZ7zjZ/rbkLsxte08B0oexVmNSKeJVlDBKoIMvXN4','f8t/kJJQEE9qsfFEtqDbA04ub2P22QP3erJxHjZk1Awvtacl56G0Zz3kaghF+2/cHxFOuJ7KaYnnBP9i6HYB7A==',NULL,NULL,NULL,'a:0:{}','Sylvia','Wolter','2017-12-18 11:30:35','2017-12-18 11:30:35',20,'employee',1),(7,'schlegel.hansulrich','schlegel.hansulrich','employee1@example.org','employee1@example.org',1,'Osnxz65VM129Oekr5I9DrEV2P/GRCkcyNgDvnWXm8S4','IImUJxe+K6atCCBD5H4NTlsGKpg0j3op1krPAML4ajHYzZMmWKAYfBg7UZiPhL90UcpfBonweJbrmaTOuAHVJw==',NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}','Default','User','2017-12-18 11:30:35','2017-12-18 11:30:35',20,'employee',1),(8,'liane50','liane50','werner.thilo@paul.de','werner.thilo@paul.de',0,'Y.kzcZoLRUYoebAN2P00v3xSPK3dQEQhfvrJL1J4m4w','NGkozd9l/MNf8joBpSx4buJEdvoEVn0IY75S1+4USI+/f8+sKDHb9Z5EvfxZYhmX8cTcBdYJd4BpePzoo3Yo8A==',NULL,NULL,NULL,'a:0:{}','Veit','Will','2017-12-18 11:30:35','2017-12-18 11:30:35',20,'employee',1),(9,'thuber','thuber','hiller.klausdieter@hotmail.de','hiller.klausdieter@hotmail.de',1,'GAEiHjZSFi.bRhE4wOZIE9Zctas6tDOmi1eXIIl9Flk','m+yx9FLGSaujbuBmlHDSrIuJeIWRc4VQRS+jJNeJ0o1kuCzH8qDaGkb8mHpEltjoocRrtisao3ovbV32KKkOvw==',NULL,NULL,NULL,'a:0:{}','Jörg','Schade','2017-12-18 11:30:35','2017-12-18 11:30:35',20,'employee',1),(10,'wilke.valeri','wilke.valeri','hummel.annegret@hotmail.de','hummel.annegret@hotmail.de',1,'r8s0fOO/EOwJuOKJCXsoiAl1.KDicUM7piUik.UaVgg','z6uOGZlAsEJ0WXYR4+utg0vDx5Fdpe9y41EL2sviQBGQV19DR71Xn7lcCotYLM7WHNO4RBxr7k3vQOvStx26Kg==',NULL,NULL,NULL,'a:0:{}','Adrian','Geißler','2017-12-18 11:30:35','2017-12-18 11:30:35',20,'employee',1),(11,'glemke','glemke','beier.christl@gmx.de','beier.christl@gmx.de',0,'3CKI2/raqgExqLeO2QMClaEL4YrEEVGuhkGg8Tjapwc','7k7y7+T1VTHbAfqexpF741GvclJxs3u8s8zZ+Gyu88Lk+YPCLRaIjdjhzU9f1ylPsXDx7XirAuQyDTC1r1gcRQ==',NULL,NULL,NULL,'a:0:{}','Rafael','Benz','2017-12-18 11:30:35','2017-12-18 11:30:35',20,'employee',1),(12,'muller.heinzgeorg','muller.heinzgeorg','henry.langer@googlemail.com','henry.langer@googlemail.com',1,'I1WPwzagD9hzS5ede1OHui5LbV8LnwsIGXyfBD6MEb8','6gQAqZtRrfftLktC1q7gltCMCtQxgLy5DzntxP5Fsvj7xIafUkFagJTjXLo9VgMwrXhi43+ao7VWTRqS6VrPXw==',NULL,NULL,NULL,'a:0:{}','Inga','Seidl','2017-12-18 11:30:35','2017-12-18 11:30:35',20,'employee',1),(13,'awalter','awalter','wendt.hermann@hartung.de','wendt.hermann@hartung.de',1,'iM9FHfO2BTsxgnwo7ECw3/gA/0sQ1XqdZLnEhZpxgsg','l32m8C5qfI/bgQ2VrsdW9SgXX0lWQ2LBCu7ToggNwGY8vlNZ+gHrN3yi5PaT9kgeIpP9eAPPNmk/8m+CRczDmQ==',NULL,NULL,NULL,'a:0:{}','Dorothea','Krebs','2017-12-18 11:30:35','2017-12-18 11:30:35',20,'employee',1),(14,'barthel.burkhard','barthel.burkhard','hpopp@gruber.com','hpopp@gruber.com',1,'ZPa4PROicxPbfuvFOP6zJUgiL3zuOm6Klt2XW1UQqgw','Wat6fszxj+DGWxA+AgpGwDaj2vY8Gq3yaAuxnSzcMzwnuaOOUUB0ir7dq01yWdJucsBJER3ALBZi3NI6okYHWQ==',NULL,NULL,NULL,'a:0:{}','Enrico','Wiese','2017-12-18 11:30:35','2017-12-18 11:30:35',20,'employee',1),(15,'viktoria66','viktoria66','martin.klara@kruger.com','martin.klara@kruger.com',0,'eqsNPdBocTM4V.G5PWyZ62gHXGSD..UEKwUx5otVxWk','UjnkIUtG43vX5CovBtgspFw9xQ4wF2Uu+IW+siqFGr/rGSEG3XF8TMiUWct/VWeOkDSJSV0npmuHfJXMllsRPA==',NULL,NULL,NULL,'a:0:{}','Nelli','Münch','2017-12-18 11:30:35','2017-12-18 11:30:35',20,'employee',1),(16,'schlegel.bernd','schlegel.bernd','gundula.ehlers@gmail.com','gundula.ehlers@gmail.com',1,'5pL7RgS8od2tZ94Vu1eTNfCCwpMB9rfn52Y6Gw7eOsM','16z2WWKqBvuhvuH2imWa/tgf35J69LoerzAeJ020L9fSEGpOQBoHja0YSx7klp2PKwcyk4/Kl91hP3NUa0QnPg==',NULL,NULL,NULL,'a:0:{}','Irmhild','Schmidt','2017-12-18 11:30:35','2017-12-18 11:30:35',20,'employee',1),(17,'aroder','aroder','lhagen@knoll.com','lhagen@knoll.com',0,'OEs2Ae2PWftlEMS1LPxHBI8RcFjMzqKcn0ci4.gYUJg','IObtYpyS9J0V3EdOZlsQhZSYswNRTzqQ5hSZFsM/VxrUs2Buv/Z3YbvtqN1QJGBumET6jn2bUhNoo8lVW+A5Pw==',NULL,NULL,NULL,'a:0:{}','Victor','Rieger','2017-12-18 11:30:35','2017-12-18 11:30:35',20,'employee',1),(18,'swen.niemann','swen.niemann','doreen.schmid@web.de','doreen.schmid@web.de',1,'mDyWIiY.w4Muflvmf9KfkKbjofayhorwVBkh.w1xfXA','lApB8yZ9HPe+DSXykwA8nw4RDsYgzMkl2j2EBGl/IfpGlxauiAmJnEl41OpBTVWoE4IED0+IDpmWHCFTKHJiMw==',NULL,NULL,NULL,'a:0:{}','Konstantinos','Heinze','2017-12-18 11:30:35','2017-12-18 11:30:35',20,'employee',1),(19,'ukuhlmann','ukuhlmann','hanno94@friedrich.de','hanno94@friedrich.de',1,'FOu6pBoV7ZrKa8Ksyu7mCgKwOYbjwCS37Q9KKidFX2w','oqP9lBhevGXO7Um4Rucf5nBJfVWZseXx0gQETQXCD9m0j13iVtOCKwBk92XX6eXuYjspgSGz5sswFQpSrPusnQ==',NULL,NULL,NULL,'a:0:{}','Birte','Hirsch','2017-12-18 11:30:35','2017-12-18 11:30:35',20,'employee',1),(20,'zdietz','zdietz','hammer.magdalena@hirsch.de','hammer.magdalena@hirsch.de',1,'dtla9R0T.NMopZnHZUeFCkgNWToooFL3xlqKo94c6ao','15PFT47u/i49pWrRaVwlsjGPtFCLr3el5zEHeaocAdfaCQ2IZwukeShJOCGI8W6pWp3BDIM56Y65OX5OGD0Qrw==',NULL,NULL,NULL,'a:0:{}','William','Hübner','2017-12-18 11:30:35','2017-12-18 11:30:35',20,'employee',1),(21,'rkessler','rkessler','marx.erhard@witte.de','marx.erhard@witte.de',1,'MkXzROOALQoSXnYiY51458KH4Xle7IDlLGTueWdvJfQ','qdd3cUwGolsvPxk+uhL3eJpONnZFh9nL6C60FmUT4DlYb8JBGLmeG6FTqA93UCLyh34v7FcCd2vUXnRVuZN6wQ==',NULL,NULL,NULL,'a:0:{}','Ernst-August','Jacob','2017-12-18 11:30:35','2017-12-18 11:30:35',20,'employee',1),(22,'jhenning','jhenning','dorothee.heller@gmail.com','dorothee.heller@gmail.com',0,'MWv6TrMFxynh312rB4RS8N0eMpkjSdQ5yyqGkgNrZ5k','ijrZgYISKM/8rQvadRNyRFKvLjLiSi0H+qDh3m+ARvC05OFnaB/SlRssl9h7rWy7nMO2lfrKEA6yxvbea5QzYw==',NULL,NULL,NULL,'a:0:{}','Heiderose','Braun','2017-12-18 11:30:35','2017-12-18 11:30:35',20,'employee',1),(23,'bertram51','bertram51','arthur.moll@aol.de','arthur.moll@aol.de',1,'YxaqfcWWK2.dTrdhwKSnP0FB3fvv.903HrX/pQ0HIfA','oQvpIBh7E0CwRFFcXJWu1WlK8IlAsOa8rPkKCzlewXa5eVlGNYFjBoYroqHpJlJLMjFpS/9gJtKNBG4hSrWz6w==',NULL,NULL,NULL,'a:0:{}','Alma','Jäger','2017-12-18 11:30:35','2017-12-18 11:30:35',20,'employee',1),(24,'fackermann','fackermann','inna.kluge@aol.de','inna.kluge@aol.de',0,'w3UKuTiG0Mfi7va86y6SQL1L4HyDKZqQL7/AtMzngEQ','rtdVIYCBiuV2ZZxzvWMHlGZksV9gIc1d9Rkl0tqW26ddEoLQyzq5GHcw4/K2JvYK2ULFbd1cklp4MjjutQ42RA==',NULL,NULL,NULL,'a:0:{}','Isabell','Lorenz','2017-12-18 11:30:35','2017-12-18 11:30:35',20,'employee',1),(25,'karlludwig11','karlludwig11','heide13@aol.de','heide13@aol.de',1,'2uDNVdtPC7TyvW1qVKPTUUcHiuP6AIs7vI2g/hb8aXc','ok+VxxxuxjQ9JJHyoakz+1LQ3Z1XC/XZ3/P+RDoAQ0IKLzA4KgvO+IzoMpffFuUkI7Fu7zAFVTJN5php1+bozA==',NULL,NULL,NULL,'a:0:{}','Markus','Mack','2017-12-18 11:30:35','2017-12-18 11:30:35',20,'employee',1),(26,'zdorr','zdorr','gwolff@loffler.net','gwolff@loffler.net',0,'3uDP4arpcrE/ochgpHqk2GzhTugu.fhUjDw.lqq7h5Y','gKNLYC+GdiCV1MZJqaSnHG2SDzgUGQF7VEyJldHjuZs2EhQWJoklHBk6hHV/8kVRzLj0rP6AecwLgCONY+oCSg==',NULL,NULL,NULL,'a:0:{}','Raimund','Schütz','2017-12-18 11:30:35','2017-12-18 11:30:35',20,'employee',1);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-12-18 10:30:42
