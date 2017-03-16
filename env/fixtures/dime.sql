-- MySQL dump 10.14  Distrib 5.5.52-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: dime
-- ------------------------------------------------------
-- Server version	5.5.52-MariaDB

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
  CONSTRAINT `FK_57C1BB88A76ED395` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_57C1BB888C03F15C` FOREIGN KEY (`employee_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `WorkingPeriods`
--

LOCK TABLES `WorkingPeriods` WRITE;
/*!40000 ALTER TABLE `WorkingPeriods` DISABLE KEYS */;
INSERT INTO `WorkingPeriods` VALUES (1,7,1,'2017-01-25','2017-06-07',1.00,222036,NULL,1,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(2,10,5,'2017-03-11','2018-03-02',0.20,118309,NULL,84129,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(3,15,6,'2016-09-29','2018-03-09',0.40,349293,NULL,898062638,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(4,19,4,'2016-05-23','2017-05-27',1.00,613085,NULL,580034347,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(5,7,4,'2017-02-27','2017-10-28',0.90,363874,NULL,132448624,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(6,19,4,'2017-03-05','2018-02-21',0.50,293287,NULL,3120706,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(7,11,2,'2016-05-22','2017-10-13',1.00,845063,NULL,7,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(8,26,6,'2017-02-05','2017-09-07',0.30,106876,NULL,6,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(9,18,1,'2017-02-06','2018-01-21',0.40,231315,NULL,727966598,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(10,13,3,'2016-12-02','2017-10-24',0.60,324107,NULL,777970486,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(11,24,2,'2016-10-19','2018-01-02',0.40,292292,NULL,665,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(12,19,6,'2016-10-26','2017-09-04',0.10,51864,NULL,85775307,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(13,19,2,'2016-09-09','2017-08-25',0.90,523442,NULL,3546376,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(14,21,6,'2016-10-23','2017-10-06',0.20,115658,NULL,52378,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(15,24,6,'2016-07-16','2017-08-21',0.10,66611,NULL,25,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(16,26,2,'2017-02-10','2018-03-13',0.00,NULL,NULL,465173,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(17,7,6,'2016-04-24','2017-10-03',0.90,787400,NULL,250,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(18,15,5,'2016-09-24','2017-09-08',0.50,289144,NULL,4,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(19,26,6,'2016-07-14','2017-05-29',1.00,530236,NULL,81,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(20,11,2,'2016-12-04','2017-09-13',1.00,468927,NULL,84226278,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(21,26,2,'2016-06-26','2017-05-26',0.60,332060,NULL,91011,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(22,20,3,'2016-07-04','2017-09-29',0.20,150123,NULL,4957,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(23,9,3,'2017-02-15','2018-01-02',0.50,266775,NULL,55784958,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(24,26,4,'2016-04-23','2017-07-01',0.60,431479,NULL,297241071,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(25,10,4,'2016-11-11','2017-11-02',0.90,532390,NULL,69,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(26,21,6,'2016-05-10','2017-07-02',0.20,138855,NULL,24019,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(27,23,3,'2016-08-16','2017-07-05',0.20,107041,NULL,256475042,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(28,10,1,'2016-05-30','2018-01-20',1.00,995849,NULL,6,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(29,26,5,'2016-09-28','2017-09-07',0.70,400162,NULL,5836,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(30,11,5,'2016-09-22','2017-06-10',0.70,302731,NULL,225143485,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(31,17,4,'2017-03-21','2018-02-19',1.00,556747,NULL,4,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(32,7,4,'2016-08-28','2017-07-29',0.70,388563,NULL,93038783,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(33,15,2,'2016-09-30','2017-05-22',0.50,193867,NULL,210880,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(34,23,3,'2016-09-08','2017-11-17',0.70,504552,NULL,69,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(35,23,5,'2016-06-11','2017-08-23',0.90,654675,NULL,9,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(36,15,4,'2016-05-29','2018-01-12',0.50,491296,NULL,9894007,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(37,15,4,'2016-10-30','2017-08-06',0.40,186245,NULL,150,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(38,25,4,'2016-03-29','2017-09-16',0.40,355921,NULL,1000230,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(39,19,2,'2016-11-12','2017-08-22',0.30,141175,NULL,46763,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(40,8,5,'2016-05-12','2017-04-02',1.00,540178,NULL,32491816,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(41,23,4,'2017-01-30','2017-10-05',0.90,371331,NULL,1427,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(42,26,2,'2016-05-14','2018-01-25',0.00,NULL,NULL,6,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(43,21,6,'2017-01-24','2017-10-22',0.40,179617,NULL,4500999,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(44,22,2,'2017-03-04','2018-02-17',0.50,290801,NULL,1198,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(45,7,5,'2016-04-19','2018-03-03',0.60,679033,NULL,2887717,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(46,20,6,'2016-10-10','2017-05-24',0.10,37614,NULL,0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(47,16,2,'2016-04-26','2017-04-23',0.90,539846,NULL,51057,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(48,11,3,'2016-06-19','2018-01-08',0.80,752935,NULL,1188,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(49,15,1,'2017-01-06','2017-10-28',0.30,146643,NULL,17583709,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(50,7,2,'2016-04-17','2017-04-21',0.70,428000,NULL,47727,'2017-03-16 14:29:59','2017-03-16 14:29:59');
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
  `rateUnitType_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_B5F1AFE5166D1F9C` (`project_id`),
  KEY `IDX_B5F1AFE5ED5CA9E6` (`service_id`),
  KEY `IDX_B5F1AFE52BE78CCE` (`rateUnitType_id`),
  KEY `IDX_B5F1AFE5A76ED395` (`user_id`),
  CONSTRAINT `FK_B5F1AFE5A76ED395` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_B5F1AFE5166D1F9C` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_B5F1AFE52BE78CCE` FOREIGN KEY (`rateUnitType_id`) REFERENCES `rateunittypes` (`id`),
  CONSTRAINT `FK_B5F1AFE5ED5CA9E6` FOREIGN KEY (`service_id`) REFERENCES `services` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activities`
--

LOCK TABLES `activities` WRITE;
/*!40000 ALTER TABLE `activities` DISABLE KEYS */;
INSERT INTO `activities` VALUES (1,9,1,2,'DimERP Programmieren','CHF 10000',1,1,0.080,'CHF/h','2017-03-16 14:29:59','2017-03-16 14:29:59','h'),(2,1,6,4,'Molestias est in sed.','CHF 18000',1,1,0.025,'CHF/h','2017-03-16 14:29:59','2017-03-16 14:29:59','h'),(3,10,13,5,'Cum ducimus vitae quam.','CHF 8100',1,1,0.025,'CHF/h','2017-03-16 14:29:59','2017-03-16 14:29:59','h'),(4,2,14,1,'Est officia voluptatibus corrupti commodi deserunt.','CHF 2800',1,1,0.080,'CHF/h','2017-03-16 14:29:59','2017-03-16 14:29:59','h'),(5,16,6,5,'Aut numquam a harum aliquam est.','CHF 18000',1,1,0.025,'CHF/h','2017-03-16 14:29:59','2017-03-16 14:29:59','h'),(6,5,2,5,'Ratione sunt ut officia est.','CHF 10300',1,1,0.080,'CHF/h','2017-03-16 14:29:59','2017-03-16 14:29:59','h'),(7,19,8,2,'Eius necessitatibus qui.','CHF 2800',1,1,0.080,'CHF/h','2017-03-16 14:29:59','2017-03-16 14:29:59','h'),(8,19,20,1,'Eum repellendus enim eum.','CHF 10300',1,1,0.080,'CHF/h','2017-03-16 14:29:59','2017-03-16 14:29:59','h'),(9,12,19,2,'Explicabo odit similique nihil numquam est.','CHF 18000',1,1,0.080,'CHF/h','2017-03-16 14:29:59','2017-03-16 14:29:59','h'),(10,20,9,5,'Sit quas quo totam quia.','CHF 18000',0,1,0.025,'CHF/h','2017-03-16 14:29:59','2017-03-16 14:29:59','h'),(11,12,16,6,'Quidem dolorum neque repudiandae.','CHF 8100',1,1,0.080,'CHF/h','2017-03-16 14:29:59','2017-03-16 14:29:59','h'),(12,5,38,3,'Occaecati ut et soluta.','CHF 16900',0,1,0.080,'CHF/d','2017-03-16 14:29:59','2017-03-16 14:29:59','t'),(13,9,35,5,'Et nihil voluptates dolores consectetur quo.','CHF 3100',1,1,0.080,'CHF/d','2017-03-16 14:29:59','2017-03-16 14:29:59','t'),(14,9,28,6,'Perspiciatis aspernatur nemo.','CHF 10800',0,1,0.025,'CHF/d','2017-03-16 14:29:59','2017-03-16 14:29:59','t'),(15,1,35,4,'Dolorem consequatur rerum suscipit.','CHF 3100',1,1,0.080,'CHF/d','2017-03-16 14:29:59','2017-03-16 14:29:59','t'),(16,20,40,4,'Et eos blanditiis.','CHF 10800',1,1,0.080,'CHF/d','2017-03-16 14:29:59','2017-03-16 14:29:59','t'),(17,12,40,3,'Iste repellat qui ipsum sit illum.','CHF 10800',1,1,0.080,'CHF/d','2017-03-16 14:29:59','2017-03-16 14:29:59','t'),(18,14,24,6,'Commodi modi quia culpa corrupti autem.','CHF 1500',1,1,0.025,'CHF/d','2017-03-16 14:29:59','2017-03-16 14:29:59','t'),(19,5,27,1,'Consequuntur provident beatae culpa consequatur aut.','CHF 10800',1,1,0.080,'CHF/d','2017-03-16 14:29:59','2017-03-16 14:29:59','t'),(20,16,30,5,'Excepturi magni qui at et inventore.','CHF 1500',1,1,0.080,'CHF/d','2017-03-16 14:29:59','2017-03-16 14:29:59','t'),(21,9,25,6,'Corporis molestias nam maxime qui dolorem.','CHF 16900',1,1,0.025,'CHF/d','2017-03-16 14:29:59','2017-03-16 14:29:59','t'),(22,16,58,1,'Ex occaecati dolorem.','CHF 18300',1,1,0.080,'Pauschal','2017-03-16 14:29:59','2017-03-16 14:29:59','a'),(23,6,48,6,'Odio in vero reiciendis modi.','CHF 18300',1,1,0.080,'Pauschal','2017-03-16 14:29:59','2017-03-16 14:29:59','a'),(24,1,50,5,'Labore minus iste corrupti.','CHF 18300',1,1,0.080,'Pauschal','2017-03-16 14:29:59','2017-03-16 14:29:59','a'),(25,20,42,6,'Consectetur omnis eaque nobis qui recusandae.','CHF 18500',1,1,0.025,'Einheit','2017-03-16 14:29:59','2017-03-16 14:29:59','a'),(26,3,58,5,'Aut delectus laudantium.','CHF 18300',1,1,0.080,'Pauschal','2017-03-16 14:29:59','2017-03-16 14:29:59','a'),(27,9,45,3,'Omnis possimus numquam nostrum officiis.','CHF 13700',1,1,0.080,'Km','2017-03-16 14:29:59','2017-03-16 14:29:59','a'),(28,7,52,3,'Sit aut temporibus dolorem occaecati.','CHF 18500',1,1,0.025,'Einheit','2017-03-16 14:29:59','2017-03-16 14:29:59','a'),(29,12,54,4,'Molestias quod error.','CHF 13700',0,1,0.025,'Km','2017-03-16 14:29:59','2017-03-16 14:29:59','a'),(30,2,59,1,'Temporibus et et veritatis quia.','CHF 18500',1,1,0.080,'Einheit','2017-03-16 14:29:59','2017-03-16 14:29:59','a'),(31,7,49,4,'Dolore accusamus qui similique et aliquam.','CHF 5500',1,1,0.025,'Einheit','2017-03-16 14:29:59','2017-03-16 14:29:59','a'),(32,15,68,6,'Commodi qui voluptate quia rerum ut.','CHF 6700',1,1,0.080,'Pauschal','2017-03-16 14:29:59','2017-03-16 14:29:59','a'),(33,19,74,6,'Totam saepe nihil mollitia consequatur et.','CHF 18300',0,1,0.025,'Pauschal','2017-03-16 14:29:59','2017-03-16 14:29:59','a'),(34,16,62,1,'Totam cupiditate odio asperiores.','CHF 18300',1,1,0.080,'Pauschal','2017-03-16 14:29:59','2017-03-16 14:29:59','a'),(35,10,79,1,'Qui ipsam similique quaerat.','CHF 10700',1,1,0.025,'Pauschal','2017-03-16 14:29:59','2017-03-16 14:29:59','a'),(36,13,72,2,'Ratione maiores et et ut.','CHF 18300',1,1,0.080,'Pauschal','2017-03-16 14:29:59','2017-03-16 14:29:59','a'),(37,8,64,2,'Sed ipsa nam minus qui.','CHF 2700',1,1,0.080,'Pauschal','2017-03-16 14:29:59','2017-03-16 14:29:59','a'),(38,16,78,2,'Eaque eos temporibus optio.','CHF 14500',1,1,0.025,'Pauschal','2017-03-16 14:29:59','2017-03-16 14:29:59','a'),(39,1,71,5,'Officia fugit et voluptatibus quam.','CHF 18300',1,1,0.080,'Pauschal','2017-03-16 14:29:59','2017-03-16 14:29:59','a'),(40,16,63,1,'Ut ratione ea aperiam quae nam.','CHF 14500',1,1,0.025,'Pauschal','2017-03-16 14:29:59','2017-03-16 14:29:59','a'),(41,9,66,2,'Quis sed autem et velit dolores.','CHF 14500',0,1,0.080,'Pauschal','2017-03-16 14:29:59','2017-03-16 14:29:59','a');
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
  CONSTRAINT `FK_6C784FB4BAD26311` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_6C784FB481C06096` FOREIGN KEY (`activity_id`) REFERENCES `activities` (`id`) ON DELETE CASCADE
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
INSERT INTO `address` VALUES (1,'Bahnhhofstrasse','25','Zürich',8000,'ZH','Switzerland'),(2,'Thieleplatz','880','Eutin',1133,'Baden-Württemberg','Mali'),(3,'Völkerweg','2/3','Ebersberg',68921,'Bremen','Neuseeland'),(4,'Ingolf-Roth-Gasse','850','Viechtach',13213,'Sachsen-Anhalt','St. Barthélemy'),(5,'Jordanallee','5','Rehau',79826,'Hamburg','Usbekistan'),(6,'Ahmet-Jacob-Ring','9/5','Bremervörde',87718,'Brandenburg','Pitcairn'),(7,'Paulstr.','8','Badalzungen',70183,'Thüringen','Demokratische Republik Kongo'),(8,'Heinrichring','686','Kassel',20837,'Mecklenburg-Vorpommern','Estland'),(9,'Hammerweg','5/3','Garmisch-Partenkirchen',23011,'Berlin','Tonga'),(10,'Adlerallee','5/7','Lemgo',80095,'Bayern','Albanien'),(11,'Schultzstr.','5/9','Miesbach',46220,'Schleswig-Holstein','Georgien'),(12,'Gebhardtplatz','5/0','Coburg',87944,'Sachsen','Brasilien'),(13,'Christl-Bock-Platz','0/0','Wetzlar',77679,'Hessen','Jersey'),(14,'Marliese-Arnold-Weg','9/9','Meißen',52415,'Nordrhein-Westfalen','St. Pierre und Miquelon'),(15,'Neuhausstraße','982','Gunzenhausen',75325,'Mecklenburg-Vorpommern','Neukaledonien'),(16,'Heinz-Günter-Fleischmann-Platz','31','Bad Langensalza',50744,'Sachsen-Anhalt','Niger'),(17,'Barthelstr.','55','Bad Kissingen',68475,'Baden-Württemberg','Chile'),(18,'Norman-Rupp-Gasse','28','Hofgeismar',87477,'Berlin','Belarus'),(19,'Heßallee','521','Rathenow',70866,'Brandenburg','Philippinen'),(20,'Marcel-Kirchner-Gasse','612','Bad Liebenwerda',38783,'Bayern','Belize'),(21,'Oskar-Schmitt-Ring','200','Crailsheim',23847,'Bayern','Botsuana'),(22,'Keilstr.','6','Coburg',78228,'Brandenburg','Gibraltar'),(23,'Irmhild-Reimer-Platz','07','Berchtesgaden',77211,'Rheinland-Pfalz','Ungarn'),(24,'Bertramstraße','668','Schwäbisch Hall',20640,'Saarland','Irak'),(25,'Steffen-Niemann-Gasse','881','Neustadtm Rübenberge',62663,'Rheinland-Pfalz','Ruanda');
/*!40000 ALTER TABLE `address` ENABLE KEYS */;
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
  CONSTRAINT `FK_3B2D3051BAD26311` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_3B2D30519395C3F3` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE
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
  CONSTRAINT `FK_62534E21A76ED395` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_62534E212983C9E6` FOREIGN KEY (`rate_group_id`) REFERENCES `rate_groups` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_62534E21F5B7AF75` FOREIGN KEY (`address_id`) REFERENCES `address` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES (1,1,1,3,'StiftungSWO','stiftungswo',NULL,NULL,NULL,NULL,1,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(2,2,2,1,'Hoffmann','et-aliquam-et-at-quod-consequa','Zimmermann GmbH','quia','Wilfried Moll','Frau',1,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(3,1,3,3,'Kiefer AG','mollitia-consequatur-et-at-mag','Köhler','odio','Frau Prof. Karen Wittmann','Frau',1,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(4,1,4,5,'Wild KG','perspiciatis-et-placeat-autem','Friedrich','et','Waldemar Dietz MBA.','Herr',1,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(5,2,5,2,'Heck KG','recusandae-nam-quia-non-vitae-','Hübner Thiele OHG mbH','eaque','Leo Hirsch','Herr',1,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(6,2,6,1,'Kern','commodi-nihil-ut-ratione-ea-ap','Held AG & Co. OHG','ipsum','Wally Breuer-Bader','Frau',0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(7,2,7,3,'Unger AG','dignissimos-enim-maxime-tempor','Hentschel','placeat','Alwin Schenk','Herr',1,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(8,2,8,2,'Braun','quod-exercitationem-numquam-qu','Mai','voluptatem','Silke Krauß','Frau',1,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(9,1,9,3,'Adler','qui-quisquam-facere-esse-quia-','Wiesner Bernhardt e.V.','dicta','Walburga Ackermann','Frau',1,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(10,1,10,3,'Voigt Stiftung & Co. KG','et-molestias-culpa-et-facilis-','Lorenz Eberhardt GmbH','nobis','Heinz-Josef Fink','Herr',1,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(11,1,11,6,'Neubauer e.G.','eveniet-sint-provident-magni-e','Becker','quia','Klara Wimmer','Herr',1,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(12,2,12,2,'Lange Seidel e.V.','reiciendis-sunt-molestias-iure','Fuhrmann e.V.','suscipit','Henny Geisler','Herr',1,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(13,2,13,2,'Heinze','adipisci-temporibus-labore-lib','Hermann Hammer AG & Co. OHG','modi','Cindy Esser B.Eng.','Frau',1,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(14,2,14,3,'Römer GmbH & Co. KG','beatae-et-et-quis-illum-molest','Brandt KG','repellat','Frau Dr. Anny Völker B.Eng.','Frau',0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(15,1,15,2,'Wolff AG & Co. KGaA','possimus-itaque-et-vel-qui-eos','Geisler GmbH & Co. KG','architecto','Reinhilde Lindemann','Frau',1,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(16,1,16,2,'Klose GmbH','enim-voluptatum-laboriosam-vit','Pietsch Meyer GbR','voluptas','Heidemarie Weiß','Herr',1,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(17,2,17,6,'Rothe Günther e.V.','maiores-dolore-et-at-debitis','Moser Friedrich GmbH','mollitia','Frau Veronika Unger','Herr',1,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(18,1,18,3,'Maier','ut-sint-est-quo-quas-eius-quam','Nowak KGaA','quisquam','Frau Prof. Edith Dietz','Frau',1,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(19,2,19,2,'Wolter','dolores-veritatis-illo-eveniet','Stumpf','omnis','Hagen Gabriel','Herr',1,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(20,1,20,1,'Geißler','officia-id-quidem-commodi-ulla','Bender','soluta','Cordula Wenzel','Herr',1,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(21,1,21,4,'Schumann Heine Stiftung & Co. KGaA','dolores-ut-tempore-modi-molest','Voß','dolorem','Kuno Barth','Frau',1,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(22,2,22,6,'Jürgens Stiftung & Co. KG','aliquid-quasi-sit-ipsa-sequi-i','Jost','alias','Torben Kellner','Herr',1,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(23,2,23,4,'Lenz GbR','cum-autem-nesciunt-et-numquam-','Huber','est','Milan Göbel','Frau',1,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(24,1,24,6,'Schlegel Preuß AG','quibusdam-reprehenderit-omnis-','Jansen','aut','Margarethe Bruns MBA.','Herr',1,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(25,1,25,1,'Reimer','dolores-est-dolores-neque-face','Thiel AG','quo','Edelgard Heinze','Frau',1,'2017-03-16 14:29:59','2017-03-16 14:29:59');
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
INSERT INTO `holidays` VALUES (1,1,'2016-05-13',30240,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(2,3,'2016-05-18',30240,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(3,5,'2016-09-18',3600,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(4,4,'2016-10-22',16200,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(5,4,'2017-01-05',3600,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(6,4,'2016-11-15',30240,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(7,5,'2016-09-03',30240,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(8,5,'2016-06-12',30240,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(9,3,'2016-09-23',16200,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(10,4,'2016-07-06',16200,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(11,5,'2017-01-25',16200,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(12,2,'2017-02-03',30240,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(13,5,'2017-01-19',30240,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(14,1,'2017-01-18',30240,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(15,5,'2016-03-20',30240,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(16,4,'2016-05-13',30240,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(17,6,'2016-04-04',30240,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(18,5,'2016-10-16',30240,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(19,1,'2016-06-07',30240,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(20,5,'2016-12-11',30240,'2017-03-16 14:29:59','2017-03-16 14:29:59');
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
  CONSTRAINT `FK_4F4E9F23A76ED395` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_4F4E9F232989F1FD` FOREIGN KEY (`invoice_id`) REFERENCES `invoices` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoiceDiscounts`
--

LOCK TABLES `invoiceDiscounts` WRITE;
/*!40000 ALTER TABLE `invoiceDiscounts` DISABLE KEYS */;
INSERT INTO `invoiceDiscounts` VALUES (1,49,2,'10% Off',0.10,1,1,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(2,50,1,'10% Off',0.10,1,1,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(3,50,3,'10% Off',0.10,1,1,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(4,48,3,'10% Off',0.10,1,1,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(5,46,1,'10% Off',0.10,1,1,'2017-03-16 14:29:59','2017-03-16 14:29:59');
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
  CONSTRAINT `FK_DCC4B9F8A76ED395` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_DCC4B9F82989F1FD` FOREIGN KEY (`invoice_id`) REFERENCES `invoices` (`id`),
  CONSTRAINT `FK_DCC4B9F881C06096` FOREIGN KEY (`activity_id`) REFERENCES `activities` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoice_items`
--

LOCK TABLES `invoice_items` WRITE;
/*!40000 ALTER TABLE `invoice_items` DISABLE KEYS */;
INSERT INTO `invoice_items` VALUES (1,1,1,2,'Zivi (Tagespauschale)','CHF 88000','CHF/h',0.080,'28',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(2,25,5,1,'molestias','CHF 64300','CHF/h',0.025,'40',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(3,49,7,4,'velit','CHF 800','CHF/h',0.080,'23',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(4,17,8,5,'ea','CHF 29200','CHF/h',0.025,'21',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(5,1,8,2,'corrupti','CHF 86000','CHF/h',0.025,'61',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(6,46,7,1,'molestiae','CHF 45200','CHF/h',0.025,'53',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(7,33,8,1,'quod','CHF 22400','CHF/h',0.025,'71',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(8,34,8,2,'ut','CHF 29900','CHF/h',0.025,'95',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(9,49,5,3,'perspiciatis','CHF 37100','CHF/h',0.025,'50',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(10,22,11,1,'neque','CHF 32600','CHF/h',0.025,'42',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(11,49,8,1,'ea','CHF 79700','CHF/h',0.025,'71',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(12,19,19,4,'nihil','CHF 71200','CHF/h',0.080,'11',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(13,30,18,2,'sunt','CHF 79200','CHF/h',0.080,'53',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(14,27,17,5,'numquam','CHF 59400','CHF/h',0.080,'11',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(15,8,18,5,'repudiandae','CHF 11700','CHF/h',0.025,'25',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(16,46,20,4,'ut','CHF 65900','CHF/h',0.025,'39',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(17,29,21,6,'eveniet','CHF 22000','CHF/h',0.025,'25',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(18,12,15,5,'illo','CHF 14800','CHF/h',0.025,'22',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(19,30,15,1,'nemo','CHF 49900','CHF/h',0.025,'35',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(20,46,20,6,'consequatur','CHF 30400','CHF/h',0.080,'99',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(21,30,15,1,'qui','CHF 69900','CHF/h',0.080,'31',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(22,3,27,2,'sit','CHF 51300','CHF/h',0.025,'58',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(23,2,24,4,'illum','CHF 26200','CHF/h',0.080,'82',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(24,50,31,1,'modi','CHF 67900','CHF/h',0.080,'25',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(25,32,28,4,'enim','CHF 10300','CHF/h',0.080,'25',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(26,15,27,4,'consequatur','CHF 65400','CHF/h',0.080,'33',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(27,19,27,4,'excepturi','CHF 37600','CHF/h',0.025,'96',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(28,1,28,5,'soluta','CHF 4300','CHF/h',0.025,'28',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(29,16,22,1,'maxime','CHF 79900','CHF/h',0.080,'8',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(30,26,28,5,'vel','CHF 18400','CHF/h',0.025,'38',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(31,22,24,4,'quia','CHF 67000','CHF/h',0.025,'35',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(32,12,32,5,'magni','CHF 88000','CHF/h',0.025,'21',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(33,37,41,6,'iste','CHF 74800','CHF/h',0.025,'77',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(34,41,36,5,'consectetur','CHF 29600','CHF/h',0.025,'86',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(35,48,36,6,'molestias','CHF 29600','CHF/h',0.025,'82',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(36,13,33,2,'sed','CHF 22800','CHF/h',0.080,'17',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(37,24,35,6,'numquam','CHF 72800','CHF/h',0.025,'89',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(38,17,36,1,'velit','CHF 25800','CHF/h',0.080,'11',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(39,19,34,3,'eos','CHF 39200','CHF/h',0.080,'91',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(40,41,34,6,'repellendus','CHF 88100','CHF/h',0.080,'96',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(41,42,35,1,'et','CHF 85600','CHF/h',0.025,'67',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59');
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
  CONSTRAINT `FK_A1BE84207EAA7D27` FOREIGN KEY (`standard_discount_id`) REFERENCES `standard_discounts` (`id`),
  CONSTRAINT `FK_A1BE84202989F1FD` FOREIGN KEY (`invoice_id`) REFERENCES `invoices` (`id`)
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
  CONSTRAINT `FK_6D79F643BAD26311` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_6D79F6432989F1FD` FOREIGN KEY (`invoice_id`) REFERENCES `invoices` (`id`) ON DELETE CASCADE
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
  CONSTRAINT `FK_6A2F2F95A76ED395` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_6A2F2F95166D1F9C` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`),
  CONSTRAINT `FK_6A2F2F959395C3F3` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_6A2F2F959582AA74` FOREIGN KEY (`accountant_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoices`
--

LOCK TABLES `invoices` WRITE;
/*!40000 ALTER TABLE `invoices` DISABLE KEYS */;
INSERT INTO `invoices` VALUES (1,1,1,NULL,1,'Default Invoice','default-invoice','This is a detailed description','2016-03-05','2016-10-28',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(2,1,19,NULL,4,'Test Invoice 2','test-invoice-2','Velit possimus cum ducimus vitae quam omnis ea. Odio quis est officia voluptatibus corrupti commodi. Minima reprehenderit laborum cumque molestiae aut numquam. Harum aliquam est quod. Laudantium qui ipsa ratione sunt ut officia.\nReprehenderit autem voluptatem perspiciatis eius necessitatibus qui. Quis saepe neque quia eum repellendus enim eum. Ea et harum ut explicabo odit similique nihil numquam. Sit suscipit libero nisi sunt sit quas quo totam.\nNumquam itaque magnam voluptas quidem dolorum neque. Totam non dolor voluptatibus nihil occaecati ut.','2016-07-03','2016-10-16','CHF 2170800','2017-03-16 14:29:59','2017-03-16 14:29:59'),(3,12,22,NULL,4,'Test Invoice 3','test-invoice-3','Sit ullam iste repellat qui ipsum. Illum necessitatibus distinctio et doloremque quia commodi modi. Culpa corrupti autem quae perferendis enim id beatae.\nBeatae culpa consequatur aut ducimus dignissimos est consequatur. Excepturi magni qui at et inventore voluptas soluta eaque. Veritatis corporis molestias nam maxime qui dolorem quam cumque. Voluptatem vel ex occaecati dolorem ab repudiandae.\nIusto odio in vero reiciendis modi magni perferendis. Suscipit labore labore minus iste corrupti rerum necessitatibus. Totam sit consectetur omnis eaque nobis.','2015-09-20','2016-11-28',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(4,17,18,NULL,3,'Test Invoice 4','test-invoice-4','Similique delectus nobis dolore accusamus qui. Et aliquam et at quod consequatur. Commodi qui voluptate quia rerum ut enim rem. Voluptas harum totam saepe.\nConsequatur et at magni nihil aut. Totam cupiditate odio asperiores perspiciatis. Et natus optio qui ipsam similique quaerat commodi. Et placeat autem ratione.\nEt ut beatae rerum assumenda et. Sed ipsa nam minus qui recusandae nam. Non vitae eaque eos temporibus optio.\nEt eaque esse officia fugit et voluptatibus. Quaerat aut id commodi nihil. Ratione ea aperiam quae nam id repellat. Nihil ipsum quis sed autem et velit dolores. Optio quos quia molestiae dignissimos enim maxime tempore.','2015-10-02','2016-11-03',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(5,12,4,NULL,5,'Test Invoice 5','test-invoice-5','Quam aut culpa illo quisquam. Distinctio quo aut aut et molestias culpa. Facilis est ut qui fugit.\nMaxime nobis ut cupiditate nemo rem. Voluptas dignissimos molestiae neque culpa. Sint provident magni eius nulla distinctio qui quia. Et magnam qui officia.\nExpedita ratione et sit reiciendis sunt molestias iure. Et molestiae laborum sequi laborum distinctio suscipit aut.\nAssumenda soluta aut magni accusantium voluptatem adipisci. Labore libero repudiandae non. Autem unde est eaque et.\nIncidunt exercitationem et reiciendis vel facilis sed facere. Est laboriosam beatae et. Quis illum molestiae rerum omnis exercitationem velit repellat. Cum vitae sunt vel ut molestiae.','2015-04-05','2016-11-04',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(6,18,25,NULL,2,'Test Invoice 6','test-invoice-6','Nihil sit labore rem voluptas quasi. A ea libero veritatis. Ad incidunt voluptatem facere. Dolore et at debitis reprehenderit sequi occaecati rerum.\nOccaecati et quod deserunt dignissimos repudiandae eos adipisci dolores. Ut sint est quo quas eius quam architecto enim. Est quo eveniet quisquam iste dolorem. Praesentium autem qui sed sed cupiditate.\nVeritatis illo eveniet est non qui. Repellendus natus omnis assumenda eaque vel modi nisi. Ipsum praesentium cumque officia id quidem commodi. Aut fuga praesentium et.','2015-05-29','2016-08-31',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(7,13,15,NULL,6,'Test Invoice 7','test-invoice-7','Quae sed atque occaecati error alias labore sit a. Omnis doloribus pariatur sint est. Cum autem nesciunt et numquam aspernatur. Odio magni est voluptatum.\nAdipisci corporis qui quis molestiae corporis placeat adipisci quibusdam. Omnis voluptas sed ut et. Minima quos est cumque facere numquam eius numquam nemo. Dolores est dolores neque facere fugit sint consequatur et.\nQuos id quo laudantium dolorem voluptatibus iure. Provident neque est inventore minima laboriosam quia possimus.','2016-07-19','2017-02-07',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(8,4,18,NULL,3,'Test Invoice 8','test-invoice-8','Perspiciatis aliquam repellat quia sequi et nihil beatae. Et dolores et dicta sunt accusamus et occaecati.\nIusto dignissimos sit aut repellendus. Voluptas sapiente autem non ut fuga voluptatibus atque. Saepe impedit eius ut alias quisquam at qui.\nMaxime adipisci et saepe esse. Sed aperiam rerum nemo animi necessitatibus. Facilis quam aut iusto harum reiciendis magnam.\nMolestiae iste dolorum velit ipsam. Quia reprehenderit earum nulla consequatur occaecati. Dolores et est quia ex sit. Explicabo libero placeat ex aperiam. Dolorum facilis enim omnis consectetur nihil ipsum velit.\nTenetur totam ad ut. Corporis veniam minima a numquam. Repellat ea atque veniam pariatur quos nulla ipsa dolorem.','2016-04-29','2017-02-12',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(9,20,9,NULL,3,'Test Invoice 9','test-invoice-9','Maiores voluptate aperiam et aut at. Voluptas est aut placeat odio optio. Qui vel qui quasi autem molestias. Odit sapiente aliquid veritatis est fuga.\nMinima ipsam eum amet qui. Veniam est reiciendis quibusdam aut omnis labore. Consequuntur explicabo sint sequi non.\nAliquam voluptatem quia hic sit. Rem enim eos necessitatibus omnis ullam maxime hic et. Expedita est id dolor aliquid officia perspiciatis autem. Et et nihil officia sit sed et pariatur et.\nUt hic est quo et. Minus aut harum reprehenderit qui. Voluptatibus numquam dolores suscipit molestiae fugiat est saepe.\nVoluptate aut ullam tempore aspernatur sit eius est. Asperiores laborum eum consequatur corrupti tempora ut iure.','2016-07-30','2016-08-30',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(10,2,10,NULL,2,'Test Invoice 10','test-invoice-10','Id molestias labore provident error consequatur modi et. Assumenda quos excepturi ipsam. Magni similique qui repellendus.\nPraesentium id porro tempora iste id. Voluptatem rerum optio sint voluptatem libero dolore. At modi assumenda et tempore ex. Vel quasi facilis eveniet repellat facere cupiditate sed rem.\nUllam temporibus quia et in dolorem quidem. Enim aspernatur sed est voluptatem officia. Velit laboriosam ut eum nulla ea ut error. Eos blanditiis animi provident omnis et quidem.\nEst inventore velit laboriosam dignissimos est enim tenetur. Dolores laborum commodi quis sit eveniet. Dolor est voluptatum cum veniam. Blanditiis sit vero quo.','2015-09-05','2017-02-01','CHF 951700','2017-03-16 14:29:59','2017-03-16 14:29:59'),(11,4,11,NULL,3,'Test Invoice 11','test-invoice-11','Aut explicabo nam fuga. Error consequatur error maxime soluta modi eveniet est quis. Laudantium adipisci explicabo molestias provident totam voluptatibus. Veritatis fuga voluptas cupiditate voluptas sit.\nAliquid libero et temporibus ut ad sint pariatur. Et sint sunt et aspernatur sapiente necessitatibus. Tempora laborum doloribus impedit eaque aliquam.\nAnimi aut possimus quidem provident qui. Atque eaque laudantium reiciendis minima. Ratione quisquam ducimus velit eligendi delectus possimus. Doloribus molestias sit exercitationem consequuntur amet quia molestiae ad. Facere aut et voluptatem esse.','2016-04-21','2016-09-20',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(12,14,25,NULL,2,'Test Invoice 12','test-invoice-12','Quo cum corrupti rerum consequatur. Expedita et voluptatibus aut voluptatem. In neque quos ut qui.\nTempore labore quia nesciunt culpa cupiditate temporibus nulla. Fugit omnis sed ullam ut deserunt magni. Voluptate quidem eaque ut distinctio.\nEst ratione rerum ipsa culpa voluptatem eos. Quia adipisci amet consequatur dolorum. Consequatur quasi perferendis provident dicta sed esse dolorum.\nQuidem eos vel voluptas. Voluptas iure et commodi quidem dicta fugit. Voluptatem ratione et rerum. Voluptas maxime vel non ea voluptatem.','2016-04-04','2016-10-08','CHF 3028100','2017-03-16 14:29:59','2017-03-16 14:29:59'),(13,NULL,4,NULL,6,'Test Invoice 13','test-invoice-13','Molestias non perferendis voluptate ad facilis. Consequatur dolore deserunt dignissimos aliquam. Ipsam omnis eos molestias autem non sunt. Aut placeat nisi reiciendis nihil eos voluptate dolorem qui.\nVoluptatem consequuntur corporis ea quia. Molestias rerum iusto quia sapiente eum molestiae optio doloribus. Est quidem dolores et magni voluptatem temporibus.\nOfficia ratione voluptatem similique qui ipsam itaque rerum. Quibusdam consectetur quas eius sint deserunt adipisci recusandae. Minus vel consequatur eum enim nihil laborum laboriosam consectetur. Architecto voluptatem qui occaecati voluptas sed voluptates.','2016-02-05','2016-09-24',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(14,6,22,NULL,2,'Test Invoice 14','test-invoice-14','Ut nisi est similique. Et possimus deserunt omnis maxime. Iste architecto aut quia eius deserunt eius. Est quod vero ab omnis sunt.\nNon tempore est vel inventore asperiores fugiat dicta. Voluptas fuga et molestiae et minima a cum. Et eius ut et vel. Nesciunt dolores officia ut.\nQuasi ut est molestiae error minus. Neque repudiandae quae non ad eos. Exercitationem voluptatem sunt pariatur nulla et. At soluta molestias autem.\nSunt praesentium velit aut sint voluptatibus ipsa. Omnis consequatur et cupiditate quisquam corporis laboriosam repudiandae itaque. Alias sint et dolorem doloribus occaecati commodi quisquam. Ipsam provident ex recusandae aliquid beatae.','2015-04-14','2016-09-07',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(15,8,5,NULL,3,'Test Invoice 15','test-invoice-15','Qui corrupti odit doloribus quia occaecati doloribus. Expedita incidunt velit porro beatae sit et autem. Sunt sit voluptatem et deleniti totam quae et.\nAsperiores corporis aperiam sit beatae. Neque distinctio odit quo et omnis est. Dolorem beatae quasi ipsa vel est ad. Illum eum eligendi reprehenderit et quas non et. Animi quibusdam labore numquam maxime modi.\nDeserunt qui sit tenetur inventore. Error occaecati enim aperiam dicta eaque id sit. Molestiae placeat nulla quia a et.\nIncidunt nulla aperiam officia eaque error cumque ullam. Ab qui minus ut sint. Autem eius mollitia perferendis dicta esse porro aut. Et et quia et enim dolor praesentium optio eveniet.','2015-10-23','2016-11-27',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(16,1,25,NULL,2,'Test Invoice 16','test-invoice-16','Iure assumenda nemo vel vel. Aut aliquam non iste doloremque repellat impedit. Aliquam nisi quia nulla pariatur inventore. Tempora non eos mollitia fugit perferendis provident.\nNecessitatibus sit repudiandae dolorum magnam quo. Eaque et asperiores animi voluptatem in ut. Culpa et quae vero quas.\nVitae harum quod rerum quis. Perferendis numquam sit iste hic. Laborum soluta sit accusantium et.\nQuam id autem explicabo hic consequatur consectetur. Aut quasi sit nam qui id et. Et aliquam minima corporis aut sequi qui. Quo sed provident aperiam vel impedit quos. Nesciunt odit esse repellat aliquid animi.','2016-05-12','2016-10-21',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(17,NULL,22,NULL,6,'Test Invoice 17','test-invoice-17','Autem qui impedit repellendus dolor vitae illo minima. Ad et dolores eos voluptas consequatur commodi odit qui. A aut et veritatis esse dolorem cumque. Vel minus accusamus laudantium possimus laboriosam optio et. Accusantium dolorem dolores beatae est eos modi.\nSit numquam voluptatibus cupiditate. Ipsa occaecati similique consequuntur voluptatum expedita. Facilis repellendus iste est fugiat ab accusamus nam. Est totam qui est omnis accusamus.\nIn eaque asperiores ad officia quo. Voluptatem cum dicta quod totam. Dicta vel quasi molestiae. Vero expedita autem sint cumque quia.','2015-09-07','2017-01-18',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(18,16,7,NULL,2,'Test Invoice 18','test-invoice-18','Non consequatur cumque voluptatibus repellendus eligendi inventore laudantium ut. Et numquam dolores ea nobis quo corrupti iste.\nRem tenetur consequuntur sit tempora excepturi officiis ipsa. Nihil aperiam provident quae quia. Reprehenderit eum consequatur cum quod dolor dolores.\nPariatur et molestias veritatis iusto quia delectus consectetur eveniet. Quae cupiditate consectetur at quam officia. Eum consequatur corporis voluptates voluptate quo doloremque. Vel unde eveniet debitis dolores iusto.','2015-11-29','2016-12-10',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(19,16,17,NULL,5,'Test Invoice 19','test-invoice-19','Et sunt ut qui quae et perferendis. Quis dolores tenetur totam sunt ut molestias quisquam. Molestiae nostrum quod qui harum et. Numquam illo nulla eius eum.\nOmnis sed enim sit repellat. Doloremque quae voluptatem est beatae ipsum hic. Enim et dolor id tempora quas modi fugit. Illo provident aliquid repellendus fuga aspernatur cupiditate.\nEst repellendus repellat rerum quo laboriosam. Quae voluptas earum placeat facilis sunt quos aliquid. Voluptatem repellendus blanditiis ea atque.\nDoloremque ullam labore dignissimos quaerat molestiae nesciunt commodi. Qui iste ab non dolorem et dolores. Culpa et provident quisquam. Perspiciatis aliquam quibusdam dolor molestiae sit quis autem.','2016-01-18','2016-10-11',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(20,19,6,NULL,2,'Test Invoice 20','test-invoice-20','Consequuntur nulla assumenda aut laboriosam. Corporis in amet ut labore. Accusantium qui veniam mollitia quia nihil.\nAccusantium maxime nesciunt ipsam itaque libero maxime. Minus omnis non eligendi nisi. Facere qui quas est molestiae nulla non.\nNon consequatur possimus tenetur consequuntur laborum temporibus natus. Impedit omnis sint explicabo exercitationem porro. Repudiandae recusandae quisquam ipsa veritatis. Sequi accusantium sit modi consectetur est.\nMolestiae nihil provident ratione quia dolores. Rerum et debitis officia labore et officiis at. Veniam magnam qui mollitia. Aut vel consequatur ducimus corporis excepturi eos.','2015-03-31','2017-01-13',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(21,3,6,NULL,2,'Test Invoice 21','test-invoice-21','Vitae consectetur vero enim inventore. Minus natus enim quis nemo aut voluptatem. Fugiat iure facere labore ducimus et ut dolorum velit.\nLaboriosam nemo ab nihil quibusdam molestias. Voluptas neque qui alias sed exercitationem excepturi numquam. Modi sed placeat odio ut ullam velit rem.\nEum quis eaque ipsa dolorum reiciendis dolore. Molestiae libero fugit corporis. Fuga ab quo temporibus rerum. Non nisi fuga quia deleniti unde minima.\nDoloremque nihil quia cum occaecati magnam hic expedita. Est iste fugit explicabo alias accusamus quo ratione. Perferendis provident provident aliquam sit eligendi.','2016-02-04','2017-03-04','CHF 9371200','2017-03-16 14:29:59','2017-03-16 14:29:59'),(22,8,13,NULL,4,'Test Invoice 22','test-invoice-22','Exercitationem vel et ea quam ad ipsa. Non omnis enim impedit aliquam cupiditate. Facilis quo minus dolor.\nMollitia corrupti magnam odit adipisci. Consequatur perferendis voluptas corporis recusandae repudiandae. Quisquam earum animi aut quisquam.\nExcepturi odit eius voluptatum officia reprehenderit eligendi totam temporibus. Et facilis dignissimos minima mollitia odit modi possimus eveniet. Culpa iste aliquid ipsam commodi blanditiis ipsam. Soluta dolore magni temporibus illum ex eveniet enim.\nVoluptatem perspiciatis consequatur repellendus eligendi. Doloremque ut dolores velit repellendus blanditiis.','2016-08-12','2016-12-16',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(23,10,9,NULL,3,'Test Invoice 23','test-invoice-23','Nihil recusandae facere voluptatem. Id magnam eveniet enim delectus animi quo maxime. Voluptatem accusantium illum perferendis suscipit. Aut suscipit dolore ut eos voluptatem reiciendis soluta.\nMaiores eius voluptatem ut aspernatur sunt omnis dolore consequatur. Asperiores quisquam nobis animi consequatur eligendi laudantium voluptatem. Aut et vel fugiat fuga.\nRerum maxime consequuntur iusto. Consectetur harum nemo laborum cupiditate. Sit soluta facilis ut numquam vel tempore et eius.\nSunt sequi sed ad quibusdam sequi. Ea pariatur incidunt aspernatur impedit nisi. Nisi officia perspiciatis reiciendis aperiam est nobis ipsa. Magnam nobis veritatis accusantium est pariatur.','2016-01-07','2016-09-14','CHF 4703200','2017-03-16 14:29:59','2017-03-16 14:29:59'),(24,12,4,NULL,5,'Test Invoice 24','test-invoice-24','Rerum nihil voluptatem debitis excepturi. A voluptas voluptate corrupti totam non aliquid fuga. Sed id et provident ea sequi. Quam rerum laboriosam in dolores id suscipit.\nIn velit modi aliquid repudiandae facere perferendis. Quaerat et delectus aut dolores. Odio molestiae et dolor officia. Fugiat dignissimos est ullam eligendi.\nNumquam non ad vel officiis dolores dolor natus. Labore est nisi illum impedit. Est veniam dicta qui.\nEt a corrupti quia aut. Cumque dolore error natus impedit commodi. Cupiditate porro sed dolorum accusantium. Consequatur quia tenetur quae odit.','2015-05-23','2016-11-28',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(25,12,2,NULL,6,'Test Invoice 25','test-invoice-25','Voluptas et et quis sed nobis et. Quae sit atque molestiae nihil molestiae eos sint. Adipisci qui quae minima qui dignissimos maiores quae quo.\nQuasi minima et odio voluptatibus. Qui enim neque odit est et fuga corporis. Dolores inventore eos tempore est ullam voluptas et fugiat. Architecto aut assumenda dolorum alias sit deserunt earum porro. Ducimus molestias fuga et.\nSunt aut ad molestiae officia. Nihil aliquam minima et porro omnis temporibus odio quam. Omnis quia deleniti ullam eum iure. Nemo sunt odit quia.','2015-07-01','2016-09-28','CHF 9225100','2017-03-16 14:29:59','2017-03-16 14:29:59'),(26,10,19,NULL,1,'Test Invoice 26','test-invoice-26','Sed id voluptates possimus velit. Repellendus aliquam voluptatem ut amet. Rerum beatae sit hic sit at ex temporibus.\nVoluptas aut eligendi et doloribus dolore quae. Hic qui harum est eius tenetur et ducimus. Nihil dolorem maiores laboriosam expedita est neque velit.\nDolores aut provident deserunt sunt. Nihil cumque id nihil quidem quia consectetur. Vero voluptatem quis consequatur alias voluptatem. Provident cupiditate harum quos dolorem perspiciatis odio.\nDolorum incidunt minus maiores molestiae nulla maiores. Et dignissimos minus nulla ut excepturi a fugit. Est maiores tempora quos laboriosam. Quam suscipit ducimus iste a repellendus.','2015-05-30','2016-09-19',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(27,12,1,NULL,1,'Test Invoice 27','test-invoice-27','Alias tempora quia qui ut ut quod. Quis est qui ad et placeat eaque itaque. Occaecati eos labore in est recusandae quaerat facilis.\nConsequuntur optio expedita ipsa incidunt debitis iure. Inventore voluptas voluptatem quia porro omnis ducimus eos. Nemo omnis cum et sunt fugiat. Illo officia perspiciatis consectetur aut ab.\nEarum fugiat est voluptatem sit rerum fuga accusamus praesentium. Autem enim ullam dicta qui et. Eum omnis esse sapiente debitis id fugit neque voluptatem. Molestiae delectus quae qui deleniti doloribus modi quia.\nAccusamus et praesentium quia quo in. Quis ipsum magnam consectetur non modi. Id neque facere quo illum quae sapiente ut est. Facere et ut et consequuntur.','2015-10-31','2016-12-20',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(28,6,18,NULL,3,'Test Invoice 28','test-invoice-28','Repellendus velit enim nostrum vero nemo et ut quisquam. Fugiat vel optio voluptatem et eligendi vitae iusto minima. Debitis saepe sit earum nostrum consequatur ipsa et.\nConsequatur sint voluptatum id molestiae. Et et non quam sint quae animi eligendi. Cum accusamus eveniet quae atque. Voluptatibus corrupti molestiae dolorem error facilis.\nEt voluptas dicta facere vero molestias. Doloribus repudiandae temporibus quia perspiciatis commodi eligendi alias.\nSint veniam explicabo sequi maiores. Expedita excepturi provident rerum corporis in sunt. Reiciendis recusandae sit ad magnam distinctio aut laborum. Ducimus provident et dolorem aliquam aut autem.','2015-07-10','2017-02-12',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(29,10,6,NULL,6,'Test Invoice 29','test-invoice-29','Quibusdam consequatur sit consectetur aliquid ad nihil quas. Et est voluptatem qui maiores vel quis. Quia voluptatem non explicabo qui reiciendis ut atque.\nEt ducimus nostrum sunt quasi qui sed nihil. Cupiditate provident aperiam esse. Dolore et ab omnis vitae quod.\nUt assumenda expedita quia rem et rerum qui. Ut dolores quisquam nam unde expedita. Doloribus numquam ut qui saepe.\nMagnam excepturi aut est pariatur. Eveniet debitis consectetur et illum. Dolores eius quibusdam laudantium blanditiis enim. Consectetur nihil reprehenderit facilis qui.\nNeque nulla enim praesentium rerum deleniti. Eos error animi quaerat similique omnis tenetur sapiente. Magnam nemo voluptate perspiciatis quaerat.','2016-03-14','2017-03-08','CHF 3152700','2017-03-16 14:29:59','2017-03-16 14:29:59'),(30,NULL,1,NULL,6,'Test Invoice 30','test-invoice-30','Vel velit illum nisi placeat atque voluptas beatae. Dolor rem eligendi veniam sint excepturi.\nIure occaecati est beatae voluptate quia cupiditate amet. Nobis et totam non voluptas. Veritatis velit et repellat tenetur eum.\nEt libero beatae omnis enim fugiat est ut vero. Aut cumque repudiandae aut totam. Beatae omnis incidunt magnam expedita aut voluptas earum.\nDolor ipsam qui doloribus. Magnam iusto quasi cum sed. Rerum error hic accusantium debitis excepturi odit fugit fuga. Aliquam voluptate amet adipisci modi veritatis.','2015-07-17','2017-02-01',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(31,16,7,NULL,3,'Test Invoice 31','test-invoice-31','Quisquam dolores doloremque unde eaque dolorum. Commodi magnam dolorem et doloribus ipsum. Hic ut cum nostrum corrupti qui dignissimos. Fugiat pariatur et nihil earum.\nFacere qui est possimus omnis omnis. Nesciunt qui delectus sed beatae unde architecto non. Numquam molestiae perspiciatis cumque illum. Sed dolor et labore quasi perferendis similique numquam. Aut rerum sint fugiat est nemo.\nExpedita consequuntur dolores ad. Et et incidunt nesciunt voluptas ratione tempore nobis. Quo est vel qui iure.\nEa aut rem ipsum itaque voluptas. Praesentium ratione deleniti et aut. Maxime sed aliquam velit rerum in. Et fugiat dolorem molestiae sit.','2015-10-29','2016-10-30','CHF 2324500','2017-03-16 14:29:59','2017-03-16 14:29:59'),(32,6,17,NULL,6,'Test Invoice 32','test-invoice-32','Reprehenderit ea aut tempora dolorum eveniet sunt. Ex sit quia saepe ullam corrupti molestiae natus assumenda.\nConsequatur ullam nam est in ipsa. Eius quo ut labore molestias harum. Est non modi sit libero velit molestiae rerum.\nA quas aut praesentium commodi iste voluptatem nobis. Itaque quo dolorum temporibus exercitationem totam praesentium fugiat.\nRepellendus quam sequi fugit blanditiis doloribus eum. Porro ea recusandae autem laborum voluptatem. Reprehenderit est voluptate et nesciunt est.\nEt quidem perspiciatis placeat necessitatibus id. Facilis dicta incidunt et odio sapiente. Sed natus delectus nesciunt blanditiis nemo.','2015-10-26','2016-12-24','CHF 3110800','2017-03-16 14:29:59','2017-03-16 14:29:59'),(33,8,13,NULL,3,'Test Invoice 33','test-invoice-33','Aut nihil aut voluptatibus sed ut. Nulla sed quas amet beatae modi.\nQui accusantium provident expedita ut. Laboriosam provident aut sed sit rerum.\nQuasi eos illo tempore ut odio natus temporibus. Et aspernatur quaerat unde iure sapiente harum nam reiciendis. Nesciunt sit et cumque molestiae voluptatem ut.\nAdipisci qui at quis numquam et mollitia. Quisquam reprehenderit ex quasi doloribus. Nemo sit est suscipit.\nSaepe hic voluptates vitae autem vero officia. Repudiandae at sed soluta est ex magnam. Quia adipisci corporis qui doloribus esse facilis.\nReprehenderit molestiae vero quos excepturi occaecati in. Vel sit est consectetur cumque qui a. Quia labore magni est.','2015-08-01','2016-10-05',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(34,17,19,NULL,5,'Test Invoice 34','test-invoice-34','Cupiditate animi recusandae quod. Maiores autem nobis ad excepturi velit ratione. Pariatur error sed ratione quasi optio sunt. Totam a rem quia unde tempore voluptate quia.\nNobis explicabo autem voluptatibus harum. Est iusto perspiciatis consequatur quis minus.\nBeatae vero ut hic vero. Ea aliquam culpa voluptas repudiandae iste atque dolorem nesciunt. Necessitatibus id molestiae sed maiores omnis laborum.\nNihil ipsum hic eum autem temporibus. Porro atque repellat sapiente autem unde voluptatem. Id porro nisi vero voluptatem nihil ipsa voluptatum.','2016-08-12','2016-11-16',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(35,4,16,NULL,6,'Test Invoice 35','test-invoice-35','Voluptatem dolor aut voluptatem consequatur. Doloremque id magnam labore voluptas rem officiis magnam. Velit est magnam nulla cupiditate.\nRem consequatur quidem et debitis nisi voluptas maiores iste. Nobis quisquam cumque et. Quaerat quia ipsa enim voluptatem quas. Et ut ut tenetur optio et.\nQui rerum maxime qui quibusdam repellendus. Occaecati rerum consequuntur dolores et rerum aut. Ullam distinctio ea dolores ad tenetur.\nDolorum reiciendis quia sit eos minus. Harum totam cum sit consequatur. Cumque est sequi architecto aut. Ex provident pariatur molestiae facilis fugit quos. Quia magnam voluptates et earum esse sequi.','2016-08-12','2016-10-22',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(36,9,4,NULL,2,'Test Invoice 36','test-invoice-36','In dicta dolores veritatis rerum quo et voluptas. Ut perferendis et et quo.\nDoloremque qui et a rerum maxime. Autem aut iusto suscipit commodi explicabo. Sed veniam sunt nulla quis tempore repellendus.\nNihil voluptatem voluptatum dignissimos rerum perspiciatis dolorem libero. Aspernatur aut iure perspiciatis quas ut voluptatem veritatis debitis. Vel enim enim officiis quia. Rerum eos magni sit ipsa vitae.\nRatione nisi ipsam hic explicabo corrupti. Labore recusandae in eveniet dolore qui qui excepturi. Sequi illo dignissimos ipsum modi nulla nemo ea. Aut corrupti dolores voluptatem voluptatem.','2015-11-18','2017-01-22','CHF 9010100','2017-03-16 14:29:59','2017-03-16 14:29:59'),(37,NULL,11,NULL,2,'Test Invoice 37','test-invoice-37','Explicabo ea eos cupiditate. Sint ipsa sint qui ut amet sit. Error dolorem veritatis et qui consequatur dolorem nam rerum. Porro natus cupiditate aut rerum.\nConsequatur ea asperiores dolorem dolor harum deserunt. Quia enim iure eum. Accusantium impedit aliquam perferendis non consequuntur culpa suscipit. Et eius et modi quis et.\nLibero ut occaecati a iure maiores saepe accusamus et. Quo sit corporis ipsa ut voluptatum mollitia quis reiciendis. Explicabo sunt suscipit ex aliquam. Molestiae laborum expedita consectetur possimus.','2016-07-13','2016-10-14',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(38,8,8,NULL,3,'Test Invoice 38','test-invoice-38','Eum quibusdam voluptas voluptas similique quo inventore. Corporis eos voluptas dicta. Aliquid consequatur et maiores sint architecto. Dolor consequatur sint repudiandae asperiores.\nRerum rerum libero delectus magni provident. Omnis illum porro nesciunt voluptas vel sint est. Ducimus iusto tempora ut labore nihil qui ea et. Et eum aut illo quas sit totam non consequatur.\nDoloremque tenetur sed velit laboriosam. Nihil iure qui voluptatum odio soluta blanditiis. Illum maiores incidunt aut asperiores. Fugiat necessitatibus nesciunt tempore consequatur et magnam.','2015-08-01','2017-01-06',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(39,8,5,NULL,4,'Test Invoice 39','test-invoice-39','Quia consequatur omnis illo fugiat. Vitae error nulla consequuntur vel. Sint inventore praesentium et qui tenetur in. Nam voluptatem nemo aliquid natus error quasi.\nAut quis non quaerat sit. Suscipit architecto dignissimos asperiores rerum dolores ratione. Aut id aut rerum quis cumque. Sapiente et rerum velit omnis officia aut velit.\nNeque commodi aliquam aperiam et et. Officiis sapiente sed sed error ex aut error. Quo ut atque numquam amet aliquam quis.\nPorro accusamus odit rerum hic neque velit. Est deleniti ad et officiis.','2016-08-15','2017-02-20',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(40,9,13,NULL,1,'Test Invoice 40','test-invoice-40','Aut repudiandae modi debitis repudiandae mollitia. Quidem accusamus omnis tempora aliquid. Iusto amet consequuntur autem non quibusdam voluptatem soluta rerum. Quia et consequatur quia odit et veniam est.\nSit voluptatum eum neque non. Repellendus blanditiis eos aperiam neque. Vel qui debitis et enim. Ratione iste omnis ut similique est alias id.\nOmnis similique minima aut repellat pariatur quia at. Temporibus expedita reiciendis aspernatur qui aut quia. Et non non molestiae est repellendus consequatur nostrum.\nFacilis occaecati consequatur voluptatem aperiam dicta autem. Pariatur expedita voluptates laborum aut ratione cum. Ipsum alias praesentium ut culpa nesciunt omnis eligendi expedita.','2015-07-07','2016-11-12',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(41,2,3,NULL,4,'Test Invoice 41','test-invoice-41','Explicabo maiores et molestiae aliquam. Sed in voluptas nostrum sit. Illum atque qui aperiam dolores. Porro sit qui odit ut vel ratione reiciendis.\nDolorum qui debitis facilis eum. Quia possimus molestiae qui ad ullam fuga est. Nostrum quis aut tempora unde.\nEnim porro nobis iusto et beatae et. Consectetur delectus accusantium totam molestiae. Quaerat vel magni vel consectetur earum voluptas voluptatum. Maxime ab et fuga voluptatibus.\nIste iure culpa enim laudantium dolor ab aut. Ipsa ducimus debitis hic similique eum. Dolor corrupti et impedit odit dolorum dicta est. Id qui provident vel velit tempora rerum qui.','2015-05-31','2016-11-29',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(42,20,12,NULL,6,'Test Invoice 42','test-invoice-42','Possimus animi quas dolor neque magni necessitatibus aut. Officiis qui impedit aliquam repudiandae. Quis nemo doloremque quis quia.\nEt sed ipsa autem ut consequatur laborum asperiores pariatur. Consectetur consequatur et maiores ex debitis sit enim. A consequuntur vel dolore illum ab adipisci. Aut eum nihil totam temporibus.\nExercitationem tempore sunt est repudiandae illum. Ut reiciendis quidem distinctio quia esse officia sint officia. Officiis sit deleniti voluptatem recusandae officiis excepturi. Et laudantium tempore ea nihil vitae rerum doloribus.\nNobis architecto aut error. Incidunt mollitia sed enim molestias et doloremque. Eos aut numquam eum quia.','2015-12-20','2016-11-04',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(43,20,20,NULL,4,'Test Invoice 43','test-invoice-43','Natus eligendi laborum aut quo vel deserunt et. Quis autem ut incidunt aut harum. Enim et aperiam et. Officiis distinctio reprehenderit quae et. Dolore error veritatis sunt doloribus dolor debitis.\nDeleniti fuga nostrum sit voluptatem vitae non. Corporis voluptatem exercitationem ut non molestias et dolores. Tenetur placeat ut reiciendis recusandae rerum.\nAtque voluptas voluptatibus unde sed. Facere quisquam inventore ut reprehenderit. Temporibus enim reiciendis et illum ullam. Qui aut ut praesentium dicta dicta voluptates nostrum qui.','2015-11-03','2016-09-23',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(44,NULL,8,NULL,1,'Test Invoice 44','test-invoice-44','Similique est dolorem nihil perferendis sequi et. Odio est sequi iusto placeat rerum placeat. Numquam id voluptas voluptas quod enim. Vero quo dolore in eius omnis illo.\nQui quia error blanditiis. Iste omnis aut placeat facere rem dolor. Vel nesciunt dolor suscipit quibusdam itaque minima.\nQui eos repellendus molestias quibusdam. Et minima voluptatum placeat eos. Voluptatum sint tempora enim. Ut optio quidem laborum ut est. Repellat ut sit et reprehenderit.\nRerum tenetur consequuntur nihil et culpa. Facilis consequatur ex unde provident iure molestiae enim distinctio. Numquam aliquid dolores repellendus maiores. Beatae qui vero inventore.','2015-04-25','2016-10-15',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(45,17,4,NULL,2,'Test Invoice 45','test-invoice-45','Voluptatem praesentium vero quasi aut quod sit quam. Doloremque est adipisci et ut laboriosam. Qui ex et quam.\nNeque sed nobis consequatur. Pariatur magni beatae ad in et placeat est. Sint pariatur dolorum qui quidem sunt dicta. Consequatur tenetur quaerat illo cupiditate.\nQuia sunt velit ex eos minima consequuntur repudiandae voluptas. Animi corporis officiis culpa non et voluptas. Omnis mollitia sed enim enim.\nExpedita eaque explicabo quisquam accusantium quos nisi. Repudiandae sequi nisi similique est. Saepe id corporis et quasi quasi quaerat atque. Voluptas quo est voluptatem maiores hic.','2015-10-16','2017-01-22',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(46,5,3,NULL,1,'Test Invoice 46','test-invoice-46','Optio quae distinctio nesciunt quisquam. Laborum laudantium cum corrupti sed est velit. Doloribus in delectus quia ut id. Inventore numquam quidem sequi laborum. Nam aut voluptatem dolores dolore.\nFacere est qui illo cumque. Et ducimus ullam asperiores nostrum necessitatibus voluptatem. Fugiat blanditiis est reprehenderit eveniet. Odio maxime laborum nihil officiis voluptatem itaque.\nSit et quaerat fugiat earum. Dolorem voluptatem deleniti odio enim aut eius aut. Neque temporibus sint aut asperiores eligendi.\nEt nihil illo aperiam repellendus quos dolor. Magni rerum eligendi reiciendis tempore perspiciatis nisi architecto. Praesentium et voluptatem necessitatibus dolorem velit.','2015-12-06','2016-12-05','CHF 7893700','2017-03-16 14:29:59','2017-03-16 14:29:59'),(47,15,15,NULL,4,'Test Invoice 47','test-invoice-47','Delectus sit dolores quis dicta et labore. Et optio harum ipsa quae maiores officia. Quis sint omnis vero officia et. Dicta sint rem cum praesentium ea non qui.\nIste tempora inventore quia eligendi enim odio sunt expedita. Tempora distinctio quasi blanditiis eos doloribus sed et nemo. Dolores enim asperiores sunt tempora voluptas voluptas. At ab aut rerum adipisci.\nAnimi quia cupiditate vel possimus qui dolor ut ut. Qui qui hic sunt ut dolores sed. Sed non exercitationem blanditiis ducimus temporibus nihil sunt.','2016-01-24','2017-02-16',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(48,6,2,NULL,1,'Test Invoice 48','test-invoice-48','Aut vitae sint est rerum. Velit maiores et facilis voluptatem quaerat. Magnam accusamus velit incidunt quasi quisquam sapiente ipsa et.\nIn vero debitis quasi aut aut reiciendis. Velit a rem mollitia ab minus. Voluptatibus eum consequatur molestiae ad consequatur omnis. Qui enim accusantium consequatur dolorem illo optio quo iste.\nEst assumenda omnis assumenda illo sit distinctio dolores ad. Aspernatur voluptatem aut hic accusamus commodi aut quo tempore. Omnis nostrum corporis qui explicabo aut fugit consequatur voluptas.','2015-11-16','2017-02-27',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(49,5,23,NULL,2,'Test Invoice 49','test-invoice-49','Facere et non accusamus qui nostrum. Molestiae animi maxime ipsa natus culpa adipisci quae optio. Consequatur sapiente ab aut dolor dolor omnis. Voluptatum tempore ea libero quis qui.\nDolorum unde alias amet quia aut. Natus sunt quisquam fugiat sed exercitationem velit. Reprehenderit dolorem illo voluptatem ipsam eum dolorum.\nSed quo dolor natus. Dolor sed id consequatur autem hic. Ut quia consequuntur non nesciunt qui quia. Sit repellendus in qui.\nOccaecati aut enim ratione quo. Reprehenderit quod rerum omnis soluta eum. Minima deserunt fuga labore. Labore aut totam aspernatur dolorem.','2015-08-31','2016-09-10',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(50,NULL,1,NULL,5,'Test Invoice 50','test-invoice-50','Illum officiis enim incidunt nobis aut. Amet enim omnis atque sunt recusandae nostrum. Quia omnis quae commodi natus. Qui laboriosam earum doloremque.\nRecusandae atque quae temporibus ex eos. Voluptatem molestiae tenetur qui atque esse qui est. Facilis assumenda velit dolores deserunt ut magni. Quia possimus rem nulla sit doloribus.\nEnim rerum dolorum velit tempore quos molestiae aut autem. Quae suscipit quo vero ab ut aperiam nesciunt. Iure sapiente qui doloremque tenetur perferendis non.\nA iusto minus doloribus eum molestias. Tempora ut modi nobis velit et.','2016-06-28','2016-09-06',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59');
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
  CONSTRAINT `FK_5F927F7CA76ED395` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_5F927F7C53C674EE` FOREIGN KEY (`offer_id`) REFERENCES `offers` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `offer_discounts`
--

LOCK TABLES `offer_discounts` WRITE;
/*!40000 ALTER TABLE `offer_discounts` DISABLE KEYS */;
INSERT INTO `offer_discounts` VALUES (1,47,2,'10% Off',0.10,1,1,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(2,50,1,'10% Off',0.10,1,1,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(3,49,3,'10% Off',0.10,1,1,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(4,48,3,'10% Off',0.10,1,1,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(5,50,1,'10% Off',0.10,1,1,'2017-03-16 14:29:59','2017-03-16 14:29:59');
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
  CONSTRAINT `FK_755A98B8A76ED395` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_755A98B82BE78CCE` FOREIGN KEY (`rateUnitType_id`) REFERENCES `rateunittypes` (`id`),
  CONSTRAINT `FK_755A98B853C674EE` FOREIGN KEY (`offer_id`) REFERENCES `offers` (`id`),
  CONSTRAINT `FK_755A98B8ED5CA9E6` FOREIGN KEY (`service_id`) REFERENCES `services` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `offer_positions`
--

LOCK TABLES `offer_positions` WRITE;
/*!40000 ALTER TABLE `offer_positions` DISABLE KEYS */;
INSERT INTO `offer_positions` VALUES (1,1,19,2,1,20.00,'CHF 18000','CHF/h',0.080,1,1,'2017-03-16 14:29:59','2017-03-16 14:29:59','h'),(2,4,69,5,324,42.00,'CHF 2700','Pauschal',0.025,1,1,'2017-03-16 14:29:59','2017-03-16 14:29:59','a'),(3,9,25,6,648,29.00,'CHF 16900','CHF/d',0.025,1,1,'2017-03-16 14:29:59','2017-03-16 14:29:59','t'),(4,3,81,4,216,38.00,'CHF 14500','Pauschal',0.080,1,1,'2017-03-16 14:29:59','2017-03-16 14:29:59','a'),(5,1,61,4,850,47.00,'CHF 5500','Einheit',0.025,1,1,'2017-03-16 14:29:59','2017-03-16 14:29:59','a'),(6,3,5,4,395,24.00,'CHF 18000','CHF/h',0.080,1,1,'2017-03-16 14:29:59','2017-03-16 14:29:59','h'),(7,5,80,2,982,6.00,'CHF 18300','Pauschal',0.025,1,1,'2017-03-16 14:29:59','2017-03-16 14:29:59','a'),(8,10,53,6,133,87.00,'CHF 18500','Einheit',0.025,0,1,'2017-03-16 14:29:59','2017-03-16 14:29:59','a'),(9,2,32,1,198,26.00,'CHF 3100','CHF/d',0.025,1,1,'2017-03-16 14:29:59','2017-03-16 14:29:59','t'),(10,7,76,3,171,98.00,'CHF 10700','Pauschal',0.080,1,1,'2017-03-16 14:29:59','2017-03-16 14:29:59','a'),(11,8,74,2,598,86.00,'CHF 18300','Pauschal',0.025,0,1,'2017-03-16 14:29:59','2017-03-16 14:29:59','a'),(12,3,62,6,218,65.00,'CHF 18300','Pauschal',0.080,1,1,'2017-03-16 14:29:59','2017-03-16 14:29:59','a'),(13,3,50,2,479,7.00,'CHF 18300','Pauschal',0.080,1,1,'2017-03-16 14:29:59','2017-03-16 14:29:59','a'),(14,5,29,6,26,76.00,'CHF 10800','CHF/d',0.080,0,1,'2017-03-16 14:29:59','2017-03-16 14:29:59','t'),(15,8,27,6,257,78.00,'CHF 10800','CHF/d',0.080,1,0,'2017-03-16 14:29:59','2017-03-16 14:29:59','t'),(16,10,63,2,95,25.00,'CHF 14500','Pauschal',0.025,1,0,'2017-03-16 14:29:59','2017-03-16 14:29:59','a'),(17,1,41,6,228,73.00,'CHF 7600','CHF/d',0.080,0,1,'2017-03-16 14:29:59','2017-03-16 14:29:59','t'),(18,9,76,5,811,50.00,'CHF 10700','Pauschal',0.080,1,1,'2017-03-16 14:29:59','2017-03-16 14:29:59','a'),(19,10,18,6,29,44.00,'CHF 8100','CHF/h',0.080,1,1,'2017-03-16 14:29:59','2017-03-16 14:29:59','h'),(20,5,1,2,295,81.00,'CHF 10000','CHF/h',0.080,1,1,'2017-03-16 14:29:59','2017-03-16 14:29:59','h'),(21,10,51,2,679,78.00,'CHF 18500','Einheit',0.025,1,1,'2017-03-16 14:29:59','2017-03-16 14:29:59','a'),(22,4,3,3,352,11.00,'CHF 18000','CHF/h',0.080,1,1,'2017-03-16 14:29:59','2017-03-16 14:29:59','h'),(23,3,73,3,601,57.00,'CHF 18300','Pauschal',0.025,0,1,'2017-03-16 14:29:59','2017-03-16 14:29:59','a'),(24,10,8,4,999,58.00,'CHF 2800','CHF/h',0.080,1,1,'2017-03-16 14:29:59','2017-03-16 14:29:59','h'),(25,4,74,4,831,71.00,'CHF 18300','Pauschal',0.025,1,1,'2017-03-16 14:29:59','2017-03-16 14:29:59','a'),(26,5,39,6,864,69.00,'CHF 7600','CHF/d',0.025,1,1,'2017-03-16 14:29:59','2017-03-16 14:29:59','t'),(27,7,39,3,868,19.00,'CHF 7600','CHF/d',0.025,0,1,'2017-03-16 14:29:59','2017-03-16 14:29:59','t'),(28,4,73,1,800,42.00,'CHF 18300','Pauschal',0.025,1,1,'2017-03-16 14:29:59','2017-03-16 14:29:59','a'),(29,10,66,5,365,6.00,'CHF 14500','Pauschal',0.080,1,1,'2017-03-16 14:29:59','2017-03-16 14:29:59','a'),(30,5,66,5,775,36.00,'CHF 14500','Pauschal',0.080,1,1,'2017-03-16 14:29:59','2017-03-16 14:29:59','a'),(31,1,27,4,371,85.00,'CHF 10800','CHF/d',0.080,1,1,'2017-03-16 14:29:59','2017-03-16 14:29:59','t'),(32,1,33,4,411,34.00,'CHF 1500','CHF/d',0.025,1,1,'2017-03-16 14:29:59','2017-03-16 14:29:59','t'),(33,9,21,2,336,83.00,'CHF 2800','CHF/h',0.025,1,0,'2017-03-16 14:29:59','2017-03-16 14:29:59','h'),(34,7,78,3,40,80.00,'CHF 14500','Pauschal',0.025,0,1,'2017-03-16 14:29:59','2017-03-16 14:29:59','a'),(35,7,13,5,847,69.00,'CHF 8100','CHF/h',0.025,0,1,'2017-03-16 14:29:59','2017-03-16 14:29:59','h'),(36,9,14,4,612,79.00,'CHF 2800','CHF/h',0.080,0,1,'2017-03-16 14:29:59','2017-03-16 14:29:59','h'),(37,9,42,4,73,7.00,'CHF 18500','Einheit',0.025,0,1,'2017-03-16 14:29:59','2017-03-16 14:29:59','a'),(38,9,50,4,866,50.00,'CHF 18300','Pauschal',0.080,1,1,'2017-03-16 14:29:59','2017-03-16 14:29:59','a'),(39,3,10,2,668,30.00,'CHF 10300','CHF/h',0.080,1,1,'2017-03-16 14:29:59','2017-03-16 14:29:59','h'),(40,2,75,5,640,63.00,'CHF 6700','Pauschal',0.080,1,1,'2017-03-16 14:29:59','2017-03-16 14:29:59','a'),(41,7,73,4,941,16.00,'CHF 18300','Pauschal',0.025,1,1,'2017-03-16 14:29:59','2017-03-16 14:29:59','a'),(42,10,48,2,146,27.00,'CHF 18300','Pauschal',0.080,1,1,'2017-03-16 14:29:59','2017-03-16 14:29:59','a'),(43,5,26,6,116,16.00,'CHF 16900','CHF/d',0.025,1,1,'2017-03-16 14:29:59','2017-03-16 14:29:59','t'),(44,6,27,2,576,99.00,'CHF 10800','CHF/d',0.080,0,1,'2017-03-16 14:29:59','2017-03-16 14:29:59','t'),(45,1,70,5,37,98.00,'CHF 18300','Pauschal',0.025,0,1,'2017-03-16 14:29:59','2017-03-16 14:29:59','a'),(46,4,73,6,362,17.00,'CHF 18300','Pauschal',0.025,1,1,'2017-03-16 14:29:59','2017-03-16 14:29:59','a'),(47,10,22,2,382,90.00,'CHF 3100','CHF/d',0.080,1,1,'2017-03-16 14:29:59','2017-03-16 14:29:59','t'),(48,5,16,3,489,57.00,'CHF 8100','CHF/h',0.080,1,1,'2017-03-16 14:29:59','2017-03-16 14:29:59','h'),(49,9,58,1,58,88.00,'CHF 18300','Pauschal',0.080,1,0,'2017-03-16 14:29:59','2017-03-16 14:29:59','a'),(50,1,15,2,112,9.00,'CHF 8100','CHF/h',0.025,1,1,'2017-03-16 14:29:59','2017-03-16 14:29:59','h');
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
  CONSTRAINT `FK_84D719D97EAA7D27` FOREIGN KEY (`standard_discount_id`) REFERENCES `standard_discounts` (`id`),
  CONSTRAINT `FK_84D719D953C674EE` FOREIGN KEY (`offer_id`) REFERENCES `offers` (`id`)
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
INSERT INTO `offer_status_uc` VALUES (1,NULL,'Potential',1,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(2,NULL,'Offered',1,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(3,NULL,'Ordered',1,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(4,NULL,'Lost',1,'2017-03-16 14:29:59','2017-03-16 14:29:59');
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
  CONSTRAINT `FK_9144BA31BAD26311` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_9144BA3153C674EE` FOREIGN KEY (`offer_id`) REFERENCES `offers` (`id`) ON DELETE CASCADE
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
  CONSTRAINT `FK_DA460427A76ED395` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_DA460427166D1F9C` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_DA4604272983C9E6` FOREIGN KEY (`rate_group_id`) REFERENCES `rate_groups` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_DA4604276BF700BD` FOREIGN KEY (`status_id`) REFERENCES `offer_status_uc` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_DA4604279395C3F3` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_DA4604279582AA74` FOREIGN KEY (`accountant_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_DA460427F5B7AF75` FOREIGN KEY (`address_id`) REFERENCES `address` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `offers`
--

LOCK TABLES `offers` WRITE;
/*!40000 ALTER TABLE `offers` DISABLE KEYS */;
INSERT INTO `offers` VALUES (1,NULL,1,1,25,1,2,5,'Default Offer','2017-01-14','This is a default offer','This is a longer description with more details',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(2,9,4,2,17,5,17,6,'Possimus cum.','2016-09-29','Est officia voluptatibus corrupti commodi deserunt minima reprehenderit laborum. Molestiae aut numquam a harum. Est quod expedita laudantium qui ipsa.','Et harum ut explicabo odit similique nihil numquam. Sit suscipit libero nisi sunt sit quas quo totam. Doloremque numquam itaque magnam. Quidem dolorum neque repudiandae totam non. Voluptatibus nihil occaecati ut et soluta.\nDignissimos omnis eveniet et nihil. Dolores consectetur quo illo molestiae quis et. Perspiciatis aspernatur nemo officia debitis. Earum praesentium dolorem consequatur rerum.\nEa sunt cumque qui. Eos blanditiis ipsam ut excepturi. Ullam iste repellat qui ipsum sit illum. Distinctio et doloremque quia commodi modi quia.\nAutem quae perferendis enim id. Consequuntur provident beatae culpa consequatur aut ducimus dignissimos. Consequatur accusantium excepturi magni qui at et.',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(3,NULL,1,2,21,3,9,6,'Magni perferendis.','2017-02-24','Necessitatibus aut totam sit consectetur omnis. Nobis qui recusandae tempore molestias expedita fugit delectus. Delectus laudantium sed iure quia illo neque omnis. Numquam nostrum officiis dolor.','Aliquam et at quod consequatur. Commodi qui voluptate quia rerum ut enim rem. Voluptas harum totam saepe.\nConsequatur et at magni nihil aut. Totam cupiditate odio asperiores perspiciatis. Et natus optio qui ipsam similique quaerat commodi. Et placeat autem ratione.\nEt ut beatae rerum assumenda et. Sed ipsa nam minus qui recusandae nam. Non vitae eaque eos temporibus optio.\nEt eaque esse officia fugit et voluptatibus. Quaerat aut id commodi nihil. Ratione ea aperiam quae nam id repellat. Nihil ipsum quis sed autem et velit dolores. Optio quos quia molestiae dignissimos enim maxime tempore.',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(4,10,4,1,13,1,1,5,'In vel neque.','2017-03-04','Quo aut aut et molestias culpa et. Est ut qui fugit sed saepe maxime. Ut cupiditate nemo rem. Voluptas dignissimos molestiae neque culpa.','Assumenda soluta aut magni accusantium voluptatem adipisci. Labore libero repudiandae non. Autem unde est eaque et.\nIncidunt exercitationem et reiciendis vel facilis sed facere. Est laboriosam beatae et. Quis illum molestiae rerum omnis exercitationem velit repellat. Cum vitae sunt vel ut molestiae.\nNobis non veniam possimus itaque et vel qui. Corrupti et deserunt sunt. Architecto id officiis odio perferendis.\nQui dolore natus quidem enim. Laboriosam vitae nihil aperiam saepe nihil. Labore rem voluptas quasi aut a ea libero veritatis. Ad incidunt voluptatem facere.',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(5,1,1,2,12,4,15,2,'Sed sed.','2017-01-06','Qui soluta repellendus natus omnis assumenda eaque vel. Nisi fuga ipsum praesentium cumque officia id quidem commodi. Aut fuga praesentium et. Magnam soluta laudantium neque id sunt omnis.','Aliquid quasi sit ipsa sequi id ea quae sed. Occaecati error alias labore sit. Qui omnis doloribus pariatur sint est dignissimos. Autem nesciunt et numquam aspernatur alias odio. Est voluptatum asperiores optio adipisci corporis qui.\nCorporis placeat adipisci quibusdam reprehenderit. Voluptas sed ut et aut minima quos est. Facere numquam eius numquam nemo. Dolores est dolores neque facere fugit sint consequatur et.\nQuos id quo laudantium dolorem voluptatibus iure. Provident neque est inventore minima laboriosam quia possimus.',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(6,20,4,2,6,1,24,5,'Debitis ut.','2016-12-17','Nihil beatae est et dolores et. Sunt accusamus et occaecati similique. Iusto dignissimos sit aut repellendus. Voluptas sapiente autem non ut fuga voluptatibus atque.','Molestiae iste dolorum velit ipsam. Quia reprehenderit earum nulla consequatur occaecati. Dolores et est quia ex sit. Explicabo libero placeat ex aperiam. Dolorum facilis enim omnis consectetur nihil ipsum velit.\nTenetur totam ad ut. Corporis veniam minima a numquam. Repellat ea atque veniam pariatur quos nulla ipsa dolorem.\nEum necessitatibus et aut explicabo voluptatem quam. Voluptas inventore et perspiciatis optio neque dolor. Rem aut blanditiis rerum placeat enim. Facere dolor optio voluptates qui nam et repellendus.\nQui aut voluptas sunt voluptatum qui neque. Qui cum maiores voluptate aperiam. Aut at natus voluptas est aut placeat. Optio itaque qui vel qui quasi autem.',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(7,NULL,3,2,24,3,4,2,'Rem enim eos.','2016-12-19','Est id dolor aliquid officia perspiciatis autem. Et et nihil officia sit sed et pariatur et. Beatae ut hic est quo et. Minus aut harum reprehenderit qui.','Ab iste non quia fuga ducimus tempore. Enim placeat et aut laborum. Id mollitia sit accusamus architecto eius.\nMolestiae incidunt a aut tempore. Quam libero ducimus accusamus id molestias labore provident error. Modi et vel assumenda quos. Ipsam est magni similique qui repellendus asperiores dolores.\nPorro tempora iste id. Voluptatem rerum optio sint voluptatem libero dolore. At modi assumenda et tempore ex. Vel quasi facilis eveniet repellat facere cupiditate sed rem.\nUllam temporibus quia et in dolorem quidem. Enim aspernatur sed est voluptatem officia. Velit laboriosam ut eum nulla ea ut error. Eos blanditiis animi provident omnis et quidem.',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(8,6,3,2,16,5,16,2,'Eaque hic velit.','2016-09-11','Non architecto blanditiis temporibus quibusdam libero eveniet architecto. Iusto vero praesentium quam vitae aut. Est nam quae debitis ut quia eum. In dignissimos quia nam aut explicabo.','Sit sit incidunt aliquid libero. Temporibus ut ad sint pariatur eos. Sint sunt et aspernatur sapiente necessitatibus blanditiis tempora laborum.\nEaque aliquam ea adipisci animi aut possimus. Provident qui magnam atque eaque laudantium reiciendis. Doloremque ratione quisquam ducimus velit eligendi delectus possimus.\nMolestias sit exercitationem consequuntur. Quia molestiae ad est facere aut. Voluptatem esse et soluta ab voluptatem odio. Vel a vel totam minus rerum. Consequatur autem quia adipisci rem dolores et.\nIn fugit doloribus numquam amet dolor temporibus. Ducimus ipsam quo cum corrupti rerum consequatur ea. Et voluptatibus aut voluptatem et. Neque quos ut qui saepe in.','CHF 8490600','2017-03-16 14:29:59','2017-03-16 14:29:59'),(9,3,1,2,23,2,6,3,'Esse dolorum.','2017-02-17','Iure et commodi quidem dicta. Similique voluptatem ratione et rerum temporibus voluptas. Vel non ea voluptatem doloribus quisquam et. Et recusandae exercitationem velit est ipsa sit tempore.','Ratione illum omnis quia. Laborum sed officia temporibus id molestias non perferendis. Ad facilis error consequatur dolore deserunt dignissimos aliquam modi. Omnis eos molestias autem non sunt nam aut.\nReiciendis nihil eos voluptate dolorem qui cupiditate. Voluptatem consequuntur corporis ea quia.\nRerum iusto quia sapiente. Molestiae optio doloribus magni est quidem dolores et magni. Temporibus qui repellat officia ratione voluptatem similique. Ipsam itaque rerum aut quibusdam consectetur. Eius sint deserunt adipisci.',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(10,17,2,2,20,3,10,3,'Rerum in eaque.','2016-09-28','Nulla et possimus deserunt omnis maxime et. Architecto aut quia eius deserunt eius voluptas est. Vero ab omnis sunt recusandae dolorem non.','Sunt pariatur nulla et dolor at soluta. Autem sed et sunt praesentium.\nSint voluptatibus ipsa ipsum omnis consequatur. Cupiditate quisquam corporis laboriosam repudiandae itaque. Alias sint et dolorem doloribus occaecati commodi quisquam.\nProvident ex recusandae aliquid beatae nihil. Eum praesentium tenetur expedita nam sint pariatur in. Voluptas sit ea delectus.\nAspernatur dolor ut veniam est repudiandae. Modi quo maxime voluptates suscipit illum velit laborum. Voluptatem fugit qui molestiae reprehenderit sint.\nQui corrupti odit doloribus quia occaecati doloribus. Expedita incidunt velit porro beatae sit et autem. Sunt sit voluptatem et deleniti totam quae et.','CHF 1660600','2017-03-16 14:29:59','2017-03-16 14:29:59'),(11,7,1,1,13,5,13,5,'Occaecati enim aperiam.','2017-01-27','Quia a et dolores molestias. Nulla aperiam officia eaque error cumque ullam. Ab qui minus ut sint.','Et id amet distinctio molestiae non. Sequi excepturi et deleniti asperiores quia. Accusamus praesentium ratione nihil. Sunt modi exercitationem voluptas est.\nAccusamus quae sit dolore impedit et voluptas. Et necessitatibus iure assumenda nemo vel. Sequi aut aliquam non iste.\nImpedit aut aliquam nisi quia. Pariatur inventore impedit tempora non eos mollitia fugit. Provident non et necessitatibus sit repudiandae dolorum magnam.\nEaque et asperiores animi voluptatem in ut. Culpa et quae vero quas. Quae vitae harum quod rerum. Dolor perferendis numquam sit iste hic eos laborum. Sit accusantium et quas nihil quam id autem.',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(12,NULL,2,1,9,4,21,6,'Odit esse.','2016-09-19','Quas illum quia qui occaecati consequuntur. Quo quam architecto et. Officia nam exercitationem aut quaerat. Labore quam ea quaerat ratione aspernatur.','Et dolores eos voluptas consequatur commodi odit qui. A aut et veritatis esse dolorem cumque. Vel minus accusamus laudantium possimus laboriosam optio et. Accusantium dolorem dolores beatae est eos modi. Et sit numquam voluptatibus cupiditate aut ipsa occaecati.\nVoluptatum expedita nesciunt facilis repellendus iste est. Ab accusamus nam dolorem est.\nEst omnis accusamus optio enim in. Asperiores ad officia quo quis voluptatem cum dicta. Totam nam dicta vel quasi molestiae consequatur.\nAutem sint cumque quia velit quo impedit est. Praesentium sit quis dolorem. Voluptatum ut rerum excepturi a repellendus ex et praesentium.',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(13,NULL,1,1,7,6,2,1,'Ut quos et.','2016-12-02','Aperiam rem tenetur consequuntur sit tempora. Officiis ipsa quod nihil aperiam provident quae quia. Reprehenderit eum consequatur cum quod dolor dolores.','Eligendi rerum ad eligendi omnis alias qui nisi sint. Dolorem neque officiis impedit eveniet. Optio sapiente earum quia eius quo similique. Illo unde soluta molestiae tempore et laboriosam. Qui et et tenetur qui nihil.\nVoluptatum accusamus rem aut quia. Commodi amet vel aliquam et sunt ut qui quae. Perferendis animi quis dolores tenetur totam sunt ut.\nVel molestiae nostrum quod qui harum et vero. Illo nulla eius eum dolorum quaerat omnis. Enim sit repellat aut. Quae voluptatem est beatae ipsum hic sint.\nDolor id tempora quas modi fugit eius illo. Aliquid repellendus fuga aspernatur cupiditate itaque deserunt est. Repellat rerum quo laboriosam qui quae voluptas earum.',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(14,13,1,1,8,3,19,1,'Error nobis.','2017-01-02','Sunt voluptatum sed excepturi accusamus. Doloremque omnis quas odit deserunt. Odit eligendi repellat praesentium. Est et aut temporibus consequuntur.','Molestiae nulla non earum sed. Consequatur possimus tenetur consequuntur laborum. Natus est impedit omnis sint explicabo exercitationem porro.\nRecusandae quisquam ipsa veritatis nam sequi accusantium. Modi consectetur est accusantium assumenda. Nihil provident ratione quia dolores quisquam rerum et.\nLabore et officiis at minus veniam magnam. Mollitia a aut vel consequatur ducimus. Excepturi eos ut harum et aliquid quas odio. Fugiat odio aut consequuntur vero praesentium incidunt ipsam.\nMollitia voluptas architecto ipsa iure deserunt libero facilis. Voluptatibus consequatur rerum vitae consectetur vero enim inventore sed.',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(15,19,4,2,25,2,6,5,'Excepturi numquam tempora.','2016-10-03','Eum eum eum quis eaque. Dolorum reiciendis dolore quo molestiae libero fugit. Sed fuga ab quo temporibus. Ad non nisi fuga quia deleniti unde minima eaque.','Esse qui et qui laboriosam a laboriosam. Enim sunt quaerat eligendi. Similique aut quia vel repudiandae doloribus deserunt cumque.\nDignissimos maxime et placeat molestias. Sint quo nesciunt exercitationem vel et ea. Ad ipsa quis non omnis enim.\nCupiditate voluptatem facilis quo minus dolor. Soluta mollitia corrupti magnam odit adipisci. Consequatur perferendis voluptas corporis recusandae repudiandae.\nEarum animi aut quisquam. Nam excepturi odit eius voluptatum officia reprehenderit eligendi. Temporibus tempora et facilis dignissimos.\nOdit modi possimus eveniet ipsam culpa. Aliquid ipsam commodi blanditiis. Esse soluta dolore magni.',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(16,20,1,1,10,1,10,6,'Consectetur laboriosam.','2016-10-09','Temporibus labore quae earum nihil recusandae facere. Similique id magnam eveniet enim delectus animi quo. Dignissimos voluptatem accusantium illum perferendis suscipit. Aut suscipit dolore ut eos voluptatem reiciendis soluta.','Rerum maxime consequuntur iusto. Consectetur harum nemo laborum cupiditate. Sit soluta facilis ut numquam vel tempore et eius.\nSunt sequi sed ad quibusdam sequi. Ea pariatur incidunt aspernatur impedit nisi. Nisi officia perspiciatis reiciendis aperiam est nobis ipsa. Magnam nobis veritatis accusantium est pariatur.\nLaboriosam voluptatibus sit ad beatae eligendi debitis quam. Minus sit ea ipsa non neque atque saepe. Laboriosam autem dolores repellendus iste tenetur quia facere.\nRem aut quia voluptatem velit. Hic mollitia ipsa recusandae odio rerum. Voluptatem debitis excepturi qui a voluptas. Corrupti totam non aliquid fuga velit sed id et.',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(17,8,1,2,9,2,6,6,'Fugit fuga numquam.','2016-12-03','Labore est nisi illum impedit. Est veniam dicta qui. Est et a corrupti quia aut ut cumque. Error natus impedit commodi sed cupiditate porro.','Aspernatur suscipit optio quia culpa ab. Cupiditate provident autem omnis reiciendis. Et aut fugiat laborum maiores fuga dignissimos corporis ex.\nNemo fugit sit nobis iure quae dolores quos voluptas. Et quis sed nobis et ullam quae sit. Molestiae nihil molestiae eos sint rem. Qui quae minima qui.\nQuae quo excepturi at quasi. Et odio voluptatibus est qui.\nOdit est et fuga corporis suscipit dolores. Eos tempore est ullam voluptas et fugiat. Architecto aut assumenda dolorum alias sit deserunt earum porro. Ducimus molestias fuga et.\nSunt aut ad molestiae officia. Nihil aliquam minima et porro omnis temporibus odio quam. Omnis quia deleniti ullam eum iure. Nemo sunt odit quia.',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(18,18,2,2,25,4,14,5,'Et dolores.','2016-09-18','Repellendus aliquam voluptatem ut amet. Rerum beatae sit hic sit at ex temporibus. Eveniet voluptas aut eligendi et.\nQuae maxime hic qui harum est eius tenetur et. Ut nihil dolorem maiores laboriosam expedita est.','Dolorum incidunt minus maiores molestiae nulla maiores. Et dignissimos minus nulla ut excepturi a fugit. Est maiores tempora quos laboriosam. Quam suscipit ducimus iste a repellendus.\nEst repellendus molestias cupiditate blanditiis. Incidunt magnam architecto sit eum tempora dolorum fugit. Laboriosam accusantium deleniti et deserunt debitis sunt. Ea molestiae quia optio sed placeat.\nVoluptatum qui aliquam voluptatem molestiae. Earum ullam quo ab dolor alias tempora quia. Ut ut quod sed quis est. Ad et placeat eaque itaque eaque occaecati.\nIn est recusandae quaerat facilis ut aut. Optio expedita ipsa incidunt debitis iure quia. Voluptas voluptatem quia porro omnis.','CHF 8036300','2017-03-16 14:29:59','2017-03-16 14:29:59'),(19,NULL,1,2,13,5,17,1,'Eum omnis esse.','2016-11-24','Delectus quae qui deleniti doloribus modi quia. Molestiae accusamus et praesentium quia quo in aut. Ipsum magnam consectetur non modi. Id neque facere quo illum quae sapiente ut est.','Quis placeat saepe ex et. Maiores nihil saepe voluptatem. Eveniet repudiandae assumenda voluptate suscipit.\nEnim nostrum vero nemo et ut quisquam nemo. Vel optio voluptatem et eligendi vitae. Minima a debitis saepe sit earum. Consequatur ipsa et accusamus ea consequatur sint voluptatum.\nAliquam et et non quam sint quae. Eligendi quam cum accusamus eveniet quae. Eaque voluptatibus corrupti molestiae dolorem error facilis et.\nVoluptas dicta facere vero molestias cum. Repudiandae temporibus quia perspiciatis commodi eligendi alias. Repellendus sint veniam explicabo sequi maiores qui.',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(20,4,3,2,14,1,21,5,'Reprehenderit dolorum.','2016-09-16','Ullam fuga autem harum quos et sit. Maiores eveniet voluptas tempora et dolor. Dolore dolorum atque atque enim. Similique molestiae quibusdam consequatur.','Nostrum sunt quasi qui. Nihil nostrum cupiditate provident aperiam. Recusandae dolore et ab omnis vitae quod et.\nAssumenda expedita quia rem et rerum qui facere. Dolores quisquam nam unde expedita quos doloribus numquam. Qui saepe incidunt quaerat magnam excepturi. Est pariatur consequatur eveniet debitis consectetur.\nDelectus dolores eius quibusdam laudantium blanditiis enim explicabo consectetur. Reprehenderit facilis qui eum. Neque nulla enim praesentium rerum deleniti.\nError animi quaerat similique omnis tenetur sapiente voluptatem. Nemo voluptate perspiciatis quaerat iure. Quia modi hic saepe. Sit accusamus animi et ipsam adipisci ut aut.','CHF 2368500','2017-03-16 14:29:59','2017-03-16 14:29:59'),(21,1,1,2,23,4,15,3,'Eligendi veniam sint.','2016-11-05','Quia cupiditate amet fuga. Et totam non voluptas quae veritatis. Et repellat tenetur eum magni quis.','Cum sed laborum rerum error hic. Debitis excepturi odit fugit fuga eos aliquam voluptate. Adipisci modi veritatis iste tempora. Explicabo debitis officiis ullam.\nMaxime consequatur nemo fugiat alias assumenda necessitatibus ex. Id est ex labore aut. Alias iusto sed quae ea porro et. Molestias inventore autem quam rerum quod. Iusto molestiae optio incidunt ut quisquam dolores doloremque.\nDolorum et commodi magnam dolorem et doloribus ipsum. Hic ut cum nostrum corrupti qui dignissimos. Fugiat pariatur et nihil earum.',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(22,5,4,1,9,3,3,2,'Incidunt nesciunt.','2017-02-03','Qui iure veniam vero ea aut rem. Itaque voluptas nam praesentium ratione deleniti et aut. Maxime sed aliquam velit rerum in. Et fugiat dolorem molestiae sit.','Praesentium impedit esse consequatur aperiam sapiente molestias repudiandae. Cupiditate reprehenderit ea aut. Dolorum eveniet sunt unde ex sit. Saepe ullam corrupti molestiae natus assumenda impedit aspernatur.\nNam est in ipsa earum eius quo. Labore molestias harum praesentium est non. Sit libero velit molestiae rerum laboriosam qui a quas. Praesentium commodi iste voluptatem nobis quibusdam.\nDolorum temporibus exercitationem totam praesentium fugiat quod. Repellendus quam sequi fugit blanditiis doloribus eum. Porro ea recusandae autem laborum voluptatem.\nEst voluptate et nesciunt est. Qui et quidem perspiciatis placeat. Id laborum facilis dicta incidunt et.',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(23,1,1,2,23,3,2,2,'Amet a.','2017-01-14','Non id animi eius error nobis delectus. Aut nihil aut voluptatibus sed ut. Nulla sed quas amet beatae modi. Qui qui accusantium provident.','Adipisci qui at quis numquam et mollitia. Quisquam reprehenderit ex quasi doloribus. Nemo sit est suscipit.\nSaepe hic voluptates vitae autem vero officia. Repudiandae at sed soluta est ex magnam. Quia adipisci corporis qui doloribus esse facilis.\nReprehenderit molestiae vero quos excepturi occaecati in. Vel sit est consectetur cumque qui a. Quia labore magni est.\nCulpa nobis eius perspiciatis quis voluptas. Et quam temporibus nostrum commodi dolorem. Culpa eos est ullam voluptatem molestiae. Nobis non veniam quis. Enim similique dolor qui rerum sit velit nesciunt iure.',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(24,20,1,2,10,5,17,4,'Rem quia.','2016-11-24','Atque repellat sapiente autem. Voluptatem aut id porro nisi vero voluptatem nihil. Voluptatum asperiores fuga earum. Quo libero enim dolore rerum.','Vero iste vitae id molestias. Necessitatibus possimus earum autem inventore voluptatem. Voluptas est doloribus laborum dolores eos.\nQuia voluptatem dolor aut voluptatem. Neque doloremque id magnam labore.\nOfficiis magnam laudantium velit. Magnam nulla cupiditate qui in. Consequatur quidem et debitis nisi voluptas maiores iste.\nQuisquam cumque et quisquam quaerat. Ipsa enim voluptatem quas nemo.\nUt tenetur optio et ea repellat qui rerum. Qui quibusdam repellendus quas occaecati. Consequuntur dolores et rerum aut.\nDistinctio ea dolores ad tenetur. Nulla dolorum reiciendis quia sit eos minus veniam harum. Cum sit consequatur quo cumque est.',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(25,NULL,3,2,19,6,8,6,'Non consequatur.','2016-09-16','Corporis nesciunt doloremque qui et nesciunt. Laborum aspernatur repudiandae aut qui et. Distinctio modi ut itaque in dicta dolores veritatis rerum. Et voluptas eligendi ut perferendis et. Quo dolores omnis doloremque qui et a.','Aut iure perspiciatis quas ut voluptatem veritatis debitis. Vel enim enim officiis quia. Rerum eos magni sit ipsa vitae. Quisquam ratione nisi ipsam hic explicabo corrupti in. Recusandae in eveniet dolore qui.\nFugiat sequi illo dignissimos ipsum modi nulla. Ea repudiandae aut corrupti dolores voluptatem voluptatem. Qui inventore sit vitae perferendis quia sit et. Non hic quibusdam omnis et.\nExplicabo suscipit fuga et porro dignissimos repellat. Ipsa id blanditiis et in delectus. Provident aut autem explicabo. Atque velit et eligendi explicabo ea eos.\nSint ipsa sint qui ut amet sit. Error dolorem veritatis et qui consequatur dolorem nam rerum.',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(26,NULL,3,1,6,5,17,6,'Suscipit omnis.','2016-12-07','Libero ut occaecati a iure maiores saepe accusamus et. Quo sit corporis ipsa ut voluptatum mollitia quis reiciendis. Explicabo sunt suscipit ex aliquam. Molestiae laborum expedita consectetur possimus.','Quos non dolore neque voluptate rerum sunt. Error unde exercitationem eum quibusdam voluptas voluptas similique. Inventore nihil corporis eos voluptas. Dolores aliquid consequatur et maiores sint.\nDolor consequatur sint repudiandae asperiores. In rerum rerum libero delectus magni provident. Omnis illum porro nesciunt voluptas vel sint est. Ducimus iusto tempora ut labore nihil qui ea et.\nEum aut illo quas sit totam. Consequatur soluta qui doloremque tenetur. Velit laboriosam aut nihil iure qui voluptatum. Soluta blanditiis nihil illum maiores incidunt aut asperiores. Fugiat necessitatibus nesciunt tempore consequatur et magnam.',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(27,8,4,2,11,2,9,1,'Corporis aliquam natus.','2017-01-26','Nulla consequuntur vel doloremque sint inventore praesentium et. Tenetur in vero nam voluptatem. Aliquid natus error quasi et voluptatum. Quis non quaerat sit nulla. Architecto dignissimos asperiores rerum dolores ratione est aut.','Neque officiis sapiente sed sed error ex. Error voluptate quo ut atque.\nAliquam quis eius alias porro accusamus. Rerum hic neque velit itaque est. Ad et officiis labore in exercitationem porro.\nBlanditiis ipsam rerum maiores ut dolores nostrum et. Consequatur tempora nostrum voluptas tenetur enim eum ab. Reprehenderit quia ab dicta nihil ab.\nOmnis eveniet architecto qui aut omnis fugit veniam. Eius rem saepe et nam quo culpa. Dolores aut repudiandae modi debitis repudiandae mollitia.\nAccusamus omnis tempora aliquid molestiae iusto amet consequuntur. Non quibusdam voluptatem soluta rerum odit quia et. Quia odit et veniam est non laborum.',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(28,4,4,2,9,6,12,6,'Est alias.','2017-01-06','Pariatur quia at veniam temporibus. Reiciendis aspernatur qui aut. Eum et non non molestiae est.','Asperiores enim aliquam nihil omnis possimus ipsam. Pariatur ut reiciendis esse. Laborum enim natus enim nam a dolorum necessitatibus. Eaque rem odit ipsam sit earum nam.\nUt minus corporis cumque voluptas aperiam autem in. Distinctio ducimus explicabo maiores et molestiae aliquam. Sed in voluptas nostrum sit.\nAtque qui aperiam dolores sunt porro. Qui odit ut vel ratione reiciendis aut eligendi dolorum. Debitis facilis eum voluptatem quia possimus molestiae.\nUllam fuga est unde nostrum quis aut tempora. Dicta velit enim porro nobis iusto et beatae et. Consectetur delectus accusantium totam molestiae. Quaerat vel magni vel consectetur earum voluptas voluptatum.',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(29,14,2,2,20,2,18,5,'Est omnis.','2017-02-06','Modi aut porro itaque nemo ut sint occaecati. Quo suscipit tenetur qui voluptas et debitis porro. Quaerat rem fugiat magnam autem tempora aut omnis.','Officiis qui impedit aliquam repudiandae. Quis nemo doloremque quis quia. Aut et sed ipsa autem ut consequatur laborum. Pariatur consequatur consectetur consequatur et maiores.\nSit enim qui a consequuntur vel. Illum ab adipisci voluptatem aut eum nihil totam. Commodi sit exercitationem tempore sunt est repudiandae illum.\nReiciendis quidem distinctio quia esse. Sint officia eaque officiis sit. Voluptatem recusandae officiis excepturi dolorem. Laudantium tempore ea nihil vitae rerum doloribus. Perspiciatis nobis architecto aut error fugit.\nSed enim molestias et doloremque soluta eos aut numquam. Quia ut quisquam molestiae voluptatem inventore ad.',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(30,NULL,3,1,16,5,18,4,'Tenetur est.','2017-01-30','Vel deserunt et beatae. Autem ut incidunt aut harum aut enim et.','Placeat ut reiciendis recusandae rerum id. Atque voluptas voluptatibus unde sed. Facere quisquam inventore ut reprehenderit.\nEnim reiciendis et illum ullam. Qui aut ut praesentium dicta dicta voluptates nostrum qui. Quia itaque reiciendis ea corrupti ut enim voluptas.\nItaque harum nobis sed sit. Cumque molestiae repellat modi commodi. Aliquam labore est fuga inventore.\nEt earum doloremque esse voluptatum est quae illum vel. Nemo iure eaque soluta nostrum. Tenetur similique est dolorem nihil perferendis sequi et.\nEst sequi iusto placeat rerum placeat laboriosam. Id voluptas voluptas quod enim et vero quo. In eius omnis illo dolorem odio qui quia error. Commodi iste omnis aut placeat facere.','CHF 3808900','2017-03-16 14:29:59','2017-03-16 14:29:59'),(31,18,4,2,24,5,13,3,'Ut sit et.','2016-11-02','Culpa voluptas facilis consequatur ex unde. Iure molestiae enim distinctio. Numquam aliquid dolores repellendus maiores. Beatae qui vero inventore.','Velit est quidem dolores nemo non et. Excepturi et suscipit voluptatem praesentium vero. Aut quod sit quam alias.\nAdipisci et ut laboriosam id qui ex et. Perferendis quae neque sed. Consequatur quas pariatur magni beatae ad. Et placeat est vel sint pariatur dolorum qui quidem.\nQui consequatur tenetur quaerat illo cupiditate sequi. Quia sunt velit ex eos minima consequuntur repudiandae voluptas. Animi corporis officiis culpa non et voluptas.\nMollitia sed enim enim et quia expedita eaque. Quisquam accusantium quos nisi voluptatem repudiandae sequi nisi. Est quisquam saepe id corporis et.','CHF 8328100','2017-03-16 14:29:59','2017-03-16 14:29:59'),(32,17,2,1,13,6,5,5,'Delectus quia quis.','2017-01-06','Expedita qui nobis tempore quo. Perferendis pariatur qui consequuntur dolorem aliquid aliquid nemo. Quae distinctio nesciunt quisquam rerum laborum. Cum corrupti sed est velit aut doloribus in. Quia ut id temporibus inventore numquam quidem.','Maxime laborum nihil officiis voluptatem itaque. Quasi sit et quaerat fugiat earum. Dolorem voluptatem deleniti odio enim aut eius aut. Neque temporibus sint aut asperiores eligendi.\nEt nihil illo aperiam repellendus quos dolor. Magni rerum eligendi reiciendis tempore perspiciatis nisi architecto. Praesentium et voluptatem necessitatibus dolorem velit.\nAnimi voluptatem omnis deleniti eos. Consequatur quae perspiciatis ex voluptas sed eum et neque. Nulla debitis illum et debitis quam illo.\nQuis deserunt occaecati nostrum voluptatem. Quo omnis quia cupiditate delectus sit dolores quis. Et labore enim et optio harum.','CHF 3880400','2017-03-16 14:29:59','2017-03-16 14:29:59'),(33,19,4,1,4,3,16,4,'Enim odio.','2017-02-11','Doloribus sed et nemo voluptatem dolores. Asperiores sunt tempora voluptas voluptas quibusdam. Ab aut rerum adipisci eaque accusamus. Quia cupiditate vel possimus qui dolor ut ut dignissimos.','Modi voluptas fuga odit iste dolor. Cumque voluptatem fugiat distinctio praesentium. Voluptatibus quaerat commodi inventore dolorem officiis sit.\nCulpa atque deserunt aut est omnis aut. Sint est rerum nostrum velit maiores et facilis.\nEaque magnam accusamus velit incidunt quasi quisquam. Ipsa et ut aliquid in vero debitis quasi. Aut reiciendis porro velit a rem.\nMinus ullam voluptatibus eum. Molestiae ad consequatur omnis possimus qui enim accusantium. Dolorem illo optio quo iste modi.\nAssumenda omnis assumenda illo sit distinctio. Ad ut aspernatur voluptatem. Hic accusamus commodi aut quo. Quas omnis nostrum corporis qui. Aut fugit consequatur voluptas quia repudiandae ipsam hic dolor.',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(34,3,3,2,11,1,5,2,'Aut blanditiis.','2016-12-10','Similique facere et non accusamus qui nostrum dolorem. Animi maxime ipsa natus culpa. Quae optio voluptates consequatur sapiente ab. Dolor dolor omnis dignissimos voluptatum tempore.','Sed id consequatur autem hic. Ut quia consequuntur non nesciunt qui quia. Sit repellendus in qui.\nOccaecati aut enim ratione quo. Reprehenderit quod rerum omnis soluta eum. Minima deserunt fuga labore. Labore aut totam aspernatur dolorem.\nEsse dolorum sed repellendus dolores dolores. In et necessitatibus sit quia voluptatem. Aut repudiandae cumque inventore iure dolores rerum.\nUt laboriosam et aliquam consequatur saepe atque rerum. Minima illum officiis enim incidunt nobis aut.\nEnim omnis atque sunt recusandae nostrum. Quia omnis quae commodi natus. Qui laboriosam earum doloremque. Accusamus recusandae atque quae temporibus ex eos.',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(35,9,3,1,6,1,13,1,'Quo vero.','2016-09-30','Doloremque tenetur perferendis non quas modi a iusto. Doloribus eum molestias harum tempora ut modi. Velit et asperiores molestias fugit ut doloribus. Magnam porro qui exercitationem corporis iste molestiae modi quaerat.','Doloribus aut sed impedit quia non veniam nobis. Enim numquam numquam sed commodi iure sit voluptatum. Corrupti assumenda ut vitae eum.\nEt unde hic dolorem sit ut. Sunt aliquid ipsam omnis sequi possimus. Hic id consequatur ea esse. Delectus nihil et labore qui sequi modi iste est.\nNemo omnis quis rerum reprehenderit assumenda. Possimus perferendis et est et vel. Ipsum numquam quis ipsum sapiente tenetur at quia consectetur.\nAccusamus modi impedit reiciendis consequuntur commodi autem. Est quia porro ut qui in. Quis odit aut non ut rerum similique sit.\nAd qui et consectetur fuga quia. Quia expedita numquam velit atque. Sint facere porro maxime labore voluptatem minus excepturi.',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(36,6,2,1,23,2,4,5,'Expedita eum nihil.','2016-11-04','Fugiat maiores totam et error excepturi quaerat aut. Itaque autem possimus qui est aliquam culpa ad. Molestiae necessitatibus doloremque voluptates fugiat voluptatem. Repellat est ullam debitis consequatur nihil ut non.','Minus maxime delectus quae. Veniam nihil perferendis veniam cupiditate velit est itaque. Ducimus voluptas cupiditate dolorum laborum modi aut. Consequatur facere corrupti suscipit.\nAtque et quibusdam repellendus deserunt commodi ad unde consequatur. Dolor non magni sed et similique. Quo vel saepe sint laudantium incidunt voluptas. Non nulla porro dolores non.\nItaque necessitatibus et dolorem. Earum animi quaerat et libero nemo. Voluptatem quo sed placeat modi corrupti hic. Temporibus laboriosam suscipit occaecati ut aperiam labore.\nEst eaque molestiae et dolorum dolorem eaque. Alias deserunt id praesentium autem et facere.','CHF 9936400','2017-03-16 14:29:59','2017-03-16 14:29:59'),(37,13,4,2,2,3,6,1,'Ut sunt.','2016-09-11','Suscipit quia doloribus quaerat. Perspiciatis eius architecto soluta enim fugiat. Sit nobis laboriosam molestiae consequatur. Consequatur et dolorem repellendus sapiente voluptas qui.','Consequatur aspernatur ad unde nobis odit dignissimos. Quia eveniet sit aut nisi velit nulla. Facilis laudantium beatae eveniet illum error sunt qui et. Vel sed placeat sed natus natus quas.\nSit eveniet sint eius recusandae nulla perferendis. Ducimus vero sapiente officiis sequi qui. Repellat facere et quia vel nesciunt facere et.\nNihil architecto alias aut. Quis perspiciatis possimus facilis animi quod earum soluta.\nVero facilis optio iure. Aut eum et amet fugit. Earum placeat dolorum voluptas cum cumque. Nobis suscipit error quos voluptatem rerum et.\nEum tempore non dolor impedit. Mollitia temporibus voluptatum odio incidunt. Sed placeat mollitia qui hic.',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(38,12,1,1,7,5,20,1,'Nesciunt alias ut.','2016-11-14','Omnis reprehenderit eum et delectus sit quia aut. Sit rerum qui nihil. Non eum est et. Incidunt unde nihil ullam est soluta omnis.','Aut dolor excepturi qui quaerat ipsam exercitationem. Et id iusto aut ut ea. Voluptas ex iste ut ipsam ullam ex non est.\nFugit nam error quo eum dolores. Laborum voluptas asperiores ullam voluptatem. Saepe nostrum enim a optio iste distinctio.\nLabore reiciendis nulla sunt minima fuga. Eveniet eligendi ut illo et. Est architecto quia at optio quisquam aut expedita. Esse esse nam qui sed molestiae.\nUt temporibus qui sit iste quaerat placeat. Saepe et quod neque aliquam. Neque quo nisi est est voluptates. Qui dolores voluptatem consequuntur ea nesciunt.',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(39,NULL,3,1,19,3,19,4,'Sit quos.','2016-11-01','Et quae voluptas suscipit et exercitationem est est saepe. Reiciendis accusantium qui exercitationem officia. Velit qui eius ducimus explicabo. Et ex debitis labore sequi. Laudantium rerum quidem tenetur quaerat cumque repellendus alias.','Nemo ullam quae odio. Maiores quisquam dolor aliquid atque est modi minus. Velit repellat similique dicta modi eaque.\nRepudiandae explicabo pariatur voluptates enim laborum. Quia tempora suscipit voluptas. Id accusantium perferendis eveniet laborum.\nQuisquam modi totam quas non ullam. Eaque et non tenetur aut odio cupiditate id. Iure unde magnam vel vel. Officiis cupiditate fugit temporibus ut voluptates sequi cum.\nDoloribus at magni nihil magni ut enim. Qui asperiores quam dolore eum dicta quia. Sunt voluptatem est dolores voluptatem.\nAccusamus quidem ullam pariatur ut. Molestiae sit omnis distinctio ut. Asperiores explicabo qui rerum explicabo.','CHF 4862100','2017-03-16 14:29:59','2017-03-16 14:29:59'),(40,6,1,1,5,5,2,2,'Architecto dolore.','2016-10-20','Facilis consectetur praesentium sapiente consequuntur voluptas. Molestiae dolorem odio sed sunt minus et fugiat. Inventore itaque fugiat accusantium dolore. Ex corrupti dolorum excepturi laborum sequi.','Ratione veniam occaecati vel velit consectetur. Modi nisi eos ea illo corporis eveniet reprehenderit. Beatae dolores labore exercitationem. Earum sed animi repudiandae nulla.\nDolorem velit animi laboriosam soluta in. Voluptatem sint asperiores accusamus vero maiores. Neque nemo nihil est maiores. Quasi consectetur iure quia culpa delectus odit et.\nError quo illo sit. Voluptas ipsam dolorem exercitationem fugiat rerum nihil. Eum nihil dicta consequatur aut debitis nemo et. In rerum laborum aut quidem nihil. Natus deleniti vero exercitationem.',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(41,10,4,2,9,1,22,1,'Incidunt sunt est.','2016-12-17','Quaerat ut qui esse eum omnis. Aliquam maxime itaque ea blanditiis accusantium. Corrupti assumenda illo fugiat est et.','Eius quis non quasi et qui autem. Qui reprehenderit tempora nam dolore nisi aliquam aperiam. Voluptas nulla eius in harum commodi id omnis. Maiores minima qui voluptas ullam odio beatae ipsum.\nSed quaerat eaque quaerat in doloremque enim ipsa. Quo similique reiciendis vel voluptate rem sit. Illo aut molestiae impedit sint.\nIusto laboriosam omnis suscipit quidem iste aspernatur molestiae. Et eos similique sed et. Pariatur distinctio accusantium porro et. Vel voluptate earum ducimus velit consequatur quam eos.\nIusto omnis alias quibusdam dicta sit laborum perspiciatis optio. Sed qui repudiandae perspiciatis officia iste praesentium et.',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(42,NULL,4,1,18,2,21,6,'Voluptatem nostrum.','2016-10-06','Enim totam rerum officiis deserunt autem accusamus aut. Aut assumenda dolorem quaerat distinctio labore. Qui in qui animi rerum nihil. Cupiditate odio dolor earum nihil hic.','Et corporis molestiae voluptatem et aliquam voluptatum veniam itaque. Laudantium voluptatem est veniam quis. Qui et in eum dolores omnis numquam. Odio repellendus velit doloribus rerum.\nQuos voluptatem consequatur voluptas minima suscipit accusamus. Quibusdam temporibus nihil et repudiandae qui dolor et. Voluptatibus ab omnis eos ullam exercitationem non.\nPraesentium dolorem asperiores accusamus aut. Praesentium voluptas rerum dolorem eos est. Et et sit distinctio iste quia magnam. Iusto blanditiis consequuntur minima est exercitationem eos dolorem fugiat. Corporis error ut commodi mollitia nostrum quod tempora.',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(43,7,4,1,5,4,17,2,'Libero repellendus.','2016-08-30','Molestias molestiae facilis exercitationem. Provident rerum tempora iste adipisci et voluptatibus error quibusdam. Doloremque animi veritatis deserunt temporibus eum vel. Id inventore cupiditate repudiandae recusandae qui.','Aperiam quia sapiente et illum. Nihil quasi modi aut quo neque facere. Veniam deserunt commodi voluptatem est.\nSunt voluptates sit dicta animi possimus dolorem. Nisi nobis nostrum consequatur sapiente rerum iste. Sint incidunt sapiente dolor voluptas.\nAutem ut animi omnis optio molestiae ducimus earum voluptate. Voluptates atque provident corrupti enim placeat. Hic sed dolores illo quia.\nDolor exercitationem fugit aperiam impedit recusandae. Consequuntur unde sapiente natus molestiae cumque in ullam. Voluptatem ut et ipsa aut.','CHF 5115300','2017-03-16 14:29:59','2017-03-16 14:29:59'),(44,4,3,2,9,3,14,4,'Omnis inventore.','2016-11-27','Omnis facilis dolores cumque minus eos. Laboriosam aut aut voluptatum magnam autem sit. Magnam quidem molestias quo atque vel est repellendus necessitatibus.','Voluptas repellendus assumenda est autem numquam qui. Ad eaque quo soluta sunt possimus perferendis. Consectetur praesentium velit pariatur ullam beatae. Quia consequuntur excepturi et maiores qui sed dolor omnis.\nAutem sed accusamus itaque. Expedita cum qui doloremque aut. Consequatur voluptate deserunt quis qui quos at voluptas.\nMolestias odit vitae accusamus natus mollitia maxime voluptatem voluptas. Et molestiae voluptatibus autem laboriosam perferendis. Voluptatem modi voluptatem voluptatem quo. Cumque quis est ut et reiciendis.\nConsequuntur blanditiis et dolorem illo dolore itaque saepe harum. Id fuga aut assumenda iure quia vel. Consectetur in autem harum deserunt et a culpa non.',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(45,18,3,1,21,5,25,4,'Qui voluptas.','2016-12-18','Sit recusandae consequatur quis. Dignissimos dolorem maiores veritatis nihil sunt.','Vero nobis praesentium culpa rerum est quam. Modi quaerat quam ab consequatur. Velit aut dolorem odit odio laudantium voluptatem.\nRatione dolore sed minus voluptatum sunt velit. Voluptate molestiae magnam sint qui rerum. Aut quaerat qui pariatur non vitae veniam quo voluptas.\nUt aliquid animi asperiores recusandae quam porro possimus dolorem. Sequi perferendis placeat quo perspiciatis fugiat. Quia fuga occaecati voluptas laboriosam.\nPorro libero et consequatur. Sed voluptates corrupti debitis ducimus saepe dolore. Cupiditate quia delectus fugiat ea repellat est.',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(46,14,1,1,2,1,4,3,'Tempore quisquam.','2016-10-10','Est consectetur voluptatem temporibus explicabo fuga. Molestiae omnis et sequi eligendi. Tempore asperiores beatae commodi tempora hic sunt.','Qui totam et commodi odio aut rerum. Occaecati et molestiae culpa. Reiciendis voluptatem id explicabo non assumenda dolore.\nQui facere dolorem non. Laboriosam ut est expedita perspiciatis perferendis vel. Et ut ut quo. Quidem numquam blanditiis omnis inventore totam qui magnam. Est velit voluptas excepturi eaque non id.\nVoluptatum illum debitis eos accusantium. Recusandae et enim illo quod tempore. Nisi vero numquam eligendi.\nAut hic et necessitatibus repellat. Nihil inventore voluptatum tempora eos ex possimus quia. Qui aut nam aut aliquam.',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(47,3,2,1,23,3,10,4,'Blanditiis suscipit voluptates.','2016-10-08','Vero neque inventore vel omnis sunt. Quia odio placeat dolorem. Minus qui fugit temporibus debitis fugiat. Officia at atque totam distinctio doloremque. Earum ut consectetur est.','Quisquam eos provident ipsam consequatur voluptates temporibus. Et debitis laborum nulla enim qui ad. Officia minus qui corrupti cupiditate velit. Voluptate ea quidem distinctio aspernatur perferendis rerum esse. Soluta cum enim maxime iusto pariatur.\nOdio odio odio ut voluptas quibusdam omnis. Minus aut ducimus aliquam dicta rerum deserunt vel. Nulla optio ut aperiam illum ut molestiae dolore. Consequatur tempore molestias sunt.\nIpsam iusto sunt ratione. Voluptatem voluptas error et corporis. Quis dolore exercitationem rerum natus qui atque. Qui qui quis illo eveniet exercitationem quasi.','CHF 7030400','2017-03-16 14:29:59','2017-03-16 14:29:59'),(48,NULL,3,2,7,6,11,1,'Magnam natus qui.','2017-01-10','Eligendi mollitia doloribus quis similique. Ipsum ad repudiandae itaque doloremque reiciendis numquam. Voluptatem voluptatibus est exercitationem error alias. Aut et sit autem cupiditate expedita.','Et minima harum molestias ullam et ab. Quia omnis molestiae tenetur nihil. Repellat veniam laborum sint quisquam. Quae at voluptate praesentium deserunt adipisci commodi pariatur consectetur. Dicta alias dolores nesciunt vel.\nBlanditiis iure a quisquam voluptas. Inventore quo voluptatem qui illum. At in magni ut sed sunt optio. Voluptas similique a minima et rerum.\nEius autem laboriosam molestias quia est est incidunt. Impedit provident voluptate delectus laboriosam voluptatem. Enim sit quis excepturi vel sit aliquid laboriosam.\nEt sed libero aut inventore doloribus odit. Ducimus facere dicta modi aut accusamus. Ad delectus sequi nam similique omnis qui.',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(49,NULL,2,1,9,4,9,3,'Et voluptates ut.','2016-12-19','Porro et aut atque doloribus. Est enim eius consequatur tenetur ut. Aliquam aut corrupti odio error repellendus.\nHic enim est enim perferendis a. Id incidunt vero iusto. Porro vel est vitae rerum consectetur eius velit.','Voluptate est ut dolorum architecto eaque nihil. Et veritatis hic sunt. Quasi ut necessitatibus quo. Doloribus consequatur mollitia cupiditate neque tempora illum incidunt laborum.\nPorro rerum et nobis iste aut. Nobis est voluptas corrupti sed in.\nNemo tempore ducimus sapiente cupiditate laboriosam nobis nihil. Eveniet saepe inventore vitae enim. Minima consectetur iusto accusamus hic.\nAspernatur hic voluptatem consequuntur modi saepe. Quisquam adipisci sed odio. Omnis debitis quia doloribus ullam doloremque. Et similique at voluptas est.',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(50,8,4,2,5,1,18,2,'Minima ut nihil.','2016-10-29','Quo voluptas asperiores ea eos odio quisquam sint. Aut blanditiis ut mollitia minus. Odio sequi exercitationem facilis ut minima ea autem.\nUt optio hic ut corporis possimus. Modi qui natus facilis nihil rerum.','Qui nihil minus recusandae excepturi similique ipsa recusandae. Dignissimos minus fugiat autem quia. At a qui perspiciatis laudantium autem laudantium quisquam.\nSaepe cumque modi soluta. Velit quo nulla et tempora laborum vero illo vel. Aut non et facere repudiandae pariatur illum enim. Ut id ut omnis qui.\nTempora asperiores cupiditate quia voluptatem odit. Libero fugiat aspernatur quia laborum quis corporis facilis. Ut illo autem laudantium quia quod exercitationem et laboriosam. Magnam blanditiis nam sit debitis consequatur.\nHarum magni et magnam id. Assumenda ut non voluptatem quia quos consequatur dolores qui. Suscipit culpa reprehenderit similique inventore voluptas et.',NULL,'2017-03-16 14:29:59','2017-03-16 14:29:59');
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
INSERT INTO `project_categories` VALUES (1,'projectCategory1','2017-03-16 14:29:59','2017-03-16 14:29:59'),(2,'perspiciatis','2017-03-16 14:29:59','2017-03-16 14:29:59'),(3,'voluptas','2017-03-16 14:29:59','2017-03-16 14:29:59'),(4,'dolor','2017-03-16 14:29:59','2017-03-16 14:29:59'),(5,'veritatis','2017-03-16 14:29:59','2017-03-16 14:29:59'),(6,'molestias','2017-03-16 14:29:59','2017-03-16 14:29:59'),(7,'est','2017-03-16 14:29:59','2017-03-16 14:29:59'),(8,'in','2017-03-16 14:29:59','2017-03-16 14:29:59'),(9,'sed','2017-03-16 14:29:59','2017-03-16 14:29:59'),(10,'qui','2017-03-16 14:29:59','2017-03-16 14:29:59');
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
  CONSTRAINT `FK_562D5C3EBAD26311` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_562D5C3E166D1F9C` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE
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
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_5C93B3A49395C3F3` (`customer_id`),
  KEY `IDX_5C93B3A42983C9E6` (`rate_group_id`),
  KEY `IDX_5C93B3A4DA896A19` (`project_category_id`),
  KEY `IDX_5C93B3A49582AA74` (`accountant_id`),
  KEY `IDX_5C93B3A4A76ED395` (`user_id`),
  CONSTRAINT `FK_5C93B3A4A76ED395` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_5C93B3A42983C9E6` FOREIGN KEY (`rate_group_id`) REFERENCES `rate_groups` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_5C93B3A49395C3F3` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_5C93B3A49582AA74` FOREIGN KEY (`accountant_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_5C93B3A4DA896A19` FOREIGN KEY (`project_category_id`) REFERENCES `project_categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projects`
--

LOCK TABLES `projects` WRITE;
/*!40000 ALTER TABLE `projects` DISABLE KEYS */;
INSERT INTO `projects` VALUES (1,1,1,1,7,2,'Büro','project-1','2015-11-20 06:57:29','2016-09-27 05:59:53',NULL,'Eine Beschreibung zum Büro Projekt',NULL,NULL,NULL,1,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(2,25,1,2,7,4,'Test Project 2','test-project-2','2015-08-10 08:08:07','2017-01-21 03:54:52','2017-02-14 13:17:16','Cum ducimus vitae quam omnis ea. Odio quis est officia voluptatibus corrupti commodi. Minima reprehenderit laborum cumque molestiae aut numquam.\nAliquam est quod expedita laudantium qui ipsa ratione. Ut officia est rerum reprehenderit autem voluptatem.','CHF 9303200','CHF 9303200',NULL,1,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(3,19,2,9,18,1,'Test Project 3','test-project-3','2015-08-08 21:11:50','2016-10-20 04:36:56',NULL,'Quas quo totam quia doloremque numquam itaque. Voluptas quidem dolorum neque repudiandae. Non dolor voluptatibus nihil occaecati ut. Soluta sequi ut dignissimos omnis eveniet et nihil.','CHF 7734300','CHF 7734300',NULL,1,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(4,12,1,9,20,3,'Test Project 4','test-project-4','2015-09-23 04:15:59','2017-03-08 06:32:42',NULL,'Et doloremque quia commodi modi quia culpa. Autem quae perferendis enim id. Consequuntur provident beatae culpa consequatur aut ducimus dignissimos. Consequatur accusantium excepturi magni qui at et.','CHF 6237100','CHF 6237100',NULL,1,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(5,17,2,1,15,1,'Test Project 5','test-project-5','2016-08-06 02:25:42','2016-09-13 02:02:27',NULL,'Labore labore minus iste corrupti rerum. Aut totam sit consectetur omnis. Nobis qui recusandae tempore molestias expedita fugit delectus. Delectus laudantium sed iure quia illo neque omnis.','CHF 3631200','CHF 3631200',NULL,1,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(6,14,2,7,8,6,'Test Project 6','test-project-6','2015-03-30 02:44:06','2016-11-03 17:14:54','2017-02-02 03:29:06','Placeat et similique delectus nobis dolore accusamus qui. Et aliquam et at quod consequatur. Commodi qui voluptate quia rerum ut enim rem. Voluptas harum totam saepe.','CHF 2899400','CHF 2899400',NULL,1,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(7,10,1,10,7,6,'Test Project 7','test-project-7','2016-04-06 05:30:02','2016-10-12 21:19:50',NULL,'Qui recusandae nam quia non vitae eaque. Temporibus optio nisi sequi et eaque esse officia fugit. Voluptatibus quam quaerat aut.','CHF 2102000','CHF 2102000',NULL,1,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(8,11,1,6,24,3,'Test Project 8','test-project-8','2016-06-08 07:09:44','2016-09-05 15:05:46',NULL,'Illo aut quod exercitationem numquam quia. Aut hic autem voluptatem placeat. Explicabo est et modi aut. Deleniti qui quisquam facere esse quia et et.','CHF 9369500','CHF 9369500',NULL,1,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(9,3,1,7,25,3,'Test Project 9','test-project-9','2015-08-02 02:53:30','2016-12-25 05:21:09',NULL,'Provident magni eius nulla distinctio qui. Ut et magnam qui officia ea. Expedita ratione et sit reiciendis sunt molestias iure. Et molestiae laborum sequi laborum distinctio suscipit aut.','CHF 2996200','CHF 2996200',NULL,1,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(10,2,1,7,13,2,'Test Project 10','test-project-10','2016-06-03 22:02:18','2017-01-28 04:47:58',NULL,'Beatae et et quis illum molestiae. Omnis exercitationem velit repellat sit cum vitae sunt vel. Molestiae sit nihil nobis non.','CHF 79329800',NULL,334,0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(11,25,1,7,15,3,'Test Project 11','test-project-11','2016-03-21 16:55:18','2016-09-22 04:59:36',NULL,'Facere maiores dolore et. Debitis reprehenderit sequi occaecati rerum occaecati mollitia occaecati et. Deserunt dignissimos repudiandae eos. Dolores debitis ut sint est quo.','CHF 28360300',NULL,843,1,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(12,9,2,5,24,4,'Test Project 12','test-project-12','2015-07-22 11:46:07','2016-11-15 23:29:02',NULL,'Cumque officia id quidem commodi ullam. Fuga praesentium et sunt magnam soluta. Neque id sunt omnis deleniti error. Voluptates ea in dolores ut tempore modi. Aperiam repudiandae mollitia molestiae voluptate cum dolorem reprehenderit.','CHF 18515900',NULL,940,1,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(13,23,2,4,16,1,'Test Project 13','test-project-13','2016-07-03 23:58:19','2016-11-26 15:40:23','2017-03-12 14:48:18','Odio magni est voluptatum. Optio adipisci corporis qui quis molestiae corporis. Adipisci quibusdam reprehenderit omnis voluptas. Ut et aut minima quos est cumque facere numquam.','CHF 15807000',NULL,432,1,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(14,21,2,7,24,5,'Test Project 14','test-project-14','2015-08-19 17:59:35','2016-12-01 08:30:23','2017-03-07 22:05:27','Reiciendis autem inventore harum animi ea nihil. Sed rerum perferendis aut saepe et nostrum consectetur. Odit est dolorem facere et. Recusandae ut quibusdam sit enim aspernatur.','CHF 54257400',NULL,863,1,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(15,22,2,7,23,6,'Test Project 15','test-project-15','2015-10-18 02:36:52','2017-02-22 23:00:09',NULL,'Ut alias quisquam at qui. Molestias maxime adipisci et saepe esse. Sed aperiam rerum nemo animi necessitatibus.','CHF 89397300',NULL,327,1,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(16,22,2,6,17,5,'Test Project 16','test-project-16','2016-01-03 06:30:57','2016-10-03 05:40:13','2017-02-28 09:47:50','Ipsum velit labore sit tenetur totam. Ut consequuntur corporis veniam minima a numquam sed repellat. Atque veniam pariatur quos nulla ipsa dolorem. Eum eum necessitatibus et aut explicabo voluptatem. Reiciendis voluptas inventore et perspiciatis.','CHF 65604800',NULL,953,1,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(17,10,1,5,23,4,'Test Project 17','test-project-17','2015-06-07 18:08:00','2016-12-31 23:15:22','2017-03-07 06:15:49','Quasi autem molestias quis odit. Aliquid veritatis est fuga cumque unde. Ipsam eum amet qui et veniam est. Quibusdam aut omnis labore molestiae consequuntur explicabo sint sequi.','CHF 69012200',NULL,883,1,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(18,21,2,7,9,3,'Test Project 18','test-project-18','2016-08-11 04:22:57','2016-11-01 02:47:45',NULL,'Est quo et culpa minus. Harum reprehenderit qui voluptates voluptatibus numquam dolores suscipit molestiae. Est saepe suscipit nulla voluptate aut. Tempore aspernatur sit eius est distinctio asperiores.','CHF 90811900',NULL,207,1,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(19,10,1,10,8,6,'Test Project 19','test-project-19','2016-04-19 19:17:03','2016-11-07 22:59:10',NULL,'Architecto eius voluptate quisquam molestiae incidunt a aut. Eos quam libero ducimus accusamus. Molestias labore provident error consequatur modi.','CHF 49896700',NULL,165,1,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(20,17,1,7,23,6,'Test Project 20','test-project-20','2016-07-28 23:47:23','2017-02-01 18:50:44',NULL,'Rem omnis consequatur ullam temporibus. Et in dolorem quidem. Enim aspernatur sed est voluptatem officia. Velit laboriosam ut eum nulla ea ut error. Eos blanditiis animi provident omnis et quidem.','CHF 72104700',NULL,757,1,'2017-03-16 14:29:59','2017-03-16 14:29:59');
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
INSERT INTO `rate_groups` VALUES (1,1,'Tarifgruppe für kantonale Einsätze','Kanton','2017-03-16 14:29:59','2017-03-16 14:29:59'),(2,1,'Tarifgruppe für die restlichen Einsätze','Gemeinde und Private','2017-03-16 14:29:59','2017-03-16 14:29:59');
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
  CONSTRAINT `FK_44D4AB3CA76ED395` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_44D4AB3C2983C9E6` FOREIGN KEY (`rate_group_id`) REFERENCES `rate_groups` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_44D4AB3C2BE78CCE` FOREIGN KEY (`rateUnitType_id`) REFERENCES `rateunittypes` (`id`),
  CONSTRAINT `FK_44D4AB3CED5CA9E6` FOREIGN KEY (`service_id`) REFERENCES `services` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rates`
--

LOCK TABLES `rates` WRITE;
/*!40000 ALTER TABLE `rates` DISABLE KEYS */;
INSERT INTO `rates` VALUES (1,1,1,2,'CHF/h','CHF 10000','2017-03-16 14:29:59','2017-03-16 14:29:59','h'),(2,1,16,3,'CHF/h','CHF 8100','2017-03-16 14:29:59','2017-03-16 14:29:59','h'),(3,2,21,5,'CHF/h','CHF 10300','2017-03-16 14:29:59','2017-03-16 14:29:59','h'),(4,1,20,4,'CHF/h','CHF 18000','2017-03-16 14:29:59','2017-03-16 14:29:59','h'),(5,2,18,4,'CHF/h','CHF 8100','2017-03-16 14:29:59','2017-03-16 14:29:59','h'),(6,1,21,4,'CHF/h','CHF 2800','2017-03-16 14:29:59','2017-03-16 14:29:59','h'),(7,1,40,5,'CHF/d','CHF 10800','2017-03-16 14:29:59','2017-03-16 14:29:59','t'),(8,2,40,5,'CHF/d','CHF 1500','2017-03-16 14:29:59','2017-03-16 14:29:59','t'),(9,1,41,3,'CHF/d','CHF 3100','2017-03-16 14:29:59','2017-03-16 14:29:59','t'),(10,1,41,4,'CHF/d','CHF 7600','2017-03-16 14:29:59','2017-03-16 14:29:59','t'),(11,1,39,5,'CHF/d','CHF 16900','2017-03-16 14:29:59','2017-03-16 14:29:59','t'),(12,2,61,4,'Einheit','CHF 18500','2017-03-16 14:29:59','2017-03-16 14:29:59','a'),(13,2,61,1,'Einheit','CHF 5500','2017-03-16 14:29:59','2017-03-16 14:29:59','a'),(14,2,54,5,'Km','CHF 13700','2017-03-16 14:29:59','2017-03-16 14:29:59','a'),(15,2,59,2,'Pauschal','CHF 18300','2017-03-16 14:29:59','2017-03-16 14:29:59','a'),(16,2,60,5,'Km','CHF 6000','2017-03-16 14:29:59','2017-03-16 14:29:59','a'),(17,1,79,3,'Pauschal','CHF 10700','2017-03-16 14:29:59','2017-03-16 14:29:59','a'),(18,1,81,6,'Pauschal','CHF 14500','2017-03-16 14:29:59','2017-03-16 14:29:59','a'),(19,2,81,6,'Pauschal','CHF 18300','2017-03-16 14:29:59','2017-03-16 14:29:59','a'),(20,1,73,3,'Pauschal','CHF 2700','2017-03-16 14:29:59','2017-03-16 14:29:59','a'),(21,1,80,6,'Pauschal','CHF 6700','2017-03-16 14:29:59','2017-03-16 14:29:59','a');
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
INSERT INTO `rateunittypes` VALUES ('a',4,'Anderes',0,1.000,3,1,'a','2017-03-16 14:29:59','2017-03-16 14:29:59'),('h',1,'Stunden',1,3600.000,2,1,'h','2017-03-16 14:29:59','2017-03-16 14:29:59'),('m',1,'Minuten',1,60.000,2,1,'m','2017-03-16 14:29:59','2017-03-16 14:29:59'),('t',3,'Tage',1,30240.000,2,1,'d','2017-03-16 14:29:59','2017-03-16 14:29:59'),('zt',3,'Zivitage',1,30240.000,2,1,'zt','2017-03-16 14:29:59','2017-03-16 14:29:59');
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
INSERT INTO `services` VALUES (1,2,'consulting','consulting','This is a detailed description',1,0.0800,0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(2,4,'voluptas','veritatis-molestias-est-in-sed','Cum ducimus vitae quam omnis ea. Odio quis est officia voluptatibus corrupti commodi. Minima reprehenderit laborum cumque molestiae aut numquam.\nAliquam est quod expedita laudantium qui ipsa ratione. Ut officia est rerum reprehenderit autem voluptatem.',1,0.0800,0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(3,5,'nihil','est-sit-suscipit-libero-nisi','Quo totam quia doloremque numquam itaque. Voluptas quidem dolorum neque repudiandae. Non dolor voluptatibus nihil occaecati ut. Soluta sequi ut dignissimos omnis eveniet et nihil.',1,0.0800,0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(4,3,'ullam','repellat-qui-ipsum-sit-illum','Doloremque quia commodi modi quia culpa corrupti autem. Perferendis enim id beatae consequuntur provident beatae culpa consequatur. Ducimus dignissimos est consequatur accusantium excepturi. Qui at et inventore voluptas.',1,0.0250,0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(5,5,'qui','tempore-molestias-expedita-fug','Quia illo neque omnis possimus numquam nostrum. Dolor mollitia repudiandae velit velit sit aut temporibus. Occaecati consectetur eos expedita tempora deserunt molestias quod. Repellendus voluptatum perferendis totam esse.',1,0.0800,0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(6,4,'harum','saepe-nihil-mollitia-consequat','Odio asperiores perspiciatis saepe et natus optio qui. Similique quaerat commodi perspiciatis et placeat autem ratione. Et et ut beatae rerum.',1,0.0250,0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(7,2,'nihil','ratione-ea-aperiam-quae-nam-id','Quis sed autem et velit dolores expedita optio quos. Molestiae dignissimos enim maxime tempore mollitia dolorem. In placeat error dolor assumenda enim aperiam sequi. Illo aut quod exercitationem numquam quia.',1,0.0250,0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(8,2,'dicta','aut-culpa-illo-quisquam-accusa','Et molestias culpa et facilis est ut. Fugit sed saepe maxime nobis ut cupiditate. Rem repellat voluptas dignissimos molestiae neque culpa.',0,0.0800,0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(9,1,'aut','accusantium-voluptatem-adipisc','Autem unde est eaque et. Modi incidunt exercitationem et reiciendis vel facilis sed. Quo est laboriosam beatae et.',1,0.0250,0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(10,5,'qui','natus-quidem-enim-voluptatum-l','Sit labore rem voluptas quasi aut. Ea libero veritatis rerum ad incidunt voluptatem facere. Dolore et at debitis reprehenderit sequi occaecati rerum.',1,0.0800,0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(11,1,'eveniet','non-qui-soluta-repellendus-nat','Fuga ipsum praesentium cumque officia id quidem commodi. Aut fuga praesentium et. Magnam soluta laudantium neque id sunt omnis. Error omnis voluptates ea in. Ut tempore modi molestiae aperiam.',1,0.0800,0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(12,1,'error','labore-sit-a-qui-omnis-dolorib','Cum autem nesciunt et numquam aspernatur. Odio magni est voluptatum. Optio adipisci corporis qui quis molestiae corporis. Adipisci quibusdam reprehenderit omnis voluptas.',1,0.0800,0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(13,6,'quia','sed-veritatis-molestiae-dolore','Magni quia maiores reiciendis autem inventore. Animi ea nihil est sed rerum perferendis. Saepe et nostrum consectetur eos odit est dolorem facere. A recusandae ut quibusdam sit enim. Quibusdam rerum vero eos atque voluptatem debitis ut autem.',1,0.0250,0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(14,1,'non','fuga-voluptatibus-atque-dolore','Qui incidunt molestias maxime adipisci et saepe. Ipsum sed aperiam rerum. Animi necessitatibus necessitatibus facilis quam aut. Harum reiciendis magnam voluptatum neque.',1,0.0800,0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(15,4,'consectetur','ipsum-velit-labore-sit-tenetur','Corporis veniam minima a numquam. Repellat ea atque veniam pariatur quos nulla ipsa dolorem. Eum eum necessitatibus et aut explicabo voluptatem.',1,0.0250,0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(16,3,'voluptas','voluptatum-qui-neque-sequi','Voluptate aperiam et aut at natus voluptas est aut. Odio optio itaque qui vel qui quasi. Molestias quis odit sapiente aliquid veritatis est fuga.',1,0.0800,0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(17,2,'quia','sit-qui-rem-enim-eos','Maxime hic et fuga expedita est id dolor. Officia perspiciatis autem et et et nihil officia. Sed et pariatur et sapiente beatae ut hic.',1,0.0250,0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(18,6,'eius','distinctio-asperiores-laborum-','Iure eaque aliquam qui consequatur neque ut debitis. Explicabo id enim ab. Non quia fuga ducimus tempore necessitatibus. Placeat et aut laborum eligendi. Mollitia sit accusamus architecto eius.',0,0.0800,0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(19,3,'iste','occaecati-voluptatem-rerum-opt','At modi assumenda et tempore ex. Vel quasi facilis eveniet repellat facere cupiditate sed rem.',1,0.0800,0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(20,3,'velit','dignissimos-est-enim-tenetur','Commodi quis sit eveniet accusamus dolor. Voluptatum cum veniam tempora blanditiis sit vero quo. Quo laudantium necessitatibus et pariatur nesciunt ut tempora. Hic velit rerum quis accusamus sed.',1,0.0800,0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(21,5,'consequatur','maxime-soluta-modi-eveniet-est','Molestias provident totam voluptatibus cumque. Fuga voluptas cupiditate voluptas sit sit incidunt aliquid libero. Temporibus ut ad sint pariatur eos. Sint sunt et aspernatur sapiente necessitatibus blanditiis tempora laborum.',1,0.0250,0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(22,4,'exercitationem','amet-quia-molestiae-ad-est-fac','Esse et soluta ab voluptatem odio dicta. A vel totam minus rerum harum consequatur autem. Adipisci rem dolores et. Velit in fugit doloribus numquam amet dolor temporibus.',1,0.0800,0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(23,6,'similique','omnis-sed-ullam-ut-deserunt-ma','Eaque ut distinctio quo. Est ratione rerum ipsa culpa voluptatem eos. Quia adipisci amet consequatur dolorum. Consequatur quasi perferendis provident dicta sed esse dolorum.',1,0.0250,0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(24,2,'et','exercitationem-velit-est-ipsa-','Natus aut est nesciunt aliquam aspernatur. Pariatur modi illo sit accusantium. Est quia sequi nostrum.',1,0.0250,0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(25,1,'eos','dolorem-qui-cupiditate-perspic','Error molestias rerum iusto quia. Eum molestiae optio doloribus. Est quidem dolores et magni voluptatem temporibus. Repellat officia ratione voluptatem similique qui ipsam itaque.',1,0.0250,0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(26,4,'et','aut-dignissimos-quia-repudiand','Sint nihil rerum in eaque. Modi optio qui ut nisi. Similique nulla et possimus deserunt.',1,0.0250,0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(27,4,'minima','cum-ut-et-eius-ut-et-vel-a','Ut vel eum quasi ut est molestiae error minus. Neque repudiandae quae non ad eos.\nVoluptatem sunt pariatur nulla. Dolor at soluta molestias autem sed et sunt. Velit aut sint voluptatibus ipsa ipsum omnis consequatur.',1,0.0800,0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(28,3,'expedita','sint-pariatur-in-eaque','Delectus doloribus perspiciatis aspernatur dolor ut. Est repudiandae quis modi quo maxime voluptates suscipit.',1,0.0250,0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(29,3,'quae','qui-nobis-asperiores-corporis-','Odit quo et omnis. Eaque dolorem beatae quasi ipsa vel. Ad voluptatem illum eum eligendi reprehenderit. Quas non et fugiat animi quibusdam labore.',1,0.0800,0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(30,3,'eaque','cumque-ullam-velit-ab-qui-minu','Perferendis dicta esse porro aut. Et et quia et enim dolor praesentium optio eveniet. Laborum sed nesciunt quisquam nihil magni eaque nostrum facere. Ipsam et id amet distinctio molestiae non. Sequi excepturi et deleniti asperiores quia.',1,0.0800,0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(31,6,'iure','nemo-vel-vel-sequi-aut-aliquam','Impedit aut aliquam nisi quia. Pariatur inventore impedit tempora non eos mollitia fugit. Provident non et necessitatibus sit repudiandae dolorum magnam.',1,0.0800,0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(32,4,'eaque','quasi-sit-nam-qui-id','Aliquam minima corporis aut sequi qui consectetur quo. Provident aperiam vel impedit quos. Nesciunt odit esse repellat aliquid animi. Quia error libero nostrum quas illum quia.',1,0.0250,0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(33,2,'qui','repellendus-dolor-vitae-illo-m','Consequatur commodi odit qui doloribus a. Et veritatis esse dolorem cumque sunt. Minus accusamus laudantium possimus laboriosam optio et.',0,0.0250,0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(34,1,'est','accusamus-optio-enim-in-eaque-','Quis voluptatem cum dicta quod totam nam. Vel quasi molestiae consequatur vero expedita autem.\nQuia velit quo impedit est. Praesentium sit quis dolorem. Voluptatum ut rerum excepturi a repellendus ex et praesentium. Eum sint dolorem in.',0,0.0250,0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(35,2,'tenetur','sit-tempora-excepturi-officiis','Ex reprehenderit eum consequatur cum quod. Dolores voluptatum esse pariatur et molestias. Iusto quia delectus consectetur eveniet maxime. Cupiditate consectetur at quam officia mollitia eum consequatur corporis.',1,0.0800,0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(36,6,'ducimus','sapiente-earum-quia-eius-quo-s','Soluta molestiae tempore et laboriosam sunt qui et. Tenetur qui nihil et. Voluptatum accusamus rem aut quia.',1,0.0250,0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(37,3,'aut','quae-voluptatem-est-beatae-ips','Id tempora quas modi fugit eius illo provident. Repellendus fuga aspernatur cupiditate. Deserunt est repellendus repellat rerum. Laboriosam qui quae voluptas earum placeat facilis sunt.',1,0.0800,0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(38,3,'provident','corporis-perspiciatis-aliquam-','Quis autem sequi debitis dolor error nobis placeat porro. Quidem dolor et explicabo dolor sunt. Sed excepturi accusamus consequuntur doloremque omnis quas. Deserunt perferendis odit eligendi repellat praesentium rerum est et.',1,0.0800,0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(39,5,'nesciunt','itaque-libero-maxime-sit-minus','Qui quas est molestiae nulla non earum sed. Consequatur possimus tenetur consequuntur laborum. Natus est impedit omnis sint explicabo exercitationem porro. Repudiandae recusandae quisquam ipsa veritatis.',1,0.0250,0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(40,1,'ducimus','excepturi-eos-ut-harum-et-aliq','Aut consequuntur vero praesentium incidunt ipsam quae. Mollitia voluptas architecto ipsa iure deserunt libero facilis. Voluptatibus consequatur rerum vitae consectetur vero enim inventore sed. Natus enim quis nemo aut voluptatem.',0,0.0800,0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(41,1,'ipsa','reiciendis-dolore-quo-molestia','Sed fuga ab quo temporibus. Ad non nisi fuga quia deleniti unde minima eaque. Doloremque nihil quia cum occaecati magnam hic expedita.',0,0.0800,0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(42,1,'qui','a-laboriosam-beatae-enim-sunt-','Vel repudiandae doloribus deserunt cumque. Reprehenderit dignissimos maxime et placeat. Nostrum sint quo nesciunt exercitationem vel et.',1,0.0250,0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(43,6,'voluptas','recusandae-repudiandae-molesti','Excepturi odit eius voluptatum officia reprehenderit eligendi totam temporibus. Et facilis dignissimos minima mollitia odit modi possimus eveniet. Culpa iste aliquid ipsam commodi blanditiis ipsam. Soluta dolore magni temporibus illum ex eveniet enim.',0,0.0250,0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(44,5,'sunt','maiores-et-aliquam-nihil-enim-','Modi natus hic aliquid corporis est eos aut. Non molestias aut ut et sunt consectetur laboriosam. Aliquid voluptatibus commodi vero sint dolores numquam temporibus. Quae earum nihil recusandae facere voluptatem similique.',0,0.0800,0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(45,1,'eligendi','voluptatem-pariatur-aut-et-vel','Iusto ipsa consectetur harum nemo laborum cupiditate sint sit. Facilis ut numquam vel tempore et eius fugit. Sunt sequi sed ad quibusdam sequi. Ea pariatur incidunt aspernatur impedit nisi.',1,0.0800,0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(46,1,'neque','saepe-quia-laboriosam-autem-do','Aut rem aut quia voluptatem velit accusantium hic. Ipsa recusandae odio rerum. Voluptatem debitis excepturi qui a voluptas. Corrupti totam non aliquid fuga velit sed id et.',0,0.0250,0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(47,1,'dignissimos','ullam-eligendi-fugit-fuga-numq','Officiis dolores dolor natus animi labore est nisi. Impedit aut est veniam dicta qui nihil. Et a corrupti quia aut.',1,0.0800,0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(48,4,'soluta','laudantium-vel-aspernatur-susc','Ab dolorum cupiditate provident autem omnis reiciendis. Et aut fugiat laborum maiores fuga dignissimos corporis ex. Iure nemo fugit sit nobis iure quae.',1,0.0800,0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(49,1,'et','voluptatibus-est-qui-enim-nequ','Fuga corporis suscipit dolores inventore eos tempore. Ullam voluptas et fugiat magni.\nAssumenda dolorum alias sit deserunt. Porro ullam ducimus molestias fuga et. Iste sunt aut ad molestiae officia ex.',1,0.0250,0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(50,4,'nam','facere-molestiae-nisi-et-ab','Perspiciatis similique temporibus odit quasi cum perspiciatis. Dolores tenetur ea adipisci molestiae et. Iusto mollitia sed id voluptates. Velit ut repellendus aliquam.',1,0.0800,0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(51,4,'expedita','neque-velit-veniam-modi','Deserunt sunt consequatur nihil cumque. Nihil quidem quia consectetur occaecati vero voluptatem. Consequatur alias voluptatem molestiae provident cupiditate. Quos dolorem perspiciatis odio.',1,0.0250,0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(52,2,'molestias','blanditiis-ex-incidunt-magnam','Tempora dolorum fugit maiores. Accusantium deleniti et deserunt debitis sunt qui. Molestiae quia optio sed placeat iusto illo. Qui aliquam voluptatem molestiae eum earum ullam. Ab dolor alias tempora quia qui.',1,0.0250,0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(53,4,'optio','ipsa-incidunt-debitis-iure-qui','Ducimus eos voluptate nemo omnis cum et. Fugiat eaque illo officia perspiciatis consectetur aut. Perspiciatis hic earum fugiat.\nSit rerum fuga accusamus praesentium a autem enim. Dicta qui et voluptatem eum. Esse sapiente debitis id.',0,0.0250,0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(54,3,'est','facere-et-ut-et-consequuntur','Et vero quo tempore commodi maiores est. Totam qui saepe modi qui aut. Dolorem quis placeat saepe ex. Aut maiores nihil saepe voluptatem.',1,0.0250,0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(55,2,'saepe','earum-nostrum-consequatur-ipsa','Voluptatum id molestiae aliquam et. Non quam sint quae animi eligendi quam. Accusamus eveniet quae atque eaque. Corrupti molestiae dolorem error facilis.',0,0.0250,0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(56,4,'explicabo','maiores-qui-expedita-excepturi','In sunt itaque reiciendis recusandae sit ad magnam distinctio. Laborum aperiam ducimus provident et dolorem aliquam. Autem facere minima eius sed qui sit. Aut voluptatem praesentium rerum reprehenderit dolorum non consequatur.',1,0.0800,0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(57,2,'consequatur','consectetur-aliquid-ad-nihil-q','Qui maiores vel quis. Quia voluptatem non explicabo qui reiciendis ut atque. Hic et ducimus nostrum sunt quasi. Sed nihil nostrum cupiditate provident aperiam.',1,0.0250,0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(58,4,'magnam','aut-est-pariatur-consequatur-e','Illum delectus dolores eius quibusdam laudantium. Enim explicabo consectetur nihil reprehenderit. Qui eum sed neque nulla.',1,0.0800,0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(59,2,'animi','ipsam-adipisci-ut-aut-odit-nih','At nam non nihil nostrum est doloribus dolor. Nam nobis eum temporibus tempore sit. Reiciendis voluptas consequatur placeat quod. Debitis fuga et vel velit illum nisi.',1,0.0800,0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(60,1,'beatae','enim-fugiat-est-ut-vero-unde-a','Numquam beatae omnis incidunt magnam expedita aut voluptas earum. Inventore dolor ipsam qui doloribus sed magnam iusto. Cum sed laborum rerum error hic. Debitis excepturi odit fugit fuga eos aliquam voluptate. Adipisci modi veritatis iste tempora.',1,0.0250,0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(61,5,'sunt','iusto-sed-quae-ea-porro-et-arc','Quam rerum quod voluptas iusto molestiae optio. Ut quisquam dolores doloremque unde eaque dolorum et. Magnam dolorem et doloribus ipsum. Hic ut cum nostrum corrupti qui dignissimos.',1,0.0250,0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(62,5,'sed','et-labore-quasi-perferendis-si','Fugiat est nemo quasi perferendis expedita. Dolores ad natus et et incidunt nesciunt voluptas. Tempore nobis saepe quo est vel.\nVeniam vero ea aut rem ipsum. Voluptas nam praesentium ratione deleniti et aut aliquam. Sed aliquam velit rerum in et.',0,0.0800,0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(63,4,'omnis','saepe-animi-optio-laborum-aut-','Aperiam sapiente molestias repudiandae ea. Reprehenderit ea aut tempora dolorum eveniet sunt. Ex sit quia saepe ullam corrupti molestiae natus assumenda. Aspernatur consequatur ullam nam est.',1,0.0250,0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(64,5,'fugiat','quas-repellendus-quam-sequi-fu','Eum porro ea recusandae autem laborum voluptatem dignissimos. Est voluptate et nesciunt est. Qui et quidem perspiciatis placeat. Id laborum facilis dicta incidunt et.',1,0.0800,0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(65,4,'rem','ex-non-amet-a-cum-aut-quam-quo','Possimus non id animi eius error nobis. Molestiae aut nihil aut. Sed ut unde nulla sed quas. Beatae modi accusamus qui qui accusantium.',1,0.0800,0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(66,6,'reiciendis','nesciunt-sit-et-cumque-molesti','Qui at quis numquam. Mollitia ea quisquam reprehenderit. Quasi doloribus voluptatum nemo sit est suscipit ut. Saepe hic voluptates vitae autem vero officia.',1,0.0800,0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(67,3,'consectetur','qui-a-voluptas-quia-labore-mag','Nobis eius perspiciatis quis voluptas. Et quam temporibus nostrum commodi dolorem. Culpa eos est ullam voluptatem molestiae.\nNon veniam quis itaque enim similique dolor. Rerum sit velit nesciunt iure.',1,0.0800,0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(68,5,'sunt','totam-a-rem-quia-unde-tempore-','Explicabo autem voluptatibus harum et est iusto perspiciatis consequatur. Minus qui sit beatae vero ut hic vero quidem. Aliquam culpa voluptas repudiandae iste atque.',1,0.0800,0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(69,5,'quo','enim-dolore-rerum-sint-dolores','Debitis dolores vel corrupti vel numquam at. Id provident assumenda deserunt aspernatur possimus illum quasi velit. Iste vitae id molestias accusamus necessitatibus possimus earum autem. Voluptatem ipsum voluptas est.',1,0.0250,0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(70,2,'voluptas','iste-cupiditate-nobis-quisquam','Quia ipsa enim voluptatem quas. Et ut ut tenetur optio et. Repellat qui rerum maxime qui quibusdam.',1,0.0250,0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(71,3,'quia','voluptates-et-earum-esse-sequi','Facere possimus et enim dolores dolor et ut reiciendis. Pariatur dolores nemo non consequatur. Dolor vitae non pariatur cupiditate.',1,0.0800,0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(72,3,'aut','suscipit-commodi-explicabo-rat','Quis tempore repellendus incidunt eum nihil voluptatem. Dignissimos rerum perspiciatis dolorem libero. Aspernatur aut iure perspiciatis quas ut voluptatem veritatis debitis.',1,0.0800,0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(73,5,'eveniet','qui-qui-excepturi-fugiat-sequi','Modi nulla nemo ea repudiandae aut corrupti dolores. Voluptatem commodi qui inventore sit vitae perferendis quia sit. Illo non hic quibusdam omnis et aliquam est. Suscipit fuga et porro dignissimos.',1,0.0250,0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(74,1,'sint','ut-amet-sit-quia-error-dolorem','Dolorem nam rerum vero porro. Cupiditate aut rerum quia voluptatum consequatur ea asperiores dolorem. Harum deserunt nulla quia enim iure eum. Accusantium impedit aliquam perferendis non consequuntur culpa suscipit.',1,0.0250,0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(75,1,'explicabo','suscipit-ex-aliquam-debitis','Consectetur possimus vel non ex. Tempore neque repellendus ut repellat nihil. Occaecati dolorem iure consectetur in.',1,0.0800,0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(76,5,'similique','inventore-nihil-corporis-eos-v','Consequatur et maiores sint architecto dolorum. Consequatur sint repudiandae asperiores odio in rerum. Libero delectus magni provident error omnis illum.',1,0.0800,0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(77,1,'soluta','nihil-illum-maiores-incidunt-a','Necessitatibus nesciunt tempore consequatur et magnam praesentium et explicabo. Distinctio totam adipisci consequatur quam. Odio illum dignissimos et incidunt eius rerum. Laudantium consequuntur aut magni in.',1,0.0800,0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(78,5,'consequuntur','doloremque-sint-inventore-prae','Nam voluptatem nemo aliquid natus error quasi. Voluptatum aut quis non quaerat sit nulla suscipit. Dignissimos asperiores rerum dolores ratione est aut id. Rerum quis cumque et sapiente et rerum velit.',1,0.0250,0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(79,4,'labore','exercitationem-porro-molestias','Et voluptas consequatur tempora nostrum. Tenetur enim eum ab qui reprehenderit quia ab. Nihil ab accusantium officia omnis eveniet architecto. Aut omnis fugit veniam ut eius rem.',1,0.0250,0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(80,4,'veniam','non-laborum-sit-voluptatum','Dolor repellendus blanditiis eos. Neque maxime vel qui debitis. Enim aliquam ratione iste omnis ut similique est.',1,0.0250,0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(81,5,'quo','facilis-occaecati-consequatur-','Voluptates laborum aut ratione cum autem ipsum. Praesentium ut culpa nesciunt omnis eligendi expedita beatae. At asperiores enim aliquam nihil omnis possimus. Quam pariatur ut reiciendis esse. Laborum enim natus enim nam a dolorum necessitatibus.',1,0.0800,0,'2017-03-16 14:29:59','2017-03-16 14:29:59');
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
INSERT INTO `settings` VALUES (1,1,'activity','/etc/defaults/timeslice','action:byName:Zivi*','2017-03-16 14:29:59','2017-03-16 14:29:59'),(2,1,'value','/etc/defaults/timeslice','30240','2017-03-16 14:29:59','2017-03-16 14:29:59'),(3,1,'startedAt','/etc/defaults/timeslice','action:nextDate','2017-03-16 14:29:59','2017-03-16 14:29:59'),(4,3,'name','/etc/defaults/1','New perspiciatis','2017-03-16 14:29:59','2017-03-16 14:29:59'),(5,1,'name','/etc/defaults/2','New dolor','2017-03-16 14:29:59','2017-03-16 14:29:59'),(6,5,'name','/etc/defaults/3','New molestias','2017-03-16 14:29:59','2017-03-16 14:29:59'),(7,3,'name','/etc/defaults/4','New in','2017-03-16 14:29:59','2017-03-16 14:29:59'),(8,5,'name','/etc/defaults/5','New qui','2017-03-16 14:29:59','2017-03-16 14:29:59');
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
INSERT INTO `standard_discounts` VALUES (1,1,'Skonto 2%',0.02,1,1,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(2,1,'Flat Rate 10 CHF',10.00,0,1,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(3,1,'Flat Rate 11 CHF',11.00,0,1,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(4,1,'Flat Rate 12 CHF',12.00,0,1,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(5,1,'Flat Rate 13 CHF',13.00,0,1,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(6,1,'Flat Rate 14 CHF',14.00,0,1,'2017-03-16 14:29:59','2017-03-16 14:29:59');
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
INSERT INTO `tags` VALUES (1,NULL,'perspiciatis',0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(2,NULL,'voluptas',0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(3,NULL,'dolor',0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(4,NULL,'veritatis',0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(5,NULL,'molestias',0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(6,NULL,'est',0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(7,NULL,'in',0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(8,NULL,'sed',0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(9,NULL,'qui',0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(10,NULL,'officiis',0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(11,NULL,'perspiciatis',0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(12,NULL,'velit',0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(13,NULL,'possimus',0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(14,NULL,'cum',0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(15,NULL,'ducimus',0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(16,NULL,'vitae',0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(17,NULL,'quam',0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(18,NULL,'omnis',0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(19,NULL,'ea',0,'2017-03-16 14:29:59','2017-03-16 14:29:59'),(20,NULL,'dolores',0,'2017-03-16 14:29:59','2017-03-16 14:29:59');
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
  CONSTRAINT `FK_4231EEB9BAD26311` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_4231EEB94FB5678C` FOREIGN KEY (`timeslice_id`) REFERENCES `timeslices` (`id`) ON DELETE CASCADE
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
  PRIMARY KEY (`id`),
  KEY `IDX_72C53BF481C06096` (`activity_id`),
  KEY `IDX_72C53BF48C03F15C` (`employee_id`),
  KEY `IDX_72C53BF4A76ED395` (`user_id`),
  CONSTRAINT `FK_72C53BF4A76ED395` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_72C53BF481C06096` FOREIGN KEY (`activity_id`) REFERENCES `activities` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_72C53BF48C03F15C` FOREIGN KEY (`employee_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=402 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `timeslices`
--

LOCK TABLES `timeslices` WRITE;
/*!40000 ALTER TABLE `timeslices` DISABLE KEYS */;
INSERT INTO `timeslices` VALUES (1,2,7,2,7200.0000,'2017-01-20 17:58:04','2017-01-20 19:58:04','2017-03-16 14:29:59','2017-03-16 14:29:59'),(2,4,7,4,3.3000,'2015-10-07 01:07:59','2015-10-07 01:08:02','2017-03-16 14:29:59','2017-03-16 14:29:59'),(3,5,16,5,3.5000,'2015-06-13 20:08:19','2015-06-13 20:08:22','2017-03-16 14:29:59','2017-03-16 14:29:59'),(4,10,22,4,2.3000,'2016-07-28 19:20:11','2016-07-28 19:20:13','2017-03-16 14:29:59','2017-03-16 14:29:59'),(5,8,19,4,7.2000,'2015-12-13 13:53:18','2015-12-13 13:53:25','2017-03-16 14:29:59','2017-03-16 14:29:59'),(6,2,11,2,7.3000,'2015-01-10 07:57:21','2015-01-10 07:57:28','2017-03-16 14:29:59','2017-03-16 14:29:59'),(7,6,22,5,1.7000,'2015-03-28 12:20:32','2015-03-28 12:20:33','2017-03-16 14:29:59','2017-03-16 14:29:59'),(8,5,9,3,4.7000,'2016-04-12 02:49:22','2016-04-12 02:49:26','2017-03-16 14:29:59','2017-03-16 14:29:59'),(9,8,18,5,1.2000,'2016-05-08 19:39:23','2016-05-08 19:39:24','2017-03-16 14:29:59','2017-03-16 14:29:59'),(10,8,14,4,3.3000,'2014-12-25 19:08:08','2014-12-25 19:08:11','2017-03-16 14:29:59','2017-03-16 14:29:59'),(11,11,13,5,8.3000,'2015-02-28 08:00:43','2015-02-28 08:00:51','2017-03-16 14:29:59','2017-03-16 14:29:59'),(12,8,18,1,4.6000,'2014-09-29 23:39:33','2014-09-29 23:39:37','2017-03-16 14:29:59','2017-03-16 14:29:59'),(13,3,25,1,5.3000,'2014-08-04 08:36:23','2014-08-04 08:36:28','2017-03-16 14:29:59','2017-03-16 14:29:59'),(14,10,25,6,2.0000,'2015-11-19 21:05:12','2015-11-19 21:05:14','2017-03-16 14:29:59','2017-03-16 14:29:59'),(15,3,19,2,5.8000,'2016-02-22 12:25:49','2016-02-22 12:25:54','2017-03-16 14:29:59','2017-03-16 14:29:59'),(16,7,18,5,1.9000,'2015-07-13 18:32:42','2015-07-13 18:32:43','2017-03-16 14:29:59','2017-03-16 14:29:59'),(17,9,14,2,5.8000,'2016-02-04 19:12:21','2016-02-04 19:12:26','2017-03-16 14:29:59','2017-03-16 14:29:59'),(18,4,23,2,2.0000,'2016-09-21 04:08:20','2016-09-21 04:08:22','2017-03-16 14:29:59','2017-03-16 14:29:59'),(19,11,21,6,5.1000,'2016-09-01 01:55:34','2016-09-01 01:55:39','2017-03-16 14:29:59','2017-03-16 14:29:59'),(20,9,9,5,3.4000,'2015-12-19 11:30:28','2015-12-19 11:30:31','2017-03-16 14:29:59','2017-03-16 14:29:59'),(21,6,22,5,6.3000,'2014-12-07 19:47:46','2014-12-07 19:47:52','2017-03-16 14:29:59','2017-03-16 14:29:59'),(22,11,13,2,5.9000,'2015-01-01 10:24:49','2015-01-01 10:24:54','2017-03-16 14:29:59','2017-03-16 14:29:59'),(23,5,12,2,6.5000,'2016-07-15 10:36:13','2016-07-15 10:36:19','2017-03-16 14:29:59','2017-03-16 14:29:59'),(24,11,17,6,2.3000,'2014-07-23 10:54:48','2014-07-23 10:54:50','2017-03-16 14:29:59','2017-03-16 14:29:59'),(25,10,10,1,7.4000,'2014-09-03 07:14:48','2014-09-03 07:14:55','2017-03-16 14:29:59','2017-03-16 14:29:59'),(26,2,26,6,4.2000,'2015-09-01 14:41:37','2015-09-01 14:41:41','2017-03-16 14:29:59','2017-03-16 14:29:59'),(27,7,17,6,1.6000,'2014-07-21 23:19:58','2014-07-21 23:19:59','2017-03-16 14:29:59','2017-03-16 14:29:59'),(28,9,26,3,5.4000,'2014-10-28 07:31:34','2014-10-28 07:31:39','2017-03-16 14:29:59','2017-03-16 14:29:59'),(29,3,8,2,2.2000,'2015-01-02 17:49:52','2015-01-02 17:49:54','2017-03-16 14:29:59','2017-03-16 14:29:59'),(30,3,25,5,2.3000,'2017-03-02 15:55:28','2017-03-02 15:55:30','2017-03-16 14:29:59','2017-03-16 14:29:59'),(31,7,24,4,5.8000,'2015-10-13 08:09:37','2015-10-13 08:09:42','2017-03-16 14:29:59','2017-03-16 14:29:59'),(32,4,9,4,2.5000,'2016-10-21 17:42:07','2016-10-21 17:42:09','2017-03-16 14:29:59','2017-03-16 14:29:59'),(33,8,26,4,3.2000,'2014-06-26 14:58:53','2014-06-26 14:58:56','2017-03-16 14:29:59','2017-03-16 14:29:59'),(34,3,11,4,8.0000,'2014-07-10 18:59:29','2014-07-10 18:59:37','2017-03-16 14:29:59','2017-03-16 14:29:59'),(35,11,11,1,7.4000,'2016-08-29 12:01:30','2016-08-29 12:01:37','2017-03-16 14:29:59','2017-03-16 14:29:59'),(36,5,24,1,8.4000,'2017-02-13 04:21:32','2017-02-13 04:21:40','2017-03-16 14:29:59','2017-03-16 14:29:59'),(37,11,23,5,5.6000,'2016-05-19 05:43:58','2016-05-19 05:44:03','2017-03-16 14:29:59','2017-03-16 14:29:59'),(38,7,9,3,2.0000,'2014-07-13 08:41:35','2014-07-13 08:41:37','2017-03-16 14:29:59','2017-03-16 14:29:59'),(39,5,23,1,2.5000,'2015-11-05 05:32:55','2015-11-05 05:32:57','2017-03-16 14:29:59','2017-03-16 14:29:59'),(40,2,26,5,3.4000,'2014-07-06 20:54:32','2014-07-06 20:54:35','2017-03-16 14:29:59','2017-03-16 14:29:59'),(41,7,8,5,3.1000,'2017-01-14 16:32:42','2017-01-14 16:32:45','2017-03-16 14:29:59','2017-03-16 14:29:59'),(42,10,18,1,2.5000,'2016-07-05 02:46:12','2016-07-05 02:46:14','2017-03-16 14:29:59','2017-03-16 14:29:59'),(43,7,15,5,4.8000,'2015-09-06 09:03:47','2015-09-06 09:03:51','2017-03-16 14:29:59','2017-03-16 14:29:59'),(44,6,8,6,5.5000,'2016-12-02 03:26:12','2016-12-02 03:26:17','2017-03-16 14:29:59','2017-03-16 14:29:59'),(45,2,10,3,2.1000,'2016-12-17 02:54:31','2016-12-17 02:54:33','2017-03-16 14:29:59','2017-03-16 14:29:59'),(46,10,26,3,6.0000,'2016-10-25 21:04:16','2016-10-25 21:04:22','2017-03-16 14:29:59','2017-03-16 14:29:59'),(47,6,23,3,6.3000,'2017-01-28 11:24:11','2017-01-28 11:24:17','2017-03-16 14:29:59','2017-03-16 14:29:59'),(48,9,10,6,8.1000,'2017-02-17 09:28:38','2017-02-17 09:28:46','2017-03-16 14:29:59','2017-03-16 14:29:59'),(49,2,19,1,2.4000,'2014-12-09 15:58:03','2014-12-09 15:58:05','2017-03-16 14:29:59','2017-03-16 14:29:59'),(50,9,10,3,7.1000,'2014-08-27 01:10:17','2014-08-27 01:10:24','2017-03-16 14:29:59','2017-03-16 14:29:59'),(51,9,16,6,6.4000,'2017-02-01 12:54:02','2017-02-01 12:54:08','2017-03-16 14:29:59','2017-03-16 14:29:59'),(52,5,17,3,5.6000,'2016-10-14 04:33:23','2016-10-14 04:33:28','2017-03-16 14:29:59','2017-03-16 14:29:59'),(53,10,11,2,3.8000,'2015-05-30 08:56:23','2015-05-30 08:56:26','2017-03-16 14:29:59','2017-03-16 14:29:59'),(54,3,19,2,6.8000,'2015-09-14 18:53:38','2015-09-14 18:53:44','2017-03-16 14:29:59','2017-03-16 14:29:59'),(55,2,24,6,1.8000,'2017-01-30 07:14:52','2017-01-30 07:14:53','2017-03-16 14:29:59','2017-03-16 14:29:59'),(56,9,8,5,6.3000,'2014-11-30 12:50:44','2014-11-30 12:50:50','2017-03-16 14:29:59','2017-03-16 14:29:59'),(57,9,23,3,3.0000,'2016-10-14 13:33:30','2016-10-14 13:33:33','2017-03-16 14:29:59','2017-03-16 14:29:59'),(58,9,16,3,7.0000,'2016-07-12 10:48:52','2016-07-12 10:48:59','2017-03-16 14:29:59','2017-03-16 14:29:59'),(59,8,23,1,3.9000,'2015-08-26 08:51:10','2015-08-26 08:51:13','2017-03-16 14:29:59','2017-03-16 14:29:59'),(60,6,16,5,1.3000,'2016-09-20 12:24:52','2016-09-20 12:24:53','2017-03-16 14:29:59','2017-03-16 14:29:59'),(61,7,22,2,4.6000,'2016-06-11 17:52:42','2016-06-11 17:52:46','2017-03-16 14:29:59','2017-03-16 14:29:59'),(62,9,19,1,2.4000,'2016-07-21 04:18:09','2016-07-21 04:18:11','2017-03-16 14:29:59','2017-03-16 14:29:59'),(63,3,9,4,6.1000,'2015-08-29 11:30:13','2015-08-29 11:30:19','2017-03-16 14:29:59','2017-03-16 14:29:59'),(64,3,22,6,3.1000,'2016-09-20 08:17:12','2016-09-20 08:17:15','2017-03-16 14:29:59','2017-03-16 14:29:59'),(65,2,18,5,5.0000,'2016-04-22 19:29:24','2016-04-22 19:29:29','2017-03-16 14:29:59','2017-03-16 14:29:59'),(66,2,24,2,3.1000,'2015-04-06 12:24:15','2015-04-06 12:24:18','2017-03-16 14:29:59','2017-03-16 14:29:59'),(67,6,24,4,7.8000,'2016-05-31 04:40:08','2016-05-31 04:40:15','2017-03-16 14:29:59','2017-03-16 14:29:59'),(68,4,15,1,7.5000,'2016-08-21 10:29:02','2016-08-21 10:29:09','2017-03-16 14:29:59','2017-03-16 14:29:59'),(69,4,25,2,7.2000,'2016-07-01 10:52:30','2016-07-01 10:52:37','2017-03-16 14:29:59','2017-03-16 14:29:59'),(70,9,19,5,3.9000,'2015-07-24 05:17:47','2015-07-24 05:17:50','2017-03-16 14:29:59','2017-03-16 14:29:59'),(71,11,14,6,1.6000,'2016-11-16 14:43:33','2016-11-16 14:43:34','2017-03-16 14:29:59','2017-03-16 14:29:59'),(72,7,12,3,4.5000,'2015-04-06 04:10:28','2015-04-06 04:10:32','2017-03-16 14:29:59','2017-03-16 14:29:59'),(73,8,24,6,3.4000,'2017-02-11 04:24:13','2017-02-11 04:24:16','2017-03-16 14:29:59','2017-03-16 14:29:59'),(74,11,25,2,7.6000,'2016-08-04 03:54:08','2016-08-04 03:54:15','2017-03-16 14:29:59','2017-03-16 14:29:59'),(75,3,25,6,2.1000,'2016-09-27 12:39:40','2016-09-27 12:39:42','2017-03-16 14:29:59','2017-03-16 14:29:59'),(76,3,10,1,1.3000,'2014-11-27 07:19:01','2014-11-27 07:19:02','2017-03-16 14:29:59','2017-03-16 14:29:59'),(77,5,7,3,4.0000,'2016-10-11 13:14:31','2016-10-11 13:14:35','2017-03-16 14:29:59','2017-03-16 14:29:59'),(78,10,19,5,7.9000,'2016-02-11 23:11:27','2016-02-11 23:11:34','2017-03-16 14:29:59','2017-03-16 14:29:59'),(79,10,18,4,6.1000,'2016-07-12 12:27:45','2016-07-12 12:27:51','2017-03-16 14:29:59','2017-03-16 14:29:59'),(80,8,26,3,3.1000,'2016-11-20 17:35:09','2016-11-20 17:35:12','2017-03-16 14:29:59','2017-03-16 14:29:59'),(81,9,7,3,5.6000,'2016-07-19 06:54:27','2016-07-19 06:54:32','2017-03-16 14:29:59','2017-03-16 14:29:59'),(82,6,24,4,1.5000,'2016-10-11 04:37:41','2016-10-11 04:37:42','2017-03-16 14:29:59','2017-03-16 14:29:59'),(83,7,15,3,4.8000,'2016-06-12 16:09:57','2016-06-12 16:10:01','2017-03-16 14:29:59','2017-03-16 14:29:59'),(84,8,24,2,8.0000,'2017-03-12 11:40:37','2017-03-12 11:40:45','2017-03-16 14:29:59','2017-03-16 14:29:59'),(85,11,24,3,6.0000,'2014-10-01 11:31:36','2014-10-01 11:31:42','2017-03-16 14:29:59','2017-03-16 14:29:59'),(86,2,21,4,5.9000,'2014-11-22 03:59:21','2014-11-22 03:59:26','2017-03-16 14:29:59','2017-03-16 14:29:59'),(87,11,25,5,4.6000,'2016-08-08 15:23:01','2016-08-08 15:23:05','2017-03-16 14:29:59','2017-03-16 14:29:59'),(88,6,10,3,2.2000,'2016-02-22 23:22:53','2016-02-22 23:22:55','2017-03-16 14:29:59','2017-03-16 14:29:59'),(89,11,16,2,4.0000,'2016-05-23 17:27:38','2016-05-23 17:27:42','2017-03-16 14:29:59','2017-03-16 14:29:59'),(90,5,22,1,2.1000,'2016-12-07 13:10:20','2016-12-07 13:10:22','2017-03-16 14:29:59','2017-03-16 14:29:59'),(91,7,21,3,2.7000,'2017-02-27 11:19:17','2017-02-27 11:19:19','2017-03-16 14:29:59','2017-03-16 14:29:59'),(92,11,21,3,6.0000,'2016-06-25 23:07:24','2016-06-25 23:07:30','2017-03-16 14:29:59','2017-03-16 14:29:59'),(93,2,13,5,4.9000,'2014-10-01 11:55:18','2014-10-01 11:55:22','2017-03-16 14:29:59','2017-03-16 14:29:59'),(94,7,12,2,6.8000,'2014-11-20 13:16:48','2014-11-20 13:16:54','2017-03-16 14:29:59','2017-03-16 14:29:59'),(95,3,7,2,7.6000,'2015-03-26 07:11:25','2015-03-26 07:11:32','2017-03-16 14:29:59','2017-03-16 14:29:59'),(96,10,18,3,2.9000,'2016-11-08 05:45:54','2016-11-08 05:45:56','2017-03-16 14:29:59','2017-03-16 14:29:59'),(97,2,19,3,1.9000,'2015-06-18 17:29:43','2015-06-18 17:29:44','2017-03-16 14:29:59','2017-03-16 14:29:59'),(98,9,15,3,2.5000,'2016-07-29 17:06:30','2016-07-29 17:06:32','2017-03-16 14:29:59','2017-03-16 14:29:59'),(99,9,13,6,6.8000,'2016-05-29 16:03:28','2016-05-29 16:03:34','2017-03-16 14:29:59','2017-03-16 14:29:59'),(100,5,21,2,2.3000,'2016-10-12 04:55:37','2016-10-12 04:55:39','2017-03-16 14:29:59','2017-03-16 14:29:59'),(101,11,23,5,5.1000,'2016-12-15 14:37:28','2016-12-15 14:37:33','2017-03-16 14:29:59','2017-03-16 14:29:59'),(102,21,19,4,30240.0000,'2016-10-19 19:54:52','2016-10-20 04:18:52','2017-03-16 14:29:59','2017-03-16 14:29:59'),(103,16,18,6,30240.0000,'2016-08-04 22:58:28','2016-08-05 07:22:28','2017-03-16 14:29:59','2017-03-16 14:29:59'),(104,15,11,4,30240.0000,'2015-12-12 15:42:36','2015-12-13 00:06:36','2017-03-16 14:29:59','2017-03-16 14:29:59'),(105,15,9,4,30240.0000,'2015-07-30 16:00:19','2015-07-31 00:24:19','2017-03-16 14:29:59','2017-03-16 14:29:59'),(106,13,23,1,30240.0000,'2017-02-23 01:33:55','2017-02-23 09:57:55','2017-03-16 14:29:59','2017-03-16 14:29:59'),(107,16,15,3,30240.0000,'2015-04-28 01:31:07','2015-04-28 09:55:07','2017-03-16 14:29:59','2017-03-16 14:29:59'),(108,17,16,2,30240.0000,'2016-03-15 01:45:52','2016-03-15 10:09:52','2017-03-16 14:29:59','2017-03-16 14:29:59'),(109,21,16,5,30240.0000,'2016-09-08 03:17:14','2016-09-08 11:41:14','2017-03-16 14:29:59','2017-03-16 14:29:59'),(110,14,13,5,30240.0000,'2015-10-16 20:51:20','2015-10-17 05:15:20','2017-03-16 14:29:59','2017-03-16 14:29:59'),(111,15,19,6,30240.0000,'2015-03-13 09:39:20','2015-03-13 18:03:20','2017-03-16 14:29:59','2017-03-16 14:29:59'),(112,12,8,1,30240.0000,'2015-09-08 03:58:58','2015-09-08 12:22:58','2017-03-16 14:29:59','2017-03-16 14:29:59'),(113,14,24,3,30240.0000,'2016-07-25 22:10:54','2016-07-26 06:34:54','2017-03-16 14:29:59','2017-03-16 14:29:59'),(114,16,22,5,30240.0000,'2016-01-04 01:49:24','2016-01-04 10:13:24','2017-03-16 14:29:59','2017-03-16 14:29:59'),(115,13,20,2,30240.0000,'2015-12-07 09:35:53','2015-12-07 17:59:53','2017-03-16 14:29:59','2017-03-16 14:29:59'),(116,17,16,5,30240.0000,'2014-07-29 06:48:23','2014-07-29 15:12:23','2017-03-16 14:29:59','2017-03-16 14:29:59'),(117,20,18,1,30240.0000,'2014-08-11 05:37:41','2014-08-11 14:01:41','2017-03-16 14:29:59','2017-03-16 14:29:59'),(118,13,13,6,30240.0000,'2017-03-14 13:47:44','2017-03-14 22:11:44','2017-03-16 14:29:59','2017-03-16 14:29:59'),(119,21,13,6,30240.0000,'2015-04-24 22:49:51','2015-04-25 07:13:51','2017-03-16 14:29:59','2017-03-16 14:29:59'),(120,19,11,1,30240.0000,'2014-08-18 22:49:35','2014-08-19 07:13:35','2017-03-16 14:29:59','2017-03-16 14:29:59'),(121,15,7,1,30240.0000,'2014-10-03 11:58:05','2014-10-03 20:22:05','2017-03-16 14:29:59','2017-03-16 14:29:59'),(122,19,21,2,30240.0000,'2016-11-20 01:04:07','2016-11-20 09:28:07','2017-03-16 14:29:59','2017-03-16 14:29:59'),(123,18,12,2,30240.0000,'2017-01-26 14:45:04','2017-01-26 23:09:04','2017-03-16 14:29:59','2017-03-16 14:29:59'),(124,19,21,4,30240.0000,'2015-02-23 21:50:50','2015-02-24 06:14:50','2017-03-16 14:29:59','2017-03-16 14:29:59'),(125,13,8,1,30240.0000,'2014-10-09 19:09:50','2014-10-10 03:33:50','2017-03-16 14:29:59','2017-03-16 14:29:59'),(126,20,26,1,30240.0000,'2016-12-14 13:24:43','2016-12-14 21:48:43','2017-03-16 14:29:59','2017-03-16 14:29:59'),(127,18,25,5,30240.0000,'2016-10-14 13:34:39','2016-10-14 21:58:39','2017-03-16 14:29:59','2017-03-16 14:29:59'),(128,19,8,4,30240.0000,'2014-11-07 08:55:38','2014-11-07 17:19:38','2017-03-16 14:29:59','2017-03-16 14:29:59'),(129,21,15,2,30240.0000,'2016-07-20 18:45:16','2016-07-21 03:09:16','2017-03-16 14:29:59','2017-03-16 14:29:59'),(130,21,13,3,30240.0000,'2016-04-02 06:36:56','2016-04-02 15:00:56','2017-03-16 14:29:59','2017-03-16 14:29:59'),(131,17,19,4,30240.0000,'2016-05-20 14:28:18','2016-05-20 22:52:18','2017-03-16 14:29:59','2017-03-16 14:29:59'),(132,12,19,4,30240.0000,'2016-11-26 18:43:35','2016-11-27 03:07:35','2017-03-16 14:29:59','2017-03-16 14:29:59'),(133,18,16,3,30240.0000,'2014-10-22 23:02:36','2014-10-23 07:26:36','2017-03-16 14:29:59','2017-03-16 14:29:59'),(134,16,12,4,30240.0000,'2015-03-15 23:03:58','2015-03-16 07:27:58','2017-03-16 14:29:59','2017-03-16 14:29:59'),(135,17,11,6,30240.0000,'2016-09-21 01:08:10','2016-09-21 09:32:10','2017-03-16 14:29:59','2017-03-16 14:29:59'),(136,15,22,3,30240.0000,'2015-05-01 06:27:09','2015-05-01 14:51:09','2017-03-16 14:29:59','2017-03-16 14:29:59'),(137,20,7,3,30240.0000,'2015-05-19 15:54:39','2015-05-20 00:18:39','2017-03-16 14:29:59','2017-03-16 14:29:59'),(138,12,21,4,30240.0000,'2014-08-06 22:59:41','2014-08-07 07:23:41','2017-03-16 14:29:59','2017-03-16 14:29:59'),(139,12,19,6,30240.0000,'2014-11-14 01:25:01','2014-11-14 09:49:01','2017-03-16 14:29:59','2017-03-16 14:29:59'),(140,12,15,5,30240.0000,'2015-04-05 08:12:01','2015-04-05 16:36:01','2017-03-16 14:29:59','2017-03-16 14:29:59'),(141,19,12,5,30240.0000,'2015-10-23 16:06:17','2015-10-24 00:30:17','2017-03-16 14:29:59','2017-03-16 14:29:59'),(142,15,10,6,30240.0000,'2016-02-01 17:01:49','2016-02-02 01:25:49','2017-03-16 14:29:59','2017-03-16 14:29:59'),(143,21,24,5,30240.0000,'2016-06-17 23:38:51','2016-06-18 08:02:51','2017-03-16 14:29:59','2017-03-16 14:29:59'),(144,13,18,5,30240.0000,'2016-07-02 12:10:45','2016-07-02 20:34:45','2017-03-16 14:29:59','2017-03-16 14:29:59'),(145,13,13,4,30240.0000,'2016-02-25 23:20:28','2016-02-26 07:44:28','2017-03-16 14:29:59','2017-03-16 14:29:59'),(146,16,21,6,30240.0000,'2014-10-07 07:55:48','2014-10-07 16:19:48','2017-03-16 14:29:59','2017-03-16 14:29:59'),(147,12,10,6,30240.0000,'2015-02-12 21:39:39','2015-02-13 06:03:39','2017-03-16 14:29:59','2017-03-16 14:29:59'),(148,15,23,3,30240.0000,'2014-09-30 11:32:56','2014-09-30 19:56:56','2017-03-16 14:29:59','2017-03-16 14:29:59'),(149,18,17,1,30240.0000,'2014-11-26 22:56:01','2014-11-27 07:20:01','2017-03-16 14:29:59','2017-03-16 14:29:59'),(150,20,9,6,30240.0000,'2017-02-04 23:12:40','2017-02-05 07:36:40','2017-03-16 14:29:59','2017-03-16 14:29:59'),(151,15,12,1,30240.0000,'2014-07-11 16:22:36','2014-07-12 00:46:36','2017-03-16 14:29:59','2017-03-16 14:29:59'),(152,21,21,5,30240.0000,'2014-10-21 18:44:54','2014-10-22 03:08:54','2017-03-16 14:29:59','2017-03-16 14:29:59'),(153,20,20,2,30240.0000,'2015-02-04 22:53:09','2015-02-05 07:17:09','2017-03-16 14:29:59','2017-03-16 14:29:59'),(154,16,22,5,30240.0000,'2014-09-05 18:34:08','2014-09-06 02:58:08','2017-03-16 14:29:59','2017-03-16 14:29:59'),(155,20,8,6,30240.0000,'2016-03-08 03:30:59','2016-03-08 11:54:59','2017-03-16 14:29:59','2017-03-16 14:29:59'),(156,18,24,5,30240.0000,'2016-06-18 10:04:46','2016-06-18 18:28:46','2017-03-16 14:29:59','2017-03-16 14:29:59'),(157,14,19,3,30240.0000,'2014-12-31 22:10:27','2015-01-01 06:34:27','2017-03-16 14:29:59','2017-03-16 14:29:59'),(158,21,22,4,30240.0000,'2016-09-01 08:06:51','2016-09-01 16:30:51','2017-03-16 14:29:59','2017-03-16 14:29:59'),(159,13,25,4,30240.0000,'2015-03-10 12:22:22','2015-03-10 20:46:22','2017-03-16 14:29:59','2017-03-16 14:29:59'),(160,12,8,3,30240.0000,'2014-09-03 19:31:04','2014-09-04 03:55:04','2017-03-16 14:29:59','2017-03-16 14:29:59'),(161,12,24,6,30240.0000,'2015-01-26 21:29:40','2015-01-27 05:53:40','2017-03-16 14:29:59','2017-03-16 14:29:59'),(162,19,16,4,30240.0000,'2016-07-26 04:02:03','2016-07-26 12:26:03','2017-03-16 14:29:59','2017-03-16 14:29:59'),(163,13,13,4,30240.0000,'2016-03-17 01:03:27','2016-03-17 09:27:27','2017-03-16 14:29:59','2017-03-16 14:29:59'),(164,14,17,4,30240.0000,'2015-02-08 19:30:02','2015-02-09 03:54:02','2017-03-16 14:29:59','2017-03-16 14:29:59'),(165,21,24,5,30240.0000,'2017-03-03 19:06:16','2017-03-04 03:30:16','2017-03-16 14:29:59','2017-03-16 14:29:59'),(166,15,11,4,30240.0000,'2015-04-03 22:51:41','2015-04-04 07:15:41','2017-03-16 14:29:59','2017-03-16 14:29:59'),(167,12,20,4,30240.0000,'2015-04-09 01:30:42','2015-04-09 09:54:42','2017-03-16 14:29:59','2017-03-16 14:29:59'),(168,15,25,5,30240.0000,'2014-07-24 04:14:03','2014-07-24 12:38:03','2017-03-16 14:29:59','2017-03-16 14:29:59'),(169,17,9,2,30240.0000,'2015-09-12 23:09:33','2015-09-13 07:33:33','2017-03-16 14:29:59','2017-03-16 14:29:59'),(170,16,8,6,30240.0000,'2016-12-10 09:03:26','2016-12-10 17:27:26','2017-03-16 14:29:59','2017-03-16 14:29:59'),(171,18,15,6,30240.0000,'2015-09-15 08:22:19','2015-09-15 16:46:19','2017-03-16 14:29:59','2017-03-16 14:29:59'),(172,20,26,2,30240.0000,'2016-10-08 18:36:11','2016-10-09 03:00:11','2017-03-16 14:29:59','2017-03-16 14:29:59'),(173,12,24,5,30240.0000,'2015-03-27 15:38:56','2015-03-28 00:02:56','2017-03-16 14:29:59','2017-03-16 14:29:59'),(174,20,16,4,30240.0000,'2016-01-10 06:09:35','2016-01-10 14:33:35','2017-03-16 14:29:59','2017-03-16 14:29:59'),(175,14,9,6,30240.0000,'2016-04-10 16:37:32','2016-04-11 01:01:32','2017-03-16 14:29:59','2017-03-16 14:29:59'),(176,15,14,5,30240.0000,'2014-10-14 03:07:36','2014-10-14 11:31:36','2017-03-16 14:29:59','2017-03-16 14:29:59'),(177,16,24,1,30240.0000,'2015-11-20 11:57:55','2015-11-20 20:21:55','2017-03-16 14:29:59','2017-03-16 14:29:59'),(178,14,23,4,30240.0000,'2015-02-21 09:43:21','2015-02-21 18:07:21','2017-03-16 14:29:59','2017-03-16 14:29:59'),(179,14,17,3,30240.0000,'2016-09-15 05:16:42','2016-09-15 13:40:42','2017-03-16 14:29:59','2017-03-16 14:29:59'),(180,17,23,6,30240.0000,'2015-12-10 10:38:13','2015-12-10 19:02:13','2017-03-16 14:29:59','2017-03-16 14:29:59'),(181,14,23,3,30240.0000,'2015-01-21 18:32:53','2015-01-22 02:56:53','2017-03-16 14:29:59','2017-03-16 14:29:59'),(182,15,17,1,30240.0000,'2015-04-05 21:21:04','2015-04-06 05:45:04','2017-03-16 14:29:59','2017-03-16 14:29:59'),(183,18,11,6,30240.0000,'2016-05-07 22:17:20','2016-05-08 06:41:20','2017-03-16 14:29:59','2017-03-16 14:29:59'),(184,18,9,1,30240.0000,'2015-02-25 17:22:59','2015-02-26 01:46:59','2017-03-16 14:29:59','2017-03-16 14:29:59'),(185,18,23,4,30240.0000,'2014-08-27 16:18:01','2014-08-28 00:42:01','2017-03-16 14:29:59','2017-03-16 14:29:59'),(186,13,21,1,30240.0000,'2015-02-11 03:26:54','2015-02-11 11:50:54','2017-03-16 14:29:59','2017-03-16 14:29:59'),(187,18,23,5,30240.0000,'2016-12-12 10:47:59','2016-12-12 19:11:59','2017-03-16 14:29:59','2017-03-16 14:29:59'),(188,18,20,5,30240.0000,'2016-08-06 11:48:34','2016-08-06 20:12:34','2017-03-16 14:29:59','2017-03-16 14:29:59'),(189,15,25,2,30240.0000,'2016-02-16 15:06:11','2016-02-16 23:30:11','2017-03-16 14:29:59','2017-03-16 14:29:59'),(190,19,19,4,30240.0000,'2015-03-18 09:02:31','2015-03-18 17:26:31','2017-03-16 14:29:59','2017-03-16 14:29:59'),(191,15,24,6,30240.0000,'2015-01-05 19:07:50','2015-01-06 03:31:50','2017-03-16 14:29:59','2017-03-16 14:29:59'),(192,18,12,4,30240.0000,'2015-03-14 11:27:28','2015-03-14 19:51:28','2017-03-16 14:29:59','2017-03-16 14:29:59'),(193,20,14,6,30240.0000,'2016-09-24 02:46:44','2016-09-24 11:10:44','2017-03-16 14:29:59','2017-03-16 14:29:59'),(194,21,25,5,30240.0000,'2015-08-31 20:37:02','2015-09-01 05:01:02','2017-03-16 14:29:59','2017-03-16 14:29:59'),(195,19,8,6,30240.0000,'2016-12-04 13:38:23','2016-12-04 22:02:23','2017-03-16 14:29:59','2017-03-16 14:29:59'),(196,17,7,5,30240.0000,'2016-12-01 23:50:44','2016-12-02 08:14:44','2017-03-16 14:29:59','2017-03-16 14:29:59'),(197,12,19,4,30240.0000,'2014-11-26 17:00:25','2014-11-27 01:24:25','2017-03-16 14:29:59','2017-03-16 14:29:59'),(198,19,21,4,30240.0000,'2014-09-21 02:00:36','2014-09-21 10:24:36','2017-03-16 14:29:59','2017-03-16 14:29:59'),(199,13,23,6,30240.0000,'2015-09-29 07:10:37','2015-09-29 15:34:37','2017-03-16 14:29:59','2017-03-16 14:29:59'),(200,15,16,2,30240.0000,'2016-07-01 05:53:01','2016-07-01 14:17:01','2017-03-16 14:29:59','2017-03-16 14:29:59'),(201,12,18,6,30240.0000,'2017-01-09 07:16:28','2017-01-09 15:40:28','2017-03-16 14:29:59','2017-03-16 14:29:59'),(202,24,7,6,153.0000,'2014-12-23 09:44:57','2014-12-23 09:47:30','2017-03-16 14:29:59','2017-03-16 14:29:59'),(203,27,10,1,189.0000,'2016-07-14 21:47:18','2016-07-14 21:50:27','2017-03-16 14:29:59','2017-03-16 14:29:59'),(204,31,17,6,22.0000,'2016-09-28 18:24:05','2016-09-28 18:24:27','2017-03-16 14:29:59','2017-03-16 14:29:59'),(205,27,22,6,66.0000,'2015-09-11 18:07:21','2015-09-11 18:08:27','2017-03-16 14:29:59','2017-03-16 14:29:59'),(206,27,9,1,188.0000,'2014-08-15 14:20:59','2014-08-15 14:24:07','2017-03-16 14:29:59','2017-03-16 14:29:59'),(207,26,25,5,145.0000,'2015-02-24 20:47:51','2015-02-24 20:50:16','2017-03-16 14:29:59','2017-03-16 14:29:59'),(208,26,26,4,42.0000,'2016-09-23 14:53:53','2016-09-23 14:54:35','2017-03-16 14:29:59','2017-03-16 14:29:59'),(209,25,19,1,150.0000,'2015-04-08 10:04:38','2015-04-08 10:07:08','2017-03-16 14:29:59','2017-03-16 14:29:59'),(210,28,9,4,91.0000,'2015-11-26 03:35:56','2015-11-26 03:37:27','2017-03-16 14:29:59','2017-03-16 14:29:59'),(211,29,11,4,153.0000,'2014-06-26 08:54:41','2014-06-26 08:57:14','2017-03-16 14:29:59','2017-03-16 14:29:59'),(212,27,17,3,197.0000,'2016-05-30 16:20:30','2016-05-30 16:23:47','2017-03-16 14:29:59','2017-03-16 14:29:59'),(213,24,24,1,137.0000,'2016-01-05 15:41:14','2016-01-05 15:43:31','2017-03-16 14:29:59','2017-03-16 14:29:59'),(214,30,16,3,63.0000,'2016-09-19 10:53:33','2016-09-19 10:54:36','2017-03-16 14:29:59','2017-03-16 14:29:59'),(215,28,7,2,4.0000,'2015-05-29 01:02:17','2015-05-29 01:02:21','2017-03-16 14:29:59','2017-03-16 14:29:59'),(216,28,19,5,160.0000,'2016-09-05 02:32:10','2016-09-05 02:34:50','2017-03-16 14:29:59','2017-03-16 14:29:59'),(217,25,20,1,125.0000,'2016-01-09 08:24:00','2016-01-09 08:26:05','2017-03-16 14:29:59','2017-03-16 14:29:59'),(218,31,20,5,18.0000,'2016-09-30 08:03:00','2016-09-30 08:03:18','2017-03-16 14:29:59','2017-03-16 14:29:59'),(219,22,26,3,147.0000,'2016-12-20 18:57:58','2016-12-20 19:00:25','2017-03-16 14:29:59','2017-03-16 14:29:59'),(220,23,9,6,81.0000,'2014-06-24 11:43:22','2014-06-24 11:44:43','2017-03-16 14:29:59','2017-03-16 14:29:59'),(221,25,26,1,146.0000,'2015-07-30 20:20:32','2015-07-30 20:22:58','2017-03-16 14:29:59','2017-03-16 14:29:59'),(222,29,26,1,122.0000,'2014-10-16 16:36:28','2014-10-16 16:38:30','2017-03-16 14:29:59','2017-03-16 14:29:59'),(223,28,12,3,25.0000,'2016-01-09 20:56:42','2016-01-09 20:57:07','2017-03-16 14:29:59','2017-03-16 14:29:59'),(224,29,7,2,125.0000,'2016-03-14 08:34:50','2016-03-14 08:36:55','2017-03-16 14:29:59','2017-03-16 14:29:59'),(225,30,17,4,195.0000,'2016-05-24 06:49:23','2016-05-24 06:52:38','2017-03-16 14:29:59','2017-03-16 14:29:59'),(226,30,26,5,59.0000,'2016-04-13 20:18:29','2016-04-13 20:19:28','2017-03-16 14:29:59','2017-03-16 14:29:59'),(227,22,12,2,41.0000,'2016-07-04 07:03:08','2016-07-04 07:03:49','2017-03-16 14:29:59','2017-03-16 14:29:59'),(228,30,15,2,4.0000,'2015-05-28 06:54:45','2015-05-28 06:54:49','2017-03-16 14:29:59','2017-03-16 14:29:59'),(229,26,23,1,141.0000,'2014-10-02 19:29:48','2014-10-02 19:32:09','2017-03-16 14:29:59','2017-03-16 14:29:59'),(230,27,8,3,6.0000,'2014-11-18 09:08:41','2014-11-18 09:08:47','2017-03-16 14:29:59','2017-03-16 14:29:59'),(231,27,17,3,78.0000,'2014-08-10 06:13:19','2014-08-10 06:14:37','2017-03-16 14:29:59','2017-03-16 14:29:59'),(232,30,17,1,76.0000,'2014-09-07 23:36:57','2014-09-07 23:38:13','2017-03-16 14:29:59','2017-03-16 14:29:59'),(233,28,7,5,14.0000,'2016-03-16 12:11:54','2016-03-16 12:12:08','2017-03-16 14:29:59','2017-03-16 14:29:59'),(234,27,26,5,195.0000,'2016-09-02 14:06:56','2016-09-02 14:10:11','2017-03-16 14:29:59','2017-03-16 14:29:59'),(235,30,20,1,6.0000,'2015-04-08 20:43:22','2015-04-08 20:43:28','2017-03-16 14:29:59','2017-03-16 14:29:59'),(236,30,18,2,1.0000,'2015-06-26 16:50:56','2015-06-26 16:50:57','2017-03-16 14:29:59','2017-03-16 14:29:59'),(237,30,17,5,26.0000,'2016-11-24 16:47:21','2016-11-24 16:47:47','2017-03-16 14:29:59','2017-03-16 14:29:59'),(238,31,25,3,75.0000,'2015-05-29 19:47:06','2015-05-29 19:48:21','2017-03-16 14:29:59','2017-03-16 14:29:59'),(239,22,19,5,114.0000,'2017-01-09 06:35:29','2017-01-09 06:37:23','2017-03-16 14:29:59','2017-03-16 14:29:59'),(240,22,12,3,135.0000,'2016-06-09 14:57:00','2016-06-09 14:59:15','2017-03-16 14:29:59','2017-03-16 14:29:59'),(241,23,20,4,67.0000,'2015-04-10 13:23:12','2015-04-10 13:24:19','2017-03-16 14:29:59','2017-03-16 14:29:59'),(242,28,10,4,70.0000,'2015-12-11 13:25:49','2015-12-11 13:26:59','2017-03-16 14:29:59','2017-03-16 14:29:59'),(243,27,13,6,123.0000,'2015-12-20 02:29:48','2015-12-20 02:31:51','2017-03-16 14:29:59','2017-03-16 14:29:59'),(244,22,19,4,183.0000,'2016-06-15 10:12:17','2016-06-15 10:15:20','2017-03-16 14:29:59','2017-03-16 14:29:59'),(245,22,21,1,117.0000,'2014-12-09 10:55:12','2014-12-09 10:57:09','2017-03-16 14:29:59','2017-03-16 14:29:59'),(246,29,18,6,67.0000,'2015-01-31 12:40:19','2015-01-31 12:41:26','2017-03-16 14:29:59','2017-03-16 14:29:59'),(247,24,17,2,18.0000,'2015-05-20 04:49:33','2015-05-20 04:49:51','2017-03-16 14:29:59','2017-03-16 14:29:59'),(248,24,9,1,62.0000,'2017-01-06 08:44:26','2017-01-06 08:45:28','2017-03-16 14:29:59','2017-03-16 14:29:59'),(249,31,23,6,3.0000,'2017-01-30 13:12:48','2017-01-30 13:12:51','2017-03-16 14:29:59','2017-03-16 14:29:59'),(250,27,8,2,118.0000,'2016-11-14 12:38:00','2016-11-14 12:39:58','2017-03-16 14:29:59','2017-03-16 14:29:59'),(251,31,25,3,124.0000,'2015-10-30 19:38:56','2015-10-30 19:41:00','2017-03-16 14:29:59','2017-03-16 14:29:59'),(252,29,26,3,192.0000,'2014-08-08 20:25:59','2014-08-08 20:29:11','2017-03-16 14:29:59','2017-03-16 14:29:59'),(253,22,10,5,138.0000,'2015-04-01 19:07:40','2015-04-01 19:09:58','2017-03-16 14:29:59','2017-03-16 14:29:59'),(254,28,11,3,153.0000,'2016-03-07 01:30:33','2016-03-07 01:33:06','2017-03-16 14:29:59','2017-03-16 14:29:59'),(255,26,13,2,94.0000,'2016-03-09 16:32:04','2016-03-09 16:33:38','2017-03-16 14:29:59','2017-03-16 14:29:59'),(256,29,11,3,8.0000,'2014-08-05 09:37:51','2014-08-05 09:37:59','2017-03-16 14:29:59','2017-03-16 14:29:59'),(257,31,15,3,110.0000,'2014-11-02 16:50:08','2014-11-02 16:51:58','2017-03-16 14:29:59','2017-03-16 14:29:59'),(258,31,15,4,93.0000,'2016-05-09 20:30:57','2016-05-09 20:32:30','2017-03-16 14:29:59','2017-03-16 14:29:59'),(259,28,9,5,86.0000,'2015-11-04 04:48:53','2015-11-04 04:50:19','2017-03-16 14:29:59','2017-03-16 14:29:59'),(260,23,21,2,143.0000,'2017-02-19 02:19:18','2017-02-19 02:21:41','2017-03-16 14:29:59','2017-03-16 14:29:59'),(261,24,15,1,54.0000,'2015-09-03 16:50:23','2015-09-03 16:51:17','2017-03-16 14:29:59','2017-03-16 14:29:59'),(262,25,14,2,142.0000,'2015-07-09 09:10:53','2015-07-09 09:13:15','2017-03-16 14:29:59','2017-03-16 14:29:59'),(263,26,24,6,130.0000,'2015-07-29 07:36:18','2015-07-29 07:38:28','2017-03-16 14:29:59','2017-03-16 14:29:59'),(264,29,10,1,199.0000,'2014-12-27 08:31:43','2014-12-27 08:35:02','2017-03-16 14:29:59','2017-03-16 14:29:59'),(265,24,15,1,125.0000,'2015-02-22 11:47:36','2015-02-22 11:49:41','2017-03-16 14:29:59','2017-03-16 14:29:59'),(266,31,8,4,110.0000,'2016-08-12 13:26:17','2016-08-12 13:28:07','2017-03-16 14:29:59','2017-03-16 14:29:59'),(267,24,8,1,131.0000,'2015-08-26 06:55:55','2015-08-26 06:58:06','2017-03-16 14:29:59','2017-03-16 14:29:59'),(268,26,12,3,142.0000,'2014-09-17 13:33:34','2014-09-17 13:35:56','2017-03-16 14:29:59','2017-03-16 14:29:59'),(269,23,23,5,168.0000,'2015-11-24 13:18:29','2015-11-24 13:21:17','2017-03-16 14:29:59','2017-03-16 14:29:59'),(270,25,15,2,97.0000,'2016-11-17 08:28:06','2016-11-17 08:29:43','2017-03-16 14:29:59','2017-03-16 14:29:59'),(271,30,8,4,63.0000,'2016-06-09 22:27:16','2016-06-09 22:28:19','2017-03-16 14:29:59','2017-03-16 14:29:59'),(272,27,8,4,55.0000,'2016-11-15 15:12:20','2016-11-15 15:13:15','2017-03-16 14:29:59','2017-03-16 14:29:59'),(273,25,9,1,192.0000,'2016-05-11 08:11:45','2016-05-11 08:14:57','2017-03-16 14:29:59','2017-03-16 14:29:59'),(274,28,24,3,37.0000,'2015-04-06 06:06:02','2015-04-06 06:06:39','2017-03-16 14:29:59','2017-03-16 14:29:59'),(275,29,26,6,75.0000,'2015-03-19 08:08:38','2015-03-19 08:09:53','2017-03-16 14:29:59','2017-03-16 14:29:59'),(276,26,23,6,133.0000,'2014-11-02 10:43:51','2014-11-02 10:46:04','2017-03-16 14:29:59','2017-03-16 14:29:59'),(277,27,24,4,146.0000,'2016-05-30 23:07:33','2016-05-30 23:09:59','2017-03-16 14:29:59','2017-03-16 14:29:59'),(278,25,22,6,13.0000,'2015-10-25 11:47:47','2015-10-25 11:48:00','2017-03-16 14:29:59','2017-03-16 14:29:59'),(279,23,13,6,181.0000,'2015-08-26 05:25:22','2015-08-26 05:28:23','2017-03-16 14:29:59','2017-03-16 14:29:59'),(280,27,8,4,93.0000,'2015-06-25 19:07:22','2015-06-25 19:08:55','2017-03-16 14:29:59','2017-03-16 14:29:59'),(281,24,23,2,185.0000,'2016-03-23 18:04:11','2016-03-23 18:07:16','2017-03-16 14:29:59','2017-03-16 14:29:59'),(282,25,22,1,80.0000,'2015-03-12 19:04:07','2015-03-12 19:05:27','2017-03-16 14:29:59','2017-03-16 14:29:59'),(283,23,23,4,62.0000,'2015-06-21 18:48:57','2015-06-21 18:49:59','2017-03-16 14:29:59','2017-03-16 14:29:59'),(284,22,14,6,158.0000,'2015-06-23 02:26:34','2015-06-23 02:29:12','2017-03-16 14:29:59','2017-03-16 14:29:59'),(285,22,24,3,143.0000,'2015-07-30 07:41:38','2015-07-30 07:44:01','2017-03-16 14:29:59','2017-03-16 14:29:59'),(286,30,7,3,185.0000,'2015-01-12 13:52:12','2015-01-12 13:55:17','2017-03-16 14:29:59','2017-03-16 14:29:59'),(287,23,21,2,99.0000,'2014-12-15 19:25:10','2014-12-15 19:26:49','2017-03-16 14:29:59','2017-03-16 14:29:59'),(288,29,13,2,43.0000,'2016-11-25 01:25:21','2016-11-25 01:26:04','2017-03-16 14:29:59','2017-03-16 14:29:59'),(289,31,15,5,175.0000,'2014-08-25 04:28:10','2014-08-25 04:31:05','2017-03-16 14:29:59','2017-03-16 14:29:59'),(290,29,18,6,187.0000,'2016-03-02 22:43:29','2016-03-02 22:46:36','2017-03-16 14:29:59','2017-03-16 14:29:59'),(291,29,22,3,97.0000,'2014-11-24 04:20:31','2014-11-24 04:22:08','2017-03-16 14:29:59','2017-03-16 14:29:59'),(292,25,17,6,83.0000,'2015-02-17 14:44:08','2015-02-17 14:45:31','2017-03-16 14:29:59','2017-03-16 14:29:59'),(293,30,24,2,17.0000,'2016-11-16 14:16:50','2016-11-16 14:17:07','2017-03-16 14:29:59','2017-03-16 14:29:59'),(294,27,12,3,149.0000,'2016-07-29 23:05:31','2016-07-29 23:08:00','2017-03-16 14:29:59','2017-03-16 14:29:59'),(295,24,15,5,17.0000,'2015-07-24 15:15:07','2015-07-24 15:15:24','2017-03-16 14:29:59','2017-03-16 14:29:59'),(296,30,22,5,120.0000,'2016-07-12 23:27:10','2016-07-12 23:29:10','2017-03-16 14:29:59','2017-03-16 14:29:59'),(297,24,10,6,27.0000,'2015-09-12 09:22:02','2015-09-12 09:22:29','2017-03-16 14:29:59','2017-03-16 14:29:59'),(298,27,12,3,14.0000,'2015-08-14 15:57:33','2015-08-14 15:57:47','2017-03-16 14:29:59','2017-03-16 14:29:59'),(299,24,22,4,155.0000,'2017-02-14 21:11:21','2017-02-14 21:13:56','2017-03-16 14:29:59','2017-03-16 14:29:59'),(300,26,16,3,83.0000,'2014-08-20 15:18:04','2014-08-20 15:19:27','2017-03-16 14:29:59','2017-03-16 14:29:59'),(301,26,19,1,140.0000,'2016-09-26 21:59:52','2016-09-26 22:02:12','2017-03-16 14:29:59','2017-03-16 14:29:59'),(302,40,21,1,1.0000,'2016-06-20 07:03:25','2016-06-20 07:03:26','2017-03-16 14:29:59','2017-03-16 14:29:59'),(303,38,16,3,1.0000,'2016-10-17 06:46:21','2016-10-17 06:46:22','2017-03-16 14:29:59','2017-03-16 14:29:59'),(304,33,22,4,1.0000,'2016-03-12 18:08:51','2016-03-12 18:08:52','2017-03-16 14:29:59','2017-03-16 14:29:59'),(305,39,12,3,1.0000,'2016-05-05 20:40:57','2016-05-05 20:40:58','2017-03-16 14:29:59','2017-03-16 14:29:59'),(306,37,16,1,1.0000,'2016-07-17 12:23:05','2016-07-17 12:23:06','2017-03-16 14:29:59','2017-03-16 14:29:59'),(307,34,7,1,1.0000,'2016-08-22 07:50:37','2016-08-22 07:50:38','2017-03-16 14:29:59','2017-03-16 14:29:59'),(308,37,12,5,1.0000,'2014-08-29 14:20:44','2014-08-29 14:20:45','2017-03-16 14:29:59','2017-03-16 14:29:59'),(309,36,24,1,1.0000,'2015-03-15 07:00:01','2015-03-15 07:00:02','2017-03-16 14:29:59','2017-03-16 14:29:59'),(310,40,26,5,1.0000,'2015-11-09 17:28:03','2015-11-09 17:28:04','2017-03-16 14:29:59','2017-03-16 14:29:59'),(311,32,10,2,1.0000,'2016-08-08 16:59:03','2016-08-08 16:59:04','2017-03-16 14:29:59','2017-03-16 14:29:59'),(312,37,12,6,1.0000,'2016-12-10 05:45:52','2016-12-10 05:45:53','2017-03-16 14:29:59','2017-03-16 14:29:59'),(313,34,21,6,1.0000,'2016-07-23 19:32:26','2016-07-23 19:32:27','2017-03-16 14:29:59','2017-03-16 14:29:59'),(314,39,19,4,1.0000,'2017-02-15 04:13:39','2017-02-15 04:13:40','2017-03-16 14:29:59','2017-03-16 14:29:59'),(315,38,17,5,1.0000,'2015-09-20 16:49:19','2015-09-20 16:49:20','2017-03-16 14:29:59','2017-03-16 14:29:59'),(316,32,25,5,1.0000,'2015-07-24 09:49:20','2015-07-24 09:49:21','2017-03-16 14:29:59','2017-03-16 14:29:59'),(317,38,19,2,1.0000,'2015-01-13 10:45:17','2015-01-13 10:45:18','2017-03-16 14:29:59','2017-03-16 14:29:59'),(318,38,14,1,1.0000,'2016-01-13 09:13:26','2016-01-13 09:13:27','2017-03-16 14:29:59','2017-03-16 14:29:59'),(319,34,24,3,1.0000,'2016-09-06 06:48:28','2016-09-06 06:48:29','2017-03-16 14:29:59','2017-03-16 14:29:59'),(320,38,26,1,1.0000,'2016-04-01 07:31:22','2016-04-01 07:31:23','2017-03-16 14:29:59','2017-03-16 14:29:59'),(321,37,22,5,1.0000,'2016-01-30 07:30:53','2016-01-30 07:30:54','2017-03-16 14:29:59','2017-03-16 14:29:59'),(322,38,19,5,1.0000,'2017-03-14 14:48:00','2017-03-14 14:48:01','2017-03-16 14:29:59','2017-03-16 14:29:59'),(323,33,9,5,1.0000,'2014-08-25 03:27:14','2014-08-25 03:27:15','2017-03-16 14:29:59','2017-03-16 14:29:59'),(324,40,26,2,1.0000,'2016-03-03 03:38:22','2016-03-03 03:38:23','2017-03-16 14:29:59','2017-03-16 14:29:59'),(325,33,24,4,1.0000,'2016-02-19 20:50:27','2016-02-19 20:50:28','2017-03-16 14:29:59','2017-03-16 14:29:59'),(326,39,23,1,1.0000,'2014-10-31 16:16:52','2014-10-31 16:16:53','2017-03-16 14:29:59','2017-03-16 14:29:59'),(327,32,23,3,1.0000,'2015-10-17 13:00:26','2015-10-17 13:00:27','2017-03-16 14:29:59','2017-03-16 14:29:59'),(328,35,17,5,1.0000,'2015-01-06 12:42:28','2015-01-06 12:42:29','2017-03-16 14:29:59','2017-03-16 14:29:59'),(329,34,7,2,1.0000,'2015-02-18 03:20:47','2015-02-18 03:20:48','2017-03-16 14:29:59','2017-03-16 14:29:59'),(330,33,9,3,1.0000,'2016-05-10 01:23:59','2016-05-10 01:24:00','2017-03-16 14:29:59','2017-03-16 14:29:59'),(331,32,8,3,1.0000,'2016-12-04 20:00:05','2016-12-04 20:00:06','2017-03-16 14:29:59','2017-03-16 14:29:59'),(332,32,21,3,1.0000,'2016-12-22 05:47:17','2016-12-22 05:47:18','2017-03-16 14:29:59','2017-03-16 14:29:59'),(333,38,9,1,1.0000,'2016-02-06 23:02:37','2016-02-06 23:02:38','2017-03-16 14:29:59','2017-03-16 14:29:59'),(334,32,25,6,1.0000,'2014-10-15 13:39:59','2014-10-15 13:40:00','2017-03-16 14:29:59','2017-03-16 14:29:59'),(335,38,17,1,1.0000,'2016-04-18 09:57:29','2016-04-18 09:57:30','2017-03-16 14:29:59','2017-03-16 14:29:59'),(336,38,14,5,1.0000,'2015-04-01 14:54:03','2015-04-01 14:54:04','2017-03-16 14:29:59','2017-03-16 14:29:59'),(337,36,26,1,1.0000,'2015-03-30 02:00:27','2015-03-30 02:00:28','2017-03-16 14:29:59','2017-03-16 14:29:59'),(338,38,21,2,1.0000,'2014-09-12 22:40:01','2014-09-12 22:40:02','2017-03-16 14:29:59','2017-03-16 14:29:59'),(339,34,22,2,1.0000,'2015-07-10 03:04:25','2015-07-10 03:04:26','2017-03-16 14:29:59','2017-03-16 14:29:59'),(340,41,13,3,1.0000,'2016-05-30 05:34:18','2016-05-30 05:34:19','2017-03-16 14:29:59','2017-03-16 14:29:59'),(341,32,11,3,1.0000,'2016-03-03 01:50:24','2016-03-03 01:50:25','2017-03-16 14:29:59','2017-03-16 14:29:59'),(342,33,11,2,1.0000,'2017-02-16 21:55:46','2017-02-16 21:55:47','2017-03-16 14:29:59','2017-03-16 14:29:59'),(343,41,22,5,1.0000,'2015-03-28 22:29:35','2015-03-28 22:29:36','2017-03-16 14:29:59','2017-03-16 14:29:59'),(344,35,25,3,1.0000,'2016-11-10 01:13:04','2016-11-10 01:13:05','2017-03-16 14:29:59','2017-03-16 14:29:59'),(345,41,22,3,1.0000,'2016-11-29 23:22:25','2016-11-29 23:22:26','2017-03-16 14:29:59','2017-03-16 14:29:59'),(346,33,20,2,1.0000,'2015-07-06 04:57:50','2015-07-06 04:57:51','2017-03-16 14:29:59','2017-03-16 14:29:59'),(347,35,22,5,1.0000,'2017-01-25 13:13:42','2017-01-25 13:13:43','2017-03-16 14:29:59','2017-03-16 14:29:59'),(348,38,26,4,1.0000,'2016-09-26 05:59:29','2016-09-26 05:59:30','2017-03-16 14:29:59','2017-03-16 14:29:59'),(349,39,21,1,1.0000,'2015-09-15 08:44:39','2015-09-15 08:44:40','2017-03-16 14:29:59','2017-03-16 14:29:59'),(350,37,13,5,1.0000,'2015-03-27 22:57:33','2015-03-27 22:57:34','2017-03-16 14:29:59','2017-03-16 14:29:59'),(351,38,17,4,1.0000,'2016-04-29 22:05:06','2016-04-29 22:05:07','2017-03-16 14:29:59','2017-03-16 14:29:59'),(352,32,25,6,1.0000,'2014-08-11 16:42:40','2014-08-11 16:42:41','2017-03-16 14:29:59','2017-03-16 14:29:59'),(353,38,10,4,1.0000,'2015-12-22 23:23:21','2015-12-22 23:23:22','2017-03-16 14:29:59','2017-03-16 14:29:59'),(354,35,14,2,1.0000,'2015-01-19 15:15:01','2015-01-19 15:15:02','2017-03-16 14:29:59','2017-03-16 14:29:59'),(355,37,25,5,1.0000,'2017-01-05 02:27:41','2017-01-05 02:27:42','2017-03-16 14:29:59','2017-03-16 14:29:59'),(356,39,10,1,1.0000,'2014-12-14 14:23:56','2014-12-14 14:23:57','2017-03-16 14:29:59','2017-03-16 14:29:59'),(357,32,7,3,1.0000,'2016-07-31 15:41:16','2016-07-31 15:41:17','2017-03-16 14:29:59','2017-03-16 14:29:59'),(358,32,22,3,1.0000,'2016-05-29 21:43:46','2016-05-29 21:43:47','2017-03-16 14:29:59','2017-03-16 14:29:59'),(359,38,13,4,1.0000,'2016-05-14 02:06:11','2016-05-14 02:06:12','2017-03-16 14:29:59','2017-03-16 14:29:59'),(360,39,9,2,1.0000,'2015-07-31 04:40:41','2015-07-31 04:40:42','2017-03-16 14:29:59','2017-03-16 14:29:59'),(361,39,8,1,1.0000,'2016-10-30 02:49:49','2016-10-30 02:49:50','2017-03-16 14:29:59','2017-03-16 14:29:59'),(362,41,23,5,1.0000,'2014-09-24 18:33:01','2014-09-24 18:33:02','2017-03-16 14:29:59','2017-03-16 14:29:59'),(363,41,14,5,1.0000,'2015-06-28 02:11:23','2015-06-28 02:11:24','2017-03-16 14:29:59','2017-03-16 14:29:59'),(364,32,19,1,1.0000,'2017-02-25 12:37:58','2017-02-25 12:37:59','2017-03-16 14:29:59','2017-03-16 14:29:59'),(365,34,19,1,1.0000,'2015-11-28 14:28:21','2015-11-28 14:28:22','2017-03-16 14:29:59','2017-03-16 14:29:59'),(366,41,11,6,1.0000,'2016-03-18 07:09:59','2016-03-18 07:10:00','2017-03-16 14:29:59','2017-03-16 14:29:59'),(367,35,23,1,1.0000,'2014-08-08 09:06:34','2014-08-08 09:06:35','2017-03-16 14:29:59','2017-03-16 14:29:59'),(368,39,21,4,1.0000,'2014-12-25 07:47:33','2014-12-25 07:47:34','2017-03-16 14:29:59','2017-03-16 14:29:59'),(369,33,18,2,1.0000,'2016-02-07 13:28:49','2016-02-07 13:28:50','2017-03-16 14:29:59','2017-03-16 14:29:59'),(370,41,16,1,1.0000,'2014-11-18 19:34:38','2014-11-18 19:34:39','2017-03-16 14:29:59','2017-03-16 14:29:59'),(371,41,25,1,1.0000,'2014-09-28 08:49:42','2014-09-28 08:49:43','2017-03-16 14:29:59','2017-03-16 14:29:59'),(372,32,9,1,1.0000,'2015-11-12 14:42:42','2015-11-12 14:42:43','2017-03-16 14:29:59','2017-03-16 14:29:59'),(373,34,16,6,1.0000,'2016-04-21 14:27:55','2016-04-21 14:27:56','2017-03-16 14:29:59','2017-03-16 14:29:59'),(374,40,17,2,1.0000,'2017-02-05 18:30:12','2017-02-05 18:30:13','2017-03-16 14:29:59','2017-03-16 14:29:59'),(375,36,16,6,1.0000,'2015-11-03 14:29:01','2015-11-03 14:29:02','2017-03-16 14:29:59','2017-03-16 14:29:59'),(376,35,16,4,1.0000,'2015-09-27 22:20:39','2015-09-27 22:20:40','2017-03-16 14:29:59','2017-03-16 14:29:59'),(377,32,8,3,1.0000,'2014-10-09 09:25:43','2014-10-09 09:25:44','2017-03-16 14:29:59','2017-03-16 14:29:59'),(378,38,13,6,1.0000,'2014-08-31 16:32:18','2014-08-31 16:32:19','2017-03-16 14:29:59','2017-03-16 14:29:59'),(379,38,24,5,1.0000,'2015-01-31 07:03:09','2015-01-31 07:03:10','2017-03-16 14:29:59','2017-03-16 14:29:59'),(380,33,9,3,1.0000,'2015-12-08 18:59:55','2015-12-08 18:59:56','2017-03-16 14:29:59','2017-03-16 14:29:59'),(381,38,13,1,1.0000,'2017-01-23 07:23:01','2017-01-23 07:23:02','2017-03-16 14:29:59','2017-03-16 14:29:59'),(382,34,9,3,1.0000,'2016-04-21 04:34:32','2016-04-21 04:34:33','2017-03-16 14:29:59','2017-03-16 14:29:59'),(383,41,24,3,1.0000,'2015-06-28 23:02:37','2015-06-28 23:02:38','2017-03-16 14:29:59','2017-03-16 14:29:59'),(384,37,26,1,1.0000,'2014-11-17 14:36:00','2014-11-17 14:36:01','2017-03-16 14:29:59','2017-03-16 14:29:59'),(385,35,8,4,1.0000,'2014-10-02 10:22:36','2014-10-02 10:22:37','2017-03-16 14:29:59','2017-03-16 14:29:59'),(386,40,20,4,1.0000,'2015-12-17 20:06:32','2015-12-17 20:06:33','2017-03-16 14:29:59','2017-03-16 14:29:59'),(387,36,14,1,1.0000,'2015-07-22 06:53:11','2015-07-22 06:53:12','2017-03-16 14:29:59','2017-03-16 14:29:59'),(388,33,13,4,1.0000,'2016-12-10 05:08:53','2016-12-10 05:08:54','2017-03-16 14:29:59','2017-03-16 14:29:59'),(389,39,11,4,1.0000,'2015-07-01 14:58:11','2015-07-01 14:58:12','2017-03-16 14:29:59','2017-03-16 14:29:59'),(390,33,19,1,1.0000,'2015-10-21 04:51:33','2015-10-21 04:51:34','2017-03-16 14:29:59','2017-03-16 14:29:59'),(391,38,10,2,1.0000,'2015-12-03 08:28:49','2015-12-03 08:28:50','2017-03-16 14:29:59','2017-03-16 14:29:59'),(392,33,11,5,1.0000,'2015-10-28 14:16:12','2015-10-28 14:16:13','2017-03-16 14:29:59','2017-03-16 14:29:59'),(393,40,16,6,1.0000,'2016-11-23 21:32:26','2016-11-23 21:32:27','2017-03-16 14:29:59','2017-03-16 14:29:59'),(394,41,17,2,1.0000,'2015-06-15 08:05:41','2015-06-15 08:05:42','2017-03-16 14:29:59','2017-03-16 14:29:59'),(395,35,12,6,1.0000,'2016-07-23 16:00:42','2016-07-23 16:00:43','2017-03-16 14:29:59','2017-03-16 14:29:59'),(396,34,26,4,1.0000,'2016-10-01 18:38:16','2016-10-01 18:38:17','2017-03-16 14:29:59','2017-03-16 14:29:59'),(397,41,14,5,1.0000,'2014-10-01 01:06:39','2014-10-01 01:06:40','2017-03-16 14:29:59','2017-03-16 14:29:59'),(398,37,15,6,1.0000,'2016-05-11 01:24:24','2016-05-11 01:24:25','2017-03-16 14:29:59','2017-03-16 14:29:59'),(399,35,16,4,1.0000,'2016-06-16 09:51:07','2016-06-16 09:51:08','2017-03-16 14:29:59','2017-03-16 14:29:59'),(400,40,14,6,1.0000,'2016-08-15 04:14:09','2016-08-15 04:14:10','2017-03-16 14:29:59','2017-03-16 14:29:59'),(401,36,11,6,1.0000,'2014-07-06 04:32:26','2014-07-06 04:32:27','2017-03-16 14:29:59','2017-03-16 14:29:59');
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
INSERT INTO `users` VALUES (1,'admin','admin','admin@example.com','admin@example.com',1,'lokC4aoNDZMmK.SYxo6twCGDji16rYqk3E6FKRXer6Q','PlSmhrSBVnRazT8XC+fzTI4T++5rHWHKD0qq3XvmldDVMtmF7ooltCmZAB6r/AcMG8xqqYdVH3A9S5P5P160/Q==',NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}','Default','User','2017-03-16 14:29:59','2017-03-16 14:29:59',20,'employee'),(2,'otto.meinhard','otto.meinhard','markus.albrecht@schubert.com','markus.albrecht@schubert.com',1,'0SMaWyY/XqN8Bv33zkw32kY14RVgEnzHpn7e9gz6zvo','CYMPmKBJuudVIDIERDLKF6sFhOHiJMQj3Pl9uzrZj/1P/fRd+oR5WO0LaajXG/R3WzZYf2RBzv96FMLkl1YkCw==',NULL,NULL,NULL,'a:0:{}','Mehmet','Reimann','2017-03-16 14:29:59','2017-03-16 14:29:59',20,'employee'),(3,'hansotto.albert','hansotto.albert','luigi58@bar.de','luigi58@bar.de',0,'DNColm6pZtBFH/9SGnt6VF1.FWEFYdycmP0EBb8zITY','2y3IoPFa37C39QVQzKw4HyI3yPsr3VBAdyE+9iCIgLeMBIz5RbjZfLPPOEhuYpH80yPoQqywiZNzTa7NsjL5pQ==',NULL,NULL,NULL,'a:0:{}','Edward','Henke','2017-03-16 14:29:59','2017-03-16 14:29:59',20,'employee'),(4,'nschade','nschade','iarnold@wetzel.net','iarnold@wetzel.net',1,'xB7nKM0kVorjCo3or1PjDhEP9o9i8FCI8xUkCwR9/HE','+wM9MurgD3DkylsNkVoMaEKgggQGbh5QM/AocRAyiCCg9m33KJ5B7pOlZYnZTy7yNRxwXl+jEIC8jmlGKOO/uA==',NULL,NULL,NULL,'a:0:{}','Madeleine','Bayer','2017-03-16 14:29:59','2017-03-16 14:29:59',20,'employee'),(5,'falk17','falk17','benz.hermine@beier.de','benz.hermine@beier.de',0,'x9mxJ8TECaqQXiwRg6YhjUAfuTHarQTeCOhCOlh.VqE','B7oZy0KPfU9z6N1BrzhQpvE4kc6yPhZM0UgRqeo0DrOktLhKwDg8tX0wrptMEQjUBQkvFORG451NHUEMziNmRw==',NULL,NULL,NULL,'a:0:{}','Friedrich','Beckmann','2017-03-16 14:29:59','2017-03-16 14:29:59',20,'employee'),(6,'liselotte07','liselotte07','karina99@walter.de','karina99@walter.de',1,'FbZkrZO7zk8Qnhy7zMBJHeWNER/pe1O/NT2bz9tBG3w','Bdt1K9U24h4A64GwduKZ4TJ3EgPexA9wR61GAs8sJdsihuKHu+ZpuTRiMySuOurykDiz0uWUFenVYugC+NYfsg==',NULL,NULL,NULL,'a:0:{}','Sylvia','Wolter','2017-03-16 14:29:59','2017-03-16 14:29:59',20,'employee'),(7,'schlegel.stephan','schlegel.stephan','employee1@example.org','employee1@example.org',1,'EHbmzmdUQ0gkWDCXn4D5FWrMA05pTu1K0T73QS1lZbE','bxfJBnjdYA+12zCOTPnntsnscKRwklOPAHVJPNd9aKLXkSLnVFUXULwb3sRRvakrtNGtTgLASfLYPbr4fa692Q==',NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}','Default','User','2017-03-16 14:29:59','2017-03-16 14:29:59',20,'employee'),(8,'liane50','liane50','werner.andreas@paul.de','werner.andreas@paul.de',0,'9s37cLPDmggufbDZmGWCGX/DKhCHZW8IaHXEUyZTKfY','W059FGkyKlIzwQS8f3QN5c/tTsJAd/Jb5lzrsvvbInd1zv1wPUU1kBraNwMPZCsUZRrMlsDCyLDv1rkY4gu/MA==',NULL,NULL,NULL,'a:0:{}','Ahmed','Will','2017-03-16 14:29:59','2017-03-16 14:29:59',20,'employee'),(9,'thuber','thuber','hiller.guenter@hotmail.de','hiller.guenter@hotmail.de',1,'5zJBfMLmKKBRzLNlay.WJ/S/bG6/DTk26VsevDdHBrw','QNK6qfDzNADhN9HztgXaIM9UnXK4BASSgxf2pmybrQCby/Fs1HeUFT9gtBY1FmM4mNeQTm315Je7kBKkunuJIg==',NULL,NULL,NULL,'a:0:{}','Hans Dieter','Schade','2017-03-16 14:29:59','2017-03-16 14:29:59',20,'employee'),(10,'wilke.valeri','wilke.valeri','hummel.annegret@hotmail.de','hummel.annegret@hotmail.de',1,'zP/./nQICzLLjw/7X.n4sMC/9U5tqtMKx7nfJLqgwPo','4MM1rTuszizP4Lxn7Px8HUc05XtiHYDE2y7W8KNxAMn+f9dWhm4wynn6cKhLrzPS3Dq3RJrP6564Iki/lwtN1A==',NULL,NULL,NULL,'a:0:{}','Adam','Geißler','2017-03-16 14:29:59','2017-03-16 14:29:59',20,'employee'),(11,'glemke','glemke','beier.christl@gmx.de','beier.christl@gmx.de',0,'iIctwAMvnoO/wmOKN/q5pre4G9yok1UKg6I4YOMaW1o','FAJngY4yOxQ84oesbDV4DjYeuRqGQ26mGoFv6DGLPa1YkoOsUp2SwLYaKNfrkdsM3m5DTAhEBV7gAR0EGmipQA==',NULL,NULL,NULL,'a:0:{}','August','Benz','2017-03-16 14:29:59','2017-03-16 14:29:59',20,'employee'),(12,'muller.hanno','muller.hanno','wenzel.langer@googlemail.com','wenzel.langer@googlemail.com',1,'d33gs5/ZGvcPCvPdhLO3jCp9V9DHR4xXef0qBswnguU','Qv11xknzHa3z3JhzKupfiH/Ht439tEqyVZJm1oGeHRLMZn9MmiIVXQ9sMAQUUIWo2rGuTHvTQLsNPSnG4hZFrg==',NULL,NULL,NULL,'a:0:{}','Inga','Seidl','2017-03-16 14:29:59','2017-03-16 14:29:59',20,'employee'),(13,'awalter','awalter','wendt.arndt@hartung.de','wendt.arndt@hartung.de',1,'Zvsd53ZxvUR5Z1oW/S50MEEya.8XfHiVkb/oxSvT1H8','BsZvCvVv1Tto/1tJdZT115wdBQItfCW20l/D/xPGqKELsCRdiCuim5WmCwYwikHuJAVT8wxDZcKecIKfzab5oQ==',NULL,NULL,NULL,'a:0:{}','Dorothea','Krebs','2017-03-16 14:29:59','2017-03-16 14:29:59',20,'employee'),(14,'barthel.hansjoachim','barthel.hansjoachim','hpopp@gruber.com','hpopp@gruber.com',1,'/T.ZtZ8L4Uk07mgGlt18vVB/fN3mPp241RZFCD9h1X0','DlJkoi6coOPZP5Dl4LUiMSya99rbnHNRguKzFXiUp8F23MdKkZI6d/s6n95fZnr2/omR2ZkpO2RMhVSIciuBmA==',NULL,NULL,NULL,'a:0:{}','Karl-Wilhelm','Wiese','2017-03-16 14:29:59','2017-03-16 14:29:59',20,'employee'),(15,'viktoria66','viktoria66','martin.klara@kruger.com','martin.klara@kruger.com',0,'sxAK8qC.D5qPiR42DXBcmXoop08WbvkR0huSoH8yVo8','OI/bPr9qmYH3rW4lW4fRUknLYsAQS8tjZV6YyAs12R3d1eq81CJAE4cNT2EZRhwXSvNmvEz32efI9z8hMW4NaQ==',NULL,NULL,NULL,'a:0:{}','Nelli','Münch','2017-03-16 14:29:59','2017-03-16 14:29:59',20,'employee'),(16,'schlegel.jorg','schlegel.jorg','gundula.ehlers@gmail.com','gundula.ehlers@gmail.com',1,'HQoTcBJd1V0cC/T6Ax9YHDUNz.Ey1eMgXMiKWRAsEMU','9hyeWCVsQeTGc6C5juF2TlpKGWxtNcD4g1i7a8917UVcxkFzbATeZBzco7McKIr1PL1OLQMmQxhTDnlrjkNWeQ==',NULL,NULL,NULL,'a:0:{}','Irmhild','Schmidt','2017-03-16 14:29:59','2017-03-16 14:29:59',20,'employee'),(17,'aroder','aroder','lhagen@knoll.com','lhagen@knoll.com',0,'umSeZalaI78BsL/Gn3EybMyY0cA4ZUxkwudlA3m0LQU','p3NOXUC27TB91d3nvJkY5YF01kbDT/pIoxQXg+igJA3CxG1Rx6Aa0T1vmbD1sukaIH5BENn1hi4VKZxT1Jq6hg==',NULL,NULL,NULL,'a:0:{}','Ulrich','Rieger','2017-03-16 14:29:59','2017-03-16 14:29:59',20,'employee'),(18,'eric.niemann','eric.niemann','doreen.schmid@web.de','doreen.schmid@web.de',1,'vpDwejOkX2GYl9aKiYPeUuexKxAefY6HE0jaA9n0hQo','MXKlM5XfzM4Y2SYSDbCVPyB0Isvdn2TFWP1OBafWqWFB/zM1stXeciPcFiksnHLfJJAVcy+yp360xmHhJ52MlA==',NULL,NULL,NULL,'a:0:{}','Hasan','Heinze','2017-03-16 14:29:59','2017-03-16 14:29:59',20,'employee'),(19,'ukuhlmann','ukuhlmann','veit94@friedrich.de','veit94@friedrich.de',1,'w38VvD2OhHCTNwgsMyR8djt4xeNqD/mmCIo2/0oNLg0','DVJcKBB/242hvEHdEz3kldTv+duWeOp6Fdhl+qcvpgEXLEfLA6O1ZUwZ8yTtqsYBgyr6DeAricK7ARakzF5ANg==',NULL,NULL,NULL,'a:0:{}','Birte','Hirsch','2017-03-16 14:29:59','2017-03-16 14:29:59',20,'employee'),(20,'zdietz','zdietz','hammer.magdalena@hirsch.de','hammer.magdalena@hirsch.de',1,'4LX1.vMrSkmMnBjJXh0ufakishmDkHHehcZgHka8H78','OXBAEJ0QdkQzshD1AiGskC2XJ9kttS88y+fEyiwkndwO4B1f9aGINZORuivbuTAS2SSsi+Gn1a/LI9d1fny9xg==',NULL,NULL,NULL,'a:0:{}','Olaf','Hübner','2017-03-16 14:29:59','2017-03-16 14:29:59',20,'employee'),(21,'rkessler','rkessler','marx.norman@witte.de','marx.norman@witte.de',1,'GwBZHXmUN6/76u0Np9FDmm9wi0uOHZhBmn1yUIAI2Go','2Zx7j+Tz60kRWJQV8Qz+umcZ5/5II+UUqXbLVOLXCsYdqqlf9mXbwLNt9+nWiM9uOywhkTK0/x1xfZ+46f9f8A==',NULL,NULL,NULL,'a:0:{}','Ernst-August','Jacob','2017-03-16 14:29:59','2017-03-16 14:29:59',20,'employee'),(22,'jhenning','jhenning','dorothee.heller@gmail.com','dorothee.heller@gmail.com',0,'eHk38NzMT4oYM1zMakDwV5vFNTrY/4xaQy7r1CJG3xQ','+I5oIKRPVkDaLuH91WUd64/VRF+TevWzc+TedBI89xn4cb3xDdzulZJKpWoRQIZ4xnCAMrB3wXUg9g5RKaRxPQ==',NULL,NULL,NULL,'a:0:{}','Heiderose','Braun','2017-03-16 14:29:59','2017-03-16 14:29:59',20,'employee'),(23,'hanns51','hanns51','august.moll@aol.de','august.moll@aol.de',1,'85MD8zvGDiSVXnJ6YjxCf7s1sPAm9qJV7TeLO4Tqfuc','8rfikBc4gjocgYSVigdjYOvP54dl+CnH616GTu2vr7C6V7RzWLl2RiKbPk9rhOixhI1+4XpA79Ggkw4V38hMMQ==',NULL,NULL,NULL,'a:0:{}','Alma','Jäger','2017-03-16 14:29:59','2017-03-16 14:29:59',20,'employee'),(24,'fackermann','fackermann','inna.kluge@aol.de','inna.kluge@aol.de',0,'XfLNHenIM8wtOCs8Y5O4wKxUyywjFnBLOODeA.R1c5A','qZ4aZIGaOHEXd+xlH+nDrRMcDlfadPq7uUxXmAsvF3fGJZK1jWZwBhTathqTELwF6r6wGc5SxBjJScXh+Fsorg==',NULL,NULL,NULL,'a:0:{}','Isabell','Lorenz','2017-03-16 14:29:59','2017-03-16 14:29:59',20,'employee'),(25,'klausjurgen11','klausjurgen11','heide13@aol.de','heide13@aol.de',1,'ar39OG5x.B54//Ss8g.PUyx9PvQB/yz/61ojssYvskY','QDgUw1CWPUowS8JMQwZDueoc9xpJsuHNkvj31E84+4ObTTDHBiLI9wc92OOPXisC8bVWRnM/nh1PQ/EJ25kRqQ==',NULL,NULL,NULL,'a:0:{}','Anton','Mack','2017-03-16 14:29:59','2017-03-16 14:29:59',20,'employee'),(26,'zdorr','zdorr','gwolff@loffler.net','gwolff@loffler.net',0,'bD.v0a33N46TDMFIJmVaER.1hhj0FbVOF7SAmbBi3Jw','hb/5LNYUjhQVkEEEVVK6jxs6KWjcT/17miZkiSqa5QZEz53OPKCFT0qMvTbsDzRgsTDeFMwG3AYJXpeNITNXVg==',NULL,NULL,NULL,'a:0:{}','Heinz-Dieter','Schütz','2017-03-16 14:29:59','2017-03-16 14:29:59',20,'employee');
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

-- Dump completed on 2017-03-16 13:30:08
