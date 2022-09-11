-- MySQL dump 10.13  Distrib 8.0.28, for macos11 (x86_64)
--
-- Host: 127.0.0.1    Database: vaccine_delivery_system
-- ------------------------------------------------------
-- Server version	8.0.28

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

--
-- Table structure for table `batch`
--

DROP TABLE IF EXISTS `batch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `batch` (
  `batch_id` int NOT NULL,
  `manufacture_date` date DEFAULT NULL,
  `expiry_date` date DEFAULT NULL,
  `batch_weight` varchar(45) DEFAULT NULL,
  `warehouse_no` int DEFAULT NULL,
  PRIMARY KEY (`batch_id`),
  KEY `warehouse_no` (`warehouse_no`),
  CONSTRAINT `batch_ibfk_1` FOREIGN KEY (`warehouse_no`) REFERENCES `Warehouse` (`warehouse_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `batch`
--

LOCK TABLES `batch` WRITE;
/*!40000 ALTER TABLE `batch` DISABLE KEYS */;
INSERT INTO `batch` VALUES 
(12,'2022-04-01','2022-04-19','2400g',8),
(34,'2022-05-10','2022-06-06','2550g',11),
(89,'2022-08-15','2022-09-01','3060g',13),
(345,'2022-05-10','2022-06-06','2550g',12),
(2345,'2022-08-15','2022-09-01','3060g',9),
(2472,'2022-04-01','2022-04-19','2400g',10);
/*!40000 ALTER TABLE `batch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `driver_credentials`
--

DROP TABLE IF EXISTS `driver_credentials`;
/*!50001 DROP VIEW IF EXISTS `driver_credentials`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE VIEW `driver_credentials` AS SELECT 
 1 AS `first_name`,
 1 AS `driver_id`;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee` (
  `employee_id` int NOT NULL,
  `warehouse_no` int NOT NULL,
  `first_name` varchar(45) NOT NULL,
  `last_name` varchar(45) NOT NULL,
  `date_of_birth` date NOT NULL,
  PRIMARY KEY (`employee_id`),
  KEY `warehouse_no` (`warehouse_no`),
  CONSTRAINT `employee_ibfk_1` FOREIGN KEY (`warehouse_no`) REFERENCES `warehouse` (`warehouse_id`),
  CONSTRAINT `check_id_valid` CHECK (((length(`employee_id`) > 0) and (length(`employee_id`) <= 300)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` VALUES 
(22,2,'Conor','Murphy','1976-11-19'),
(23,2,'Elaine','Rooney','1982-08-12'),
(24,2,'Stephen','Kennedy','1999-02-15'),
(112,6,'David','Quinn','1996-04-19'),
(113,6,'Tom','Divine','1984-05-06'),
(114,6,'John','O\'Connor','1989-03-17');
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` TRIGGER `addEmployee` AFTER INSERT ON `employee` FOR EACH ROW BEGIN
UPDATE Warehouse
SET no_of_employees = no_of_employees + 1
WHERE warehouse_id = new.warehouse_no;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `hospital`
--

DROP TABLE IF EXISTS `hospital`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hospital` (
  `hopsital_address` varchar(45) NOT NULL,
  `hospital_name` varchar(45) NOT NULL,
  `driver_id` int NOT NULL,
  `tracking` varchar(45) NOT NULL,
  PRIMARY KEY (`hopsital_address`),
  KEY `driver_id` (`driver_id`),
  CONSTRAINT `hospital_ibfk_1` FOREIGN KEY (`driver_id`) REFERENCES `employee` (`employee_id`),
  CONSTRAINT `check_hospital_tracking` CHECK ((`tracking` in (_utf8mb4'delivered',_utf8mb4'not delivered')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hospital`
--

LOCK TABLES `hospital` WRITE;
/*!40000 ALTER TABLE `hospital` DISABLE KEYS */;
INSERT INTO `hospital` VALUES 
('Beacon Court, Sandyford, Dublin','Beacon Hospital',146,'delivered'),
('Beaumont Road, Dublin','Beaumont Hospital',147,'delivered'),
('Block Road, Ballyroan, Portlaoise','Midland Regional Hospital',148,'not delivered'),
('James Street, Dublin','St. James\'s Hospital',149,'delivered'),
('Wilton Manor, Glasheen, Cork','Cork University Hospital',150,'not delivered');
/*!40000 ALTER TABLE `hospital` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vaccination_centre`
--

DROP TABLE IF EXISTS `vaccination_centre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vaccination_centre` (
  `centre_name` varchar(45) NOT NULL,
  `centre_address` varchar(60) NOT NULL,
  `tracking` varchar(45) NOT NULL,
  `driver_id` int NOT NULL,
  PRIMARY KEY (`centre_name`),
  KEY `driver_id` (`driver_id`),
  CONSTRAINT `vaccination_centre_ibfk_1` FOREIGN KEY (`driver_id`) REFERENCES `employee` (`employee_id`),
  CONSTRAINT `check_vaccination_centre_tracking` CHECK ((`tracking` in (_utf8mb4'delivered',_utf8mb4'not delivered')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vaccination_centre`
--

LOCK TABLES `vaccination_centre` WRITE;
/*!40000 ALTER TABLE `vaccination_centre` DISABLE KEYS */;
INSERT INTO `vaccination_centre` VALUES 
('Croke Park Vaccination Centre','Jonses Road, Dublin','not delivered',2),
('Kerry Vaccination Centre','Borg Warner, Tralee, Kerry','delivered',5),
('Kilkenny Vaccination Centre','Dublin Road, Lyrath, Kilkenny','delivered',26),
('Letterkenny vaccination centre','Letterkenny Business Park, Letterkenny, Donegal','delivered',34),
('Mayo Vaccination Centre','Breaffy, Castlebar, Mayo','delivered',22),
('Richmond Barracks Vaccination Centre','St. Michael\'s Estate, Inchicore, Dublin','not delivered',2);
/*!40000 ALTER TABLE `vaccination_centre` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vaccine`
--

DROP TABLE IF EXISTS `vaccine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vaccine` (
  `vaccine_id` varchar(45) NOT NULL,
  `vaccine_name` varchar(45) DEFAULT NULL,
  `batch_no` int DEFAULT NULL,
  `expiry_date` date DEFAULT NULL,
  PRIMARY KEY (`vaccine_id`),
  KEY `batch_no` (`batch_no`),
  CONSTRAINT `vaccine_ibfk_1` FOREIGN KEY (`batch_no`) REFERENCES `batch` (`batch_id`),
  CONSTRAINT `check_vaccine_id_is_valid` CHECK (((length(`vaccine_id`) > 0) and (length(`vaccine_id`) <= 5)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vaccine`
--

LOCK TABLES `vaccine` WRITE;
/*!40000 ALTER TABLE `vaccine` DISABLE KEYS */;
INSERT INTO `vaccine` VALUES 
('1','Janssen',271,'2022-09-01'),
('2','Moderna',122,'2022-06-06'),
('3','Pfizer',4,'2022-04-19'),
('4','AstraZeneca',236,'2022-05-05'),
('5','Novavax',490,'2022-10-10');
/*!40000 ALTER TABLE `vaccine` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` TRIGGER `addVaccineID` AFTER INSERT ON `vaccine` FOR EACH ROW BEGIN
UPDATE Vaccine
SET vaccine_id = vaccine_id + 1
WHERE vaccine_id = new.vaccine_name;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `vehicle`
--

DROP TABLE IF EXISTS `vehicle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vehicle` (
  `vehicle_id` int NOT NULL,
  `vehicle_registration` varchar(45) DEFAULT NULL,
  `vehicle_manufacturer` varchar(45) DEFAULT NULL,
  `driver_id` int DEFAULT NULL,
  `drop_off_location` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`vehicle_id`),
  KEY `driver_id` (`driver_id`),
  CONSTRAINT `vehicle_ibfk_1` FOREIGN KEY (`driver_id`) REFERENCES `employee` (`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehicle`
--

LOCK TABLES `vehicle` WRITE;
/*!40000 ALTER TABLE `vehicle` DISABLE KEYS */;
INSERT INTO `vehicle` VALUES 
(1,'191-D-2094','Mercedes',7,'St. James\'s Hospital'),
(2,'182-C-312','Volkswagen',11,'Cork University Hospital'),
(3,'201-KY-662','Renault',26,'Kerry Vaccination Centre'),
(4,'192-D-29034','Volkswagen',2,'Croke Park Vaccination Centre'),
(5,'211-KK-7864','Fiat',18,'Midland Regional Hospital'),
(15,'191-D-2094','Mercedes',7,'St. James\'s Hospital');
/*!40000 ALTER TABLE `vehicle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `vehicle_driver`
--

DROP TABLE IF EXISTS `vehicle_driver`;
/*!50001 DROP VIEW IF EXISTS `vehicle_driver`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
 CREATE VIEW `vehicle_driver` AS SELECT 
 1 AS `Driver First Name`,
 1 AS `Driver Last Name`,
 1 AS `Driver DOB`,
 1 AS `Vehicle Identification`,
 1 AS `Vehicle Registration`,
 1 AS `Vehicle Type`;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `Warehouse`
--

DROP TABLE IF EXISTS `Warehouse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Warehouse` (
  `warehouse_id` int NOT NULL,
  `warehouse_address` varchar(60) NOT NULL,
  `no_of_employees` int NOT NULL,
  `batch_capacity` int NOT NULL,
  PRIMARY KEY (`warehouse_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Warehouse`
--

LOCK TABLES `Warehouse` WRITE;
/*!40000 ALTER TABLE `Warehouse` DISABLE KEYS */;
INSERT INTO `Warehouse` VALUES 
(1,'Ballycoolin Industrial Estate, Dublin',32,25000),
(2,'Dublin Industrial Estate, Glasnevin, Dublin',41,33000),
(3,'Blyry Business Park, Athlone, Westmeath',23,18000),
(4,'Doughcloyne Business Park, Sarsfield Road, Cork',16,12000),
(5,'Ballybane Industrial Estate, Galway City',19,14500);
/*!40000 ALTER TABLE `Warehouse` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'vaccine_delivery_system'
--

--
-- Dumping routines for database 'vaccine_delivery_system'
--

--
-- Final view structure for view `driver_credentials`
--

/*!50001 DROP VIEW IF EXISTS `driver_credentials`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `driver_credentials` AS select `employee`.`first_name` AS `first_name`,`vehicle`.`driver_id` AS `driver_id` from (`employee` join `vehicle`) where (`employee`.`employee_id` = `vehicle`.`driver_id`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vehicle_driver`
--

/*!50001 DROP VIEW IF EXISTS `vehicle_driver`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vehicle_driver` AS select `employee`.`first_name` AS `Driver First Name`,`employee`.`last_name` AS `Driver Last Name`,`employee`.`date_of_birth` AS `Driver DOB`,`vehicle`.`vehicle_id` AS `Vehicle Identification`,`vehicle`.`vehicle_registration` AS `Vehicle Registration`,`vehicle`.`vehicle_manufacturer` AS `Vehicle Type` from (`vehicle` join `employee` on((`employee`.`employee_id` = `vehicle`.`driver_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-03-24 13:37:18
