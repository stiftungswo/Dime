-- MySQL dump 10.13  Distrib 5.5.58, for debian-linux-gnu (x86_64)
--
-- Host: mysql    Database: dime
-- ------------------------------------------------------
-- Server version	5.5.5-10.2.10-MariaDB-10.2.10+maria~jessie

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
INSERT INTO `WorkingPeriods` VALUES (1,7,2,'2017-01-25','2017-06-07',0.80,177629,'28',210880,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(2,7,1,'2017-06-27','2018-03-15',0.30,129742,'94',6040,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(3,15,4,'2017-06-01','2018-08-12',1.00,724103,'13',146918008,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(4,25,3,'2016-12-30','2018-04-03',0.20,152111,'13',34265150,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(5,11,2,'2017-07-05','2018-01-06',0.70,215740,'72',6900506,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(6,20,2,'2017-04-18','2018-07-22',0.40,305548,'57',82,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(7,11,2,'2017-01-17','2018-06-15',1.00,851691,'95',7,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(8,17,2,'2017-04-21','2018-07-15',0.50,373650,'23',476016,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(9,10,5,'2017-07-01','2018-05-20',0.20,107041,'41',87450342,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(10,25,6,'2017-08-19','2017-11-26',0.90,149129,'62',56797,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(11,12,3,'2017-11-09','2018-07-07',0.10,39933,'1',2660981,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(12,22,2,'2017-10-06','2018-10-10',0.60,367851,'4',68816,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(13,18,6,'2017-01-30','2018-01-03',0.30,168018,'21',41246257,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(14,24,6,'2017-03-11','2018-04-21',0.10,67439,'97',25,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(15,13,2,'2017-01-20','2018-08-12',0.00,NULL,'14',49784287,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(16,16,5,'2017-07-20','2018-08-25',0.50,333054,'84',51122,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(17,16,2,'2017-09-25','2018-03-29',0.10,30654,'26',499,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(18,8,4,'2017-03-03','2018-01-25',0.40,218059,'10',959807,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(19,14,1,'2017-09-28','2018-05-26',0.40,159733,'93',277343,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(20,25,5,'2017-07-26','2018-01-01',0.80,210769,'41',49590601,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(21,9,3,'2017-10-15','2018-09-05',0.50,270089,'58',55784958,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(22,16,4,'2016-12-06','2018-08-12',0.90,915651,'93',4,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(23,13,2,'2017-03-31','2018-03-25',0.60,357909,'35',3533,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(24,15,6,'2017-04-15','2017-11-28',0.80,300909,'6',376,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(25,9,3,'2017-03-07','2018-04-05',0.90,587567,'59',4048018,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(26,7,1,'2017-05-22','2018-05-26',0.80,490468,'45',210,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(27,25,2,'2017-03-15','2018-04-29',0.50,340511,'100',1,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(28,17,4,'2017-11-15','2018-10-24',1.00,570003,'84',4,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(29,15,1,'2017-10-16','2018-10-15',0.30,180943,'44',347921,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(30,26,3,'2017-05-05','2018-09-19',0.90,748626,'5',941743286,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(31,14,3,'2017-07-03','2018-07-01',0.70,422200,'27',96,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(32,26,1,'2017-09-30','2017-11-29',0.70,70753,'85',858883,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(33,24,6,'2017-01-31','2018-04-20',0.90,663623,'27',569103,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(34,18,4,'2017-10-29','2018-10-30',0.10,60811,'70',78668,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(35,19,2,'2017-07-12','2018-04-23',0.30,142169,'19',46763,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(36,24,4,'2017-03-13','2018-06-14',0.00,NULL,'90',4,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(37,10,1,'2017-07-25','2018-06-27',0.40,223362,'64',126449,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(38,23,1,'2017-03-30','2018-03-12',0.20,115326,'2',658554,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(39,26,1,'2017-01-23','2018-02-01',0.20,123943,'18',85,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(40,19,1,'2016-12-21','2018-02-14',0.40,278374,'38',2427113,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(41,8,6,'2017-07-22','2018-03-06',0.30,112841,'39',82,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(42,16,2,'2016-12-24','2017-12-26',0.90,547303,'43',51057,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(43,26,1,'2017-03-28','2018-09-13',0.00,NULL,'90',4520052,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(44,21,1,'2017-05-25','2018-09-23',0.10,80530,'98',16979,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(45,19,5,'2017-03-22','2018-01-30',1.00,520294,'92',3239,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(46,22,1,'2017-09-15','2018-04-23',0.50,182268,'41',0,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(47,9,2,'2017-08-18','2018-04-25',0.10,41425,'26',24318,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(48,10,2,'2017-01-30','2017-12-08',0.10,51864,'83',9341,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(49,26,4,'2017-10-09','2018-01-04',0.50,72079,'92',9292198,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(50,19,5,'2016-11-26','2018-03-21',0.90,715818,'90',515,'2017-11-14 16:14:31','2017-11-14 16:14:31');
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
  `description` longtext COLLATE utf8_unicode_ci DEFAULT NULL,
  `rate_value` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `chargeable` tinyint(1) DEFAULT NULL,
  `cargeable_reference` smallint(6) NOT NULL,
  `vat` decimal(10,3) DEFAULT NULL,
  `rate_unit` longtext COLLATE utf8_unicode_ci DEFAULT NULL,
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
INSERT INTO `activities` VALUES (1,9,1,2,'DimERP Programmieren','CHF 10000',1,1,0.080,'CHF/h','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL,'h'),(2,1,6,4,'Molestias est in sed.','CHF 18000',1,1,0.025,'CHF/h','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL,'h'),(3,10,13,5,'Cum ducimus vitae quam.','CHF 8100',1,1,0.025,'CHF/h','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL,'h'),(4,2,14,1,'Est officia voluptatibus corrupti commodi deserunt.','CHF 2800',1,1,0.080,'CHF/h','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL,'h'),(5,16,6,5,'Aut numquam a harum aliquam est.','CHF 18000',1,1,0.025,'CHF/h','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL,'h'),(6,5,2,5,'Ratione sunt ut officia est.','CHF 10300',1,1,0.080,'CHF/h','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL,'h'),(7,19,8,2,'Eius necessitatibus qui.','CHF 2800',1,1,0.080,'CHF/h','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL,'h'),(8,19,20,1,'Eum repellendus enim eum.','CHF 10300',1,1,0.080,'CHF/h','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL,'h'),(9,12,19,2,'Explicabo odit similique nihil numquam est.','CHF 18000',1,1,0.080,'CHF/h','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL,'h'),(10,20,9,5,'Sit quas quo totam quia.','CHF 18000',0,1,0.025,'CHF/h','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL,'h'),(11,12,16,6,'Quidem dolorum neque repudiandae.','CHF 8100',1,1,0.080,'CHF/h','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL,'h'),(12,5,38,3,'Occaecati ut et soluta.','CHF 16900',0,1,0.080,'CHF/d','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL,'t'),(13,9,35,5,'Et nihil voluptates dolores consectetur quo.','CHF 3100',1,1,0.080,'CHF/d','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL,'t'),(14,9,28,6,'Perspiciatis aspernatur nemo.','CHF 10800',0,1,0.025,'CHF/d','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL,'t'),(15,1,35,4,'Dolorem consequatur rerum suscipit.','CHF 3100',1,1,0.080,'CHF/d','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL,'t'),(16,20,40,4,'Et eos blanditiis.','CHF 10800',1,1,0.080,'CHF/d','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL,'t'),(17,12,40,3,'Iste repellat qui ipsum sit illum.','CHF 10800',1,1,0.080,'CHF/d','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL,'t'),(18,14,24,6,'Commodi modi quia culpa corrupti autem.','CHF 1500',1,1,0.025,'CHF/d','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL,'t'),(19,5,27,1,'Consequuntur provident beatae culpa consequatur aut.','CHF 10800',1,1,0.080,'CHF/d','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL,'t'),(20,16,30,5,'Excepturi magni qui at et inventore.','CHF 1500',1,1,0.080,'CHF/d','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL,'t'),(21,9,25,6,'Corporis molestias nam maxime qui dolorem.','CHF 16900',1,1,0.025,'CHF/d','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL,'t'),(22,16,58,1,'Ex occaecati dolorem.','CHF 18300',1,1,0.080,'Pauschal','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL,'a'),(23,6,48,6,'Odio in vero reiciendis modi.','CHF 18300',1,1,0.080,'Pauschal','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL,'a'),(24,1,50,5,'Labore minus iste corrupti.','CHF 18300',1,1,0.080,'Pauschal','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL,'a'),(25,20,42,6,'Consectetur omnis eaque nobis qui recusandae.','CHF 18500',1,1,0.025,'Einheit','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL,'a'),(26,3,58,5,'Aut delectus laudantium.','CHF 18300',1,1,0.080,'Pauschal','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL,'a'),(27,9,45,3,'Omnis possimus numquam nostrum officiis.','CHF 13700',1,1,0.080,'Km','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL,'a'),(28,7,52,3,'Sit aut temporibus dolorem occaecati.','CHF 18500',1,1,0.025,'Einheit','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL,'a'),(29,12,54,4,'Molestias quod error.','CHF 13700',0,1,0.025,'Km','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL,'a'),(30,2,59,1,'Temporibus et et veritatis quia.','CHF 18500',1,1,0.080,'Einheit','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL,'a'),(31,7,49,4,'Dolore accusamus qui similique et aliquam.','CHF 5500',1,1,0.025,'Einheit','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL,'a'),(32,15,68,6,'Commodi qui voluptate quia rerum ut.','CHF 6700',1,1,0.080,'Pauschal','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL,'a'),(33,19,74,6,'Totam saepe nihil mollitia consequatur et.','CHF 18300',0,1,0.025,'Pauschal','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL,'a'),(34,16,62,1,'Totam cupiditate odio asperiores.','CHF 18300',1,1,0.080,'Pauschal','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL,'a'),(35,10,79,1,'Qui ipsam similique quaerat.','CHF 10700',1,1,0.025,'Pauschal','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL,'a'),(36,13,72,2,'Ratione maiores et et ut.','CHF 18300',1,1,0.080,'Pauschal','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL,'a'),(37,8,64,2,'Sed ipsa nam minus qui.','CHF 2700',1,1,0.080,'Pauschal','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL,'a'),(38,16,78,2,'Eaque eos temporibus optio.','CHF 14500',1,1,0.025,'Pauschal','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL,'a'),(39,1,71,5,'Officia fugit et voluptatibus quam.','CHF 18300',1,1,0.080,'Pauschal','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL,'a'),(40,16,63,1,'Ut ratione ea aperiam quae nam.','CHF 14500',1,1,0.025,'Pauschal','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL,'a'),(41,9,66,2,'Quis sed autem et velit dolores.','CHF 14500',0,1,0.080,'Pauschal','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL,'a');
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
INSERT INTO `customers` VALUES (1,1,1,5,'StiftungSWO','stiftungswo',NULL,NULL,NULL,NULL,1,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(2,2,2,2,'Heck KG','recusandae-nam-quia-non-vitae-','Hübner Thiele OHG mbH','eaque','Stefan Hirsch','Herr',1,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(3,2,3,1,'Kern','commodi-nihil-ut-ratione-ea-ap','Held AG & Co. OHG','ipsum','Wally Breuer-Bader','Frau',0,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(4,2,4,3,'Unger AG','dignissimos-enim-maxime-tempor','Hentschel','placeat','Harald Schenk','Herr',1,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(5,2,5,2,'Braun','quod-exercitationem-numquam-qu','Mai','voluptatem','Silke Krauß','Frau',1,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(6,1,6,3,'Adler','qui-quisquam-facere-esse-quia-','Wiesner Bernhardt e.V.','dicta','Walburga Ackermann','Frau',1,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(7,1,7,3,'Voigt Stiftung & Co. KG','et-molestias-culpa-et-facilis-','Lorenz Eberhardt GmbH','nobis','Adam Fink','Herr',1,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(8,1,8,6,'Neubauer e.G.','eveniet-sint-provident-magni-e','Becker','quia','Klara Wimmer','Herr',1,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(9,2,9,2,'Lange Seidel e.V.','reiciendis-sunt-molestias-iure','Fuhrmann e.V.','suscipit','Henny Geisler','Herr',1,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(10,2,10,2,'Heinze','adipisci-temporibus-labore-lib','Hermann Hammer AG & Co. OHG','modi','Cindy Esser B.Eng.','Frau',1,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(11,2,11,3,'Römer GmbH & Co. KG','beatae-et-et-quis-illum-molest','Brandt KG','repellat','Frau Dr. Anny Völker B.Eng.','Frau',0,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(12,1,12,2,'Wolff AG & Co. KGaA','possimus-itaque-et-vel-qui-eos','Geisler GmbH & Co. KG','architecto','Reinhilde Lindemann','Frau',1,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(13,1,13,2,'Klose GmbH','enim-voluptatum-laboriosam-vit','Pietsch Meyer GbR','voluptas','Heidemarie Weiß','Herr',1,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(14,2,14,6,'Rothe Günther e.V.','maiores-dolore-et-at-debitis','Moser Friedrich GmbH','mollitia','Frau Veronika Unger','Herr',1,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(15,1,15,3,'Maier','ut-sint-est-quo-quas-eius-quam','Nowak KGaA','quisquam','Frau Prof. Edith Dietz','Frau',1,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(16,2,16,2,'Wolter','dolores-veritatis-illo-eveniet','Stumpf','omnis','Marcus Gabriel','Herr',1,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(17,1,17,1,'Geißler','officia-id-quidem-commodi-ulla','Bender','soluta','Cordula Wenzel','Herr',1,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(18,1,18,4,'Schumann Heine Stiftung & Co. KGaA','dolores-ut-tempore-modi-molest','Voß','dolorem','Lutz Barth','Frau',1,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(19,2,19,6,'Jürgens Stiftung & Co. KG','aliquid-quasi-sit-ipsa-sequi-i','Jost','alias','Hans-Günther Kellner','Herr',1,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(20,2,20,4,'Lenz GbR','cum-autem-nesciunt-et-numquam-','Huber','est','Andree Göbel','Frau',1,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(21,1,21,6,'Schlegel Preuß AG','quibusdam-reprehenderit-omnis-','Jansen','aut','Margarethe Bruns MBA.','Herr',1,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(22,1,22,1,'Reimer','dolores-est-dolores-neque-face','Thiel AG','quo','Edelgard Heinze','Frau',1,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(23,1,23,1,'Bernhardt Philipp AG','quia-possimus-sed-veritatis-mo','Krug','enim','Boris Winkler','Herr',0,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(24,1,24,5,'Dörr','ea-nihil-est-sed-rerum','Strobel AG','nostrum','Hans-Günter Scherer','Herr',1,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(25,1,25,1,'Barth','ut-quibusdam-sit-enim','Bär Wolter AG','atque','Herr Dr. Ewald Körner MBA.','Frau',1,'2017-11-14 16:14:31','2017-11-14 16:14:31');
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
INSERT INTO `holidays` VALUES (1,1,'2017-01-11',30240,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(2,3,'2017-01-16',30240,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(3,5,'2017-05-19',3600,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(4,4,'2017-06-22',16200,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(5,4,'2017-09-05',3600,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(6,4,'2017-07-17',30240,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(7,5,'2017-05-04',30240,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(8,5,'2017-02-10',30240,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(9,3,'2017-05-24',16200,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(10,4,'2017-03-06',16200,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(11,5,'2017-09-25',16200,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(12,2,'2017-10-04',30240,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(13,5,'2017-09-20',30240,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(14,1,'2017-09-18',30240,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(15,5,'2016-11-18',30240,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(16,4,'2017-01-11',30240,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(17,6,'2016-12-03',30240,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(18,5,'2017-06-16',30240,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(19,1,'2017-02-05',30240,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(20,5,'2017-08-12',30240,'2017-11-14 16:14:31','2017-11-14 16:14:31');
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
INSERT INTO `invoiceDiscounts` VALUES (1,49,2,'10% Off',0.10,1,1,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(2,47,1,'10% Off',0.10,1,1,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(3,50,3,'10% Off',0.10,1,1,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(4,45,3,'10% Off',0.10,1,1,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(5,49,1,'10% Off',0.10,1,1,'2017-11-14 16:14:31','2017-11-14 16:14:31');
/*!40000 ALTER TABLE `invoiceDiscounts` ENABLE KEYS */;
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
INSERT INTO `invoice_items` VALUES (1,1,1,2,'Zivi (Tagespauschale)','CHF 88000','CHF/h',0.080,'28',1,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(2,25,5,1,'molestias','CHF 64300','CHF/h',0.025,'40',48,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(3,30,8,4,'possimus','CHF 45500','CHF/h',0.080,'8',38,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(4,17,9,4,'odio','CHF 45600','CHF/h',0.025,'50',24,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(5,12,5,1,'minima','CHF 39500','CHF/h',0.025,'6',53,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(6,3,3,5,'harum','CHF 70600','CHF/h',0.025,'82',24,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(7,21,11,5,'ratione','CHF 58700','CHF/h',0.080,'87',90,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(8,7,10,1,'voluptatem','CHF 15000','CHF/h',0.080,'16',3,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(9,22,11,1,'neque','CHF 32600','CHF/h',0.025,'42',98,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(10,37,10,6,'et','CHF 3200','CHF/h',0.025,'97',65,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(11,39,9,6,'est','CHF 83700','CHF/h',0.080,'81',55,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(12,4,21,3,'quo','CHF 2600','CHF/h',0.025,'16',11,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(13,45,17,2,'quidem','CHF 37800','CHF/h',0.025,'57',17,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(14,5,21,5,'nihil','CHF 50200','CHF/h',0.080,'25',66,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(15,49,16,3,'omnis','CHF 62500','CHF/h',0.025,'87',69,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(16,12,15,5,'illo','CHF 14800','CHF/h',0.025,'22',29,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(17,45,17,5,'officia','CHF 70000','CHF/h',0.080,'99',81,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(18,1,20,2,'suscipit','CHF 70800','CHF/h',0.080,'7',47,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(19,32,20,2,'blanditiis','CHF 35200','CHF/h',0.080,'43',58,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(20,14,14,3,'qui','CHF 95700','CHF/h',0.025,'1',62,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(21,14,21,5,'quia','CHF 36600','CHF/h',0.080,'58',49,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(22,10,31,6,'perferendis','CHF 72500','CHF/h',0.080,'24',26,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(23,15,27,4,'consequatur','CHF 65400','CHF/h',0.080,'33',68,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(24,20,22,5,'magni','CHF 34000','CHF/h',0.080,'76',42,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(25,22,28,1,'autem','CHF 87600','CHF/h',0.080,'18',40,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(26,9,23,6,'quam','CHF 77500','CHF/h',0.025,'10',38,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(27,35,27,3,'ab','CHF 48500','CHF/h',0.025,'71',70,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(28,29,22,1,'reiciendis','CHF 33500','CHF/h',0.080,'34',8,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(29,21,22,3,'minus','CHF 27700','CHF/h',0.025,'21',99,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(30,41,26,5,'consectetur','CHF 29600','CHF/h',0.025,'86',47,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(31,20,24,4,'expedita','CHF 14000','CHF/h',0.025,'96',79,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(32,21,39,4,'quia','CHF 82100','CHF/h',0.080,'83',77,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(33,40,39,5,'dolor','CHF 86600','CHF/h',0.025,'3',11,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(34,9,33,2,'dolorem','CHF 23000','CHF/h',0.080,'68',92,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(35,40,33,1,'quod','CHF 83700','CHF/h',0.025,'63',37,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(36,23,38,2,'et','CHF 46700','CHF/h',0.025,'64',63,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(37,47,38,4,'nobis','CHF 49900','CHF/h',0.080,'49',16,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(38,17,38,4,'at','CHF 24600','CHF/h',0.080,'54',99,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(39,46,40,2,'rerum','CHF 30300','CHF/h',0.080,'85',72,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(40,17,39,3,'saepe','CHF 36200','CHF/h',0.080,'13',41,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(41,44,33,4,'aut','CHF 49000','CHF/h',0.025,'82',49,'2017-11-14 16:14:31','2017-11-14 16:14:31');
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
  `costgroup_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `alias` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8_unicode_ci DEFAULT NULL,
  `start` date DEFAULT NULL,
  `end` date DEFAULT NULL,
  `fixed_price` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_6A2F2F95166D1F9C` (`project_id`),
  KEY `IDX_6A2F2F959395C3F3` (`customer_id`),
  KEY `IDX_6A2F2F959582AA74` (`accountant_id`),
  KEY `IDX_6A2F2F95CC72B005` (`costgroup_id`),
  KEY `IDX_6A2F2F95A76ED395` (`user_id`),
  CONSTRAINT `FK_6A2F2F95166D1F9C` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`),
  CONSTRAINT `FK_6A2F2F959395C3F3` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_6A2F2F959582AA74` FOREIGN KEY (`accountant_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_6A2F2F95A76ED395` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_6A2F2F95CC72B005` FOREIGN KEY (`costgroup_id`) REFERENCES `costgroups` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoices`
--

LOCK TABLES `invoices` WRITE;
/*!40000 ALTER TABLE `invoices` DISABLE KEYS */;
INSERT INTO `invoices` VALUES (1,1,1,2,NULL,2,'Default Invoice','default-invoice','This is a detailed description','2016-07-20','2017-05-28',NULL,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(2,12,19,4,NULL,3,'Test Invoice 2','test-invoice-2','Velit possimus cum ducimus vitae quam omnis ea. Odio quis est officia voluptatibus corrupti commodi. Minima reprehenderit laborum cumque molestiae aut numquam. Harum aliquam est quod. Laudantium qui ipsa ratione sunt ut officia. Reprehenderit autem voluptatem perspiciatis eius necessitatibus qui. Quis saepe neque quia eum repellendus enim eum. Ea et harum ut explicabo odit similique nihil numquam. Sit suscipit libero nisi sunt sit quas quo totam. Numquam itaque magnam voluptas quidem dolorum neque. Totam non dolor voluptatibus nihil occaecati ut.','2017-03-03','2017-06-16','CHF 2170800','2017-11-14 16:14:31','2017-11-14 16:14:31'),(3,12,22,5,NULL,4,'Test Invoice 3','test-invoice-3','Ullam iste repellat qui ipsum sit illum. Distinctio et doloremque quia commodi modi quia. Corrupti autem quae perferendis enim. Consequuntur provident beatae culpa consequatur aut ducimus dignissimos. Consequatur accusantium excepturi magni qui at et. Voluptas soluta eaque autem veritatis. Nam maxime qui dolorem quam cumque eius. Vel ex occaecati dolorem ab. Eius quia iusto odio in. Reiciendis modi magni perferendis iure suscipit labore. Minus iste corrupti rerum necessitatibus aut totam sit. Eaque nobis qui recusandae tempore molestias. Fugit delectus aut delectus laudantium. Iure quia illo neque omnis possimus numquam nostrum.','2016-11-25','2017-11-05',NULL,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(4,7,17,6,NULL,4,'Test Invoice 4','test-invoice-4','Est commodi qui voluptate quia rerum. Enim rem provident voluptas harum totam. Nihil mollitia consequatur et at magni nihil aut. Totam cupiditate odio asperiores perspiciatis. Natus optio qui ipsam similique quaerat. Perspiciatis et placeat autem. Maiores et et ut beatae rerum assumenda et. Sed ipsa nam minus qui recusandae nam. Vitae eaque eos temporibus optio nisi sequi et. Esse officia fugit et voluptatibus quam quaerat. Id commodi nihil ut. Aperiam quae nam id repellat et. Ipsum quis sed autem et velit dolores. Optio quos quia molestiae dignissimos enim maxime tempore.','2016-06-01','2017-07-04',NULL,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(5,12,4,2,NULL,5,'Test Invoice 5','test-invoice-5','Aut culpa illo quisquam accusamus distinctio. Aut aut et molestias. Et facilis est ut qui fugit sed saepe. Ut cupiditate nemo rem. Voluptas dignissimos molestiae neque culpa. Sint provident magni eius nulla distinctio qui quia. Et magnam qui officia. Expedita ratione et sit reiciendis sunt molestias iure. Et molestiae laborum sequi laborum distinctio suscipit aut. Assumenda soluta aut magni accusantium voluptatem adipisci. Labore libero repudiandae non. Autem unde est eaque et. Incidunt exercitationem et reiciendis vel facilis sed facere. Est laboriosam beatae et. Quis illum molestiae rerum omnis exercitationem velit repellat. Cum vitae sunt vel ut molestiae.','2015-12-04','2017-07-05',NULL,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(6,18,25,6,NULL,2,'Test Invoice 6','test-invoice-6','Sit labore rem voluptas quasi aut. Ea libero veritatis rerum ad incidunt voluptatem facere. Dolore et at debitis reprehenderit sequi occaecati rerum. Occaecati et quod deserunt dignissimos repudiandae eos adipisci dolores. Ut sint est quo quas eius quam architecto enim. Est quo eveniet quisquam iste dolorem. Praesentium autem qui sed sed cupiditate. Veritatis illo eveniet est non qui. Repellendus natus omnis assumenda eaque vel modi nisi. Ipsum praesentium cumque officia id quidem commodi. Aut fuga praesentium et.','2016-01-27','2017-05-01',NULL,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(7,13,15,4,NULL,6,'Test Invoice 7','test-invoice-7','Sed atque occaecati error. Labore sit a qui omnis doloribus pariatur. Est dignissimos cum autem nesciunt. Numquam aspernatur alias odio magni est. Asperiores optio adipisci corporis qui. Corporis placeat adipisci quibusdam reprehenderit. Voluptas sed ut et aut minima quos est. Facere numquam eius numquam nemo. Dolores est dolores neque facere fugit sint consequatur et. Quos id quo laudantium dolorem voluptatibus iure. Provident neque est inventore minima laboriosam quia possimus.','2017-03-19','2017-10-08',NULL,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(8,4,18,1,NULL,3,'Test Invoice 8','test-invoice-8','Aliquam repellat quia sequi. Nihil beatae est et dolores et. Sunt accusamus et occaecati similique. Iusto dignissimos sit aut repellendus. Sapiente autem non ut fuga voluptatibus atque dolore. Impedit eius ut alias quisquam at qui incidunt. Maxime adipisci et saepe esse. Sed aperiam rerum nemo animi necessitatibus. Quam aut iusto harum reiciendis magnam voluptatum neque molestiae. Dolorum velit ipsam beatae. Reprehenderit earum nulla consequatur occaecati sit. Et est quia ex. Explicabo libero placeat ex aperiam. Dolorum facilis enim omnis consectetur nihil ipsum velit. Sit tenetur totam ad ut consequuntur. Veniam minima a numquam sed repellat ea atque.','2017-03-10','2017-11-10',NULL,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(9,11,13,5,NULL,3,'Test Invoice 9','test-invoice-9','Neque sequi qui cum maiores voluptate aperiam. Aut at natus voluptas est aut placeat. Optio itaque qui vel qui quasi autem. Quis odit sapiente aliquid veritatis est fuga cumque. Ipsam eum amet qui et veniam est. Quibusdam aut omnis labore molestiae consequuntur explicabo sint sequi. Facere recusandae aliquam voluptatem quia hic. Rem enim eos necessitatibus omnis ullam maxime hic et. Expedita est id dolor aliquid officia perspiciatis autem. Et et nihil officia sit sed et pariatur et. Beatae ut hic est quo et. Aut harum reprehenderit qui voluptates voluptatibus numquam dolores suscipit. Fugiat est saepe suscipit nulla. Aut ullam tempore aspernatur.','2016-09-07','2017-05-08','CHF 4526100','2017-11-14 16:14:31','2017-11-14 16:14:31'),(10,NULL,20,1,NULL,4,'Test Invoice 10','test-invoice-10','Quisquam molestiae incidunt a aut tempore eos quam. Ducimus accusamus id molestias labore. Error consequatur modi et vel assumenda. Excepturi ipsam est magni similique. Asperiores dolores praesentium id porro tempora. Id occaecati voluptatem rerum optio sint voluptatem libero. Commodi at modi assumenda. Tempore ex mollitia vel quasi facilis eveniet. Cupiditate sed rem omnis consequatur ullam. Quia et in dolorem quidem id enim aspernatur. Est voluptatem officia provident velit laboriosam ut eum. Ea ut error unde eos blanditiis animi. Et quidem ut ut est inventore velit. Dignissimos est enim tenetur. Dolores laborum commodi quis sit eveniet. Dolor est voluptatum cum veniam.','2016-03-07','2017-09-24','CHF 7349800','2017-11-14 16:14:31','2017-11-14 16:14:31'),(11,NULL,3,1,NULL,2,'Test Invoice 11','test-invoice-11','Architecto esse iusto vero praesentium quam vitae aut. Est nam quae debitis ut quia eum. In dignissimos quia nam aut explicabo. Fuga deserunt error consequatur error. Modi eveniet est quis enim. Adipisci explicabo molestias provident totam voluptatibus cumque. Fuga voluptas cupiditate voluptas sit sit incidunt aliquid libero. Temporibus ut ad sint pariatur eos. Sint sunt et aspernatur sapiente necessitatibus blanditiis tempora laborum. Eaque aliquam ea adipisci animi aut possimus. Provident qui magnam atque eaque laudantium reiciendis. Doloremque ratione quisquam ducimus velit eligendi delectus possimus.','2016-12-20','2017-05-21',NULL,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(12,14,25,4,NULL,2,'Test Invoice 12','test-invoice-12','Cum corrupti rerum consequatur ea expedita et voluptatibus. Voluptatem et in neque quos ut qui saepe. Tempore labore quia nesciunt culpa cupiditate temporibus nulla. Omnis sed ullam ut deserunt magni. Voluptate quidem eaque ut distinctio. Quis est ratione rerum ipsa culpa. Eos velit quia adipisci amet. Voluptatem consequatur quasi perferendis provident dicta sed esse. Ex voluptates quidem eos vel voluptas non. Iure et commodi quidem dicta. Similique voluptatem ratione et rerum temporibus voluptas. Non ea voluptatem doloribus. Et dolor et recusandae exercitationem velit est ipsa. Tempore quia atque natus. Est nesciunt aliquam aspernatur repellendus pariatur modi illo.','2017-04-23','2017-09-11','CHF 9443500','2017-11-14 16:14:31','2017-11-14 16:14:31'),(13,NULL,9,1,NULL,5,'Test Invoice 13','test-invoice-13','Sunt nam aut placeat nisi reiciendis. Eos voluptate dolorem qui cupiditate perspiciatis voluptatem. Corporis ea quia error molestias rerum. Quia sapiente eum molestiae optio doloribus magni est. Et magni voluptatem temporibus qui repellat officia. Voluptatem similique qui ipsam itaque rerum aut. Quas eius sint deserunt. Recusandae modi minus vel consequatur eum enim nihil. Consectetur voluptatem architecto voluptatem qui occaecati. Sed voluptates et libero voluptates. Autem aut tempore vitae unde doloremque fugiat et. Dignissimos quia repudiandae consequatur impedit magnam quaerat sint nihil. In eaque commodi modi optio. Ut nisi est similique.','2016-09-06','2017-10-26',NULL,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(14,NULL,16,5,NULL,4,'Test Invoice 14','test-invoice-14','A cum ut et eius ut et vel. Nesciunt dolores officia ut. Eum quasi ut est molestiae error minus. Repudiandae quae non ad eos maiores exercitationem. Sunt pariatur nulla et dolor at soluta. Autem sed et sunt praesentium. Sint voluptatibus ipsa ipsum omnis consequatur. Cupiditate quisquam corporis laboriosam repudiandae itaque. Alias sint et dolorem doloribus occaecati commodi quisquam. Provident ex recusandae aliquid beatae nihil. Eum praesentium tenetur expedita nam sint pariatur in. Voluptas sit ea delectus. Aspernatur dolor ut veniam est repudiandae. Modi quo maxime voluptates suscipit illum velit laborum. Voluptatem fugit qui molestiae reprehenderit sint.','2016-10-21','2017-08-24',NULL,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(15,NULL,3,3,NULL,6,'Test Invoice 15','test-invoice-15','Omnis est eaque dolorem beatae. Ipsa vel est ad voluptatem illum eum eligendi reprehenderit. Non et fugiat animi quibusdam labore numquam maxime modi. Architecto deserunt qui sit tenetur inventore. Error occaecati enim aperiam dicta eaque id sit. Molestiae placeat nulla quia a et. Incidunt nulla aperiam officia eaque error cumque ullam. Ab qui minus ut sint. Autem eius mollitia perferendis dicta esse porro aut. Et et quia et enim dolor praesentium optio eveniet. Sed nesciunt quisquam nihil magni eaque nostrum. Atque ipsam et id amet distinctio molestiae non. Sequi excepturi et deleniti asperiores quia. Accusamus praesentium ratione nihil. Sunt modi exercitationem voluptas est.','2016-01-05','2017-09-14',NULL,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(16,NULL,1,6,NULL,6,'Test Invoice 16','test-invoice-16','Eos mollitia fugit perferendis. Non et necessitatibus sit repudiandae dolorum. Quo sunt eaque et asperiores animi voluptatem in ut. Et quae vero quas eum quae vitae harum. Rerum quis dolor perferendis. Sit iste hic eos laborum. Accusantium et quas nihil quam id autem. Hic consequatur consectetur eaque aut. Sit nam qui id et. Et aliquam minima corporis aut sequi qui. Sed provident aperiam vel impedit quos. Nesciunt odit esse repellat aliquid animi. Quia error libero nostrum quas illum quia. Occaecati consequuntur facere quo quam architecto et aut.','2017-02-25','2017-09-01',NULL,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(17,NULL,10,2,NULL,2,'Test Invoice 17','test-invoice-17','Odit qui doloribus a aut et. Esse dolorem cumque sunt vel. Accusamus laudantium possimus laboriosam optio et. Accusantium dolorem dolores beatae est eos modi. Sit numquam voluptatibus cupiditate. Ipsa occaecati similique consequuntur voluptatum expedita. Facilis repellendus iste est fugiat ab accusamus nam. Est totam qui est omnis accusamus. In eaque asperiores ad officia quo. Voluptatem cum dicta quod totam. Dicta vel quasi molestiae. Vero expedita autem sint cumque quia. Impedit est distinctio praesentium sit quis dolorem. Voluptatum ut rerum excepturi a repellendus ex et praesentium. Eum sint dolorem in.','2017-04-20','2017-09-16',NULL,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(18,10,19,2,NULL,2,'Test Invoice 18','test-invoice-18','Provident quae quia ex reprehenderit eum. Cum quod dolor dolores voluptatum esse pariatur et. Veritatis iusto quia delectus consectetur eveniet. Cupiditate consectetur at quam officia mollitia eum consequatur corporis. Voluptate quo doloremque quis vel. Eveniet debitis dolores iusto quidem. Rerum ad eligendi omnis alias qui nisi. Aliquid dolorem neque officiis impedit eveniet ducimus. Sapiente earum quia eius quo similique. Illo unde soluta molestiae tempore et laboriosam. Qui et et tenetur qui nihil. Voluptatum accusamus rem aut quia. Commodi amet vel aliquam et sunt ut qui quae. Perferendis animi quis dolores tenetur totam sunt ut.','2016-12-22','2017-11-09',NULL,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(19,NULL,21,4,NULL,5,'Test Invoice 19','test-invoice-19','Fuga aspernatur cupiditate itaque deserunt est repellendus repellat. Quo laboriosam qui quae voluptas earum. Sunt quos aliquid temporibus voluptatem repellendus blanditiis ea. Sunt tempore doloremque ullam labore dignissimos quaerat molestiae. Commodi fugit qui iste ab non dolorem et. Rem culpa et provident quisquam corporis perspiciatis aliquam. Molestiae sit quis autem sequi debitis dolor error nobis. Porro maiores quidem dolor et explicabo. Sunt voluptatum sed excepturi accusamus. Omnis quas odit deserunt perferendis odit. Repellat praesentium rerum est et. Temporibus consequuntur nulla assumenda aut laboriosam.','2017-02-04','2017-09-07',NULL,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(20,NULL,10,2,NULL,3,'Test Invoice 20','test-invoice-20','Est molestiae nulla non earum. Non consequatur possimus tenetur consequuntur laborum temporibus natus. Impedit omnis sint explicabo exercitationem porro. Repudiandae recusandae quisquam ipsa veritatis. Accusantium sit modi consectetur est accusantium assumenda molestiae nihil. Ratione quia dolores quisquam rerum et debitis officia. Et officiis at minus veniam magnam qui mollitia. Vel consequatur ducimus corporis excepturi. Ut harum et aliquid quas. Aut fugiat odio aut consequuntur vero praesentium incidunt. Quae voluptatem mollitia voluptas architecto ipsa.','2016-01-25','2017-05-16',NULL,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(21,7,15,1,NULL,5,'Test Invoice 21','test-invoice-21','Voluptas neque qui alias sed exercitationem excepturi numquam. Modi sed placeat odio ut ullam velit rem. Eum eum quis eaque ipsa dolorum reiciendis. Molestiae libero fugit corporis. Fuga ab quo temporibus rerum. Non nisi fuga quia deleniti unde minima. Doloremque nihil quia cum occaecati magnam hic expedita. Est iste fugit explicabo alias accusamus quo ratione. Perferendis provident provident aliquam sit eligendi. Omnis delectus possimus harum ullam laudantium. Blanditiis cumque esse qui et qui laboriosam. Laboriosam beatae enim sunt quaerat. Laudantium similique aut quia vel repudiandae doloribus.','2016-05-20','2017-07-24',NULL,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(22,20,24,2,NULL,5,'Test Invoice 22','test-invoice-22','Magnam odit adipisci saepe consequatur perferendis voluptas. Recusandae repudiandae molestias quisquam earum animi aut. Porro nam excepturi odit eius voluptatum. Reprehenderit eligendi totam temporibus tempora et. Minima mollitia odit modi possimus eveniet. Culpa iste aliquid ipsam commodi blanditiis ipsam. Soluta dolore magni temporibus illum ex eveniet enim. Voluptatem perspiciatis consequatur repellendus eligendi. Doloremque ut dolores velit repellendus blanditiis. Quisquam autem sunt blanditiis maiores et. Nihil enim atque voluptas id eaque modi. Hic aliquid corporis est eos aut. Non molestias aut ut et sunt consectetur laboriosam.','2016-08-01','2017-08-09',NULL,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(23,6,15,1,NULL,3,'Test Invoice 23','test-invoice-23','Tempore maiores eius voluptatem ut aspernatur. Omnis dolore consequatur recusandae asperiores. Nobis animi consequatur eligendi laudantium. Aut et vel fugiat fuga. In rerum maxime consequuntur iusto ipsa. Harum nemo laborum cupiditate sint. Facilis ut numquam vel tempore et eius fugit. Sunt sequi sed ad quibusdam sequi. Ea pariatur incidunt aspernatur impedit nisi. Nisi officia perspiciatis reiciendis aperiam est nobis ipsa. Nobis veritatis accusantium est pariatur aut eos. Voluptatibus sit ad beatae eligendi debitis quam. Minus sit ea ipsa non neque atque saepe.','2017-03-23','2017-05-27',NULL,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(24,20,13,5,NULL,4,'Test Invoice 24','test-invoice-24','Quam rerum laboriosam in dolores id suscipit. Assumenda in velit modi aliquid repudiandae facere perferendis. Quaerat et delectus aut dolores. Odio molestiae et dolor officia. Dignissimos est ullam eligendi fugit fuga numquam. Ad vel officiis dolores dolor natus animi. Est nisi illum impedit aut est veniam dicta. Est et a corrupti quia aut ut cumque. Error natus impedit commodi sed cupiditate porro. Dolorum accusantium laborum consequatur quia. Odit ipsam est qui sit recusandae repellendus qui. Quam voluptatem aut commodi soluta ut laudantium. Aspernatur suscipit optio quia culpa ab.','2016-07-31','2017-07-27',NULL,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(25,14,19,6,NULL,6,'Test Invoice 25','test-invoice-25','Molestiae nihil molestiae eos sint rem. Qui quae minima qui. Maiores quae quo excepturi. Minima et odio voluptatibus est qui enim. Odit est et fuga corporis suscipit dolores. Eos tempore est ullam voluptas et fugiat. Aut assumenda dolorum alias sit. Earum porro ullam ducimus molestias fuga. Velit iste sunt aut ad molestiae officia ex. Aliquam minima et porro omnis temporibus odio quam. Omnis quia deleniti ullam eum iure. Sunt odit quia inventore. Perspiciatis quas non facere eligendi maiores provident quas vel.','2015-12-04','2017-06-07',NULL,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(26,6,3,5,NULL,2,'Test Invoice 26','test-invoice-26','Sit hic sit at ex temporibus dolorem eveniet. Aut eligendi et doloribus dolore quae maxime hic. Harum est eius tenetur et ducimus ut. Maiores laboriosam expedita est neque. Veniam modi dolores aut provident deserunt sunt. Nihil cumque id nihil quidem quia consectetur. Vero voluptatem quis consequatur alias voluptatem. Provident cupiditate harum quos dolorem perspiciatis odio. Dolorum incidunt minus maiores molestiae nulla maiores. Et dignissimos minus nulla ut excepturi a fugit. Est maiores tempora quos laboriosam. Quam suscipit ducimus iste a repellendus.','2016-01-28','2017-05-20',NULL,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(27,12,1,4,NULL,1,'Test Invoice 27','test-invoice-27','Tempora quia qui ut ut quod. Quis est qui ad et placeat eaque itaque. Occaecati eos labore in est recusandae quaerat facilis. Aut consequuntur optio expedita ipsa incidunt debitis. Inventore voluptas voluptatem quia porro omnis ducimus eos. Nemo omnis cum et sunt fugiat. Illo officia perspiciatis consectetur aut ab. Hic earum fugiat est voluptatem sit rerum fuga. Praesentium a autem enim ullam. Et voluptatem eum omnis esse. Debitis id fugit neque voluptatem error. Delectus quae qui deleniti doloribus modi quia. Molestiae accusamus et praesentium quia quo in aut. Ipsum magnam consectetur non modi.','2016-08-22','2017-10-13',NULL,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(28,17,21,6,NULL,2,'Test Invoice 28','test-invoice-28','Suscipit repellendus velit enim nostrum. Nemo et ut quisquam nemo fugiat vel optio voluptatem. Eligendi vitae iusto minima a debitis saepe sit. Nostrum consequatur ipsa et accusamus. Consequatur sint voluptatum id molestiae. Et non quam sint quae. Eligendi quam cum accusamus eveniet quae. Eaque voluptatibus corrupti molestiae dolorem error facilis et. Et voluptas dicta facere vero molestias. Repudiandae temporibus quia perspiciatis commodi eligendi alias. Repellendus sint veniam explicabo sequi maiores qui. Excepturi provident rerum corporis in. Itaque reiciendis recusandae sit ad magnam distinctio aut.','2016-03-09','2017-10-13',NULL,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(29,10,6,1,NULL,6,'Test Invoice 29','test-invoice-29','Consequatur sit consectetur aliquid ad nihil quas dignissimos et. Voluptatem qui maiores vel quis tempora quia voluptatem. Explicabo qui reiciendis ut atque est hic et. Nostrum sunt quasi qui. Nostrum cupiditate provident aperiam esse recusandae. Et ab omnis vitae quod et. Ut assumenda expedita quia rem et rerum qui. Dolores quisquam nam unde expedita quos doloribus numquam. Qui saepe incidunt quaerat magnam excepturi. Est pariatur consequatur eveniet debitis consectetur. Delectus dolores eius quibusdam laudantium blanditiis enim explicabo consectetur. Reprehenderit facilis qui eum. Neque nulla enim praesentium rerum deleniti.','2016-03-06','2017-07-02',NULL,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(30,3,1,4,NULL,2,'Test Invoice 30','test-invoice-30','Nam nobis eum temporibus tempore sit. Reiciendis voluptas consequatur placeat quod. Debitis fuga et vel velit illum nisi. Voluptas beatae qui dolor rem eligendi veniam sint. Temporibus qui iure occaecati est beatae voluptate. Cupiditate amet fuga nobis et. Non voluptas quae veritatis velit et repellat tenetur eum. Et libero beatae omnis enim fugiat est ut vero. Aut cumque repudiandae aut totam. Beatae omnis incidunt magnam expedita aut voluptas earum. Dolor ipsam qui doloribus. Magnam iusto quasi cum sed. Rerum error hic accusantium debitis excepturi odit fugit fuga. Aliquam voluptate amet adipisci modi veritatis.','2016-03-16','2017-10-02',NULL,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(31,16,7,1,NULL,3,'Test Invoice 31','test-invoice-31','Dolores doloremque unde eaque dolorum. Commodi magnam dolorem et doloribus ipsum. Hic ut cum nostrum corrupti qui dignissimos. Pariatur et nihil earum. Eaque facere qui est possimus omnis omnis occaecati nesciunt. Delectus sed beatae unde architecto non eum numquam molestiae. Illum et sed dolor et labore. Perferendis similique numquam nihil aut. Sint fugiat est nemo quasi. Expedita consequuntur dolores ad. Et incidunt nesciunt voluptas ratione tempore nobis. Quo est vel qui iure. Vero ea aut rem ipsum itaque voluptas. Praesentium ratione deleniti et aut. Sed aliquam velit rerum in et. Fugiat dolorem molestiae sit quis quo. Nemo deserunt quam dolor animi.','2016-05-30','2017-07-12',NULL,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(32,15,22,5,NULL,2,'Test Invoice 32','test-invoice-32','Quia saepe ullam corrupti molestiae natus assumenda impedit. Consequatur ullam nam est in ipsa. Eius quo ut labore molestias harum. Non modi sit libero velit molestiae rerum. Qui a quas aut. Commodi iste voluptatem nobis quibusdam itaque quo dolorum. Exercitationem totam praesentium fugiat quod quas repellendus quam. Blanditiis doloribus eum eum porro ea recusandae autem. Voluptatem dignissimos reprehenderit est. Et nesciunt est aut qui. Quidem perspiciatis placeat necessitatibus id laborum facilis dicta incidunt. Odio sapiente laborum sed natus delectus nesciunt.','2016-10-30','2017-09-05',NULL,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(33,18,2,5,NULL,3,'Test Invoice 33','test-invoice-33','Unde nulla sed quas amet beatae modi accusamus. Qui accusantium provident expedita ut. Laboriosam provident aut sed sit rerum. Non quasi eos illo tempore. Odio natus temporibus et et aspernatur quaerat unde. Harum nam reiciendis id nesciunt sit. Cumque molestiae voluptatem ut repellat. Adipisci qui at quis numquam et mollitia. Reprehenderit ex quasi doloribus voluptatum nemo sit. Suscipit ut impedit saepe. Voluptates vitae autem vero officia ab repudiandae at. Est ex magnam nesciunt. Adipisci corporis qui doloribus esse. Nisi in reprehenderit molestiae vero.','2016-07-02','2017-11-05',NULL,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(34,14,22,1,NULL,1,'Test Invoice 34','test-invoice-34','Nihil explicabo libero eaque dolore sunt ea. Voluptate cupiditate animi recusandae quod doloremque maiores autem. Ad excepturi velit ratione earum pariatur. Sed ratione quasi optio sunt. A rem quia unde tempore voluptate quia. Libero nobis explicabo autem. Harum et est iusto perspiciatis consequatur. Minus qui sit beatae vero ut hic vero quidem. Culpa voluptas repudiandae iste atque. Nesciunt aut necessitatibus id molestiae sed maiores omnis. Sit modi nihil ipsum hic eum autem temporibus. Atque repellat sapiente autem. Voluptatem aut id porro nisi vero voluptatem nihil. Voluptatum asperiores fuga earum. Quo libero enim dolore rerum.','2015-12-14','2017-10-15','CHF 9495800','2017-11-14 16:14:31','2017-11-14 16:14:31'),(35,NULL,24,1,NULL,4,'Test Invoice 35','test-invoice-35','Ipsum voluptas est doloribus laborum dolores eos necessitatibus. Quia voluptatem dolor aut voluptatem. Doloremque id magnam labore voluptas rem officiis magnam. Velit est magnam nulla cupiditate. In rem consequatur quidem et debitis nisi. Iste cupiditate nobis quisquam cumque. Quisquam quaerat quia ipsa enim voluptatem quas. Et ut ut tenetur optio et. Qui rerum maxime qui quibusdam repellendus. Occaecati rerum consequuntur dolores et rerum aut. Ullam distinctio ea dolores ad tenetur. Dolorum reiciendis quia sit eos minus. Harum totam cum sit consequatur. Cumque est sequi architecto aut. Ex provident pariatur molestiae facilis fugit quos. Quia magnam voluptates et earum esse sequi.','2017-04-12','2017-06-22',NULL,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(36,9,4,2,NULL,2,'Test Invoice 36','test-invoice-36','Dicta dolores veritatis rerum quo. Voluptas eligendi ut perferendis. Et quo dolores omnis doloremque qui. A rerum maxime aut autem aut. Commodi explicabo ratione sed veniam sunt nulla quis. Repellendus incidunt eum nihil voluptatem voluptatum. Rerum perspiciatis dolorem libero non aspernatur aut iure perspiciatis. Voluptatem veritatis debitis eum vel enim enim officiis. Architecto rerum eos magni sit. Vitae provident quisquam ratione. Ipsam hic explicabo corrupti in. In eveniet dolore qui qui excepturi fugiat. Illo dignissimos ipsum modi nulla nemo ea. Aut corrupti dolores voluptatem voluptatem.','2016-07-18','2017-09-22','CHF 9010100','2017-11-14 16:14:31','2017-11-14 16:14:31'),(37,NULL,11,2,NULL,2,'Test Invoice 37','test-invoice-37','Ea eos cupiditate repudiandae sint ipsa sint qui. Amet sit quia error dolorem. Qui consequatur dolorem nam rerum vero porro natus. Aut rerum quia voluptatum consequatur ea asperiores. Dolor harum deserunt nulla quia enim. Dolorem accusantium impedit aliquam perferendis. Consequuntur culpa suscipit omnis et eius et modi quis. Quia dolorem libero ut occaecati a iure. Saepe accusamus et perferendis quo. Ipsa ut voluptatum mollitia quis reiciendis vero explicabo. Suscipit ex aliquam debitis. Laborum expedita consectetur possimus vel non ex non. Neque repellendus ut repellat nihil ab occaecati dolorem.','2016-10-26','2017-10-16',NULL,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(38,NULL,22,3,NULL,5,'Test Invoice 38','test-invoice-38','Aliquid consequatur et maiores sint architecto. Dolor consequatur sint repudiandae asperiores. In rerum rerum libero delectus magni provident. Illum porro nesciunt voluptas. Sint est molestias ducimus iusto. Ut labore nihil qui ea et. Et eum aut illo quas sit totam non consequatur. Doloremque tenetur sed velit laboriosam. Nihil iure qui voluptatum odio soluta blanditiis. Illum maiores incidunt aut asperiores. Fugiat necessitatibus nesciunt tempore consequatur et magnam. Explicabo molestiae distinctio totam adipisci consequatur quam ratione. Illum dignissimos et incidunt eius rerum aut. Consequuntur aut magni in quia excepturi facere sit. Cum harum quia enim.','2017-01-13','2017-09-04',NULL,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(39,16,8,5,NULL,5,'Test Invoice 39','test-invoice-39','Error quasi et voluptatum aut quis non quaerat. Nulla suscipit architecto dignissimos asperiores rerum dolores ratione. Aut id aut rerum quis cumque. Sapiente et rerum velit omnis officia aut velit. Neque commodi aliquam aperiam et et. Officiis sapiente sed sed error ex aut error. Quo ut atque numquam amet aliquam quis. Porro accusamus odit rerum hic neque velit. Est deleniti ad et officiis. Exercitationem porro molestias illum blanditiis ipsam rerum maiores. Dolores nostrum et voluptas consequatur tempora nostrum voluptas. Enim eum ab qui reprehenderit quia ab dicta. Ab accusantium officia omnis eveniet architecto qui aut omnis.','2017-02-20','2017-05-19','CHF 6675700','2017-11-14 16:14:31','2017-11-14 16:14:31'),(40,11,20,6,NULL,5,'Test Invoice 40','test-invoice-40','Consequatur quia odit et veniam. Non laborum sit voluptatum. Neque non dolor repellendus blanditiis eos aperiam neque. Vel qui debitis et enim. Ratione iste omnis ut similique est alias id. Omnis similique minima aut repellat pariatur quia at. Temporibus expedita reiciendis aspernatur qui aut quia. Et non non molestiae est repellendus consequatur nostrum. Facilis occaecati consequatur voluptatem aperiam dicta autem. Pariatur expedita voluptates laborum aut ratione cum. Ipsum alias praesentium ut culpa nesciunt omnis eligendi expedita.','2016-03-06','2017-07-13',NULL,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(41,2,3,3,NULL,4,'Test Invoice 41','test-invoice-41','Maiores et molestiae aliquam eveniet sed in voluptas nostrum. Temporibus illum atque qui aperiam dolores sunt. Sit qui odit ut vel. Aut eligendi dolorum qui debitis. Eum voluptatem quia possimus molestiae qui ad. Fuga est unde nostrum quis aut. Dicta velit enim porro nobis iusto et beatae et. Consectetur delectus accusantium totam molestiae. Quaerat vel magni vel consectetur earum voluptas voluptatum. Maxime ab et fuga voluptatibus. Iste iure culpa enim laudantium dolor ab aut. Ipsa ducimus debitis hic similique eum. Dolor corrupti et impedit odit dolorum dicta est. Id qui provident vel velit tempora rerum qui.','2016-01-29','2017-07-30',NULL,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(42,20,12,2,NULL,6,'Test Invoice 42','test-invoice-42','Animi quas dolor neque magni. Aut sed officiis qui impedit aliquam repudiandae harum. Nemo doloremque quis quia quam aut et sed. Autem ut consequatur laborum asperiores pariatur consequatur. Et maiores ex debitis sit enim. A consequuntur vel dolore illum ab adipisci. Aut eum nihil totam temporibus. Exercitationem tempore sunt est repudiandae illum. Ut reiciendis quidem distinctio quia esse officia sint officia. Officiis sit deleniti voluptatem recusandae officiis excepturi. Et laudantium tempore ea nihil vitae rerum doloribus. Nobis architecto aut error. Incidunt mollitia sed enim molestias et doloremque. Eos aut numquam eum quia.','2016-08-20','2017-07-05',NULL,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(43,20,20,3,NULL,4,'Test Invoice 43','test-invoice-43','Eligendi laborum aut quo vel deserunt et. Quis autem ut incidunt aut harum. Enim et aperiam et. Officiis distinctio reprehenderit quae et. Error veritatis sunt doloribus dolor debitis odio. Deleniti fuga nostrum sit voluptatem vitae non. Corporis voluptatem exercitationem ut non molestias et dolores. Tenetur placeat ut reiciendis recusandae rerum. Atque voluptas voluptatibus unde sed. Facere quisquam inventore ut reprehenderit. Temporibus enim reiciendis et illum ullam. Qui aut ut praesentium dicta dicta voluptates nostrum qui.','2016-07-03','2017-05-24',NULL,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(44,NULL,8,4,NULL,1,'Test Invoice 44','test-invoice-44','Est dolorem nihil perferendis sequi. Velit odio est sequi. Placeat rerum placeat laboriosam numquam id voluptas voluptas. Enim et vero quo. Eius omnis illo dolorem odio qui quia error. Commodi iste omnis aut placeat facere. Dolor et vel nesciunt dolor suscipit quibusdam itaque. Quam qui qui eos repellendus molestias quibusdam laudantium. Minima voluptatum placeat eos. Sint tempora enim et ut optio quidem laborum. Est voluptatem repellat ut sit et reprehenderit. Rerum tenetur consequuntur nihil et culpa. Facilis consequatur ex unde provident iure molestiae enim distinctio. Numquam aliquid dolores repellendus maiores. Beatae qui vero inventore.','2015-12-24','2017-06-15',NULL,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(45,17,4,1,NULL,2,'Test Invoice 45','test-invoice-45','Praesentium vero quasi aut quod sit quam. Doloremque est adipisci et ut laboriosam. Qui ex et quam. Quae neque sed nobis consequatur quas pariatur magni. In et placeat est vel sint pariatur dolorum qui. Sunt dicta qui consequatur tenetur quaerat illo cupiditate. Ut quia sunt velit ex eos. Consequuntur repudiandae voluptas doloremque animi corporis officiis. Et voluptas voluptatibus omnis mollitia sed enim enim. Quia expedita eaque explicabo quisquam accusantium quos. Voluptatem repudiandae sequi nisi similique est quisquam saepe.','2017-02-08','2017-11-07',NULL,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(46,17,10,6,NULL,4,'Test Invoice 46','test-invoice-46','Voluptates et expedita qui nobis. Quo porro perferendis pariatur qui consequuntur. Aliquid aliquid nemo optio quae distinctio. Quisquam rerum laborum laudantium cum corrupti sed est. Doloribus in delectus quia ut id. Inventore numquam quidem sequi laborum. Nam aut voluptatem dolores dolore. Facere est qui illo cumque. Et ducimus ullam asperiores nostrum necessitatibus voluptatem. Fugiat blanditiis est reprehenderit eveniet. Odio maxime laborum nihil officiis voluptatem itaque. Sit et quaerat fugiat earum. Dolorem voluptatem deleniti odio enim aut eius aut. Neque temporibus sint aut asperiores eligendi.','2016-04-14','2017-06-17',NULL,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(47,13,20,4,NULL,6,'Test Invoice 47','test-invoice-47','Sed eum et neque aperiam nulla. Illum et debitis quam illo in amet quis deserunt. Nostrum voluptatem minima quo omnis. Delectus sit dolores quis dicta et labore. Et optio harum ipsa quae maiores officia. Quis sint omnis vero officia et. Dicta sint rem cum praesentium ea non qui. Iste tempora inventore quia eligendi enim odio sunt expedita. Tempora distinctio quasi blanditiis eos doloribus sed et nemo. Dolores enim asperiores sunt tempora voluptas voluptas. At ab aut rerum adipisci. Animi quia cupiditate vel possimus qui dolor ut ut. Qui qui hic sunt ut dolores sed. Sed non exercitationem blanditiis ducimus temporibus nihil sunt.','2016-09-23','2017-10-17',NULL,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(48,6,2,6,NULL,1,'Test Invoice 48','test-invoice-48','Vitae sint est rerum nostrum velit maiores et facilis. Quaerat eaque magnam accusamus velit. Quasi quisquam sapiente ipsa et ut aliquid in. Quasi aut aut reiciendis porro velit a. Mollitia ab minus ullam voluptatibus eum consequatur molestiae. Consequatur omnis possimus qui enim. Consequatur dolorem illo optio quo. Delectus est assumenda omnis assumenda. Sit distinctio dolores ad ut aspernatur voluptatem aut hic. Commodi aut quo tempore quas omnis. Qui explicabo aut fugit consequatur. Quia repudiandae ipsam hic dolor. Quisquam sed et et vel. Laboriosam similique voluptatem in. Aut possimus minus ut labore odit a quo numquam. Autem nihil mollitia illum aut.','2016-10-11','2017-10-03',NULL,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(49,12,13,6,NULL,3,'Test Invoice 49','test-invoice-49','Voluptatum tempore ea libero quis qui. Ipsum dolorum unde alias amet. Aut ut natus sunt quisquam fugiat. Velit a reprehenderit dolorem illo voluptatem ipsam. Dolorum facilis aliquid sed quo dolor natus. Dolor sed id consequatur autem hic. Ut quia consequuntur non nesciunt qui quia. Repellendus in qui molestiae iusto occaecati aut. Ratione quo quae reprehenderit quod. Soluta eum dolorem minima deserunt fuga labore. Labore aut totam aspernatur dolorem. Commodi esse dolorum sed repellendus. Dolores consectetur in et necessitatibus.','2016-08-22','2017-09-19',NULL,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(50,NULL,5,2,NULL,5,'Test Invoice 50','test-invoice-50','Atque quae temporibus ex eos aut voluptatem molestiae. Qui atque esse qui. Debitis facilis assumenda velit dolores. Magni corrupti quia possimus rem nulla sit doloribus. Qui enim rerum dolorum velit tempore. Molestiae aut autem aut quae suscipit quo. Ab ut aperiam nesciunt ducimus. Qui doloremque tenetur perferendis non quas modi. Iusto minus doloribus eum molestias. Tempora ut modi nobis velit et. Fugit ut doloribus quas magnam porro qui. Corporis iste molestiae modi quaerat et. Cupiditate est ut aspernatur consequatur sunt reprehenderit omnis neque. Veniam qui tenetur sed repudiandae pariatur ut. Consequatur eum voluptatem facere est maxime non sequi. In culpa qui exercitationem et quia.','2016-08-18','2017-05-20',NULL,'2017-11-14 16:14:31','2017-11-14 16:14:31');
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
INSERT INTO `offer_discounts` VALUES (1,47,2,'10% Off',0.10,1,1,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(2,50,1,'10% Off',0.10,1,1,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(3,49,3,'10% Off',0.10,1,1,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(4,48,3,'10% Off',0.10,1,1,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(5,50,1,'10% Off',0.10,1,1,'2017-11-14 16:14:31','2017-11-14 16:14:31');
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
  `rate_unit` longtext COLLATE utf8_unicode_ci DEFAULT NULL,
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
INSERT INTO `offer_positions` VALUES (1,1,19,2,1,20.00,'CHF 18000','CHF/h',0.080,1,1,'2017-11-14 16:14:31','2017-11-14 16:14:31','h'),(2,4,69,5,324,42.00,'CHF 2700','Pauschal',0.025,1,1,'2017-11-14 16:14:31','2017-11-14 16:14:31','a'),(3,9,25,6,648,29.00,'CHF 16900','CHF/d',0.025,1,1,'2017-11-14 16:14:31','2017-11-14 16:14:31','t'),(4,3,81,4,216,38.00,'CHF 14500','Pauschal',0.080,1,1,'2017-11-14 16:14:31','2017-11-14 16:14:31','a'),(5,1,61,4,850,47.00,'CHF 5500','Einheit',0.025,1,1,'2017-11-14 16:14:31','2017-11-14 16:14:31','a'),(6,3,5,4,395,24.00,'CHF 18000','CHF/h',0.080,1,1,'2017-11-14 16:14:31','2017-11-14 16:14:31','h'),(7,5,80,2,982,6.00,'CHF 18300','Pauschal',0.025,1,1,'2017-11-14 16:14:31','2017-11-14 16:14:31','a'),(8,10,53,6,133,87.00,'CHF 18500','Einheit',0.025,0,1,'2017-11-14 16:14:31','2017-11-14 16:14:31','a'),(9,2,32,1,198,26.00,'CHF 3100','CHF/d',0.025,1,1,'2017-11-14 16:14:31','2017-11-14 16:14:31','t'),(10,7,76,3,171,98.00,'CHF 10700','Pauschal',0.080,1,1,'2017-11-14 16:14:31','2017-11-14 16:14:31','a'),(11,8,74,2,598,86.00,'CHF 18300','Pauschal',0.025,0,1,'2017-11-14 16:14:31','2017-11-14 16:14:31','a'),(12,3,62,6,218,65.00,'CHF 18300','Pauschal',0.080,1,1,'2017-11-14 16:14:31','2017-11-14 16:14:31','a'),(13,3,50,2,479,7.00,'CHF 18300','Pauschal',0.080,1,1,'2017-11-14 16:14:31','2017-11-14 16:14:31','a'),(14,5,29,6,26,76.00,'CHF 10800','CHF/d',0.080,0,1,'2017-11-14 16:14:31','2017-11-14 16:14:31','t'),(15,8,27,6,257,78.00,'CHF 10800','CHF/d',0.080,1,0,'2017-11-14 16:14:31','2017-11-14 16:14:31','t'),(16,10,63,2,95,25.00,'CHF 14500','Pauschal',0.025,1,0,'2017-11-14 16:14:31','2017-11-14 16:14:31','a'),(17,1,41,6,228,73.00,'CHF 7600','CHF/d',0.080,0,1,'2017-11-14 16:14:31','2017-11-14 16:14:31','t'),(18,9,76,5,811,50.00,'CHF 10700','Pauschal',0.080,1,1,'2017-11-14 16:14:31','2017-11-14 16:14:31','a'),(19,10,18,6,29,44.00,'CHF 8100','CHF/h',0.080,1,1,'2017-11-14 16:14:31','2017-11-14 16:14:31','h'),(20,5,1,2,295,81.00,'CHF 10000','CHF/h',0.080,1,1,'2017-11-14 16:14:31','2017-11-14 16:14:31','h'),(21,10,51,2,679,78.00,'CHF 18500','Einheit',0.025,1,1,'2017-11-14 16:14:31','2017-11-14 16:14:31','a'),(22,4,3,3,352,11.00,'CHF 18000','CHF/h',0.080,1,1,'2017-11-14 16:14:31','2017-11-14 16:14:31','h'),(23,3,73,3,601,57.00,'CHF 18300','Pauschal',0.025,0,1,'2017-11-14 16:14:31','2017-11-14 16:14:31','a'),(24,10,8,4,999,58.00,'CHF 2800','CHF/h',0.080,1,1,'2017-11-14 16:14:31','2017-11-14 16:14:31','h'),(25,4,74,4,831,71.00,'CHF 18300','Pauschal',0.025,1,1,'2017-11-14 16:14:31','2017-11-14 16:14:31','a'),(26,5,39,6,864,69.00,'CHF 7600','CHF/d',0.025,1,1,'2017-11-14 16:14:31','2017-11-14 16:14:31','t'),(27,7,39,3,868,19.00,'CHF 7600','CHF/d',0.025,0,1,'2017-11-14 16:14:31','2017-11-14 16:14:31','t'),(28,4,73,1,800,42.00,'CHF 18300','Pauschal',0.025,1,1,'2017-11-14 16:14:31','2017-11-14 16:14:31','a'),(29,10,66,5,365,6.00,'CHF 14500','Pauschal',0.080,1,1,'2017-11-14 16:14:31','2017-11-14 16:14:31','a'),(30,5,66,5,775,36.00,'CHF 14500','Pauschal',0.080,1,1,'2017-11-14 16:14:31','2017-11-14 16:14:31','a'),(31,1,27,4,371,85.00,'CHF 10800','CHF/d',0.080,1,1,'2017-11-14 16:14:31','2017-11-14 16:14:31','t'),(32,1,33,4,411,34.00,'CHF 1500','CHF/d',0.025,1,1,'2017-11-14 16:14:31','2017-11-14 16:14:31','t'),(33,9,21,2,336,83.00,'CHF 2800','CHF/h',0.025,1,0,'2017-11-14 16:14:31','2017-11-14 16:14:31','h'),(34,7,78,3,40,80.00,'CHF 14500','Pauschal',0.025,0,1,'2017-11-14 16:14:31','2017-11-14 16:14:31','a'),(35,7,13,5,847,69.00,'CHF 8100','CHF/h',0.025,0,1,'2017-11-14 16:14:31','2017-11-14 16:14:31','h'),(36,9,14,4,612,79.00,'CHF 2800','CHF/h',0.080,0,1,'2017-11-14 16:14:31','2017-11-14 16:14:31','h'),(37,9,42,4,73,7.00,'CHF 18500','Einheit',0.025,0,1,'2017-11-14 16:14:31','2017-11-14 16:14:31','a'),(38,9,50,4,866,50.00,'CHF 18300','Pauschal',0.080,1,1,'2017-11-14 16:14:31','2017-11-14 16:14:31','a'),(39,3,10,2,668,30.00,'CHF 10300','CHF/h',0.080,1,1,'2017-11-14 16:14:31','2017-11-14 16:14:31','h'),(40,2,75,5,640,63.00,'CHF 6700','Pauschal',0.080,1,1,'2017-11-14 16:14:31','2017-11-14 16:14:31','a'),(41,7,73,4,941,16.00,'CHF 18300','Pauschal',0.025,1,1,'2017-11-14 16:14:31','2017-11-14 16:14:31','a'),(42,10,48,2,146,27.00,'CHF 18300','Pauschal',0.080,1,1,'2017-11-14 16:14:31','2017-11-14 16:14:31','a'),(43,5,26,6,116,16.00,'CHF 16900','CHF/d',0.025,1,1,'2017-11-14 16:14:31','2017-11-14 16:14:31','t'),(44,6,27,2,576,99.00,'CHF 10800','CHF/d',0.080,0,1,'2017-11-14 16:14:31','2017-11-14 16:14:31','t'),(45,1,70,5,37,98.00,'CHF 18300','Pauschal',0.025,0,1,'2017-11-14 16:14:31','2017-11-14 16:14:31','a'),(46,4,73,6,362,17.00,'CHF 18300','Pauschal',0.025,1,1,'2017-11-14 16:14:31','2017-11-14 16:14:31','a'),(47,10,22,2,382,90.00,'CHF 3100','CHF/d',0.080,1,1,'2017-11-14 16:14:31','2017-11-14 16:14:31','t'),(48,5,16,3,489,57.00,'CHF 8100','CHF/h',0.080,1,1,'2017-11-14 16:14:31','2017-11-14 16:14:31','h'),(49,9,58,1,58,88.00,'CHF 18300','Pauschal',0.080,1,0,'2017-11-14 16:14:31','2017-11-14 16:14:31','a'),(50,1,15,2,112,9.00,'CHF 8100','CHF/h',0.025,1,1,'2017-11-14 16:14:31','2017-11-14 16:14:31','h');
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
INSERT INTO `offer_status_uc` VALUES (1,NULL,'Potential',1,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(2,NULL,'Offered',1,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(3,NULL,'Ordered',1,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(4,NULL,'Lost',1,'2017-11-14 16:14:31','2017-11-14 16:14:31');
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
  `short_description` longtext COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` longtext COLLATE utf8_unicode_ci DEFAULT NULL,
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
INSERT INTO `offers` VALUES (1,NULL,1,1,25,1,2,5,'Default Offer','2017-09-14','This is a default offer','This is a longer description with more details',NULL,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(2,9,4,2,17,5,17,6,'Possimus cum.','2017-05-30','Est officia voluptatibus corrupti commodi deserunt minima reprehenderit laborum. Molestiae aut numquam a harum. Est quod expedita laudantium qui ipsa.','Et harum ut explicabo odit similique nihil numquam. Sit suscipit libero nisi sunt sit quas quo totam. Doloremque numquam itaque magnam. Quidem dolorum neque repudiandae totam non. Voluptatibus nihil occaecati ut et soluta. Dignissimos omnis eveniet et nihil. Dolores consectetur quo illo molestiae quis et. Perspiciatis aspernatur nemo officia debitis. Earum praesentium dolorem consequatur rerum. Ea sunt cumque qui. Eos blanditiis ipsam ut excepturi. Ullam iste repellat qui ipsum sit illum. Distinctio et doloremque quia commodi modi quia. Autem quae perferendis enim id. Consequuntur provident beatae culpa consequatur aut ducimus dignissimos. Consequatur accusantium excepturi magni qui at et.',NULL,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(3,NULL,1,2,21,3,9,6,'Magni perferendis.','2017-10-25','Necessitatibus aut totam sit consectetur omnis. Nobis qui recusandae tempore molestias expedita fugit delectus. Delectus laudantium sed iure quia illo neque omnis. Numquam nostrum officiis dolor.','Aliquam et at quod consequatur. Commodi qui voluptate quia rerum ut enim rem. Voluptas harum totam saepe. Consequatur et at magni nihil aut. Totam cupiditate odio asperiores perspiciatis. Et natus optio qui ipsam similique quaerat commodi. Et placeat autem ratione. Et ut beatae rerum assumenda et. Sed ipsa nam minus qui recusandae nam. Non vitae eaque eos temporibus optio. Et eaque esse officia fugit et voluptatibus. Quaerat aut id commodi nihil. Ratione ea aperiam quae nam id repellat. Nihil ipsum quis sed autem et velit dolores. Optio quos quia molestiae dignissimos enim maxime tempore.',NULL,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(4,10,4,1,13,1,1,5,'In vel neque.','2017-11-02','Quo aut aut et molestias culpa et. Est ut qui fugit sed saepe maxime. Ut cupiditate nemo rem. Voluptas dignissimos molestiae neque culpa.','Assumenda soluta aut magni accusantium voluptatem adipisci. Labore libero repudiandae non. Autem unde est eaque et. Incidunt exercitationem et reiciendis vel facilis sed facere. Est laboriosam beatae et. Quis illum molestiae rerum omnis exercitationem velit repellat. Cum vitae sunt vel ut molestiae. Nobis non veniam possimus itaque et vel qui. Corrupti et deserunt sunt. Architecto id officiis odio perferendis. Qui dolore natus quidem enim. Laboriosam vitae nihil aperiam saepe nihil. Labore rem voluptas quasi aut a ea libero veritatis. Ad incidunt voluptatem facere.',NULL,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(5,1,1,2,12,4,15,2,'Sed sed.','2017-09-06','Qui soluta repellendus natus omnis assumenda eaque vel. Nisi fuga ipsum praesentium cumque officia id quidem commodi. Aut fuga praesentium et. Magnam soluta laudantium neque id sunt omnis.','Aliquid quasi sit ipsa sequi id ea quae sed. Occaecati error alias labore sit. Qui omnis doloribus pariatur sint est dignissimos. Autem nesciunt et numquam aspernatur alias odio. Est voluptatum asperiores optio adipisci corporis qui. Corporis placeat adipisci quibusdam reprehenderit. Voluptas sed ut et aut minima quos est. Facere numquam eius numquam nemo. Dolores est dolores neque facere fugit sint consequatur et. Quos id quo laudantium dolorem voluptatibus iure. Provident neque est inventore minima laboriosam quia possimus.',NULL,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(6,20,4,2,6,1,24,5,'Debitis ut.','2017-08-17','Nihil beatae est et dolores et. Sunt accusamus et occaecati similique. Iusto dignissimos sit aut repellendus. Voluptas sapiente autem non ut fuga voluptatibus atque.','Molestiae iste dolorum velit ipsam. Quia reprehenderit earum nulla consequatur occaecati. Dolores et est quia ex sit. Explicabo libero placeat ex aperiam. Dolorum facilis enim omnis consectetur nihil ipsum velit. Tenetur totam ad ut. Corporis veniam minima a numquam. Repellat ea atque veniam pariatur quos nulla ipsa dolorem. Eum necessitatibus et aut explicabo voluptatem quam. Voluptas inventore et perspiciatis optio neque dolor. Rem aut blanditiis rerum placeat enim. Facere dolor optio voluptates qui nam et repellendus. Qui aut voluptas sunt voluptatum qui neque. Qui cum maiores voluptate aperiam. Aut at natus voluptas est aut placeat. Optio itaque qui vel qui quasi autem.',NULL,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(7,NULL,3,2,24,3,4,2,'Rem enim eos.','2017-08-19','Est id dolor aliquid officia perspiciatis autem. Et et nihil officia sit sed et pariatur et. Beatae ut hic est quo et. Minus aut harum reprehenderit qui.','Ab iste non quia fuga ducimus tempore. Enim placeat et aut laborum. Id mollitia sit accusamus architecto eius. Molestiae incidunt a aut tempore. Quam libero ducimus accusamus id molestias labore provident error. Modi et vel assumenda quos. Ipsam est magni similique qui repellendus asperiores dolores. Porro tempora iste id. Voluptatem rerum optio sint voluptatem libero dolore. At modi assumenda et tempore ex. Vel quasi facilis eveniet repellat facere cupiditate sed rem. Ullam temporibus quia et in dolorem quidem. Enim aspernatur sed est voluptatem officia. Velit laboriosam ut eum nulla ea ut error. Eos blanditiis animi provident omnis et quidem.',NULL,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(8,6,3,2,16,5,16,2,'Eaque hic velit.','2017-05-12','Non architecto blanditiis temporibus quibusdam libero eveniet architecto. Iusto vero praesentium quam vitae aut. Est nam quae debitis ut quia eum. In dignissimos quia nam aut explicabo.','Sit sit incidunt aliquid libero. Temporibus ut ad sint pariatur eos. Sint sunt et aspernatur sapiente necessitatibus blanditiis tempora laborum. Eaque aliquam ea adipisci animi aut possimus. Provident qui magnam atque eaque laudantium reiciendis. Doloremque ratione quisquam ducimus velit eligendi delectus possimus. Molestias sit exercitationem consequuntur. Quia molestiae ad est facere aut. Voluptatem esse et soluta ab voluptatem odio. Vel a vel totam minus rerum. Consequatur autem quia adipisci rem dolores et. In fugit doloribus numquam amet dolor temporibus. Ducimus ipsam quo cum corrupti rerum consequatur ea. Et voluptatibus aut voluptatem et. Neque quos ut qui saepe in.','CHF 8490600','2017-11-14 16:14:31','2017-11-14 16:14:31'),(9,3,1,2,23,2,6,3,'Esse dolorum.','2017-10-18','Iure et commodi quidem dicta. Similique voluptatem ratione et rerum temporibus voluptas. Vel non ea voluptatem doloribus quisquam et. Et recusandae exercitationem velit est ipsa sit tempore.','Ratione illum omnis quia. Laborum sed officia temporibus id molestias non perferendis. Ad facilis error consequatur dolore deserunt dignissimos aliquam modi. Omnis eos molestias autem non sunt nam aut. Reiciendis nihil eos voluptate dolorem qui cupiditate. Voluptatem consequuntur corporis ea quia. Rerum iusto quia sapiente. Molestiae optio doloribus magni est quidem dolores et magni. Temporibus qui repellat officia ratione voluptatem similique. Ipsam itaque rerum aut quibusdam consectetur. Eius sint deserunt adipisci.',NULL,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(10,17,2,2,20,3,10,3,'Rerum in eaque.','2017-05-29','Nulla et possimus deserunt omnis maxime et. Architecto aut quia eius deserunt eius voluptas est. Vero ab omnis sunt recusandae dolorem non.','Sunt pariatur nulla et dolor at soluta. Autem sed et sunt praesentium. Sint voluptatibus ipsa ipsum omnis consequatur. Cupiditate quisquam corporis laboriosam repudiandae itaque. Alias sint et dolorem doloribus occaecati commodi quisquam. Provident ex recusandae aliquid beatae nihil. Eum praesentium tenetur expedita nam sint pariatur in. Voluptas sit ea delectus. Aspernatur dolor ut veniam est repudiandae. Modi quo maxime voluptates suscipit illum velit laborum. Voluptatem fugit qui molestiae reprehenderit sint. Qui corrupti odit doloribus quia occaecati doloribus. Expedita incidunt velit porro beatae sit et autem. Sunt sit voluptatem et deleniti totam quae et.','CHF 1660600','2017-11-14 16:14:31','2017-11-14 16:14:31'),(11,7,1,1,13,5,13,5,'Occaecati enim aperiam.','2017-09-27','Quia a et dolores molestias. Nulla aperiam officia eaque error cumque ullam. Ab qui minus ut sint.','Et id amet distinctio molestiae non. Sequi excepturi et deleniti asperiores quia. Accusamus praesentium ratione nihil. Sunt modi exercitationem voluptas est. Accusamus quae sit dolore impedit et voluptas. Et necessitatibus iure assumenda nemo vel. Sequi aut aliquam non iste. Impedit aut aliquam nisi quia. Pariatur inventore impedit tempora non eos mollitia fugit. Provident non et necessitatibus sit repudiandae dolorum magnam. Eaque et asperiores animi voluptatem in ut. Culpa et quae vero quas. Quae vitae harum quod rerum. Dolor perferendis numquam sit iste hic eos laborum. Sit accusantium et quas nihil quam id autem.',NULL,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(12,NULL,2,1,9,4,21,6,'Odit esse.','2017-05-20','Quas illum quia qui occaecati consequuntur. Quo quam architecto et. Officia nam exercitationem aut quaerat. Labore quam ea quaerat ratione aspernatur.','Et dolores eos voluptas consequatur commodi odit qui. A aut et veritatis esse dolorem cumque. Vel minus accusamus laudantium possimus laboriosam optio et. Accusantium dolorem dolores beatae est eos modi. Et sit numquam voluptatibus cupiditate aut ipsa occaecati. Voluptatum expedita nesciunt facilis repellendus iste est. Ab accusamus nam dolorem est. Est omnis accusamus optio enim in. Asperiores ad officia quo quis voluptatem cum dicta. Totam nam dicta vel quasi molestiae consequatur. Autem sint cumque quia velit quo impedit est. Praesentium sit quis dolorem. Voluptatum ut rerum excepturi a repellendus ex et praesentium.',NULL,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(13,NULL,1,1,7,6,2,1,'Ut quos et.','2017-08-02','Aperiam rem tenetur consequuntur sit tempora. Officiis ipsa quod nihil aperiam provident quae quia. Reprehenderit eum consequatur cum quod dolor dolores.','Eligendi rerum ad eligendi omnis alias qui nisi sint. Dolorem neque officiis impedit eveniet. Optio sapiente earum quia eius quo similique. Illo unde soluta molestiae tempore et laboriosam. Qui et et tenetur qui nihil. Voluptatum accusamus rem aut quia. Commodi amet vel aliquam et sunt ut qui quae. Perferendis animi quis dolores tenetur totam sunt ut. Vel molestiae nostrum quod qui harum et vero. Illo nulla eius eum dolorum quaerat omnis. Enim sit repellat aut. Quae voluptatem est beatae ipsum hic sint. Dolor id tempora quas modi fugit eius illo. Aliquid repellendus fuga aspernatur cupiditate itaque deserunt est. Repellat rerum quo laboriosam qui quae voluptas earum.',NULL,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(14,13,1,1,8,3,19,1,'Error nobis.','2017-09-02','Sunt voluptatum sed excepturi accusamus. Doloremque omnis quas odit deserunt. Odit eligendi repellat praesentium. Est et aut temporibus consequuntur.','Molestiae nulla non earum sed. Consequatur possimus tenetur consequuntur laborum. Natus est impedit omnis sint explicabo exercitationem porro. Recusandae quisquam ipsa veritatis nam sequi accusantium. Modi consectetur est accusantium assumenda. Nihil provident ratione quia dolores quisquam rerum et. Labore et officiis at minus veniam magnam. Mollitia a aut vel consequatur ducimus. Excepturi eos ut harum et aliquid quas odio. Fugiat odio aut consequuntur vero praesentium incidunt ipsam. Mollitia voluptas architecto ipsa iure deserunt libero facilis. Voluptatibus consequatur rerum vitae consectetur vero enim inventore sed.',NULL,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(15,19,4,2,25,2,6,5,'Excepturi numquam tempora.','2017-06-03','Eum eum eum quis eaque. Dolorum reiciendis dolore quo molestiae libero fugit. Sed fuga ab quo temporibus. Ad non nisi fuga quia deleniti unde minima eaque.','Esse qui et qui laboriosam a laboriosam. Enim sunt quaerat eligendi. Similique aut quia vel repudiandae doloribus deserunt cumque. Dignissimos maxime et placeat molestias. Sint quo nesciunt exercitationem vel et ea. Ad ipsa quis non omnis enim. Cupiditate voluptatem facilis quo minus dolor. Soluta mollitia corrupti magnam odit adipisci. Consequatur perferendis voluptas corporis recusandae repudiandae. Earum animi aut quisquam. Nam excepturi odit eius voluptatum officia reprehenderit eligendi. Temporibus tempora et facilis dignissimos. Odit modi possimus eveniet ipsam culpa. Aliquid ipsam commodi blanditiis. Esse soluta dolore magni.',NULL,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(16,20,1,1,10,1,10,6,'Consectetur laboriosam.','2017-06-09','Temporibus labore quae earum nihil recusandae facere. Similique id magnam eveniet enim delectus animi quo. Dignissimos voluptatem accusantium illum perferendis suscipit. Aut suscipit dolore ut eos voluptatem reiciendis soluta.','Rerum maxime consequuntur iusto. Consectetur harum nemo laborum cupiditate. Sit soluta facilis ut numquam vel tempore et eius. Sunt sequi sed ad quibusdam sequi. Ea pariatur incidunt aspernatur impedit nisi. Nisi officia perspiciatis reiciendis aperiam est nobis ipsa. Magnam nobis veritatis accusantium est pariatur. Laboriosam voluptatibus sit ad beatae eligendi debitis quam. Minus sit ea ipsa non neque atque saepe. Laboriosam autem dolores repellendus iste tenetur quia facere. Rem aut quia voluptatem velit. Hic mollitia ipsa recusandae odio rerum. Voluptatem debitis excepturi qui a voluptas. Corrupti totam non aliquid fuga velit sed id et.',NULL,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(17,8,1,2,9,2,6,6,'Fugit fuga numquam.','2017-08-03','Labore est nisi illum impedit. Est veniam dicta qui. Est et a corrupti quia aut ut cumque. Error natus impedit commodi sed cupiditate porro.','Aspernatur suscipit optio quia culpa ab. Cupiditate provident autem omnis reiciendis. Et aut fugiat laborum maiores fuga dignissimos corporis ex. Nemo fugit sit nobis iure quae dolores quos voluptas. Et quis sed nobis et ullam quae sit. Molestiae nihil molestiae eos sint rem. Qui quae minima qui. Quae quo excepturi at quasi. Et odio voluptatibus est qui. Odit est et fuga corporis suscipit dolores. Eos tempore est ullam voluptas et fugiat. Architecto aut assumenda dolorum alias sit deserunt earum porro. Ducimus molestias fuga et. Sunt aut ad molestiae officia. Nihil aliquam minima et porro omnis temporibus odio quam. Omnis quia deleniti ullam eum iure. Nemo sunt odit quia.',NULL,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(18,18,2,2,25,4,14,5,'Et dolores.','2017-05-19','Repellendus aliquam voluptatem ut amet. Rerum beatae sit hic sit at ex temporibus. Eveniet voluptas aut eligendi et. Quae maxime hic qui harum est eius tenetur et. Ut nihil dolorem maiores laboriosam expedita est.','Dolorum incidunt minus maiores molestiae nulla maiores. Et dignissimos minus nulla ut excepturi a fugit. Est maiores tempora quos laboriosam. Quam suscipit ducimus iste a repellendus. Est repellendus molestias cupiditate blanditiis. Incidunt magnam architecto sit eum tempora dolorum fugit. Laboriosam accusantium deleniti et deserunt debitis sunt. Ea molestiae quia optio sed placeat. Voluptatum qui aliquam voluptatem molestiae. Earum ullam quo ab dolor alias tempora quia. Ut ut quod sed quis est. Ad et placeat eaque itaque eaque occaecati. In est recusandae quaerat facilis ut aut. Optio expedita ipsa incidunt debitis iure quia. Voluptas voluptatem quia porro omnis.','CHF 8036300','2017-11-14 16:14:31','2017-11-14 16:14:31'),(19,NULL,1,2,13,5,17,1,'Eum omnis esse.','2017-07-25','Delectus quae qui deleniti doloribus modi quia. Molestiae accusamus et praesentium quia quo in aut. Ipsum magnam consectetur non modi. Id neque facere quo illum quae sapiente ut est.','Quis placeat saepe ex et. Maiores nihil saepe voluptatem. Eveniet repudiandae assumenda voluptate suscipit. Enim nostrum vero nemo et ut quisquam nemo. Vel optio voluptatem et eligendi vitae. Minima a debitis saepe sit earum. Consequatur ipsa et accusamus ea consequatur sint voluptatum. Aliquam et et non quam sint quae. Eligendi quam cum accusamus eveniet quae. Eaque voluptatibus corrupti molestiae dolorem error facilis et. Voluptas dicta facere vero molestias cum. Repudiandae temporibus quia perspiciatis commodi eligendi alias. Repellendus sint veniam explicabo sequi maiores qui.',NULL,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(20,4,3,2,14,1,21,5,'Reprehenderit dolorum.','2017-05-17','Ullam fuga autem harum quos et sit. Maiores eveniet voluptas tempora et dolor. Dolore dolorum atque atque enim. Similique molestiae quibusdam consequatur.','Nostrum sunt quasi qui. Nihil nostrum cupiditate provident aperiam. Recusandae dolore et ab omnis vitae quod et. Assumenda expedita quia rem et rerum qui facere. Dolores quisquam nam unde expedita quos doloribus numquam. Qui saepe incidunt quaerat magnam excepturi. Est pariatur consequatur eveniet debitis consectetur. Delectus dolores eius quibusdam laudantium blanditiis enim explicabo consectetur. Reprehenderit facilis qui eum. Neque nulla enim praesentium rerum deleniti. Error animi quaerat similique omnis tenetur sapiente voluptatem. Nemo voluptate perspiciatis quaerat iure. Quia modi hic saepe. Sit accusamus animi et ipsam adipisci ut aut.','CHF 2368500','2017-11-14 16:14:31','2017-11-14 16:14:31'),(21,1,1,2,23,4,15,3,'Eligendi veniam sint.','2017-07-06','Quia cupiditate amet fuga. Et totam non voluptas quae veritatis. Et repellat tenetur eum magni quis.','Cum sed laborum rerum error hic. Debitis excepturi odit fugit fuga eos aliquam voluptate. Adipisci modi veritatis iste tempora. Explicabo debitis officiis ullam. Maxime consequatur nemo fugiat alias assumenda necessitatibus ex. Id est ex labore aut. Alias iusto sed quae ea porro et. Molestias inventore autem quam rerum quod. Iusto molestiae optio incidunt ut quisquam dolores doloremque. Dolorum et commodi magnam dolorem et doloribus ipsum. Hic ut cum nostrum corrupti qui dignissimos. Fugiat pariatur et nihil earum.',NULL,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(22,5,4,1,9,3,3,2,'Incidunt nesciunt.','2017-10-04','Qui iure veniam vero ea aut rem. Itaque voluptas nam praesentium ratione deleniti et aut. Maxime sed aliquam velit rerum in. Et fugiat dolorem molestiae sit.','Praesentium impedit esse consequatur aperiam sapiente molestias repudiandae. Cupiditate reprehenderit ea aut. Dolorum eveniet sunt unde ex sit. Saepe ullam corrupti molestiae natus assumenda impedit aspernatur. Nam est in ipsa earum eius quo. Labore molestias harum praesentium est non. Sit libero velit molestiae rerum laboriosam qui a quas. Praesentium commodi iste voluptatem nobis quibusdam. Dolorum temporibus exercitationem totam praesentium fugiat quod. Repellendus quam sequi fugit blanditiis doloribus eum. Porro ea recusandae autem laborum voluptatem. Est voluptate et nesciunt est. Qui et quidem perspiciatis placeat. Id laborum facilis dicta incidunt et.',NULL,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(23,1,1,2,23,3,2,2,'Amet a.','2017-09-15','Non id animi eius error nobis delectus. Aut nihil aut voluptatibus sed ut. Nulla sed quas amet beatae modi. Qui qui accusantium provident.','Adipisci qui at quis numquam et mollitia. Quisquam reprehenderit ex quasi doloribus. Nemo sit est suscipit. Saepe hic voluptates vitae autem vero officia. Repudiandae at sed soluta est ex magnam. Quia adipisci corporis qui doloribus esse facilis. Reprehenderit molestiae vero quos excepturi occaecati in. Vel sit est consectetur cumque qui a. Quia labore magni est. Culpa nobis eius perspiciatis quis voluptas. Et quam temporibus nostrum commodi dolorem. Culpa eos est ullam voluptatem molestiae. Nobis non veniam quis. Enim similique dolor qui rerum sit velit nesciunt iure.',NULL,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(24,20,1,2,10,5,17,4,'Rem quia.','2017-07-25','Atque repellat sapiente autem. Voluptatem aut id porro nisi vero voluptatem nihil. Voluptatum asperiores fuga earum. Quo libero enim dolore rerum.','Vero iste vitae id molestias. Necessitatibus possimus earum autem inventore voluptatem. Voluptas est doloribus laborum dolores eos. Quia voluptatem dolor aut voluptatem. Neque doloremque id magnam labore. Officiis magnam laudantium velit. Magnam nulla cupiditate qui in. Consequatur quidem et debitis nisi voluptas maiores iste. Quisquam cumque et quisquam quaerat. Ipsa enim voluptatem quas nemo. Ut tenetur optio et ea repellat qui rerum. Qui quibusdam repellendus quas occaecati. Consequuntur dolores et rerum aut. Distinctio ea dolores ad tenetur. Nulla dolorum reiciendis quia sit eos minus veniam harum. Cum sit consequatur quo cumque est.',NULL,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(25,NULL,3,2,19,6,8,6,'Non consequatur.','2017-05-17','Corporis nesciunt doloremque qui et nesciunt. Laborum aspernatur repudiandae aut qui et. Distinctio modi ut itaque in dicta dolores veritatis rerum. Et voluptas eligendi ut perferendis et. Quo dolores omnis doloremque qui et a.','Aut iure perspiciatis quas ut voluptatem veritatis debitis. Vel enim enim officiis quia. Rerum eos magni sit ipsa vitae. Quisquam ratione nisi ipsam hic explicabo corrupti in. Recusandae in eveniet dolore qui. Fugiat sequi illo dignissimos ipsum modi nulla. Ea repudiandae aut corrupti dolores voluptatem voluptatem. Qui inventore sit vitae perferendis quia sit et. Non hic quibusdam omnis et. Explicabo suscipit fuga et porro dignissimos repellat. Ipsa id blanditiis et in delectus. Provident aut autem explicabo. Atque velit et eligendi explicabo ea eos. Sint ipsa sint qui ut amet sit. Error dolorem veritatis et qui consequatur dolorem nam rerum.',NULL,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(26,NULL,3,1,6,5,17,6,'Suscipit omnis.','2017-08-07','Libero ut occaecati a iure maiores saepe accusamus et. Quo sit corporis ipsa ut voluptatum mollitia quis reiciendis. Explicabo sunt suscipit ex aliquam. Molestiae laborum expedita consectetur possimus.','Quos non dolore neque voluptate rerum sunt. Error unde exercitationem eum quibusdam voluptas voluptas similique. Inventore nihil corporis eos voluptas. Dolores aliquid consequatur et maiores sint. Dolor consequatur sint repudiandae asperiores. In rerum rerum libero delectus magni provident. Omnis illum porro nesciunt voluptas vel sint est. Ducimus iusto tempora ut labore nihil qui ea et. Eum aut illo quas sit totam. Consequatur soluta qui doloremque tenetur. Velit laboriosam aut nihil iure qui voluptatum. Soluta blanditiis nihil illum maiores incidunt aut asperiores. Fugiat necessitatibus nesciunt tempore consequatur et magnam.',NULL,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(27,8,4,2,11,2,9,1,'Corporis aliquam natus.','2017-09-26','Nulla consequuntur vel doloremque sint inventore praesentium et. Tenetur in vero nam voluptatem. Aliquid natus error quasi et voluptatum. Quis non quaerat sit nulla. Architecto dignissimos asperiores rerum dolores ratione est aut.','Neque officiis sapiente sed sed error ex. Error voluptate quo ut atque. Aliquam quis eius alias porro accusamus. Rerum hic neque velit itaque est. Ad et officiis labore in exercitationem porro. Blanditiis ipsam rerum maiores ut dolores nostrum et. Consequatur tempora nostrum voluptas tenetur enim eum ab. Reprehenderit quia ab dicta nihil ab. Omnis eveniet architecto qui aut omnis fugit veniam. Eius rem saepe et nam quo culpa. Dolores aut repudiandae modi debitis repudiandae mollitia. Accusamus omnis tempora aliquid molestiae iusto amet consequuntur. Non quibusdam voluptatem soluta rerum odit quia et. Quia odit et veniam est non laborum.',NULL,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(28,4,4,2,9,6,12,6,'Est alias.','2017-09-06','Pariatur quia at veniam temporibus. Reiciendis aspernatur qui aut. Eum et non non molestiae est.','Asperiores enim aliquam nihil omnis possimus ipsam. Pariatur ut reiciendis esse. Laborum enim natus enim nam a dolorum necessitatibus. Eaque rem odit ipsam sit earum nam. Ut minus corporis cumque voluptas aperiam autem in. Distinctio ducimus explicabo maiores et molestiae aliquam. Sed in voluptas nostrum sit. Atque qui aperiam dolores sunt porro. Qui odit ut vel ratione reiciendis aut eligendi dolorum. Debitis facilis eum voluptatem quia possimus molestiae. Ullam fuga est unde nostrum quis aut tempora. Dicta velit enim porro nobis iusto et beatae et. Consectetur delectus accusantium totam molestiae. Quaerat vel magni vel consectetur earum voluptas voluptatum.',NULL,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(29,14,2,2,20,2,18,5,'Est omnis.','2017-10-07','Modi aut porro itaque nemo ut sint occaecati. Quo suscipit tenetur qui voluptas et debitis porro. Quaerat rem fugiat magnam autem tempora aut omnis.','Officiis qui impedit aliquam repudiandae. Quis nemo doloremque quis quia. Aut et sed ipsa autem ut consequatur laborum. Pariatur consequatur consectetur consequatur et maiores. Sit enim qui a consequuntur vel. Illum ab adipisci voluptatem aut eum nihil totam. Commodi sit exercitationem tempore sunt est repudiandae illum. Reiciendis quidem distinctio quia esse. Sint officia eaque officiis sit. Voluptatem recusandae officiis excepturi dolorem. Laudantium tempore ea nihil vitae rerum doloribus. Perspiciatis nobis architecto aut error fugit. Sed enim molestias et doloremque soluta eos aut numquam. Quia ut quisquam molestiae voluptatem inventore ad.',NULL,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(30,NULL,3,1,16,5,18,4,'Tenetur est.','2017-09-30','Vel deserunt et beatae. Autem ut incidunt aut harum aut enim et.','Placeat ut reiciendis recusandae rerum id. Atque voluptas voluptatibus unde sed. Facere quisquam inventore ut reprehenderit. Enim reiciendis et illum ullam. Qui aut ut praesentium dicta dicta voluptates nostrum qui. Quia itaque reiciendis ea corrupti ut enim voluptas. Itaque harum nobis sed sit. Cumque molestiae repellat modi commodi. Aliquam labore est fuga inventore. Et earum doloremque esse voluptatum est quae illum vel. Nemo iure eaque soluta nostrum. Tenetur similique est dolorem nihil perferendis sequi et. Est sequi iusto placeat rerum placeat laboriosam. Id voluptas voluptas quod enim et vero quo. In eius omnis illo dolorem odio qui quia error. Commodi iste omnis aut placeat facere.','CHF 3808900','2017-11-14 16:14:31','2017-11-14 16:14:31'),(31,18,4,2,24,5,13,3,'Ut sit et.','2017-07-03','Culpa voluptas facilis consequatur ex unde. Iure molestiae enim distinctio. Numquam aliquid dolores repellendus maiores. Beatae qui vero inventore.','Velit est quidem dolores nemo non et. Excepturi et suscipit voluptatem praesentium vero. Aut quod sit quam alias. Adipisci et ut laboriosam id qui ex et. Perferendis quae neque sed. Consequatur quas pariatur magni beatae ad. Et placeat est vel sint pariatur dolorum qui quidem. Qui consequatur tenetur quaerat illo cupiditate sequi. Quia sunt velit ex eos minima consequuntur repudiandae voluptas. Animi corporis officiis culpa non et voluptas. Mollitia sed enim enim et quia expedita eaque. Quisquam accusantium quos nisi voluptatem repudiandae sequi nisi. Est quisquam saepe id corporis et.','CHF 8328100','2017-11-14 16:14:31','2017-11-14 16:14:31'),(32,17,2,1,13,6,5,5,'Delectus quia quis.','2017-09-06','Expedita qui nobis tempore quo. Perferendis pariatur qui consequuntur dolorem aliquid aliquid nemo. Quae distinctio nesciunt quisquam rerum laborum. Cum corrupti sed est velit aut doloribus in. Quia ut id temporibus inventore numquam quidem.','Maxime laborum nihil officiis voluptatem itaque. Quasi sit et quaerat fugiat earum. Dolorem voluptatem deleniti odio enim aut eius aut. Neque temporibus sint aut asperiores eligendi. Et nihil illo aperiam repellendus quos dolor. Magni rerum eligendi reiciendis tempore perspiciatis nisi architecto. Praesentium et voluptatem necessitatibus dolorem velit. Animi voluptatem omnis deleniti eos. Consequatur quae perspiciatis ex voluptas sed eum et neque. Nulla debitis illum et debitis quam illo. Quis deserunt occaecati nostrum voluptatem. Quo omnis quia cupiditate delectus sit dolores quis. Et labore enim et optio harum.','CHF 3880400','2017-11-14 16:14:31','2017-11-14 16:14:31'),(33,19,4,1,4,3,16,4,'Enim odio.','2017-10-12','Doloribus sed et nemo voluptatem dolores. Asperiores sunt tempora voluptas voluptas quibusdam. Ab aut rerum adipisci eaque accusamus. Quia cupiditate vel possimus qui dolor ut ut dignissimos.','Modi voluptas fuga odit iste dolor. Cumque voluptatem fugiat distinctio praesentium. Voluptatibus quaerat commodi inventore dolorem officiis sit. Culpa atque deserunt aut est omnis aut. Sint est rerum nostrum velit maiores et facilis. Eaque magnam accusamus velit incidunt quasi quisquam. Ipsa et ut aliquid in vero debitis quasi. Aut reiciendis porro velit a rem. Minus ullam voluptatibus eum. Molestiae ad consequatur omnis possimus qui enim accusantium. Dolorem illo optio quo iste modi. Assumenda omnis assumenda illo sit distinctio. Ad ut aspernatur voluptatem. Hic accusamus commodi aut quo. Quas omnis nostrum corporis qui. Aut fugit consequatur voluptas quia repudiandae ipsam hic dolor.',NULL,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(34,3,3,2,11,1,5,2,'Aut blanditiis.','2017-08-10','Similique facere et non accusamus qui nostrum dolorem. Animi maxime ipsa natus culpa. Quae optio voluptates consequatur sapiente ab. Dolor dolor omnis dignissimos voluptatum tempore.','Sed id consequatur autem hic. Ut quia consequuntur non nesciunt qui quia. Sit repellendus in qui. Occaecati aut enim ratione quo. Reprehenderit quod rerum omnis soluta eum. Minima deserunt fuga labore. Labore aut totam aspernatur dolorem. Esse dolorum sed repellendus dolores dolores. In et necessitatibus sit quia voluptatem. Aut repudiandae cumque inventore iure dolores rerum. Ut laboriosam et aliquam consequatur saepe atque rerum. Minima illum officiis enim incidunt nobis aut. Enim omnis atque sunt recusandae nostrum. Quia omnis quae commodi natus. Qui laboriosam earum doloremque. Accusamus recusandae atque quae temporibus ex eos.',NULL,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(35,9,3,1,6,1,13,1,'Quo vero.','2017-05-31','Doloremque tenetur perferendis non quas modi a iusto. Doloribus eum molestias harum tempora ut modi. Velit et asperiores molestias fugit ut doloribus. Magnam porro qui exercitationem corporis iste molestiae modi quaerat.','Doloribus aut sed impedit quia non veniam nobis. Enim numquam numquam sed commodi iure sit voluptatum. Corrupti assumenda ut vitae eum. Et unde hic dolorem sit ut. Sunt aliquid ipsam omnis sequi possimus. Hic id consequatur ea esse. Delectus nihil et labore qui sequi modi iste est. Nemo omnis quis rerum reprehenderit assumenda. Possimus perferendis et est et vel. Ipsum numquam quis ipsum sapiente tenetur at quia consectetur. Accusamus modi impedit reiciendis consequuntur commodi autem. Est quia porro ut qui in. Quis odit aut non ut rerum similique sit. Ad qui et consectetur fuga quia. Quia expedita numquam velit atque. Sint facere porro maxime labore voluptatem minus excepturi.',NULL,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(36,6,2,1,23,2,4,5,'Expedita eum nihil.','2017-07-05','Fugiat maiores totam et error excepturi quaerat aut. Itaque autem possimus qui est aliquam culpa ad. Molestiae necessitatibus doloremque voluptates fugiat voluptatem. Repellat est ullam debitis consequatur nihil ut non.','Minus maxime delectus quae. Veniam nihil perferendis veniam cupiditate velit est itaque. Ducimus voluptas cupiditate dolorum laborum modi aut. Consequatur facere corrupti suscipit. Atque et quibusdam repellendus deserunt commodi ad unde consequatur. Dolor non magni sed et similique. Quo vel saepe sint laudantium incidunt voluptas. Non nulla porro dolores non. Itaque necessitatibus et dolorem. Earum animi quaerat et libero nemo. Voluptatem quo sed placeat modi corrupti hic. Temporibus laboriosam suscipit occaecati ut aperiam labore. Est eaque molestiae et dolorum dolorem eaque. Alias deserunt id praesentium autem et facere.','CHF 9936400','2017-11-14 16:14:31','2017-11-14 16:14:31'),(37,13,4,2,2,3,6,1,'Ut sunt.','2017-05-12','Suscipit quia doloribus quaerat. Perspiciatis eius architecto soluta enim fugiat. Sit nobis laboriosam molestiae consequatur. Consequatur et dolorem repellendus sapiente voluptas qui.','Consequatur aspernatur ad unde nobis odit dignissimos. Quia eveniet sit aut nisi velit nulla. Facilis laudantium beatae eveniet illum error sunt qui et. Vel sed placeat sed natus natus quas. Sit eveniet sint eius recusandae nulla perferendis. Ducimus vero sapiente officiis sequi qui. Repellat facere et quia vel nesciunt facere et. Nihil architecto alias aut. Quis perspiciatis possimus facilis animi quod earum soluta. Vero facilis optio iure. Aut eum et amet fugit. Earum placeat dolorum voluptas cum cumque. Nobis suscipit error quos voluptatem rerum et. Eum tempore non dolor impedit. Mollitia temporibus voluptatum odio incidunt. Sed placeat mollitia qui hic.',NULL,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(38,12,1,1,7,5,20,1,'Nesciunt alias ut.','2017-07-15','Omnis reprehenderit eum et delectus sit quia aut. Sit rerum qui nihil. Non eum est et. Incidunt unde nihil ullam est soluta omnis.','Aut dolor excepturi qui quaerat ipsam exercitationem. Et id iusto aut ut ea. Voluptas ex iste ut ipsam ullam ex non est. Fugit nam error quo eum dolores. Laborum voluptas asperiores ullam voluptatem. Saepe nostrum enim a optio iste distinctio. Labore reiciendis nulla sunt minima fuga. Eveniet eligendi ut illo et. Est architecto quia at optio quisquam aut expedita. Esse esse nam qui sed molestiae. Ut temporibus qui sit iste quaerat placeat. Saepe et quod neque aliquam. Neque quo nisi est est voluptates. Qui dolores voluptatem consequuntur ea nesciunt.',NULL,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(39,NULL,3,1,19,3,19,4,'Sit quos.','2017-07-03','Et quae voluptas suscipit et exercitationem est est saepe. Reiciendis accusantium qui exercitationem officia. Velit qui eius ducimus explicabo. Et ex debitis labore sequi. Laudantium rerum quidem tenetur quaerat cumque repellendus alias.','Nemo ullam quae odio. Maiores quisquam dolor aliquid atque est modi minus. Velit repellat similique dicta modi eaque. Repudiandae explicabo pariatur voluptates enim laborum. Quia tempora suscipit voluptas. Id accusantium perferendis eveniet laborum. Quisquam modi totam quas non ullam. Eaque et non tenetur aut odio cupiditate id. Iure unde magnam vel vel. Officiis cupiditate fugit temporibus ut voluptates sequi cum. Doloribus at magni nihil magni ut enim. Qui asperiores quam dolore eum dicta quia. Sunt voluptatem est dolores voluptatem. Accusamus quidem ullam pariatur ut. Molestiae sit omnis distinctio ut. Asperiores explicabo qui rerum explicabo.','CHF 4862100','2017-11-14 16:14:31','2017-11-14 16:14:31'),(40,6,1,1,5,5,2,2,'Architecto dolore.','2017-06-20','Facilis consectetur praesentium sapiente consequuntur voluptas. Molestiae dolorem odio sed sunt minus et fugiat. Inventore itaque fugiat accusantium dolore. Ex corrupti dolorum excepturi laborum sequi.','Ratione veniam occaecati vel velit consectetur. Modi nisi eos ea illo corporis eveniet reprehenderit. Beatae dolores labore exercitationem. Earum sed animi repudiandae nulla. Dolorem velit animi laboriosam soluta in. Voluptatem sint asperiores accusamus vero maiores. Neque nemo nihil est maiores. Quasi consectetur iure quia culpa delectus odit et. Error quo illo sit. Voluptas ipsam dolorem exercitationem fugiat rerum nihil. Eum nihil dicta consequatur aut debitis nemo et. In rerum laborum aut quidem nihil. Natus deleniti vero exercitationem.',NULL,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(41,10,4,2,9,1,22,1,'Incidunt sunt est.','2017-08-17','Quaerat ut qui esse eum omnis. Aliquam maxime itaque ea blanditiis accusantium. Corrupti assumenda illo fugiat est et.','Eius quis non quasi et qui autem. Qui reprehenderit tempora nam dolore nisi aliquam aperiam. Voluptas nulla eius in harum commodi id omnis. Maiores minima qui voluptas ullam odio beatae ipsum. Sed quaerat eaque quaerat in doloremque enim ipsa. Quo similique reiciendis vel voluptate rem sit. Illo aut molestiae impedit sint. Iusto laboriosam omnis suscipit quidem iste aspernatur molestiae. Et eos similique sed et. Pariatur distinctio accusantium porro et. Vel voluptate earum ducimus velit consequatur quam eos. Iusto omnis alias quibusdam dicta sit laborum perspiciatis optio. Sed qui repudiandae perspiciatis officia iste praesentium et.',NULL,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(42,NULL,4,1,18,2,21,6,'Voluptatem nostrum.','2017-06-06','Enim totam rerum officiis deserunt autem accusamus aut. Aut assumenda dolorem quaerat distinctio labore. Qui in qui animi rerum nihil. Cupiditate odio dolor earum nihil hic.','Et corporis molestiae voluptatem et aliquam voluptatum veniam itaque. Laudantium voluptatem est veniam quis. Qui et in eum dolores omnis numquam. Odio repellendus velit doloribus rerum. Quos voluptatem consequatur voluptas minima suscipit accusamus. Quibusdam temporibus nihil et repudiandae qui dolor et. Voluptatibus ab omnis eos ullam exercitationem non. Praesentium dolorem asperiores accusamus aut. Praesentium voluptas rerum dolorem eos est. Et et sit distinctio iste quia magnam. Iusto blanditiis consequuntur minima est exercitationem eos dolorem fugiat. Corporis error ut commodi mollitia nostrum quod tempora.',NULL,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(43,7,4,1,5,4,17,2,'Libero repellendus.','2017-04-30','Molestias molestiae facilis exercitationem. Provident rerum tempora iste adipisci et voluptatibus error quibusdam. Doloremque animi veritatis deserunt temporibus eum vel. Id inventore cupiditate repudiandae recusandae qui.','Aperiam quia sapiente et illum. Nihil quasi modi aut quo neque facere. Veniam deserunt commodi voluptatem est. Sunt voluptates sit dicta animi possimus dolorem. Nisi nobis nostrum consequatur sapiente rerum iste. Sint incidunt sapiente dolor voluptas. Autem ut animi omnis optio molestiae ducimus earum voluptate. Voluptates atque provident corrupti enim placeat. Hic sed dolores illo quia. Dolor exercitationem fugit aperiam impedit recusandae. Consequuntur unde sapiente natus molestiae cumque in ullam. Voluptatem ut et ipsa aut.','CHF 5115300','2017-11-14 16:14:31','2017-11-14 16:14:31'),(44,4,3,2,9,3,14,4,'Omnis inventore.','2017-07-28','Omnis facilis dolores cumque minus eos. Laboriosam aut aut voluptatum magnam autem sit. Magnam quidem molestias quo atque vel est repellendus necessitatibus.','Voluptas repellendus assumenda est autem numquam qui. Ad eaque quo soluta sunt possimus perferendis. Consectetur praesentium velit pariatur ullam beatae. Quia consequuntur excepturi et maiores qui sed dolor omnis. Autem sed accusamus itaque. Expedita cum qui doloremque aut. Consequatur voluptate deserunt quis qui quos at voluptas. Molestias odit vitae accusamus natus mollitia maxime voluptatem voluptas. Et molestiae voluptatibus autem laboriosam perferendis. Voluptatem modi voluptatem voluptatem quo. Cumque quis est ut et reiciendis. Consequuntur blanditiis et dolorem illo dolore itaque saepe harum. Id fuga aut assumenda iure quia vel. Consectetur in autem harum deserunt et a culpa non.',NULL,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(45,18,3,1,21,5,25,4,'Qui voluptas.','2017-08-18','Sit recusandae consequatur quis. Dignissimos dolorem maiores veritatis nihil sunt.','Vero nobis praesentium culpa rerum est quam. Modi quaerat quam ab consequatur. Velit aut dolorem odit odio laudantium voluptatem. Ratione dolore sed minus voluptatum sunt velit. Voluptate molestiae magnam sint qui rerum. Aut quaerat qui pariatur non vitae veniam quo voluptas. Ut aliquid animi asperiores recusandae quam porro possimus dolorem. Sequi perferendis placeat quo perspiciatis fugiat. Quia fuga occaecati voluptas laboriosam. Porro libero et consequatur. Sed voluptates corrupti debitis ducimus saepe dolore. Cupiditate quia delectus fugiat ea repellat est.',NULL,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(46,14,1,1,2,1,4,3,'Tempore quisquam.','2017-06-10','Est consectetur voluptatem temporibus explicabo fuga. Molestiae omnis et sequi eligendi. Tempore asperiores beatae commodi tempora hic sunt.','Qui totam et commodi odio aut rerum. Occaecati et molestiae culpa. Reiciendis voluptatem id explicabo non assumenda dolore. Qui facere dolorem non. Laboriosam ut est expedita perspiciatis perferendis vel. Et ut ut quo. Quidem numquam blanditiis omnis inventore totam qui magnam. Est velit voluptas excepturi eaque non id. Voluptatum illum debitis eos accusantium. Recusandae et enim illo quod tempore. Nisi vero numquam eligendi. Aut hic et necessitatibus repellat. Nihil inventore voluptatum tempora eos ex possimus quia. Qui aut nam aut aliquam.',NULL,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(47,3,2,1,23,3,10,4,'Blanditiis suscipit voluptates.','2017-06-08','Vero neque inventore vel omnis sunt. Quia odio placeat dolorem. Minus qui fugit temporibus debitis fugiat. Officia at atque totam distinctio doloremque. Earum ut consectetur est.','Quisquam eos provident ipsam consequatur voluptates temporibus. Et debitis laborum nulla enim qui ad. Officia minus qui corrupti cupiditate velit. Voluptate ea quidem distinctio aspernatur perferendis rerum esse. Soluta cum enim maxime iusto pariatur. Odio odio odio ut voluptas quibusdam omnis. Minus aut ducimus aliquam dicta rerum deserunt vel. Nulla optio ut aperiam illum ut molestiae dolore. Consequatur tempore molestias sunt. Ipsam iusto sunt ratione. Voluptatem voluptas error et corporis. Quis dolore exercitationem rerum natus qui atque. Qui qui quis illo eveniet exercitationem quasi.','CHF 7030400','2017-11-14 16:14:31','2017-11-14 16:14:31'),(48,NULL,3,2,7,6,11,1,'Magnam natus qui.','2017-09-10','Eligendi mollitia doloribus quis similique. Ipsum ad repudiandae itaque doloremque reiciendis numquam. Voluptatem voluptatibus est exercitationem error alias. Aut et sit autem cupiditate expedita.','Et minima harum molestias ullam et ab. Quia omnis molestiae tenetur nihil. Repellat veniam laborum sint quisquam. Quae at voluptate praesentium deserunt adipisci commodi pariatur consectetur. Dicta alias dolores nesciunt vel. Blanditiis iure a quisquam voluptas. Inventore quo voluptatem qui illum. At in magni ut sed sunt optio. Voluptas similique a minima et rerum. Eius autem laboriosam molestias quia est est incidunt. Impedit provident voluptate delectus laboriosam voluptatem. Enim sit quis excepturi vel sit aliquid laboriosam. Et sed libero aut inventore doloribus odit. Ducimus facere dicta modi aut accusamus. Ad delectus sequi nam similique omnis qui.',NULL,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(49,NULL,2,1,9,4,9,3,'Et voluptates ut.','2017-08-20','Porro et aut atque doloribus. Est enim eius consequatur tenetur ut. Aliquam aut corrupti odio error repellendus. Hic enim est enim perferendis a. Id incidunt vero iusto. Porro vel est vitae rerum consectetur eius velit.','Voluptate est ut dolorum architecto eaque nihil. Et veritatis hic sunt. Quasi ut necessitatibus quo. Doloribus consequatur mollitia cupiditate neque tempora illum incidunt laborum. Porro rerum et nobis iste aut. Nobis est voluptas corrupti sed in. Nemo tempore ducimus sapiente cupiditate laboriosam nobis nihil. Eveniet saepe inventore vitae enim. Minima consectetur iusto accusamus hic. Aspernatur hic voluptatem consequuntur modi saepe. Quisquam adipisci sed odio. Omnis debitis quia doloribus ullam doloremque. Et similique at voluptas est.',NULL,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(50,8,4,2,5,1,18,2,'Minima ut nihil.','2017-06-29','Quo voluptas asperiores ea eos odio quisquam sint. Aut blanditiis ut mollitia minus. Odio sequi exercitationem facilis ut minima ea autem. Ut optio hic ut corporis possimus. Modi qui natus facilis nihil rerum.','Qui nihil minus recusandae excepturi similique ipsa recusandae. Dignissimos minus fugiat autem quia. At a qui perspiciatis laudantium autem laudantium quisquam. Saepe cumque modi soluta. Velit quo nulla et tempora laborum vero illo vel. Aut non et facere repudiandae pariatur illum enim. Ut id ut omnis qui. Tempora asperiores cupiditate quia voluptatem odit. Libero fugiat aspernatur quia laborum quis corporis facilis. Ut illo autem laudantium quia quod exercitationem et laboriosam. Magnam blanditiis nam sit debitis consequatur. Harum magni et magnam id. Assumenda ut non voluptatem quia quos consequatur dolores qui. Suscipit culpa reprehenderit similique inventore voluptas et.',NULL,'2017-11-14 16:14:31','2017-11-14 16:14:31');
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
INSERT INTO `project_categories` VALUES (1,'projectCategory1','2017-11-14 16:14:31','2017-11-14 16:14:31'),(2,'perspiciatis','2017-11-14 16:14:31','2017-11-14 16:14:31'),(3,'voluptas','2017-11-14 16:14:31','2017-11-14 16:14:31'),(4,'dolor','2017-11-14 16:14:31','2017-11-14 16:14:31'),(5,'veritatis','2017-11-14 16:14:31','2017-11-14 16:14:31'),(6,'molestias','2017-11-14 16:14:31','2017-11-14 16:14:31'),(7,'est','2017-11-14 16:14:31','2017-11-14 16:14:31'),(8,'in','2017-11-14 16:14:31','2017-11-14 16:14:31'),(9,'sed','2017-11-14 16:14:31','2017-11-14 16:14:31'),(10,'qui','2017-11-14 16:14:31','2017-11-14 16:14:31');
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
  `description` longtext COLLATE utf8_unicode_ci DEFAULT NULL,
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
INSERT INTO `projects` VALUES 
(1,1,1,1,7,2,'Büro','project-1','2016-07-20 09:41:49','2017-05-28 07:44:13',NULL,'Eine Beschreibung zum Büro Projekt',NULL,NULL,NULL,1,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(2,25,1,2,7,4,'Test Project 2','test-project-2','2016-04-09 09:52:27','2017-09-21 06:39:12','2017-10-15 11:01:36','Cum ducimus vitae quam omnis ea. Odio quis est officia voluptatibus corrupti commodi. Minima reprehenderit laborum cumque molestiae aut numquam. Aliquam est quod expedita laudantium qui ipsa ratione. Ut officia est rerum reprehenderit autem voluptatem.','CHF 9303200','CHF 9303200',NULL,1,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(3,19,2,9,18,1,'Test Project 3','test-project-3','2016-04-07 22:56:10','2017-06-20 06:21:16',NULL,'Quas quo totam quia doloremque numquam itaque. Voluptas quidem dolorum neque repudiandae. Non dolor voluptatibus nihil occaecati ut. Soluta sequi ut dignissimos omnis eveniet et nihil.','CHF 7734300','CHF 7734300',NULL,1,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(4,12,1,9,20,3,'Test Project 4','test-project-4','2016-05-23 06:00:19','2017-11-06 08:17:02',NULL,'Et doloremque quia commodi modi quia culpa. Autem quae perferendis enim id. Consequuntur provident beatae culpa consequatur aut ducimus dignissimos. Consequatur accusantium excepturi magni qui at et.','CHF 6237100','CHF 6237100',NULL,1,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(5,17,2,1,15,1,'Test Project 5','test-project-5','2017-04-06 04:10:02','2017-05-14 03:46:47',NULL,'Labore labore minus iste corrupti rerum. Aut totam sit consectetur omnis. Nobis qui recusandae tempore molestias expedita fugit delectus. Delectus laudantium sed iure quia illo neque omnis.','CHF 3631200','CHF 3631200',NULL,1,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(6,14,2,7,8,6,'Test Project 6','test-project-6','2015-11-28 03:28:26','2017-07-04 19:59:14','2017-11-11 07:13:27','Placeat et similique delectus nobis dolore accusamus qui. Et aliquam et at quod consequatur. Commodi qui voluptate quia rerum ut enim rem. Voluptas harum totam saepe.','CHF 2899400','CHF 2899400',NULL,1,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(7,10,1,10,7,6,'Test Project 7','test-project-7','2016-12-05 06:14:22','2017-06-12 23:04:10',NULL,'Qui recusandae nam quia non vitae eaque. Temporibus optio nisi sequi et eaque esse officia fugit. Voluptatibus quam quaerat aut.','CHF 2102000','CHF 2102000',NULL,1,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(8,11,1,6,24,3,'Test Project 8','test-project-8','2017-02-06 07:54:04','2017-05-06 16:50:06',NULL,'Illo aut quod exercitationem numquam quia. Aut hic autem voluptatem placeat. Explicabo est et modi aut. Deleniti qui quisquam facere esse quia et et.','CHF 9369500','CHF 9369500',NULL,1,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(9,3,1,7,25,3,'Test Project 9','test-project-9','2016-04-01 04:37:50','2017-08-25 08:05:29',NULL,'Provident magni eius nulla distinctio qui. Ut et magnam qui officia ea. Expedita ratione et sit reiciendis sunt molestias iure. Et molestiae laborum sequi laborum distinctio suscipit aut.','CHF 2996200','CHF 2996200',NULL,1,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(10,2,1,7,13,2,'Test Project 10','test-project-10','2017-02-01 22:46:38','2017-09-28 07:32:18',NULL,'Beatae et et quis illum molestiae. Omnis exercitationem velit repellat sit cum vitae sunt vel. Molestiae sit nihil nobis non.','CHF 79329800',NULL,334,0,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(11,25,1,7,15,3,'Test Project 11','test-project-11','2016-11-19 18:39:38','2017-05-23 06:43:56',NULL,'Facere maiores dolore et. Debitis reprehenderit sequi occaecati rerum occaecati mollitia occaecati et. Deserunt dignissimos repudiandae eos. Dolores debitis ut sint est quo.','CHF 28360300',NULL,843,1,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(12,9,2,5,24,4,'Test Project 12','test-project-12','2016-03-21 12:30:27','2017-07-17 02:13:22',NULL,'Cumque officia id quidem commodi ullam. Fuga praesentium et sunt magnam soluta. Neque id sunt omnis deleniti error. Voluptates ea in dolores ut tempore modi. Aperiam repudiandae mollitia molestiae voluptate cum dolorem reprehenderit.','CHF 18515900',NULL,940,1,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(13,23,2,4,16,1,'Test Project 13','test-project-13','2017-03-04 00:42:39','2017-07-27 18:24:43','2017-10-22 12:32:38','Odio magni est voluptatum. Optio adipisci corporis qui quis molestiae corporis. Adipisci quibusdam reprehenderit omnis voluptas. Ut et aut minima quos est cumque facere numquam.','CHF 15807000',NULL,432,1,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(14,21,2,7,24,5,'Test Project 14','test-project-14','2016-04-18 19:43:55','2017-08-01 11:14:43','2017-09-25 22:49:47','Reiciendis autem inventore harum animi ea nihil. Sed rerum perferendis aut saepe et nostrum consectetur. Odit est dolorem facere et. Recusandae ut quibusdam sit enim aspernatur.','CHF 54257400',NULL,863,1,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(15,22,2,7,23,6,'Test Project 15','test-project-15','2016-06-17 04:21:12','2017-10-24 01:44:29',NULL,'Ut alias quisquam at qui. Molestias maxime adipisci et saepe esse. Sed aperiam rerum nemo animi necessitatibus.','CHF 89397300',NULL,327,1,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(16,22,2,6,17,5,'Test Project 16','test-project-16','2016-09-02 09:15:17','2017-06-03 07:24:33','2017-10-28 11:32:10','Ipsum velit labore sit tenetur totam. Ut consequuntur corporis veniam minima a numquam sed repellat. Atque veniam pariatur quos nulla ipsa dolorem. Eum eum necessitatibus et aut explicabo voluptatem. Reiciendis voluptas inventore et perspiciatis.','CHF 65604800',NULL,953,1,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(17,10,1,5,23,4,'Test Project 17','test-project-17','2016-02-05 18:52:20','2017-09-01 01:59:42','2017-10-08 09:00:09','Quasi autem molestias quis odit. Aliquid veritatis est fuga cumque unde. Ipsam eum amet qui et veniam est. Quibusdam aut omnis labore molestiae consequuntur explicabo sint sequi.','CHF 69012200',NULL,883,1,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(18,21,2,7,9,3,'Test Project 18','test-project-18','2017-04-11 06:07:17','2017-07-02 05:32:05',NULL,'Est quo et culpa minus. Harum reprehenderit qui voluptates voluptatibus numquam dolores suscipit molestiae. Est saepe suscipit nulla voluptate aut. Tempore aspernatur sit eius est distinctio asperiores.','CHF 90811900',NULL,207,1,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(19,10,1,10,8,6,'Test Project 19','test-project-19','2016-12-18 20:01:23','2017-07-09 01:43:30',NULL,'Architecto eius voluptate quisquam molestiae incidunt a aut. Eos quam libero ducimus accusamus. Molestias labore provident error consequatur modi.','CHF 49896700',NULL,165,1,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(20,17,1,7,23,6,'Test Project 20','test-project-20','2017-03-29 01:31:43','2017-10-02 21:35:04',NULL,'Rem omnis consequatur ullam temporibus. Et in dolorem quidem. Enim aspernatur sed est voluptatem officia. Velit laboriosam ut eum nulla ea ut error. Eos blanditiis animi provident omnis et quidem.','CHF 72104700',NULL,757,1,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL);
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
  `description` longtext COLLATE utf8_unicode_ci DEFAULT NULL,
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
INSERT INTO `rate_groups` VALUES (1,1,'Tarifgruppe für kantonale Einsätze','Kanton','2017-11-14 16:14:31','2017-11-14 16:14:31'),(2,1,'Tarifgruppe für die restlichen Einsätze','Gemeinde und Private','2017-11-14 16:14:31','2017-11-14 16:14:31');
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
  `rate_unit` longtext COLLATE utf8_unicode_ci DEFAULT NULL,
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
INSERT INTO `rates` VALUES (1,1,1,2,'CHF/h','CHF 10000','2017-11-14 16:14:31','2017-11-14 16:14:31','h'),(2,1,16,3,'CHF/h','CHF 8100','2017-11-14 16:14:31','2017-11-14 16:14:31','h'),(3,2,21,5,'CHF/h','CHF 10300','2017-11-14 16:14:31','2017-11-14 16:14:31','h'),(4,1,20,4,'CHF/h','CHF 18000','2017-11-14 16:14:31','2017-11-14 16:14:31','h'),(5,2,18,4,'CHF/h','CHF 8100','2017-11-14 16:14:31','2017-11-14 16:14:31','h'),(6,1,21,4,'CHF/h','CHF 2800','2017-11-14 16:14:31','2017-11-14 16:14:31','h'),(7,1,40,5,'CHF/d','CHF 10800','2017-11-14 16:14:31','2017-11-14 16:14:31','t'),(8,2,40,5,'CHF/d','CHF 1500','2017-11-14 16:14:31','2017-11-14 16:14:31','t'),(9,1,41,3,'CHF/d','CHF 3100','2017-11-14 16:14:31','2017-11-14 16:14:31','t'),(10,1,41,4,'CHF/d','CHF 7600','2017-11-14 16:14:31','2017-11-14 16:14:31','t'),(11,1,39,5,'CHF/d','CHF 16900','2017-11-14 16:14:31','2017-11-14 16:14:31','t'),(12,2,61,4,'Einheit','CHF 18500','2017-11-14 16:14:31','2017-11-14 16:14:31','a'),(13,2,61,1,'Einheit','CHF 5500','2017-11-14 16:14:31','2017-11-14 16:14:31','a'),(14,2,54,5,'Km','CHF 13700','2017-11-14 16:14:31','2017-11-14 16:14:31','a'),(15,2,59,2,'Pauschal','CHF 18300','2017-11-14 16:14:31','2017-11-14 16:14:31','a'),(16,2,60,5,'Km','CHF 6000','2017-11-14 16:14:31','2017-11-14 16:14:31','a'),(17,1,79,3,'Pauschal','CHF 10700','2017-11-14 16:14:31','2017-11-14 16:14:31','a'),(18,1,81,6,'Pauschal','CHF 14500','2017-11-14 16:14:31','2017-11-14 16:14:31','a'),(19,2,81,6,'Pauschal','CHF 18300','2017-11-14 16:14:31','2017-11-14 16:14:31','a'),(20,1,73,3,'Pauschal','CHF 2700','2017-11-14 16:14:31','2017-11-14 16:14:31','a'),(21,1,80,6,'Pauschal','CHF 6700','2017-11-14 16:14:31','2017-11-14 16:14:31','a');
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
INSERT INTO `rateunittypes` VALUES ('a',4,'Anderes',0,1.000,3,1,'a','2017-11-14 16:14:31','2017-11-14 16:14:31'),('h',1,'Stunden',1,3600.000,2,1,'h','2017-11-14 16:14:31','2017-11-14 16:14:31'),('m',1,'Minuten',1,60.000,2,1,'m','2017-11-14 16:14:31','2017-11-14 16:14:31'),('t',3,'Tage',1,30240.000,2,1,'d','2017-11-14 16:14:31','2017-11-14 16:14:31'),('zt',3,'Zivitage',1,30240.000,2,1,'zt','2017-11-14 16:14:31','2017-11-14 16:14:31');
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
  `description` longtext COLLATE utf8_unicode_ci DEFAULT NULL,
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
INSERT INTO `services` VALUES (1,2,'consulting','consulting','This is a detailed description',1,0.0800,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(2,4,'voluptas','veritatis-molestias-est-in-sed','Cum ducimus vitae quam omnis ea. Odio quis est officia voluptatibus corrupti commodi. Minima reprehenderit laborum cumque molestiae aut numquam. Aliquam est quod expedita laudantium qui ipsa ratione. Ut officia est rerum reprehenderit autem voluptatem.',1,0.0800,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(3,5,'nihil','est-sit-suscipit-libero-nisi','Quo totam quia doloremque numquam itaque. Voluptas quidem dolorum neque repudiandae. Non dolor voluptatibus nihil occaecati ut. Soluta sequi ut dignissimos omnis eveniet et nihil.',1,0.0800,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(4,3,'ullam','repellat-qui-ipsum-sit-illum','Doloremque quia commodi modi quia culpa corrupti autem. Perferendis enim id beatae consequuntur provident beatae culpa consequatur. Ducimus dignissimos est consequatur accusantium excepturi. Qui at et inventore voluptas.',1,0.0250,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(5,5,'qui','tempore-molestias-expedita-fug','Quia illo neque omnis possimus numquam nostrum. Dolor mollitia repudiandae velit velit sit aut temporibus. Occaecati consectetur eos expedita tempora deserunt molestias quod. Repellendus voluptatum perferendis totam esse.',1,0.0800,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(6,4,'harum','saepe-nihil-mollitia-consequat','Odio asperiores perspiciatis saepe et natus optio qui. Similique quaerat commodi perspiciatis et placeat autem ratione. Et et ut beatae rerum.',1,0.0250,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(7,2,'nihil','ratione-ea-aperiam-quae-nam-id','Quis sed autem et velit dolores expedita optio quos. Molestiae dignissimos enim maxime tempore mollitia dolorem. In placeat error dolor assumenda enim aperiam sequi. Illo aut quod exercitationem numquam quia.',1,0.0250,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(8,2,'dicta','aut-culpa-illo-quisquam-accusa','Et molestias culpa et facilis est ut. Fugit sed saepe maxime nobis ut cupiditate. Rem repellat voluptas dignissimos molestiae neque culpa.',0,0.0800,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(9,1,'aut','accusantium-voluptatem-adipisc','Autem unde est eaque et. Modi incidunt exercitationem et reiciendis vel facilis sed. Quo est laboriosam beatae et.',1,0.0250,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(10,5,'qui','natus-quidem-enim-voluptatum-l','Sit labore rem voluptas quasi aut. Ea libero veritatis rerum ad incidunt voluptatem facere. Dolore et at debitis reprehenderit sequi occaecati rerum.',1,0.0800,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(11,1,'eveniet','non-qui-soluta-repellendus-nat','Fuga ipsum praesentium cumque officia id quidem commodi. Aut fuga praesentium et. Magnam soluta laudantium neque id sunt omnis. Error omnis voluptates ea in. Ut tempore modi molestiae aperiam.',1,0.0800,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(12,1,'error','labore-sit-a-qui-omnis-dolorib','Cum autem nesciunt et numquam aspernatur. Odio magni est voluptatum. Optio adipisci corporis qui quis molestiae corporis. Adipisci quibusdam reprehenderit omnis voluptas.',1,0.0800,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(13,6,'quia','sed-veritatis-molestiae-dolore','Magni quia maiores reiciendis autem inventore. Animi ea nihil est sed rerum perferendis. Saepe et nostrum consectetur eos odit est dolorem facere. A recusandae ut quibusdam sit enim. Quibusdam rerum vero eos atque voluptatem debitis ut autem.',1,0.0250,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(14,1,'non','fuga-voluptatibus-atque-dolore','Qui incidunt molestias maxime adipisci et saepe. Ipsum sed aperiam rerum. Animi necessitatibus necessitatibus facilis quam aut. Harum reiciendis magnam voluptatum neque.',1,0.0800,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(15,4,'consectetur','ipsum-velit-labore-sit-tenetur','Corporis veniam minima a numquam. Repellat ea atque veniam pariatur quos nulla ipsa dolorem. Eum eum necessitatibus et aut explicabo voluptatem.',1,0.0250,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(16,3,'voluptas','voluptatum-qui-neque-sequi','Voluptate aperiam et aut at natus voluptas est aut. Odio optio itaque qui vel qui quasi. Molestias quis odit sapiente aliquid veritatis est fuga.',1,0.0800,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(17,2,'quia','sit-qui-rem-enim-eos','Maxime hic et fuga expedita est id dolor. Officia perspiciatis autem et et et nihil officia. Sed et pariatur et sapiente beatae ut hic.',1,0.0250,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(18,6,'eius','distinctio-asperiores-laborum-','Iure eaque aliquam qui consequatur neque ut debitis. Explicabo id enim ab. Non quia fuga ducimus tempore necessitatibus. Placeat et aut laborum eligendi. Mollitia sit accusamus architecto eius.',0,0.0800,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(19,3,'iste','occaecati-voluptatem-rerum-opt','At modi assumenda et tempore ex. Vel quasi facilis eveniet repellat facere cupiditate sed rem.',1,0.0800,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(20,3,'velit','dignissimos-est-enim-tenetur','Commodi quis sit eveniet accusamus dolor. Voluptatum cum veniam tempora blanditiis sit vero quo. Quo laudantium necessitatibus et pariatur nesciunt ut tempora. Hic velit rerum quis accusamus sed.',1,0.0800,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(21,5,'consequatur','maxime-soluta-modi-eveniet-est','Molestias provident totam voluptatibus cumque. Fuga voluptas cupiditate voluptas sit sit incidunt aliquid libero. Temporibus ut ad sint pariatur eos. Sint sunt et aspernatur sapiente necessitatibus blanditiis tempora laborum.',1,0.0250,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(22,4,'exercitationem','amet-quia-molestiae-ad-est-fac','Esse et soluta ab voluptatem odio dicta. A vel totam minus rerum harum consequatur autem. Adipisci rem dolores et. Velit in fugit doloribus numquam amet dolor temporibus.',1,0.0800,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(23,6,'similique','omnis-sed-ullam-ut-deserunt-ma','Eaque ut distinctio quo. Est ratione rerum ipsa culpa voluptatem eos. Quia adipisci amet consequatur dolorum. Consequatur quasi perferendis provident dicta sed esse dolorum.',1,0.0250,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(24,2,'et','exercitationem-velit-est-ipsa-','Natus aut est nesciunt aliquam aspernatur. Pariatur modi illo sit accusantium. Est quia sequi nostrum.',1,0.0250,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(25,1,'eos','dolorem-qui-cupiditate-perspic','Error molestias rerum iusto quia. Eum molestiae optio doloribus. Est quidem dolores et magni voluptatem temporibus. Repellat officia ratione voluptatem similique qui ipsam itaque.',1,0.0250,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(26,4,'et','aut-dignissimos-quia-repudiand','Sint nihil rerum in eaque. Modi optio qui ut nisi. Similique nulla et possimus deserunt.',1,0.0250,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(27,4,'minima','cum-ut-et-eius-ut-et-vel-a','Ut vel eum quasi ut est molestiae error minus. Neque repudiandae quae non ad eos. Voluptatem sunt pariatur nulla. Dolor at soluta molestias autem sed et sunt. Velit aut sint voluptatibus ipsa ipsum omnis consequatur.',1,0.0800,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(28,3,'expedita','sint-pariatur-in-eaque','Delectus doloribus perspiciatis aspernatur dolor ut. Est repudiandae quis modi quo maxime voluptates suscipit.',1,0.0250,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(29,3,'quae','qui-nobis-asperiores-corporis-','Odit quo et omnis. Eaque dolorem beatae quasi ipsa vel. Ad voluptatem illum eum eligendi reprehenderit. Quas non et fugiat animi quibusdam labore.',1,0.0800,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(30,3,'eaque','cumque-ullam-velit-ab-qui-minu','Perferendis dicta esse porro aut. Et et quia et enim dolor praesentium optio eveniet. Laborum sed nesciunt quisquam nihil magni eaque nostrum facere. Ipsam et id amet distinctio molestiae non. Sequi excepturi et deleniti asperiores quia.',1,0.0800,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(31,6,'iure','nemo-vel-vel-sequi-aut-aliquam','Impedit aut aliquam nisi quia. Pariatur inventore impedit tempora non eos mollitia fugit. Provident non et necessitatibus sit repudiandae dolorum magnam.',1,0.0800,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(32,4,'eaque','quasi-sit-nam-qui-id','Aliquam minima corporis aut sequi qui consectetur quo. Provident aperiam vel impedit quos. Nesciunt odit esse repellat aliquid animi. Quia error libero nostrum quas illum quia.',1,0.0250,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(33,2,'qui','repellendus-dolor-vitae-illo-m','Consequatur commodi odit qui doloribus a. Et veritatis esse dolorem cumque sunt. Minus accusamus laudantium possimus laboriosam optio et.',0,0.0250,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(34,1,'est','accusamus-optio-enim-in-eaque-','Quis voluptatem cum dicta quod totam nam. Vel quasi molestiae consequatur vero expedita autem. Quia velit quo impedit est. Praesentium sit quis dolorem. Voluptatum ut rerum excepturi a repellendus ex et praesentium. Eum sint dolorem in.',0,0.0250,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(35,2,'tenetur','sit-tempora-excepturi-officiis','Ex reprehenderit eum consequatur cum quod. Dolores voluptatum esse pariatur et molestias. Iusto quia delectus consectetur eveniet maxime. Cupiditate consectetur at quam officia mollitia eum consequatur corporis.',1,0.0800,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(36,6,'ducimus','sapiente-earum-quia-eius-quo-s','Soluta molestiae tempore et laboriosam sunt qui et. Tenetur qui nihil et. Voluptatum accusamus rem aut quia.',1,0.0250,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(37,3,'aut','quae-voluptatem-est-beatae-ips','Id tempora quas modi fugit eius illo provident. Repellendus fuga aspernatur cupiditate. Deserunt est repellendus repellat rerum. Laboriosam qui quae voluptas earum placeat facilis sunt.',1,0.0800,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(38,3,'provident','corporis-perspiciatis-aliquam-','Quis autem sequi debitis dolor error nobis placeat porro. Quidem dolor et explicabo dolor sunt. Sed excepturi accusamus consequuntur doloremque omnis quas. Deserunt perferendis odit eligendi repellat praesentium rerum est et.',1,0.0800,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(39,5,'nesciunt','itaque-libero-maxime-sit-minus','Qui quas est molestiae nulla non earum sed. Consequatur possimus tenetur consequuntur laborum. Natus est impedit omnis sint explicabo exercitationem porro. Repudiandae recusandae quisquam ipsa veritatis.',1,0.0250,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(40,1,'ducimus','excepturi-eos-ut-harum-et-aliq','Aut consequuntur vero praesentium incidunt ipsam quae. Mollitia voluptas architecto ipsa iure deserunt libero facilis. Voluptatibus consequatur rerum vitae consectetur vero enim inventore sed. Natus enim quis nemo aut voluptatem.',0,0.0800,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(41,1,'ipsa','reiciendis-dolore-quo-molestia','Sed fuga ab quo temporibus. Ad non nisi fuga quia deleniti unde minima eaque. Doloremque nihil quia cum occaecati magnam hic expedita.',0,0.0800,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(42,1,'qui','a-laboriosam-beatae-enim-sunt-','Vel repudiandae doloribus deserunt cumque. Reprehenderit dignissimos maxime et placeat. Nostrum sint quo nesciunt exercitationem vel et.',1,0.0250,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(43,6,'voluptas','recusandae-repudiandae-molesti','Excepturi odit eius voluptatum officia reprehenderit eligendi totam temporibus. Et facilis dignissimos minima mollitia odit modi possimus eveniet. Culpa iste aliquid ipsam commodi blanditiis ipsam. Soluta dolore magni temporibus illum ex eveniet enim.',0,0.0250,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(44,5,'sunt','maiores-et-aliquam-nihil-enim-','Modi natus hic aliquid corporis est eos aut. Non molestias aut ut et sunt consectetur laboriosam. Aliquid voluptatibus commodi vero sint dolores numquam temporibus. Quae earum nihil recusandae facere voluptatem similique.',0,0.0800,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(45,1,'eligendi','voluptatem-pariatur-aut-et-vel','Iusto ipsa consectetur harum nemo laborum cupiditate sint sit. Facilis ut numquam vel tempore et eius fugit. Sunt sequi sed ad quibusdam sequi. Ea pariatur incidunt aspernatur impedit nisi.',1,0.0800,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(46,1,'neque','saepe-quia-laboriosam-autem-do','Aut rem aut quia voluptatem velit accusantium hic. Ipsa recusandae odio rerum. Voluptatem debitis excepturi qui a voluptas. Corrupti totam non aliquid fuga velit sed id et.',0,0.0250,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(47,1,'dignissimos','ullam-eligendi-fugit-fuga-numq','Officiis dolores dolor natus animi labore est nisi. Impedit aut est veniam dicta qui nihil. Et a corrupti quia aut.',1,0.0800,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(48,4,'soluta','laudantium-vel-aspernatur-susc','Ab dolorum cupiditate provident autem omnis reiciendis. Et aut fugiat laborum maiores fuga dignissimos corporis ex. Iure nemo fugit sit nobis iure quae.',1,0.0800,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(49,1,'et','voluptatibus-est-qui-enim-nequ','Fuga corporis suscipit dolores inventore eos tempore. Ullam voluptas et fugiat magni. Assumenda dolorum alias sit deserunt. Porro ullam ducimus molestias fuga et. Iste sunt aut ad molestiae officia ex.',1,0.0250,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(50,4,'nam','facere-molestiae-nisi-et-ab','Perspiciatis similique temporibus odit quasi cum perspiciatis. Dolores tenetur ea adipisci molestiae et. Iusto mollitia sed id voluptates. Velit ut repellendus aliquam.',1,0.0800,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(51,4,'expedita','neque-velit-veniam-modi','Deserunt sunt consequatur nihil cumque. Nihil quidem quia consectetur occaecati vero voluptatem. Consequatur alias voluptatem molestiae provident cupiditate. Quos dolorem perspiciatis odio.',1,0.0250,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(52,2,'molestias','blanditiis-ex-incidunt-magnam','Tempora dolorum fugit maiores. Accusantium deleniti et deserunt debitis sunt qui. Molestiae quia optio sed placeat iusto illo. Qui aliquam voluptatem molestiae eum earum ullam. Ab dolor alias tempora quia qui.',1,0.0250,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(53,4,'optio','ipsa-incidunt-debitis-iure-qui','Ducimus eos voluptate nemo omnis cum et. Fugiat eaque illo officia perspiciatis consectetur aut. Perspiciatis hic earum fugiat. Sit rerum fuga accusamus praesentium a autem enim. Dicta qui et voluptatem eum. Esse sapiente debitis id.',0,0.0250,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(54,3,'est','facere-et-ut-et-consequuntur','Et vero quo tempore commodi maiores est. Totam qui saepe modi qui aut. Dolorem quis placeat saepe ex. Aut maiores nihil saepe voluptatem.',1,0.0250,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(55,2,'saepe','earum-nostrum-consequatur-ipsa','Voluptatum id molestiae aliquam et. Non quam sint quae animi eligendi quam. Accusamus eveniet quae atque eaque. Corrupti molestiae dolorem error facilis.',0,0.0250,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(56,4,'explicabo','maiores-qui-expedita-excepturi','In sunt itaque reiciendis recusandae sit ad magnam distinctio. Laborum aperiam ducimus provident et dolorem aliquam. Autem facere minima eius sed qui sit. Aut voluptatem praesentium rerum reprehenderit dolorum non consequatur.',1,0.0800,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(57,2,'consequatur','consectetur-aliquid-ad-nihil-q','Qui maiores vel quis. Quia voluptatem non explicabo qui reiciendis ut atque. Hic et ducimus nostrum sunt quasi. Sed nihil nostrum cupiditate provident aperiam.',1,0.0250,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(58,4,'magnam','aut-est-pariatur-consequatur-e','Illum delectus dolores eius quibusdam laudantium. Enim explicabo consectetur nihil reprehenderit. Qui eum sed neque nulla.',1,0.0800,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(59,2,'animi','ipsam-adipisci-ut-aut-odit-nih','At nam non nihil nostrum est doloribus dolor. Nam nobis eum temporibus tempore sit. Reiciendis voluptas consequatur placeat quod. Debitis fuga et vel velit illum nisi.',1,0.0800,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(60,1,'beatae','enim-fugiat-est-ut-vero-unde-a','Numquam beatae omnis incidunt magnam expedita aut voluptas earum. Inventore dolor ipsam qui doloribus sed magnam iusto. Cum sed laborum rerum error hic. Debitis excepturi odit fugit fuga eos aliquam voluptate. Adipisci modi veritatis iste tempora.',1,0.0250,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(61,5,'sunt','iusto-sed-quae-ea-porro-et-arc','Quam rerum quod voluptas iusto molestiae optio. Ut quisquam dolores doloremque unde eaque dolorum et. Magnam dolorem et doloribus ipsum. Hic ut cum nostrum corrupti qui dignissimos.',1,0.0250,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(62,5,'sed','et-labore-quasi-perferendis-si','Fugiat est nemo quasi perferendis expedita. Dolores ad natus et et incidunt nesciunt voluptas. Tempore nobis saepe quo est vel. Veniam vero ea aut rem ipsum. Voluptas nam praesentium ratione deleniti et aut aliquam. Sed aliquam velit rerum in et.',0,0.0800,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(63,4,'omnis','saepe-animi-optio-laborum-aut-','Aperiam sapiente molestias repudiandae ea. Reprehenderit ea aut tempora dolorum eveniet sunt. Ex sit quia saepe ullam corrupti molestiae natus assumenda. Aspernatur consequatur ullam nam est.',1,0.0250,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(64,5,'fugiat','quas-repellendus-quam-sequi-fu','Eum porro ea recusandae autem laborum voluptatem dignissimos. Est voluptate et nesciunt est. Qui et quidem perspiciatis placeat. Id laborum facilis dicta incidunt et.',1,0.0800,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(65,4,'rem','ex-non-amet-a-cum-aut-quam-quo','Possimus non id animi eius error nobis. Molestiae aut nihil aut. Sed ut unde nulla sed quas. Beatae modi accusamus qui qui accusantium.',1,0.0800,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(66,6,'reiciendis','nesciunt-sit-et-cumque-molesti','Qui at quis numquam. Mollitia ea quisquam reprehenderit. Quasi doloribus voluptatum nemo sit est suscipit ut. Saepe hic voluptates vitae autem vero officia.',1,0.0800,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(67,3,'consectetur','qui-a-voluptas-quia-labore-mag','Nobis eius perspiciatis quis voluptas. Et quam temporibus nostrum commodi dolorem. Culpa eos est ullam voluptatem molestiae. Non veniam quis itaque enim similique dolor. Rerum sit velit nesciunt iure.',1,0.0800,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(68,5,'sunt','totam-a-rem-quia-unde-tempore-','Explicabo autem voluptatibus harum et est iusto perspiciatis consequatur. Minus qui sit beatae vero ut hic vero quidem. Aliquam culpa voluptas repudiandae iste atque.',1,0.0800,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(69,5,'quo','enim-dolore-rerum-sint-dolores','Debitis dolores vel corrupti vel numquam at. Id provident assumenda deserunt aspernatur possimus illum quasi velit. Iste vitae id molestias accusamus necessitatibus possimus earum autem. Voluptatem ipsum voluptas est.',1,0.0250,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(70,2,'voluptas','iste-cupiditate-nobis-quisquam','Quia ipsa enim voluptatem quas. Et ut ut tenetur optio et. Repellat qui rerum maxime qui quibusdam.',1,0.0250,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(71,3,'quia','voluptates-et-earum-esse-sequi','Facere possimus et enim dolores dolor et ut reiciendis. Pariatur dolores nemo non consequatur. Dolor vitae non pariatur cupiditate.',1,0.0800,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(72,3,'aut','suscipit-commodi-explicabo-rat','Quis tempore repellendus incidunt eum nihil voluptatem. Dignissimos rerum perspiciatis dolorem libero. Aspernatur aut iure perspiciatis quas ut voluptatem veritatis debitis.',1,0.0800,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(73,5,'eveniet','qui-qui-excepturi-fugiat-sequi','Modi nulla nemo ea repudiandae aut corrupti dolores. Voluptatem commodi qui inventore sit vitae perferendis quia sit. Illo non hic quibusdam omnis et aliquam est. Suscipit fuga et porro dignissimos.',1,0.0250,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(74,1,'sint','ut-amet-sit-quia-error-dolorem','Dolorem nam rerum vero porro. Cupiditate aut rerum quia voluptatum consequatur ea asperiores dolorem. Harum deserunt nulla quia enim iure eum. Accusantium impedit aliquam perferendis non consequuntur culpa suscipit.',1,0.0250,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(75,1,'explicabo','suscipit-ex-aliquam-debitis','Consectetur possimus vel non ex. Tempore neque repellendus ut repellat nihil. Occaecati dolorem iure consectetur in.',1,0.0800,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(76,5,'similique','inventore-nihil-corporis-eos-v','Consequatur et maiores sint architecto dolorum. Consequatur sint repudiandae asperiores odio in rerum. Libero delectus magni provident error omnis illum.',1,0.0800,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(77,1,'soluta','nihil-illum-maiores-incidunt-a','Necessitatibus nesciunt tempore consequatur et magnam praesentium et explicabo. Distinctio totam adipisci consequatur quam. Odio illum dignissimos et incidunt eius rerum. Laudantium consequuntur aut magni in.',1,0.0800,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(78,5,'consequuntur','doloremque-sint-inventore-prae','Nam voluptatem nemo aliquid natus error quasi. Voluptatum aut quis non quaerat sit nulla suscipit. Dignissimos asperiores rerum dolores ratione est aut id. Rerum quis cumque et sapiente et rerum velit.',1,0.0250,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(79,4,'labore','exercitationem-porro-molestias','Et voluptas consequatur tempora nostrum. Tenetur enim eum ab qui reprehenderit quia ab. Nihil ab accusantium officia omnis eveniet architecto. Aut omnis fugit veniam ut eius rem.',1,0.0250,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(80,4,'veniam','non-laborum-sit-voluptatum','Dolor repellendus blanditiis eos. Neque maxime vel qui debitis. Enim aliquam ratione iste omnis ut similique est.',1,0.0250,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(81,5,'quo','facilis-occaecati-consequatur-','Voluptates laborum aut ratione cum autem ipsum. Praesentium ut culpa nesciunt omnis eligendi expedita beatae. At asperiores enim aliquam nihil omnis possimus. Quam pariatur ut reiciendis esse. Laborum enim natus enim nam a dolorum necessitatibus.',1,0.0800,0,'2017-11-14 16:14:31','2017-11-14 16:14:31',NULL);
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
  `value` longtext COLLATE utf8_unicode_ci DEFAULT NULL,
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
INSERT INTO `settings` VALUES (1,1,'activity','/etc/defaults/timeslice','action:byName:Zivi*','2017-11-14 16:14:31','2017-11-14 16:14:31'),(2,1,'value','/etc/defaults/timeslice','30240','2017-11-14 16:14:31','2017-11-14 16:14:31'),(3,1,'startedAt','/etc/defaults/timeslice','action:nextDate','2017-11-14 16:14:31','2017-11-14 16:14:31'),(4,3,'name','/etc/defaults/1','New perspiciatis','2017-11-14 16:14:31','2017-11-14 16:14:31'),(5,1,'name','/etc/defaults/2','New dolor','2017-11-14 16:14:31','2017-11-14 16:14:31'),(6,5,'name','/etc/defaults/3','New molestias','2017-11-14 16:14:31','2017-11-14 16:14:31'),(7,3,'name','/etc/defaults/4','New in','2017-11-14 16:14:31','2017-11-14 16:14:31'),(8,5,'name','/etc/defaults/5','New qui','2017-11-14 16:14:31','2017-11-14 16:14:31');
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
INSERT INTO `standard_discounts` VALUES (1,1,'Skonto 2%',0.02,1,1,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(2,1,'Flat Rate 10 CHF',10.00,0,1,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(3,1,'Flat Rate 11 CHF',11.00,0,1,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(4,1,'Flat Rate 12 CHF',12.00,0,1,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(5,1,'Flat Rate 13 CHF',13.00,0,1,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(6,1,'Flat Rate 14 CHF',14.00,0,1,'2017-11-14 16:14:31','2017-11-14 16:14:31');
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
INSERT INTO `tags` VALUES (1,NULL,'perspiciatis',0,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(2,NULL,'voluptas',0,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(3,NULL,'dolor',0,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(4,NULL,'veritatis',0,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(5,NULL,'molestias',0,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(6,NULL,'est',0,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(7,NULL,'in',0,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(8,NULL,'sed',0,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(9,NULL,'qui',0,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(10,NULL,'officiis',0,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(11,NULL,'perspiciatis',0,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(12,NULL,'velit',0,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(13,NULL,'possimus',0,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(14,NULL,'cum',0,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(15,NULL,'ducimus',0,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(16,NULL,'vitae',0,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(17,NULL,'quam',0,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(18,NULL,'omnis',0,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(19,NULL,'ea',0,'2017-11-14 16:14:31','2017-11-14 16:14:31'),(20,NULL,'dolores',0,'2017-11-14 16:14:31','2017-11-14 16:14:31');
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
INSERT INTO `timeslices` VALUES (1,2,7,2,7200.0000,'2017-09-22 10:42:23','2017-09-22 12:42:23','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(2,4,7,4,22072.0000,'2016-06-07 17:52:18','2016-06-08 00:00:10','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(3,5,16,5,6988.0000,'2016-02-12 09:52:38','2016-02-12 11:49:06','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(4,10,22,4,4716.0000,'2017-03-29 03:04:30','2017-03-29 04:23:06','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(5,8,19,4,10966.0000,'2016-08-14 02:37:37','2016-08-14 05:40:23','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(6,2,11,2,10094.0000,'2015-09-10 19:41:40','2015-09-10 22:29:54','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(7,6,22,5,21934.0000,'2015-11-27 12:04:51','2015-11-27 18:10:25','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(8,5,9,3,26661.0000,'2016-12-13 08:33:41','2016-12-13 15:58:02','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(9,8,18,5,25935.0000,'2017-01-07 09:23:42','2017-01-07 16:35:57','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(10,8,14,4,24318.0000,'2015-08-26 23:52:27','2015-08-27 06:37:45','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(11,11,13,5,19100.0000,'2015-10-30 23:45:02','2015-10-31 05:03:22','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(12,8,18,1,13178.0000,'2015-06-02 08:23:52','2015-06-02 12:03:30','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(13,3,25,1,21823.0000,'2015-04-05 08:20:42','2015-04-05 14:24:25','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(14,10,25,6,19892.0000,'2016-07-20 07:49:31','2016-07-20 13:21:03','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(15,3,19,2,10452.0000,'2016-10-23 19:10:08','2016-10-23 22:04:20','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(16,7,18,5,20524.0000,'2016-03-14 21:17:01','2016-03-15 02:59:05','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(17,9,14,2,14539.0000,'2016-10-06 07:56:40','2016-10-06 11:58:59','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(18,4,23,2,20016.0000,'2017-05-24 04:52:39','2017-05-24 10:26:15','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(19,11,21,6,16838.0000,'2017-05-03 15:39:53','2017-05-03 20:20:31','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(20,9,9,5,20465.0000,'2016-08-18 15:14:47','2016-08-18 20:55:52','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(21,6,22,5,16269.0000,'2015-08-09 19:32:05','2015-08-10 00:03:14','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(22,11,13,2,13902.0000,'2015-09-01 20:09:08','2015-09-02 00:00:50','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(23,5,12,2,13316.0000,'2017-03-17 12:20:32','2017-03-17 16:02:28','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(24,11,17,6,25400.0000,'2015-03-25 03:39:07','2015-03-25 10:42:27','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(25,10,10,1,22500.0000,'2015-05-05 12:59:07','2015-05-05 19:14:07','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(26,2,26,6,14647.0000,'2016-05-03 09:25:56','2016-05-03 13:30:03','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(27,7,17,6,19032.0000,'2015-03-23 05:04:17','2015-03-23 10:21:29','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(28,9,26,3,9291.0000,'2015-06-28 14:15:53','2015-06-28 16:50:44','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(29,3,8,2,9075.0000,'2015-09-04 21:34:11','2015-09-05 00:05:26','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(30,3,25,5,19834.0000,'2017-11-01 11:39:47','2017-11-01 17:10:21','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(31,7,24,4,10195.0000,'2016-06-13 16:53:56','2016-06-13 19:43:51','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(32,4,9,4,4891.0000,'2017-06-23 20:26:26','2017-06-23 21:47:57','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(33,8,26,4,6954.0000,'2015-02-25 10:43:12','2015-02-25 12:39:06','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(34,3,11,4,29842.0000,'2015-03-12 05:43:48','2015-03-12 14:01:10','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(35,11,11,1,27481.0000,'2017-04-29 20:45:49','2017-04-30 04:23:50','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(36,5,24,1,26931.0000,'2017-10-16 05:05:51','2017-10-16 12:34:42','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(37,11,23,5,17427.0000,'2017-01-18 06:28:17','2017-01-18 11:18:44','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(38,7,9,3,8132.0000,'2015-03-14 16:25:54','2015-03-14 18:41:26','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(39,5,23,1,4495.0000,'2016-07-07 07:17:14','2016-07-07 08:32:09','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(40,2,26,5,6427.0000,'2015-03-08 01:38:51','2015-03-08 03:25:58','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(41,7,8,5,15529.0000,'2017-09-16 13:17:01','2017-09-16 17:35:50','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(42,10,18,1,29308.0000,'2017-03-05 09:30:31','2017-03-05 17:38:59','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(43,7,15,5,10842.0000,'2016-05-07 19:48:06','2016-05-07 22:48:48','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(44,6,8,6,27588.0000,'2017-08-03 15:10:31','2017-08-03 22:50:19','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(45,2,10,3,14222.0000,'2017-08-18 12:38:50','2017-08-18 16:35:52','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(46,10,26,3,11491.0000,'2017-06-26 13:48:35','2017-06-26 17:00:06','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(47,6,23,3,16842.0000,'2017-09-29 13:08:30','2017-09-29 17:49:12','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(48,9,10,6,23946.0000,'2017-10-19 18:12:57','2017-10-20 00:52:03','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(49,2,19,1,6302.0000,'2015-08-10 01:42:22','2015-08-10 03:27:24','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(50,9,10,3,18759.0000,'2015-04-29 01:54:36','2015-04-29 07:07:15','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(51,9,16,6,13111.0000,'2017-10-03 16:38:21','2017-10-03 20:16:52','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(52,5,17,3,18773.0000,'2017-06-15 21:17:42','2017-06-16 02:30:35','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(53,10,11,2,25206.0000,'2016-01-29 07:40:42','2016-01-29 14:40:48','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(54,3,19,2,21292.0000,'2016-05-15 02:37:57','2016-05-15 08:32:49','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(55,2,24,6,9475.0000,'2017-09-30 23:59:11','2017-10-01 02:37:06','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(56,9,8,5,27957.0000,'2015-08-01 22:35:03','2015-08-02 06:21:00','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(57,9,23,3,13147.0000,'2017-06-16 15:17:49','2017-06-16 18:56:56','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(58,9,16,3,5734.0000,'2017-03-12 19:33:11','2017-03-12 21:08:45','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(59,8,23,1,22214.0000,'2016-04-25 23:35:29','2016-04-26 05:45:43','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(60,6,16,5,15001.0000,'2017-05-23 03:09:11','2017-05-23 07:19:12','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(61,7,22,2,8116.0000,'2017-02-11 01:37:01','2017-02-11 03:52:17','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(62,9,19,1,11196.0000,'2017-03-21 13:02:28','2017-03-21 16:09:04','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(63,3,9,4,12944.0000,'2016-04-28 14:14:32','2016-04-28 17:50:16','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(64,3,22,6,23526.0000,'2017-05-22 15:01:31','2017-05-22 21:33:37','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(65,2,18,5,6968.0000,'2016-12-22 08:13:43','2016-12-22 10:09:51','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(66,2,24,2,8773.0000,'2015-12-05 22:08:34','2015-12-06 00:34:47','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(67,6,24,4,21099.0000,'2017-01-29 11:24:27','2017-01-29 17:16:06','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(68,4,15,1,27248.0000,'2017-04-23 04:13:21','2017-04-23 11:47:29','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(69,4,25,2,23030.0000,'2017-03-03 01:36:49','2017-03-03 08:00:39','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(70,9,19,5,24836.0000,'2016-03-23 13:02:06','2016-03-23 19:56:02','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(71,11,14,6,14111.0000,'2017-07-19 06:27:52','2017-07-19 10:23:03','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(72,7,12,3,14496.0000,'2015-12-05 06:54:47','2015-12-05 10:56:23','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(73,8,24,6,4022.0000,'2017-10-13 04:08:32','2017-10-13 05:15:34','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(74,11,25,2,27410.0000,'2017-04-05 07:38:27','2017-04-05 15:15:17','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(75,3,25,6,9788.0000,'2017-05-30 02:23:59','2017-05-30 05:07:07','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(76,3,10,1,20469.0000,'2015-07-28 18:03:20','2015-07-28 23:44:29','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(77,5,7,3,27725.0000,'2017-06-12 12:58:50','2017-06-12 20:40:55','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(78,10,19,5,21410.0000,'2016-10-13 08:55:46','2016-10-13 14:52:36','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(79,10,18,4,10725.0000,'2017-03-13 06:12:04','2017-03-13 09:10:49','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(80,8,26,3,21522.0000,'2017-07-22 12:19:28','2017-07-22 18:18:10','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(81,9,7,3,14041.0000,'2017-03-20 09:38:46','2017-03-20 13:32:47','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(82,6,24,4,29059.0000,'2017-06-12 08:22:00','2017-06-12 16:26:19','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(83,7,15,3,6366.0000,'2017-02-11 06:54:16','2017-02-11 08:40:22','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(84,8,24,2,20695.0000,'2017-11-12 09:24:56','2017-11-12 15:09:51','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(85,11,24,3,26465.0000,'2015-06-01 15:15:55','2015-06-01 22:37:00','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(86,2,21,4,14585.0000,'2015-07-23 17:43:40','2015-07-23 21:46:45','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(87,11,25,5,9492.0000,'2017-04-08 21:07:20','2017-04-08 23:45:32','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(88,6,10,3,16809.0000,'2016-10-24 20:07:12','2016-10-25 00:47:21','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(89,11,16,2,9552.0000,'2017-01-23 12:11:57','2017-01-23 14:51:09','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(90,5,22,1,4902.0000,'2017-08-08 05:54:39','2017-08-08 07:16:21','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(91,7,21,3,25074.0000,'2017-10-30 02:03:36','2017-10-30 09:01:30','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(92,11,21,3,6643.0000,'2017-02-24 08:51:43','2017-02-24 10:42:26','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(93,2,13,5,3681.0000,'2015-06-01 19:39:37','2015-06-01 20:40:58','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(94,7,12,2,8562.0000,'2015-07-22 11:01:07','2015-07-22 13:23:49','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(95,3,7,2,21528.0000,'2015-11-24 12:55:44','2015-11-24 18:54:32','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(96,10,18,3,12428.0000,'2017-07-10 22:30:13','2017-07-11 01:57:21','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(97,2,19,3,19300.0000,'2016-02-17 11:14:02','2016-02-17 16:35:42','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(98,9,15,3,23420.0000,'2017-03-30 21:50:49','2017-03-31 04:21:09','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(99,9,13,6,7382.0000,'2017-01-29 10:47:47','2017-01-29 12:50:49','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(100,5,21,2,26241.0000,'2017-06-14 08:39:56','2017-06-14 15:57:17','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(101,11,23,5,19878.0000,'2017-08-16 23:21:47','2017-08-17 04:53:05','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(102,21,19,4,30240.0000,'2017-06-20 23:39:11','2017-06-21 08:03:11','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(103,16,18,6,30240.0000,'2017-04-06 07:42:47','2017-04-06 16:06:47','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(104,15,11,4,30240.0000,'2016-08-12 14:26:55','2016-08-12 22:50:55','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(105,15,9,4,30240.0000,'2016-03-31 18:44:38','2016-04-01 03:08:38','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(106,13,23,1,30240.0000,'2017-10-25 06:18:14','2017-10-25 14:42:14','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(107,16,15,3,30240.0000,'2015-12-28 12:15:26','2015-12-28 20:39:26','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(108,17,16,2,30240.0000,'2016-11-14 20:30:11','2016-11-15 04:54:11','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(109,21,16,5,30240.0000,'2017-05-10 18:01:33','2017-05-11 02:25:33','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(110,14,13,5,30240.0000,'2016-06-17 14:35:39','2016-06-17 22:59:39','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(111,15,19,6,30240.0000,'2015-11-11 22:23:39','2015-11-12 06:47:39','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(112,12,8,1,30240.0000,'2016-05-09 04:43:17','2016-05-09 13:07:17','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(113,14,24,3,30240.0000,'2017-03-26 14:55:13','2017-03-26 23:19:13','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(114,16,22,5,30240.0000,'2016-09-03 05:33:43','2016-09-03 13:57:43','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(115,13,20,2,30240.0000,'2016-08-08 11:20:12','2016-08-08 19:44:12','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(116,17,16,5,30240.0000,'2015-03-30 11:32:42','2015-03-30 19:56:42','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(117,20,18,1,30240.0000,'2015-04-11 22:22:00','2015-04-12 06:46:00','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(118,13,13,6,30240.0000,'2017-11-14 01:32:03','2017-11-14 09:56:03','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(119,21,13,6,30240.0000,'2015-12-25 11:34:10','2015-12-25 19:58:10','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(120,19,11,1,30240.0000,'2015-04-20 20:33:54','2015-04-21 04:57:54','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(121,15,7,1,30240.0000,'2015-06-04 04:42:24','2015-06-04 13:06:24','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(122,19,21,2,30240.0000,'2017-07-21 18:48:26','2017-07-22 03:12:26','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(123,18,12,2,30240.0000,'2017-09-26 23:29:23','2017-09-27 07:53:23','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(124,19,21,4,30240.0000,'2015-10-26 16:35:09','2015-10-27 00:59:09','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(125,13,8,1,30240.0000,'2015-06-11 01:54:09','2015-06-11 10:18:09','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(126,20,26,1,30240.0000,'2017-08-16 13:09:02','2017-08-16 21:33:02','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(127,18,25,5,30240.0000,'2017-06-15 20:18:58','2017-06-16 04:42:58','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(128,19,8,4,30240.0000,'2015-07-09 02:39:57','2015-07-09 11:03:57','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(129,21,15,2,30240.0000,'2017-03-21 15:29:35','2017-03-21 23:53:35','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(130,21,13,3,30240.0000,'2016-12-02 18:21:15','2016-12-03 02:45:15','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(131,17,19,4,30240.0000,'2017-01-19 07:12:37','2017-01-19 15:36:37','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(132,12,19,4,30240.0000,'2017-07-29 07:27:54','2017-07-29 15:51:54','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(133,18,16,3,30240.0000,'2015-06-23 22:46:55','2015-06-24 07:10:55','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(134,16,12,4,30240.0000,'2015-11-14 18:48:17','2015-11-15 03:12:17','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(135,17,11,6,30240.0000,'2017-05-22 16:52:29','2017-05-23 01:16:29','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(136,15,22,3,30240.0000,'2015-12-31 08:11:28','2015-12-31 16:35:28','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(137,20,7,3,30240.0000,'2016-01-18 08:38:58','2016-01-18 17:02:58','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(138,12,21,4,30240.0000,'2015-04-07 17:44:00','2015-04-08 02:08:00','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(139,12,19,6,30240.0000,'2015-07-15 08:09:20','2015-07-15 16:33:20','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(140,12,15,5,30240.0000,'2015-12-05 18:56:20','2015-12-06 03:20:20','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(141,19,12,5,30240.0000,'2016-06-23 21:50:36','2016-06-24 06:14:36','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(142,15,10,6,30240.0000,'2016-10-03 03:46:08','2016-10-03 12:10:08','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(143,21,24,5,30240.0000,'2017-02-16 21:23:10','2017-02-17 05:47:10','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(144,13,18,5,30240.0000,'2017-03-03 12:55:04','2017-03-03 21:19:04','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(145,13,13,4,30240.0000,'2016-10-26 12:04:47','2016-10-26 20:28:47','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(146,16,21,6,30240.0000,'2015-06-08 05:40:07','2015-06-08 14:04:07','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(147,12,10,6,30240.0000,'2015-10-14 11:23:58','2015-10-14 19:47:58','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(148,15,23,3,30240.0000,'2015-05-31 20:17:15','2015-06-01 04:41:15','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(149,18,17,1,30240.0000,'2015-07-29 19:40:20','2015-07-30 04:04:20','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(150,20,9,6,30240.0000,'2017-10-06 09:56:59','2017-10-06 18:20:59','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(151,15,12,1,30240.0000,'2015-03-11 18:06:55','2015-03-12 02:30:55','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(152,21,21,5,30240.0000,'2015-06-22 10:29:13','2015-06-22 18:53:13','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(153,20,20,2,30240.0000,'2015-10-07 12:37:28','2015-10-07 21:01:28','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(154,16,22,5,30240.0000,'2015-05-08 08:18:27','2015-05-08 16:42:27','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(155,20,8,6,30240.0000,'2016-11-08 07:15:18','2016-11-08 15:39:18','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(156,18,24,5,30240.0000,'2017-02-16 13:49:05','2017-02-16 22:13:05','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(157,14,19,3,30240.0000,'2015-09-01 01:54:46','2015-09-01 10:18:46','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(158,21,22,4,30240.0000,'2017-05-02 23:51:10','2017-05-03 08:15:10','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(159,13,25,4,30240.0000,'2015-11-08 21:06:41','2015-11-09 05:30:41','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(160,12,8,3,30240.0000,'2015-05-06 10:15:23','2015-05-06 18:39:23','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(161,12,24,6,30240.0000,'2015-09-28 06:13:59','2015-09-28 14:37:59','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(162,19,16,4,30240.0000,'2017-03-28 08:46:22','2017-03-28 17:10:22','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(163,13,13,4,30240.0000,'2016-11-16 23:47:46','2016-11-17 08:11:46','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(164,14,17,4,30240.0000,'2015-10-11 07:14:21','2015-10-11 15:38:21','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(165,21,24,5,30240.0000,'2017-11-02 09:50:35','2017-11-02 18:14:35','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(166,15,11,4,30240.0000,'2015-12-04 08:36:00','2015-12-04 17:00:00','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(167,12,20,4,30240.0000,'2015-12-08 07:15:01','2015-12-08 15:39:01','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(168,15,25,5,30240.0000,'2015-03-25 10:58:22','2015-03-25 19:22:22','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(169,17,9,2,30240.0000,'2016-05-14 08:53:52','2016-05-14 17:17:52','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(170,16,8,6,30240.0000,'2017-08-10 17:47:45','2017-08-11 02:11:45','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(171,18,15,6,30240.0000,'2016-05-15 16:06:38','2016-05-16 00:30:38','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(172,20,26,2,30240.0000,'2017-06-10 02:20:30','2017-06-10 10:44:30','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(173,12,24,5,30240.0000,'2015-11-25 18:23:15','2015-11-26 02:47:15','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(174,20,16,4,30240.0000,'2016-09-10 19:53:54','2016-09-11 04:17:54','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(175,14,9,6,30240.0000,'2016-12-10 22:21:51','2016-12-11 06:45:51','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(176,15,14,5,30240.0000,'2015-06-15 04:51:55','2015-06-15 13:15:55','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(177,16,24,1,30240.0000,'2016-07-22 10:42:14','2016-07-22 19:06:14','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(178,14,23,4,30240.0000,'2015-10-23 21:27:40','2015-10-24 05:51:40','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(179,14,17,3,30240.0000,'2017-05-17 04:01:01','2017-05-17 12:25:01','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(180,17,23,6,30240.0000,'2016-08-10 10:22:32','2016-08-10 18:46:32','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(181,14,23,3,30240.0000,'2015-09-22 15:17:12','2015-09-22 23:41:12','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(182,15,17,1,30240.0000,'2015-12-07 08:05:23','2015-12-07 16:29:23','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(183,18,11,6,30240.0000,'2017-01-07 21:01:39','2017-01-08 05:25:39','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(184,18,9,1,30240.0000,'2015-10-28 19:07:18','2015-10-29 03:31:18','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(185,18,23,4,30240.0000,'2015-04-28 07:02:20','2015-04-28 15:26:20','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(186,13,21,1,30240.0000,'2015-10-13 08:11:13','2015-10-13 16:35:13','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(187,18,23,5,30240.0000,'2017-08-14 08:32:18','2017-08-14 16:56:18','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(188,18,20,5,30240.0000,'2017-04-07 19:32:53','2017-04-08 03:56:53','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(189,15,25,2,30240.0000,'2016-10-18 04:50:30','2016-10-18 13:14:30','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(190,19,19,4,30240.0000,'2015-11-18 06:46:50','2015-11-18 15:10:50','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(191,15,24,6,30240.0000,'2015-09-06 20:52:09','2015-09-07 05:16:09','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(192,18,12,4,30240.0000,'2015-11-14 11:11:47','2015-11-14 19:35:47','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(193,20,14,6,30240.0000,'2017-05-26 14:31:03','2017-05-26 22:55:03','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(194,21,25,5,30240.0000,'2016-05-01 08:21:20','2016-05-01 16:45:20','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(195,19,8,6,30240.0000,'2017-08-05 08:22:41','2017-08-05 16:46:41','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(196,17,7,5,30240.0000,'2017-08-02 23:35:02','2017-08-03 07:59:02','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(197,12,19,4,30240.0000,'2015-07-28 22:44:43','2015-07-29 07:08:43','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(198,19,21,4,30240.0000,'2015-05-24 04:44:54','2015-05-24 13:08:54','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(199,13,23,6,30240.0000,'2016-05-30 22:54:55','2016-05-31 07:18:55','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(200,15,16,2,30240.0000,'2017-03-01 16:37:19','2017-03-02 01:01:19','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(201,12,18,6,30240.0000,'2017-09-09 17:00:46','2017-09-10 01:24:46','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(202,24,7,6,153.0000,'2015-08-24 07:29:15','2015-08-24 07:31:48','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(203,27,10,1,189.0000,'2017-03-15 14:31:36','2017-03-15 14:34:45','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(204,31,17,6,22.0000,'2017-05-31 02:08:23','2017-05-31 02:08:45','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(205,27,22,6,66.0000,'2016-05-13 09:51:39','2016-05-13 09:52:45','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(206,27,9,1,188.0000,'2015-04-15 20:05:17','2015-04-15 20:08:25','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(207,26,25,5,145.0000,'2015-10-27 13:32:09','2015-10-27 13:34:34','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(208,26,26,4,42.0000,'2017-05-25 07:38:11','2017-05-25 07:38:53','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(209,25,19,1,150.0000,'2015-12-07 13:48:56','2015-12-07 13:51:26','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(210,28,9,4,91.0000,'2016-07-26 23:20:14','2016-07-26 23:21:45','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(211,29,11,4,153.0000,'2015-02-26 06:38:59','2015-02-26 06:41:32','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(212,27,17,3,197.0000,'2017-01-30 03:04:48','2017-01-30 03:08:05','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(213,24,24,1,137.0000,'2016-09-05 09:25:32','2016-09-05 09:27:49','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(214,30,16,3,63.0000,'2017-05-21 04:37:51','2017-05-21 04:38:54','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(215,28,7,2,4.0000,'2016-01-27 17:46:35','2016-01-27 17:46:39','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(216,28,19,5,160.0000,'2017-05-06 17:16:28','2017-05-06 17:19:08','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(217,25,20,1,125.0000,'2016-09-08 23:08:18','2016-09-08 23:10:23','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(218,31,20,5,18.0000,'2017-06-01 12:47:18','2017-06-01 12:47:36','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(219,22,26,3,147.0000,'2017-08-22 17:42:16','2017-08-22 17:44:43','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(220,23,9,6,81.0000,'2015-02-24 14:27:40','2015-02-24 14:29:01','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(221,25,26,1,146.0000,'2016-03-30 17:04:50','2016-03-30 17:07:16','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(222,29,26,1,122.0000,'2015-06-17 17:20:46','2015-06-17 17:22:48','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(223,28,12,3,25.0000,'2016-09-10 10:41:00','2016-09-10 10:41:25','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(224,29,7,2,125.0000,'2016-11-13 06:19:08','2016-11-13 06:21:13','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(225,30,17,4,195.0000,'2017-01-23 18:33:42','2017-01-23 18:36:57','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(226,30,26,5,59.0000,'2016-12-13 20:02:48','2016-12-13 20:03:47','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(227,22,12,2,41.0000,'2017-03-04 22:47:27','2017-03-04 22:48:08','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(228,30,15,2,4.0000,'2016-01-28 04:39:04','2016-01-28 04:39:08','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(229,26,23,1,141.0000,'2015-06-04 14:14:07','2015-06-04 14:16:28','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(230,27,8,3,6.0000,'2015-07-21 08:53:00','2015-07-21 08:53:06','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(231,27,17,3,78.0000,'2015-04-10 17:57:38','2015-04-10 17:58:56','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(232,30,17,1,76.0000,'2015-05-10 10:21:16','2015-05-10 10:22:32','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(233,28,7,5,14.0000,'2016-11-14 19:56:13','2016-11-14 19:56:27','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(234,27,26,5,195.0000,'2017-05-05 13:51:15','2017-05-05 13:54:30','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(235,30,20,1,6.0000,'2015-12-09 13:27:41','2015-12-09 13:27:47','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(236,30,18,2,1.0000,'2016-02-25 03:35:15','2016-02-25 03:35:16','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(237,30,17,5,26.0000,'2017-07-26 16:31:40','2017-07-26 16:32:06','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(238,31,25,3,75.0000,'2016-01-29 11:31:25','2016-01-29 11:32:40','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(239,22,19,5,114.0000,'2017-09-10 14:19:48','2017-09-10 14:21:42','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(240,22,12,3,135.0000,'2017-02-09 15:41:19','2017-02-09 15:43:34','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(241,23,20,4,67.0000,'2015-12-11 16:07:31','2015-12-11 16:08:38','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(242,28,10,4,70.0000,'2016-08-12 03:10:08','2016-08-12 03:11:18','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(243,27,13,6,123.0000,'2016-08-20 10:14:07','2016-08-20 10:16:10','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(244,22,19,4,183.0000,'2017-02-14 08:56:36','2017-02-14 08:59:39','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(245,22,21,1,117.0000,'2015-08-10 18:39:31','2015-08-10 18:41:28','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(246,29,18,6,67.0000,'2015-10-03 08:24:38','2015-10-03 08:25:45','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(247,24,17,2,18.0000,'2016-01-19 03:33:52','2016-01-19 03:34:10','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(248,24,9,1,62.0000,'2017-09-06 04:28:45','2017-09-06 04:29:47','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(249,31,23,6,3.0000,'2017-10-02 09:57:07','2017-10-02 09:57:10','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(250,27,8,2,118.0000,'2017-07-16 18:22:19','2017-07-16 18:24:17','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(251,31,25,3,124.0000,'2016-06-30 08:23:15','2016-06-30 08:25:19','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(252,29,26,3,192.0000,'2015-04-09 19:10:18','2015-04-09 19:13:30','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(253,22,10,5,138.0000,'2015-12-01 22:51:59','2015-12-01 22:54:17','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(254,28,11,3,153.0000,'2016-11-06 06:14:52','2016-11-06 06:17:25','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(255,26,13,2,94.0000,'2016-11-09 09:16:23','2016-11-09 09:17:57','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(256,29,11,3,8.0000,'2015-04-07 06:22:10','2015-04-07 06:22:18','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(257,31,15,3,110.0000,'2015-07-05 19:34:27','2015-07-05 19:36:17','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(258,31,15,4,93.0000,'2017-01-08 05:15:16','2017-01-08 05:16:49','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(259,28,9,5,86.0000,'2016-07-04 08:33:12','2016-07-04 08:34:38','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(260,23,21,2,143.0000,'2017-10-21 08:03:37','2017-10-21 08:06:00','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(261,24,15,1,54.0000,'2016-05-04 02:34:42','2016-05-04 02:35:36','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(262,25,14,2,142.0000,'2016-03-10 08:55:12','2016-03-10 08:57:34','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(263,26,24,6,130.0000,'2016-03-29 11:20:37','2016-03-29 11:22:47','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(264,29,10,1,199.0000,'2015-08-27 14:16:02','2015-08-27 14:19:21','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(265,24,15,1,125.0000,'2015-10-24 07:31:55','2015-10-24 07:34:00','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(266,31,8,4,110.0000,'2017-04-12 16:10:36','2017-04-12 16:12:26','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(267,24,8,1,131.0000,'2016-04-25 15:40:14','2016-04-25 15:42:25','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(268,26,12,3,142.0000,'2015-05-20 04:17:53','2015-05-20 04:20:15','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(269,23,23,5,168.0000,'2016-07-26 10:02:48','2016-07-26 10:05:36','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(270,25,15,2,97.0000,'2017-07-18 09:12:25','2017-07-18 09:14:02','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(271,30,8,4,63.0000,'2017-02-09 03:11:35','2017-02-09 03:12:38','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(272,27,8,4,55.0000,'2017-07-17 09:56:39','2017-07-17 09:57:34','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(273,25,9,1,192.0000,'2017-01-11 10:56:04','2017-01-11 10:59:16','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(274,28,24,3,37.0000,'2015-12-07 06:50:21','2015-12-07 06:50:58','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(275,29,26,6,75.0000,'2015-11-18 08:52:57','2015-11-18 08:54:12','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(276,26,23,6,133.0000,'2015-07-04 19:28:10','2015-07-04 19:30:23','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(277,27,24,4,146.0000,'2017-01-29 20:51:52','2017-01-29 20:54:18','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(278,25,22,6,13.0000,'2016-06-25 18:32:06','2016-06-25 18:32:19','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(279,23,13,6,181.0000,'2016-04-25 10:09:41','2016-04-25 10:12:42','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(280,27,8,4,93.0000,'2016-02-24 07:51:41','2016-02-24 07:53:14','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(281,24,23,2,185.0000,'2016-11-22 20:48:30','2016-11-22 20:51:35','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(282,25,22,1,80.0000,'2015-11-12 10:48:26','2015-11-12 10:49:46','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(283,23,23,4,62.0000,'2016-02-21 19:33:16','2016-02-21 19:34:18','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(284,22,14,6,158.0000,'2016-02-23 03:10:53','2016-02-23 03:13:31','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(285,22,24,3,143.0000,'2016-03-29 11:25:57','2016-03-29 11:28:20','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(286,30,7,3,185.0000,'2015-09-14 06:36:31','2015-09-14 06:39:36','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(287,23,21,2,99.0000,'2015-08-18 08:09:29','2015-08-18 08:11:08','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(288,29,13,2,43.0000,'2017-07-27 23:09:40','2017-07-27 23:10:23','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(289,31,15,5,175.0000,'2015-04-26 04:12:29','2015-04-26 04:15:24','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(290,29,18,6,187.0000,'2016-11-02 17:27:48','2016-11-02 17:30:55','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(291,29,22,3,97.0000,'2015-07-27 01:04:50','2015-07-27 01:06:27','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(292,25,17,6,83.0000,'2015-10-20 14:28:27','2015-10-20 14:29:50','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(293,30,24,2,17.0000,'2017-07-17 19:01:09','2017-07-17 19:01:26','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(294,27,12,3,149.0000,'2017-03-30 05:49:50','2017-03-30 05:52:19','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(295,24,15,5,17.0000,'2016-03-23 20:59:26','2016-03-23 20:59:43','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(296,30,22,5,120.0000,'2017-03-13 08:11:29','2017-03-13 08:13:29','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(297,24,10,6,27.0000,'2016-05-13 10:06:21','2016-05-13 10:06:48','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(298,27,12,3,14.0000,'2016-04-13 18:41:52','2016-04-13 18:42:06','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(299,24,22,4,155.0000,'2017-10-17 07:55:40','2017-10-17 07:58:15','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(300,26,16,3,83.0000,'2015-04-21 11:02:23','2015-04-21 11:03:46','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(301,26,19,1,140.0000,'2017-05-29 06:44:11','2017-05-29 06:46:31','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(302,40,21,1,1.0000,'2017-02-18 14:47:44','2017-02-18 14:47:45','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(303,38,16,3,1.0000,'2017-06-17 11:30:40','2017-06-17 11:30:41','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(304,33,22,4,1.0000,'2016-11-12 14:53:10','2016-11-12 14:53:11','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(305,39,12,3,1.0000,'2017-01-05 18:25:16','2017-01-05 18:25:17','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(306,37,16,1,1.0000,'2017-03-18 08:07:24','2017-03-18 08:07:25','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(307,34,7,1,1.0000,'2017-04-24 08:34:56','2017-04-24 08:34:57','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(308,37,12,5,1.0000,'2015-05-01 15:05:03','2015-05-01 15:05:04','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(309,36,24,1,1.0000,'2015-11-13 16:44:20','2015-11-13 16:44:21','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(310,40,26,5,1.0000,'2016-07-10 18:12:22','2016-07-10 18:12:23','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(311,32,10,2,1.0000,'2017-04-09 07:43:22','2017-04-09 07:43:23','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(312,37,12,6,1.0000,'2017-08-11 21:30:11','2017-08-11 21:30:12','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(313,34,21,6,1.0000,'2017-03-25 19:16:45','2017-03-25 19:16:46','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(314,39,19,4,1.0000,'2017-10-17 09:57:58','2017-10-17 09:57:59','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(315,38,17,5,1.0000,'2016-05-22 12:33:38','2016-05-22 12:33:39','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(316,32,25,5,1.0000,'2016-03-24 01:33:39','2016-03-24 01:33:40','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(317,38,19,2,1.0000,'2015-09-15 02:29:36','2015-09-15 02:29:37','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(318,38,14,1,1.0000,'2016-09-13 22:57:45','2016-09-13 22:57:46','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(319,34,24,3,1.0000,'2017-05-07 14:32:47','2017-05-07 14:32:48','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(320,38,26,1,1.0000,'2016-12-02 10:15:41','2016-12-02 10:15:42','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(321,37,22,5,1.0000,'2016-09-30 01:15:12','2016-09-30 01:15:13','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(322,38,19,5,1.0000,'2017-11-14 02:32:19','2017-11-14 02:32:20','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(323,33,9,5,1.0000,'2015-04-26 23:11:33','2015-04-26 23:11:34','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(324,40,26,2,1.0000,'2016-11-02 03:22:41','2016-11-02 03:22:42','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(325,33,24,4,1.0000,'2016-10-21 20:34:46','2016-10-21 20:34:47','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(326,39,23,1,1.0000,'2015-07-02 15:01:11','2015-07-02 15:01:12','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(327,32,23,3,1.0000,'2016-06-18 10:44:45','2016-06-18 10:44:46','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(328,35,17,5,1.0000,'2015-09-07 21:26:47','2015-09-07 21:26:48','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(329,34,7,2,1.0000,'2015-10-20 23:05:06','2015-10-20 23:05:07','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(330,33,9,3,1.0000,'2017-01-09 15:08:18','2017-01-09 15:08:19','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(331,32,8,3,1.0000,'2017-08-05 23:44:24','2017-08-05 23:44:25','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(332,32,21,3,1.0000,'2017-08-24 01:31:36','2017-08-24 01:31:37','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(333,38,9,1,1.0000,'2016-10-08 18:46:56','2016-10-08 18:46:57','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(334,32,25,6,1.0000,'2015-06-17 03:24:18','2015-06-17 03:24:19','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(335,38,17,1,1.0000,'2016-12-18 09:41:48','2016-12-18 09:41:49','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(336,38,14,5,1.0000,'2015-12-01 08:38:22','2015-12-01 08:38:23','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(337,36,26,1,1.0000,'2015-11-28 08:44:46','2015-11-28 08:44:47','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(338,38,21,2,1.0000,'2015-05-14 19:24:20','2015-05-14 19:24:21','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(339,34,22,2,1.0000,'2016-03-09 13:48:44','2016-03-09 13:48:45','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(340,41,13,3,1.0000,'2017-01-28 20:18:37','2017-01-28 20:18:38','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(341,32,11,3,1.0000,'2016-11-02 20:34:43','2016-11-02 20:34:44','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(342,33,11,2,1.0000,'2017-10-19 01:40:05','2017-10-19 01:40:06','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(343,41,22,5,1.0000,'2015-11-28 05:13:54','2015-11-28 05:13:55','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(344,35,25,3,1.0000,'2017-07-12 11:57:23','2017-07-12 11:57:24','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(345,41,22,3,1.0000,'2017-08-01 18:06:44','2017-08-01 18:06:45','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(346,33,20,2,1.0000,'2016-03-07 03:42:09','2016-03-07 03:42:10','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(347,35,22,5,1.0000,'2017-09-27 08:58:01','2017-09-27 08:58:02','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(348,38,26,4,1.0000,'2017-05-28 17:43:48','2017-05-28 17:43:49','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(349,39,21,1,1.0000,'2016-05-16 09:28:58','2016-05-16 09:28:59','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(350,37,13,5,1.0000,'2015-11-26 22:41:52','2015-11-26 22:41:53','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(351,38,17,4,1.0000,'2016-12-30 15:49:25','2016-12-30 15:49:26','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(352,32,25,6,1.0000,'2015-04-11 22:26:59','2015-04-11 22:27:00','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(353,38,10,4,1.0000,'2016-08-23 16:07:40','2016-08-23 16:07:41','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(354,35,14,2,1.0000,'2015-09-21 13:59:20','2015-09-21 13:59:21','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(355,37,25,5,1.0000,'2017-09-06 18:12:00','2017-09-06 18:12:01','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(356,39,10,1,1.0000,'2015-08-15 10:08:15','2015-08-15 10:08:16','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(357,32,7,3,1.0000,'2017-04-01 07:25:35','2017-04-01 07:25:36','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(358,32,22,3,1.0000,'2017-01-28 02:28:05','2017-01-28 02:28:06','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(359,38,13,4,1.0000,'2017-01-12 17:50:30','2017-01-12 17:50:31','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(360,39,9,2,1.0000,'2016-03-30 20:25:00','2016-03-30 20:25:01','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(361,39,8,1,1.0000,'2017-07-01 07:34:08','2017-07-01 07:34:09','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(362,41,23,5,1.0000,'2015-05-26 08:17:20','2015-05-26 08:17:21','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(363,41,14,5,1.0000,'2016-02-26 23:55:42','2016-02-26 23:55:43','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(364,32,19,1,1.0000,'2017-10-26 22:22:17','2017-10-26 22:22:18','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(365,34,19,1,1.0000,'2016-07-30 12:12:40','2016-07-30 12:12:41','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(366,41,11,6,1.0000,'2016-11-16 13:54:18','2016-11-16 13:54:19','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(367,35,23,1,1.0000,'2015-04-09 11:50:53','2015-04-09 11:50:54','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(368,39,21,4,1.0000,'2015-08-25 17:31:52','2015-08-25 17:31:53','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(369,33,18,2,1.0000,'2016-10-08 21:13:08','2016-10-08 21:13:09','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(370,41,16,1,1.0000,'2015-07-20 23:18:57','2015-07-20 23:18:58','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(371,41,25,1,1.0000,'2015-05-30 09:34:01','2015-05-30 09:34:02','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(372,32,9,1,1.0000,'2016-07-14 10:27:01','2016-07-14 10:27:02','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(373,34,16,6,1.0000,'2016-12-22 02:12:14','2016-12-22 02:12:15','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(374,40,17,2,1.0000,'2017-10-08 04:14:31','2017-10-08 04:14:32','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(375,36,16,6,1.0000,'2016-07-04 21:13:20','2016-07-04 21:13:21','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(376,35,16,4,1.0000,'2016-05-28 20:04:58','2016-05-28 20:04:59','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(377,32,8,3,1.0000,'2015-06-09 19:10:02','2015-06-09 19:10:03','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(378,38,13,6,1.0000,'2015-05-03 07:16:37','2015-05-03 07:16:38','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(379,38,24,5,1.0000,'2015-10-02 17:47:28','2015-10-02 17:47:29','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(380,33,9,3,1.0000,'2016-08-08 06:44:14','2016-08-08 06:44:15','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(381,38,13,1,1.0000,'2017-09-25 05:07:20','2017-09-25 05:07:21','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(382,34,9,3,1.0000,'2016-12-22 06:18:51','2016-12-22 06:18:52','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(383,41,24,3,1.0000,'2016-02-27 19:46:56','2016-02-27 19:46:57','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(384,37,26,1,1.0000,'2015-07-19 04:20:19','2015-07-19 04:20:20','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(385,35,8,4,1.0000,'2015-06-02 16:06:55','2015-06-02 16:06:56','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(386,40,20,4,1.0000,'2016-08-17 20:50:51','2016-08-17 20:50:52','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(387,36,14,1,1.0000,'2016-03-23 07:37:30','2016-03-23 07:37:31','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(388,33,13,4,1.0000,'2017-08-12 02:53:12','2017-08-12 02:53:13','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(389,39,11,4,1.0000,'2016-03-01 08:42:30','2016-03-01 08:42:31','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(390,33,19,1,1.0000,'2016-06-21 01:35:52','2016-06-21 01:35:53','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(391,38,10,2,1.0000,'2016-08-03 08:13:08','2016-08-03 08:13:09','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(392,33,11,5,1.0000,'2016-06-29 18:00:31','2016-06-29 18:00:32','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(393,40,16,6,1.0000,'2017-07-26 09:16:45','2017-07-26 09:16:46','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(394,41,17,2,1.0000,'2016-02-13 13:49:59','2016-02-13 13:50:00','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(395,35,12,6,1.0000,'2017-03-23 18:45:00','2017-03-23 18:45:01','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(396,34,26,4,1.0000,'2017-06-03 21:22:34','2017-06-03 21:22:35','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(397,41,14,5,1.0000,'2015-06-02 05:50:57','2015-06-02 05:50:58','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(398,37,15,6,1.0000,'2017-01-10 10:08:42','2017-01-10 10:08:43','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(399,35,16,4,1.0000,'2017-02-14 18:35:25','2017-02-14 18:35:26','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(400,40,14,6,1.0000,'2017-04-15 21:58:27','2017-04-15 21:58:28','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL),(401,36,11,6,1.0000,'2015-03-07 16:16:44','2015-03-07 16:16:45','2017-11-14 16:14:31','2017-11-14 16:14:31',NULL);
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
INSERT INTO `users` VALUES (1,'admin','admin','admin@example.com','admin@example.com',1,'2QgxoyYSJkgUyKTdzE109aL.mMAodRpbyF8YcSMHu4U','JnvVHXdvItv89Jum4eo90YyEmpk9HWRjX6bEaV6Leqe7+jhnQM6c/tfCIpwKckpJi48gJUZAqWcdxp1vi5fr9w==',NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}','Default','User','2017-11-14 16:14:31','2017-11-14 16:14:31',20,'employee',1),(2,'otto.albrecht','otto.albrecht','berthold.albrecht@schubert.com','berthold.albrecht@schubert.com',1,'zr8eX/paDEB9I/BQcj9085zm.H9SLt6XQHm.LjUIgPg','JUU5/UIbMXOCrefkFP+kUKZK1NBDgIFuautT0r4vw/PAB8vmweDPGP5uuW0pUB3/cESZTLLaiGWLjf2Snk+u3Q==',NULL,NULL,NULL,'a:0:{}','Helge','Reimann','2017-11-14 16:14:31','2017-11-14 16:14:31',20,'employee',1),(3,'karlwilhelm.albert','karlwilhelm.albert','viktor58@bar.de','viktor58@bar.de',0,'zxjbvQSUXc8eEzsJTjHtotzb0L1teCSRLMksABLu534','BX9ydV58dP9fpY2r2+cczcJHqj2nDatA6wQEyvAQA4r1oXZuWtJ9jsDsTMOnw3lQua7G16IE7s8TMmicva9tpA==',NULL,NULL,NULL,'a:0:{}','Max','Henke','2017-11-14 16:14:31','2017-11-14 16:14:31',20,'employee',1),(4,'nschade','nschade','iarnold@wetzel.net','iarnold@wetzel.net',1,'wiWFOOWyY1DVbsoIgeTNHtTjiXmSRck4Chdej/4LN6o','4jUWlP3PtoiOSq3bHuS+bjL4paB2dgJg3qz9zig18qYg0Y4II6RQTf9ouoDjRMrcm2SEAORal66xS0tBE5qIVA==',NULL,NULL,NULL,'a:0:{}','Madeleine','Bayer','2017-11-14 16:14:31','2017-11-14 16:14:31',20,'employee',1),(5,'hansjosef17','hansjosef17','benz.hermine@beier.de','benz.hermine@beier.de',0,'NcmdDkwxEk7yOBVCUsvVK6iYsAqbFxjozhvqnV7CeOE','Mpx+k2o1XIiRn90mqcHxL1U9xpET5Df8f1aYc9tmj6DYRlW9VmW+XIrc8e4XOF4ZwtLfd/4zo6h67osvZjds4Q==',NULL,NULL,NULL,'a:0:{}','Julian','Beckmann','2017-11-14 16:14:31','2017-11-14 16:14:31',20,'employee',1),(6,'liselotte07','liselotte07','karina99@walter.de','karina99@walter.de',1,'BigHggQWwYJ/ZDvCh8MObPeENTVpRl1qWawhQrGhlnY','xQhcrdPaoHJ+APQIL3Ur9stBMHRNbaq5be2fUtiWRN0w/GGUazjIFl3MDYdynlPjugMJS0jhDSD8gNZ9ZkkCIw==',NULL,NULL,NULL,'a:0:{}','Sylvia','Wolter','2017-11-14 16:14:31','2017-11-14 16:14:31',20,'employee',1),(7,'schlegel.hansulrich','schlegel.hansulrich','employee1@example.org','employee1@example.org',1,'NMR3tPlWSSQ/7GzBSI1jfDNol8uUTtvapSYAOtVE7ww','kMJt2vc0e3q7aEH4RQ6HmlDIQOa/L3Lt8hqB4o12lmnq08qbBQjI259uzZiGvGIEhwZ04cnaa6PU+OX9kkHHHA==',NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}','Default','User','2017-11-14 16:14:31','2017-11-14 16:14:31',20,'employee',1),(8,'liane50','liane50','werner.thilo@paul.de','werner.thilo@paul.de',0,'DMtVwLGSSLBFpwthYlyQFm6fbbWg2CjbAJOFHt45A2I','tT++PXXjN8z3repXxTHrEJ3h9YOZvOL+gspMoozZi0YDvEUFvRRyE69mEor+vctdTb/xSo1LHfQRHWSMEhqiWQ==',NULL,NULL,NULL,'a:0:{}','Veit','Will','2017-11-14 16:14:31','2017-11-14 16:14:31',20,'employee',1),(9,'thuber','thuber','hiller.klausdieter@hotmail.de','hiller.klausdieter@hotmail.de',1,'XJMuWhYBZEXKen6AmAnTKGiAK6t2UvexCrkLL/7/P6M','6/FIdINwfGjJF6FMbsiX7x8s6BRjGqQ+nOsqfQNXXCJQQMwMHPe0K8FPQnfi/y82yAN8yU9t8I0C2evIfq/BPA==',NULL,NULL,NULL,'a:0:{}','Jörg','Schade','2017-11-14 16:14:31','2017-11-14 16:14:31',20,'employee',1),(10,'wilke.valeri','wilke.valeri','hummel.annegret@hotmail.de','hummel.annegret@hotmail.de',1,'c0evYH/FiNlpoYhEmfflI8yWKXsROgzZTuMu2.LUftM','d1tlWHmP8fkH6InguzTpmy/k9w2aIaOLZy106VazZG+3eqWMPh+jxnBhM7DqfDzmL84j+/R3N6YNXwUEkzsj2g==',NULL,NULL,NULL,'a:0:{}','Adrian','Geißler','2017-11-14 16:14:31','2017-11-14 16:14:31',20,'employee',1),(11,'glemke','glemke','beier.christl@gmx.de','beier.christl@gmx.de',0,'g2BogUCPUJ4zomjOVfretTWCLp/1QAnOslKG/WggZ1U','w0xc0b0pKJiM1t0tW2/SWmjhTMeQDFJ1EtEihbRWtyVYGdvsZQFYLZaJYOVRZGDHCgqCfTp/79TgkGvwpXfK9w==',NULL,NULL,NULL,'a:0:{}','Rafael','Benz','2017-11-14 16:14:31','2017-11-14 16:14:31',20,'employee',1),(12,'muller.heinzgeorg','muller.heinzgeorg','henry.langer@googlemail.com','henry.langer@googlemail.com',1,'laZkUMmQvZjWXu1eIshHN4C1Oj9Cc6BllPPsi2E6gK4','h7Roauf9uXJDVoQw2F1IEQtQHwtpBLkiENSWPftw6ti1bbpQXkojoP+391IDQ+0nGxfIcey5U6X8fIPOBm5WLg==',NULL,NULL,NULL,'a:0:{}','Inga','Seidl','2017-11-14 16:14:31','2017-11-14 16:14:31',20,'employee',1),(13,'awalter','awalter','wendt.hermann@hartung.de','wendt.hermann@hartung.de',1,'1uthWOHUao5uFkNPwfWuh1o5/9WY2nrK7cbQuA0woNo','MQX58vwYN3gosurvOWcviuSwqdcjZDz6BvMl9alsHoOrtJOBLI4BmgFkSc2Utj3B/ck68+RFAJA8EISccJvizQ==',NULL,NULL,NULL,'a:0:{}','Dorothea','Krebs','2017-11-14 16:14:31','2017-11-14 16:14:31',20,'employee',1),(14,'barthel.burkhard','barthel.burkhard','hpopp@gruber.com','hpopp@gruber.com',1,'XvI5dAGzvBg14WO7RiR6PwOe9unzrz4dDPvihywq.w4','2QsOIEoGszYi7KjYD8SdWkLcWL5GZPPphirO2BhR4TH0whXEjuXdplqGETTi8Oqbfgwecy5lND+yURpSI3bieQ==',NULL,NULL,NULL,'a:0:{}','Enrico','Wiese','2017-11-14 16:14:31','2017-11-14 16:14:31',20,'employee',1),(15,'viktoria66','viktoria66','martin.klara@kruger.com','martin.klara@kruger.com',0,'gHXgEPXVeuEwwAxXiAPZVfuEb8MduGeuav/eFpNvdy8','/Zbxz9Hb5XDSMH3pvxeH1cGOOYaRXfCO+Xoom3OUp5Ge0YtWKfRf2N/BLSkYzZ9thPxnCF4I9cSgNnUvvvbkJg==',NULL,NULL,NULL,'a:0:{}','Nelli','Münch','2017-11-14 16:14:31','2017-11-14 16:14:31',20,'employee',1),(16,'schlegel.bernd','schlegel.bernd','gundula.ehlers@gmail.com','gundula.ehlers@gmail.com',1,'JnzJdfw0r.IVZDl5QMVMDUVfKzMVtaeTUin/K0I4VCQ','csTSUeL6SHJn/SlNf182DCHVFlvuO/93W9Kqy4jy4mmIz/UdDlSByc2GfmsvfEoWuNbjiuF7kQKr0hP1Cfj2Dw==',NULL,NULL,NULL,'a:0:{}','Irmhild','Schmidt','2017-11-14 16:14:31','2017-11-14 16:14:31',20,'employee',1),(17,'aroder','aroder','lhagen@knoll.com','lhagen@knoll.com',0,'TD9rxlvMZD4dWTeKBRQ96xnpiQ0GEA94vpg0tjMPHMk','KjQLEojRIMceEOdRUQLpqXR2hvnrxA9tcY6C6wq9+ERC00zCPmqjWphw7yBes6bBO6q1B11Xs5xavFUaHneP5w==',NULL,NULL,NULL,'a:0:{}','Victor','Rieger','2017-11-14 16:14:31','2017-11-14 16:14:31',20,'employee',1),(18,'swen.niemann','swen.niemann','doreen.schmid@web.de','doreen.schmid@web.de',1,'W8RmGyac52rTORocE/XpITpvsywFzo8nQlc5nmU0BuU','sy0vPphkG0NKNs94LtCEXHmVCZZFCMC3nol4YU7Nq+7hjXtA4zjvAoIw3xIUCjuu3+6sn1OYpDGcYg5DGZenzQ==',NULL,NULL,NULL,'a:0:{}','Konstantinos','Heinze','2017-11-14 16:14:31','2017-11-14 16:14:31',20,'employee',1),(19,'ukuhlmann','ukuhlmann','hanno94@friedrich.de','hanno94@friedrich.de',1,'QvwvVj7GKxM.OFXqdgqLd1//C5z1WVFKBWsUqX4539I','YrUlP7w/QnmyC0atgk0u387R/DxVdIzq5t6LUAxhtK05658xtBb0O/vx6LGg5TVWPzJQqSxGGOXNV+nOi2nm/g==',NULL,NULL,NULL,'a:0:{}','Birte','Hirsch','2017-11-14 16:14:31','2017-11-14 16:14:31',20,'employee',1),(20,'zdietz','zdietz','hammer.magdalena@hirsch.de','hammer.magdalena@hirsch.de',1,'Yy9HEt6nGnUojDzrdrdAvFg.rR3tva8qnMR04ZDf0AE','5SmM/lhwXGicsYqTh91eDWBKE3gB0ET5WI2+HNs/m6fvNAdEhNjLL/m860UIbgA+fSmklf1Lb6ZgTH/1feJUvQ==',NULL,NULL,NULL,'a:0:{}','William','Hübner','2017-11-14 16:14:31','2017-11-14 16:14:31',20,'employee',1),(21,'rkessler','rkessler','marx.erhard@witte.de','marx.erhard@witte.de',1,'/Md9GENYVyvdg1FgRAqMvKBAqxYpb/jUJivtc73Ab6U','z8l+NC4svMNt05vo28kFv/7ZKfw15ga10Uwiz+RXUcDIlxUVUQ/ys+Qh8YeI0mtoYfv1ACy9vxQ2F0XZFiD7uA==',NULL,NULL,NULL,'a:0:{}','Ernst-August','Jacob','2017-11-14 16:14:31','2017-11-14 16:14:31',20,'employee',1),(22,'jhenning','jhenning','dorothee.heller@gmail.com','dorothee.heller@gmail.com',0,'bE5R7kX.Nz5yX1ndT.M8BJyc2mmZ/V1ncB01BpLYtuU','6z8/2FvLExIIwJqxQaptDnB7Cxu71qL6QEyG1i7xxvDNDqEpcLgLgtyT9g/XSWza0DzF/0ZFZecRvKOfL1frdA==',NULL,NULL,NULL,'a:0:{}','Heiderose','Braun','2017-11-14 16:14:31','2017-11-14 16:14:31',20,'employee',1),(23,'bertram51','bertram51','arthur.moll@aol.de','arthur.moll@aol.de',1,'IflzObUDAjuhw9GYHet2rlsWrvJjso9PjF.RttBxGyg','hlEiZWS5rTfxcn2kC2k6eBmIxxyMvJwcoOHeehAyEeleW3E0pqZVhv+3VRYZmJizZ7wiz1R+ViWX/RYv+Ti6ug==',NULL,NULL,NULL,'a:0:{}','Alma','Jäger','2017-11-14 16:14:31','2017-11-14 16:14:31',20,'employee',1),(24,'fackermann','fackermann','inna.kluge@aol.de','inna.kluge@aol.de',0,'v/AAfGxQb6wtR4dHDWnF0id9VnC023IpSqZBcJUBUgM','rwcLm56JCoD5818fUkjTms40v4pJ2FTiFsCRM8RmCnqQBAH25n+HjmJevr2x4aX8+gXyJWmjtC9xWn3Iupep4w==',NULL,NULL,NULL,'a:0:{}','Isabell','Lorenz','2017-11-14 16:14:31','2017-11-14 16:14:31',20,'employee',1),(25,'karlludwig11','karlludwig11','heide13@aol.de','heide13@aol.de',1,'F4tpKPVuvk6oP5QZWRDrji8JdNNxLhJkGjGdYBG0Nlo','GJDrTnA25eAAM6Dc9BO8gjEPcggA/w2KSWqx3FyLE/cRBZtI3SQJ+zxULhXYt1yUmXs+8yRjFvyBn0t8lkvVsA==',NULL,NULL,NULL,'a:0:{}','Markus','Mack','2017-11-14 16:14:31','2017-11-14 16:14:31',20,'employee',1),(26,'zdorr','zdorr','gwolff@loffler.net','gwolff@loffler.net',0,'Iby1dNxcCgf.2wIbSVA.83Rekn1hOdScRh77Zwr40Rk','/aK6cfDaT8vQAUTPZ+N3uAFKn3VLJNE7/5hBUckAii8o/76urr+H3F92K4PiFIbTAqF/v7fnCNuBcRpG5HFyPA==',NULL,NULL,NULL,'a:0:{}','Raimund','Schütz','2017-11-14 16:14:31','2017-11-14 16:14:31',20,'employee',1);
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

-- Dump completed on 2017-11-14 15:14:33
