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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `WorkingPeriods`
--

LOCK TABLES `WorkingPeriods` WRITE;
/*!40000 ALTER TABLE `WorkingPeriods` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activities`
--

LOCK TABLES `activities` WRITE;
/*!40000 ALTER TABLE `activities` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address`
--

LOCK TABLES `address` WRITE;
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `holidays`
--

LOCK TABLES `holidays` WRITE;
/*!40000 ALTER TABLE `holidays` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoiceDiscounts`
--

LOCK TABLES `invoiceDiscounts` WRITE;
/*!40000 ALTER TABLE `invoiceDiscounts` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoice_items`
--

LOCK TABLES `invoice_items` WRITE;
/*!40000 ALTER TABLE `invoice_items` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoices`
--

LOCK TABLES `invoices` WRITE;
/*!40000 ALTER TABLE `invoices` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `offer_discounts`
--

LOCK TABLES `offer_discounts` WRITE;
/*!40000 ALTER TABLE `offer_discounts` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `offer_positions`
--

LOCK TABLES `offer_positions` WRITE;
/*!40000 ALTER TABLE `offer_positions` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `offer_status_uc`
--

LOCK TABLES `offer_status_uc` WRITE;
/*!40000 ALTER TABLE `offer_status_uc` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `offers`
--

LOCK TABLES `offers` WRITE;
/*!40000 ALTER TABLE `offers` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_categories`
--

LOCK TABLES `project_categories` WRITE;
/*!40000 ALTER TABLE `project_categories` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projects`
--

LOCK TABLES `projects` WRITE;
/*!40000 ALTER TABLE `projects` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rate_groups`
--

LOCK TABLES `rate_groups` WRITE;
/*!40000 ALTER TABLE `rate_groups` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rates`
--

LOCK TABLES `rates` WRITE;
/*!40000 ALTER TABLE `rates` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `services`
--

LOCK TABLES `services` WRITE;
/*!40000 ALTER TABLE `services` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings`
--

LOCK TABLES `settings` WRITE;
/*!40000 ALTER TABLE `settings` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `standard_discounts`
--

LOCK TABLES `standard_discounts` WRITE;
/*!40000 ALTER TABLE `standard_discounts` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `timeslices`
--

LOCK TABLES `timeslices` WRITE;
/*!40000 ALTER TABLE `timeslices` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
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

-- Dump completed on 2017-11-14 13:36:43
