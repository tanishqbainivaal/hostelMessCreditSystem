CREATE DATABASE  IF NOT EXISTS `mess_credit_system` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `mess_credit_system`;
-- MySQL dump 10.13  Distrib 8.0.44, for macos15 (arm64)
--
-- Host: localhost    Database: mess_credit_system
-- ------------------------------------------------------
-- Server version	9.5.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '019b0858-b95c-11f0-9e3d-cc6596c105d1:1-46';

--
-- Table structure for table `DailyMenu`
--

DROP TABLE IF EXISTS `DailyMenu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `DailyMenu` (
  `dm_id` int NOT NULL AUTO_INCREMENT,
  `item_id` int NOT NULL,
  `day` varchar(20) NOT NULL,
  `meal` varchar(20) NOT NULL,
  PRIMARY KEY (`dm_id`),
  KEY `item_id` (`item_id`),
  CONSTRAINT `dailymenu_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `MenuItem` (`item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=185 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DailyMenu`
--

LOCK TABLES `DailyMenu` WRITE;
/*!40000 ALTER TABLE `DailyMenu` DISABLE KEYS */;
INSERT INTO `DailyMenu` VALUES (1,1,'Monday','Breakfast'),(2,2,'Monday','Breakfast'),(3,4,'Monday','Breakfast'),(4,32,'Monday','Breakfast'),(5,36,'Monday','Breakfast'),(6,37,'Monday','Breakfast'),(7,38,'Monday','Breakfast'),(8,40,'Monday','Breakfast'),(16,13,'Monday','Lunch'),(17,22,'Monday','Lunch'),(18,24,'Monday','Lunch'),(19,35,'Monday','Lunch'),(20,41,'Monday','Lunch'),(23,31,'Monday','Snacks'),(24,32,'Monday','Snacks'),(26,10,'Monday','Dinner'),(27,18,'Monday','Dinner'),(28,22,'Monday','Dinner'),(29,24,'Monday','Dinner'),(30,40,'Monday','Dinner'),(31,41,'Monday','Dinner'),(32,46,'Monday','Dinner'),(33,2,'Tuesday','Breakfast'),(34,3,'Tuesday','Breakfast'),(35,4,'Tuesday','Breakfast'),(36,32,'Tuesday','Breakfast'),(37,37,'Tuesday','Breakfast'),(38,38,'Tuesday','Breakfast'),(40,9,'Tuesday','Lunch'),(41,17,'Tuesday','Lunch'),(42,23,'Tuesday','Lunch'),(43,24,'Tuesday','Lunch'),(44,35,'Tuesday','Lunch'),(45,39,'Tuesday','Lunch'),(47,28,'Tuesday','Snacks'),(48,32,'Tuesday','Snacks'),(50,14,'Tuesday','Dinner'),(51,16,'Tuesday','Dinner'),(52,22,'Tuesday','Dinner'),(53,25,'Tuesday','Dinner'),(54,39,'Tuesday','Dinner'),(55,40,'Tuesday','Dinner'),(56,49,'Tuesday','Dinner'),(57,1,'Wednesday','Breakfast'),(58,2,'Wednesday','Breakfast'),(59,32,'Wednesday','Breakfast'),(60,36,'Wednesday','Breakfast'),(61,37,'Wednesday','Breakfast'),(62,38,'Wednesday','Breakfast'),(64,8,'Wednesday','Lunch'),(65,15,'Wednesday','Lunch'),(66,22,'Wednesday','Lunch'),(67,24,'Wednesday','Lunch'),(68,35,'Wednesday','Lunch'),(69,41,'Wednesday','Lunch'),(71,29,'Wednesday','Snacks'),(72,32,'Wednesday','Snacks'),(74,5,'Wednesday','Dinner'),(75,23,'Wednesday','Dinner'),(76,24,'Wednesday','Dinner'),(77,40,'Wednesday','Dinner'),(78,41,'Wednesday','Dinner'),(79,48,'Wednesday','Dinner'),(81,2,'Thursday','Breakfast'),(82,4,'Thursday','Breakfast'),(83,32,'Thursday','Breakfast'),(84,37,'Thursday','Breakfast'),(85,38,'Thursday','Breakfast'),(86,43,'Thursday','Breakfast'),(88,11,'Thursday','Lunch'),(89,17,'Thursday','Lunch'),(90,23,'Thursday','Lunch'),(91,24,'Thursday','Lunch'),(92,35,'Thursday','Lunch'),(93,39,'Thursday','Lunch'),(95,28,'Thursday','Snacks'),(96,32,'Thursday','Snacks'),(98,12,'Thursday','Dinner'),(99,19,'Thursday','Dinner'),(100,22,'Thursday','Dinner'),(101,25,'Thursday','Dinner'),(102,39,'Thursday','Dinner'),(103,40,'Thursday','Dinner'),(104,47,'Thursday','Dinner'),(105,2,'Friday','Breakfast'),(106,6,'Friday','Breakfast'),(107,14,'Friday','Breakfast'),(108,32,'Friday','Breakfast'),(109,37,'Friday','Breakfast'),(110,38,'Friday','Breakfast'),(112,11,'Friday','Lunch'),(113,15,'Friday','Lunch'),(114,22,'Friday','Lunch'),(115,24,'Friday','Lunch'),(116,35,'Friday','Lunch'),(117,39,'Friday','Lunch'),(119,26,'Friday','Snacks'),(120,34,'Friday','Snacks'),(122,9,'Friday','Dinner'),(123,24,'Friday','Dinner'),(124,35,'Friday','Dinner'),(125,39,'Friday','Dinner'),(126,40,'Friday','Dinner'),(127,48,'Friday','Dinner'),(129,1,'Saturday','Breakfast'),(130,2,'Saturday','Breakfast'),(131,4,'Saturday','Breakfast'),(132,32,'Saturday','Breakfast'),(133,36,'Saturday','Breakfast'),(134,37,'Saturday','Breakfast'),(136,16,'Saturday','Lunch'),(137,17,'Saturday','Lunch'),(138,23,'Saturday','Lunch'),(139,24,'Saturday','Lunch'),(140,35,'Saturday','Lunch'),(141,41,'Saturday','Lunch'),(143,27,'Saturday','Snacks'),(144,32,'Saturday','Snacks'),(146,12,'Saturday','Dinner'),(147,14,'Saturday','Dinner'),(148,23,'Saturday','Dinner'),(149,24,'Saturday','Dinner'),(150,39,'Saturday','Dinner'),(151,40,'Saturday','Dinner'),(152,50,'Saturday','Dinner'),(153,2,'Sunday','Breakfast'),(154,32,'Sunday','Breakfast'),(155,37,'Sunday','Breakfast'),(156,38,'Sunday','Breakfast'),(157,44,'Sunday','Breakfast'),(158,49,'Sunday','Breakfast'),(160,35,'Sunday','Lunch'),(161,40,'Sunday','Lunch'),(162,41,'Sunday','Lunch'),(163,42,'Sunday','Lunch'),(167,30,'Sunday','Snacks'),(168,34,'Sunday','Snacks'),(170,5,'Sunday','Dinner'),(171,9,'Sunday','Dinner'),(172,20,'Sunday','Dinner'),(173,22,'Sunday','Dinner'),(174,24,'Sunday','Dinner'),(175,39,'Sunday','Dinner'),(176,40,'Sunday','Dinner'),(177,48,'Sunday','Dinner');
/*!40000 ALTER TABLE `DailyMenu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MenuItem`
--

DROP TABLE IF EXISTS `MenuItem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `MenuItem` (
  `item_id` int NOT NULL AUTO_INCREMENT,
  `item_name` varchar(100) NOT NULL,
  `cost` int NOT NULL,
  `is_available` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`item_id`),
  CONSTRAINT `menuitem_chk_1` CHECK ((`cost` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MenuItem`
--

LOCK TABLES `MenuItem` WRITE;
/*!40000 ALTER TABLE `MenuItem` DISABLE KEYS */;
INSERT INTO `MenuItem` VALUES (1,'Aloo Pyaz Paratha',15,1),(2,'Toasted Bread',5,1),(3,'Pav Bhaji',25,1),(4,'Boiled Egg',8,1),(5,'Egg Curry',20,1),(6,'Bread Omelette',10,1),(7,'Dal Chana',20,1),(8,'Dal Makhani',20,1),(9,'Chana Dal',20,1),(10,'Arhar Dal',20,1),(11,'Dal Tadka',20,1),(12,'Mix Dal',20,1),(13,'Aloo Gobhi Matar',20,1),(14,'Aloo Sabzi',20,1),(15,'Mix Veg',20,1),(16,'Kala Chana',20,1),(17,'Aloo Masala',20,1),(18,'Matar Paneer',25,1),(19,'Kadai Paneer',25,1),(20,'Malai Kofta',25,1),(21,'Paneer Thali',25,1),(22,'Rice',10,1),(23,'Jeera Rice',10,1),(24,'Roti',5,1),(25,'Poori',5,1),(26,'Veg Noodles',25,1),(27,'French Fries',25,1),(28,'Samosa',25,1),(29,'Piyaz Ki Kachori',25,1),(30,'Bhel Poori',25,1),(31,'Bread Roll',25,1),(32,'Tea',5,1),(33,'Milk',5,1),(34,'Coffee',5,1),(35,'Raita',5,1),(36,'Curd',5,1),(37,'Butter',5,1),(38,'Jam',5,1),(39,'Salad',5,1),(40,'Achar',5,1),(41,'Green Salad',5,1),(42,'Punjabi Chole Bhature',25,1),(43,'Matar Kulcha',25,1),(44,'Masala Dosa',25,1),(45,'Chole Bhature',25,1),(46,'Rice Kheer',15,1),(47,'Motichoor Ladoo',15,1),(48,'Gulab Jamun',15,1),(49,'Sooji Halwa',15,1),(50,'Ice Cream',15,1),(51,'Besan Ladoo',15,1);
/*!40000 ALTER TABLE `MenuItem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Student`
--

DROP TABLE IF EXISTS `Student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Student` (
  `roll_no` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `balance` int DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`roll_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Student`
--

LOCK TABLES `Student` WRITE;
/*!40000 ALTER TABLE `Student` DISABLE KEYS */;
/*!40000 ALTER TABLE `Student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TransactionLog`
--

DROP TABLE IF EXISTS `TransactionLog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TransactionLog` (
  `txn_id` int NOT NULL AUTO_INCREMENT,
  `roll_no` varchar(50) NOT NULL,
  `item_id` int NOT NULL,
  `quantity` int DEFAULT '1',
  `total_cost` int NOT NULL,
  `txn_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`txn_id`),
  KEY `roll_no` (`roll_no`),
  KEY `item_id` (`item_id`),
  CONSTRAINT `transactionlog_ibfk_1` FOREIGN KEY (`roll_no`) REFERENCES `Student` (`roll_no`),
  CONSTRAINT `transactionlog_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `MenuItem` (`item_id`),
  CONSTRAINT `transactionlog_chk_1` CHECK ((`quantity` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TransactionLog`
--

LOCK TABLES `TransactionLog` WRITE;
/*!40000 ALTER TABLE `TransactionLog` DISABLE KEYS */;
/*!40000 ALTER TABLE `TransactionLog` ENABLE KEYS */;
UNLOCK TABLES;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-11-11 23:32:54
