-- MySQL dump 10.13  Distrib 8.0.31, for macos13.0 (arm64)
--
-- Host: localhost    Database: LittleLemonDB
-- ------------------------------------------------------
-- Server version	8.0.31

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Bookings`
--

DROP TABLE IF EXISTS `Bookings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Bookings` (
  `BookingID` int NOT NULL,
  `Customer_CustomerID` int NOT NULL,
  `Orders_OrderID` int NOT NULL,
  `TabbleNum` int NOT NULL,
  `BookingDate` datetime NOT NULL,
  `Staff_StaffID` int NOT NULL,
  PRIMARY KEY (`BookingID`),
  KEY `fk_Bookings_Customer_idx` (`Customer_CustomerID`),
  KEY `fk_Bookings_Orders1_idx` (`Orders_OrderID`),
  KEY `fk_Bookings_Staff1_idx` (`Staff_StaffID`),
  CONSTRAINT `fk_Bookings_Customer` FOREIGN KEY (`Customer_CustomerID`) REFERENCES `Customer` (`CustomerID`),
  CONSTRAINT `fk_Bookings_Orders1` FOREIGN KEY (`Orders_OrderID`) REFERENCES `Orders` (`OrderID`),
  CONSTRAINT `fk_Bookings_Staff1` FOREIGN KEY (`Staff_StaffID`) REFERENCES `Staff` (`StaffID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Bookings`
--

LOCK TABLES `Bookings` WRITE;
/*!40000 ALTER TABLE `Bookings` DISABLE KEYS */;
/*!40000 ALTER TABLE `Bookings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Customer`
--

DROP TABLE IF EXISTS `Customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Customer` (
  `CustomerID` int NOT NULL,
  `Name` varchar(200) NOT NULL,
  `Email` varchar(255) NOT NULL,
  `PhoneNumber` int DEFAULT NULL,
  PRIMARY KEY (`CustomerID`),
  UNIQUE KEY `Email_UNIQUE` (`Email`),
  UNIQUE KEY `PhoneNumber_UNIQUE` (`PhoneNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Customer`
--

LOCK TABLES `Customer` WRITE;
/*!40000 ALTER TABLE `Customer` DISABLE KEYS */;
/*!40000 ALTER TABLE `Customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Menu`
--

DROP TABLE IF EXISTS `Menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Menu` (
  `MenuID` int NOT NULL,
  `Cuisine` varchar(45) NOT NULL,
  PRIMARY KEY (`MenuID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Menu`
--

LOCK TABLES `Menu` WRITE;
/*!40000 ALTER TABLE `Menu` DISABLE KEYS */;
/*!40000 ALTER TABLE `Menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MenuItem`
--

DROP TABLE IF EXISTS `MenuItem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `MenuItem` (
  `MenuItemID` int NOT NULL,
  `Menu_MenuID` int NOT NULL,
  `ItemType` varchar(45) NOT NULL,
  `ItemName` varchar(45) NOT NULL,
  `ItemPrice` decimal(5,2) NOT NULL,
  PRIMARY KEY (`MenuItemID`),
  KEY `fk_MenuItem_Menu1_idx` (`Menu_MenuID`),
  CONSTRAINT `fk_MenuItem_Menu1` FOREIGN KEY (`Menu_MenuID`) REFERENCES `Menu` (`MenuID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MenuItem`
--

LOCK TABLES `MenuItem` WRITE;
/*!40000 ALTER TABLE `MenuItem` DISABLE KEYS */;
/*!40000 ALTER TABLE `MenuItem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OrderDeliveryStatus`
--

DROP TABLE IF EXISTS `OrderDeliveryStatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `OrderDeliveryStatus` (
  `OrderDeliveryStatusID` int NOT NULL,
  `DeliveryDate` datetime DEFAULT NULL,
  `Status` varchar(45) NOT NULL,
  PRIMARY KEY (`OrderDeliveryStatusID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OrderDeliveryStatus`
--

LOCK TABLES `OrderDeliveryStatus` WRITE;
/*!40000 ALTER TABLE `OrderDeliveryStatus` DISABLE KEYS */;
/*!40000 ALTER TABLE `OrderDeliveryStatus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OrderItems`
--

DROP TABLE IF EXISTS `OrderItems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `OrderItems` (
  `OrderItemsID` int NOT NULL,
  `Orders_OrderID` int NOT NULL,
  `MenuItem_MenuItemID` int NOT NULL,
  PRIMARY KEY (`OrderItemsID`),
  KEY `fk_OrderItems_Orders1_idx` (`Orders_OrderID`),
  KEY `fk_OrderItems_MenuItem1_idx` (`MenuItem_MenuItemID`),
  CONSTRAINT `fk_OrderItems_MenuItem1` FOREIGN KEY (`MenuItem_MenuItemID`) REFERENCES `MenuItem` (`MenuItemID`),
  CONSTRAINT `fk_OrderItems_Orders1` FOREIGN KEY (`Orders_OrderID`) REFERENCES `Orders` (`OrderID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OrderItems`
--

LOCK TABLES `OrderItems` WRITE;
/*!40000 ALTER TABLE `OrderItems` DISABLE KEYS */;
/*!40000 ALTER TABLE `OrderItems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Orders`
--

DROP TABLE IF EXISTS `Orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Orders` (
  `OrderID` int NOT NULL,
  `OrderDate` datetime NOT NULL,
  `Quantity` int NOT NULL,
  `TotalCost` int NOT NULL,
  `OrderDeliveryStatus_OrderDeliveryStatusID` int NOT NULL,
  PRIMARY KEY (`OrderID`),
  KEY `fk_Orders_OrderDeliveryStatus1_idx` (`OrderDeliveryStatus_OrderDeliveryStatusID`),
  CONSTRAINT `fk_Orders_OrderDeliveryStatus1` FOREIGN KEY (`OrderDeliveryStatus_OrderDeliveryStatusID`) REFERENCES `OrderDeliveryStatus` (`OrderDeliveryStatusID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Orders`
--

LOCK TABLES `Orders` WRITE;
/*!40000 ALTER TABLE `Orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `Orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Staff`
--

DROP TABLE IF EXISTS `Staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Staff` (
  `StaffID` int NOT NULL,
  `Name` varchar(200) NOT NULL,
  `Position` varchar(45) NOT NULL,
  `AnnualSalary` int NOT NULL,
  PRIMARY KEY (`StaffID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Staff`
--

LOCK TABLES `Staff` WRITE;
/*!40000 ALTER TABLE `Staff` DISABLE KEYS */;
/*!40000 ALTER TABLE `Staff` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-04-23 22:37:33
