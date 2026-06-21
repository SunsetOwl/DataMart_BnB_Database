CREATE DATABASE  IF NOT EXISTS `earthbnb` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `earthbnb`;
-- MySQL dump 10.13  Distrib 8.0.45, for Win64 (x86_64)
--
-- Host: localhost    Database: earthbnb
-- ------------------------------------------------------
-- Server version	8.0.45

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
-- Table structure for table `accommodations`
--

DROP TABLE IF EXISTS `accommodations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accommodations` (
  `accomm_id` int NOT NULL AUTO_INCREMENT,
  `host_id` int NOT NULL,
  `address_id` int NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text,
  `maximum_guests` int NOT NULL,
  `bedrooms` int NOT NULL,
  `bathrooms` int NOT NULL,
  `check_in_time` time NOT NULL,
  `check_out_time` time NOT NULL,
  `square_footage` int DEFAULT NULL,
  `visible` tinyint(1) NOT NULL,
  PRIMARY KEY (`accomm_id`),
  UNIQUE KEY `accomm_id` (`accomm_id`),
  UNIQUE KEY `address_id` (`address_id`),
  KEY `fk_accommodations_host` (`host_id`),
  CONSTRAINT `fk_accommodations_address` FOREIGN KEY (`address_id`) REFERENCES `addresses` (`address_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_accommodations_host` FOREIGN KEY (`host_id`) REFERENCES `hosts` (`user_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accommodations`
--

LOCK TABLES `accommodations` WRITE;
/*!40000 ALTER TABLE `accommodations` DISABLE KEYS */;
INSERT INTO `accommodations` VALUES (1,40,41,'Alpine Mountain Cabin','Cozy cabin near Garmisch-Partenkirchen with mountain views, wood interiors, and easy access to hiking trails.',4,2,1,'15:00:00','10:00:00',72,1),(2,43,42,'Hamburg City Loft','Modern loft close to Hamburg nightlife and harbour attractions, ideal for short city stays.',2,1,1,'16:00:00','11:00:00',55,1),(3,14,43,'Quiet Berlin Garden Studio','Compact garden studio in a calm Berlin neighborhood with a private patio and bright workspace.',2,1,1,'15:00:00','10:00:00',38,1),(4,11,44,'Historic Salzburg Guest Flat','Charming flat in central Salzburg with historic details and quick access to the old town.',3,1,1,'14:00:00','10:00:00',48,1),(5,12,45,'Lucerne Lakefront Apartment','Bright apartment near the lake with scenic views, a dining area, and comfortable space for families.',5,2,1,'15:00:00','11:00:00',82,1),(6,13,46,'Amsterdam Canal House Suite','Stylish suite in a classic canal house with water views and easy access to museums and cafés.',2,1,1,'15:00:00','10:00:00',46,1),(7,21,47,'Stockholm Old Town Room','Comfortable room in the heart of Stockholm old town, perfect for solo travelers or couples.',2,1,1,'16:00:00','10:00:00',30,1),(8,35,48,'Central Paris Flat','Elegant central Paris flat near major sights, with a full kitchen and cozy living area.',4,2,1,'15:00:00','11:00:00',65,1),(9,18,49,'Barcelona Gothic Quarter Stay','Characterful apartment in the Gothic Quarter with balcony access and walkable city highlights.',3,1,1,'15:00:00','10:00:00',44,1),(10,33,50,'Roman Holiday Apartment','Warm and traditional Rome apartment with rooftop access and classic city atmosphere.',4,2,1,'14:00:00','10:00:00',70,1),(11,24,51,'Athens Acropolis View Studio','Small studio with a beautiful view toward the Acropolis, suited for short cultural trips.',2,1,1,'15:00:00','11:00:00',34,1),(12,31,52,'Miami Beachfront Condo','Sunny beachfront condo with balcony, pool access, and a relaxed coastal atmosphere.',4,2,2,'16:00:00','11:00:00',88,1),(13,23,53,'Toronto Downtown Rental','Convenient downtown apartment with skyline views and quick access to transit and restaurants.',3,1,1,'15:00:00','10:00:00',52,1),(14,23,54,'Sydney Harbour Apartment','Spacious harbour apartment with balcony views, modern kitchen, and bright living area.',5,2,2,'15:00:00','10:00:00',95,1),(15,38,55,'Classic London Flat','Traditional London flat near Baker Street with classic details and modern amenities.',4,2,1,'16:00:00','11:00:00',68,1),(16,38,56,'Dublin City Room','Simple and welcoming city room near central Dublin, ideal for weekend stays.',2,1,1,'15:00:00','10:00:00',28,1),(17,37,57,'Harajuku Micro Flat','Efficient Tokyo micro flat near Harajuku, designed for compact but comfortable city travel.',2,1,1,'16:00:00','10:00:00',24,1),(18,27,58,'Dubai Beach Apartment','Bright beach apartment with balcony, modern interiors, and easy access to the waterfront.',4,2,2,'15:00:00','11:00:00',90,1),(19,25,59,'Lisbon Balcony Flat','Sunny Lisbon flat with balcony, tiled details, and walkable access to historic streets.',3,1,1,'15:00:00','10:00:00',50,1),(20,13,60,'Brussels Market Studio','Compact Brussels studio near the Grand Place, suitable for short city breaks.',2,1,1,'14:00:00','10:00:00',32,0),(21,83,93,'Minimal Berlin Studio','Clean and practical Berlin studio near cafés, nightlife, and public transport.',2,1,1,'15:00:00','10:00:00',36,1),(22,84,94,'Vienna Courtyard Apartment','Quiet apartment with courtyard view in a central Vienna neighborhood, ideal for longer city stays.',3,1,1,'15:00:00','11:00:00',49,1),(23,85,95,'Zurich Riverside Room','Comfortable private room close to the Limmat, suited for business travelers and weekend visits.',2,1,1,'16:00:00','10:00:00',32,1),(24,86,96,'Amsterdam Artist Flat','Bright and characterful flat in Amsterdam with creative decor and canal-area charm.',2,1,1,'15:00:00','10:00:00',43,1),(25,87,97,'Stockholm Harbour Studio','Compact harbour-side studio in Stockholm with easy access to old town and ferry routes.',2,1,1,'16:00:00','11:00:00',35,1),(26,88,98,'San Francisco Hilltop Room','Private room in San Francisco with city views and quick access to central neighborhoods.',2,1,1,'15:00:00','10:00:00',40,1),(27,89,99,'Nuremberg Old Town Flat','Traditional old town flat with warm interiors and walking-distance access to historic sights.',3,1,1,'14:00:00','10:00:00',46,1),(28,90,100,'Copenhagen Cozy Flat','Comfortable Copenhagen apartment with simple Scandinavian style and a relaxed neighborhood feel.',2,1,1,'15:00:00','11:00:00',42,1),(29,91,101,'Athens Plaka Apartment','Sunny apartment in Plaka with classic city atmosphere and quick access to historic landmarks.',3,1,1,'15:00:00','10:00:00',45,1),(30,92,102,'Brooklyn Brownstone Room','Welcoming room in a Brooklyn brownstone, close to local cafés, parks, and subway connections.',2,1,1,'16:00:00','11:00:00',38,1),(31,93,103,'Madrid Sunny Apartment','Bright Madrid apartment with warm decor, central access, and space for a small group.',4,2,1,'15:00:00','10:00:00',62,1),(32,94,104,'Warsaw City Studio','Modern Warsaw studio near restaurants, shops, and cultural sights, ideal for short stays.',2,1,1,'14:00:00','10:00:00',34,1);
/*!40000 ALTER TABLE `accommodations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `addresses`
--

DROP TABLE IF EXISTS `addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `addresses` (
  `address_id` int NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) DEFAULT NULL,
  `street` varchar(255) NOT NULL,
  `street_no` varchar(20) NOT NULL,
  `postal_code` varchar(20) NOT NULL,
  `city` varchar(100) NOT NULL,
  `state` varchar(20) DEFAULT NULL,
  `country_id` int NOT NULL,
  PRIMARY KEY (`address_id`),
  UNIQUE KEY `address_id` (`address_id`),
  KEY `fk_addresses_country` (`country_id`),
  CONSTRAINT `fk_addresses_country` FOREIGN KEY (`country_id`) REFERENCES `countries` (`country_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=105 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `addresses`
--

LOCK TABLES `addresses` WRITE;
/*!40000 ALTER TABLE `addresses` DISABLE KEYS */;
INSERT INTO `addresses` VALUES (1,'Private apartment','Lindenweg','14','80331','Munich','BY',1),(2,'Private apartment','Bergstraße','8','10115','Berlin','BE',1),(3,'Private apartment','Mariahilfer Straße','22','1060','Vienna','W',2),(4,'Private apartment','Seefeldstrasse','41','8008','Zurich','ZH',3),(5,'Private apartment','Keizersgracht','118','1015 CW','Amsterdam','NH',4),(6,'Private apartment','Hafenstraße','5','20457','Hamburg','HH',1),(7,'Private apartment','Sveavägen','73','113 50','Stockholm','AB',5),(8,'Private apartment','Market Street','621','94105','San Francisco','CA',11),(9,'Private apartment','Nordring','19','90409','Nuremberg','BY',1),(10,'Private apartment','Römerstraße','27','50667','Cologne','NW',1),(11,'Private apartment','Graben','11','1010','Vienna','W',2),(12,'Private apartment','Rue du Rhône','15','1204','Geneva','GE',3),(13,'Private apartment','Prinsengracht','204','1016 HD','Amsterdam','NH',4),(14,'Private apartment','Schlossallee','3','53113','Bonn','NW',1),(15,'Private apartment','Königstraße','55','70173','Stuttgart','BW',1),(16,'Private apartment','Theaterplatz','9','01067','Dresden','SN',1),(17,'Private apartment','Goethestraße','16','60313','Frankfurt','HE',1),(18,'Private apartment','Carrer de Mallorca','301','08037','Barcelona','CT',8),(19,'Private apartment','Am Markt','4','28195','Bremen','HB',1),(20,'Private apartment','Holzmarkt','31','50676','Cologne','NW',1),(21,'Private apartment','Drottninggatan','46','111 21','Stockholm','AB',5),(22,'Private apartment','Nyhavn','18','1051','Copenhagen','84',24),(23,'Private apartment','West 23rd Street','144','10011','New York','NY',11),(24,'Private apartment','Ermou Street','33','10563','Athens','I',10),(25,'Private apartment','Tahrir Square Road','7','11512','Cairo','C',19),(26,'Private apartment','Brooklyn Avenue','82','11216','New York','NY',11),(27,'Private apartment','Al Wasl Road','210','00000','Dubai','DU',17),(28,'Private apartment','Via Torino','64','20123','Milan','MI',9),(29,'Private apartment','Calle Atocha','97','28012','Madrid','MD',8),(30,'Private apartment','Marszałkowska','58','00-545','Warsaw','MZ',20),(31,'Private apartment','Larimer Street','1930','80202','Denver','CO',11),(32,'Private apartment','King Fahd Road','44','12271','Riyadh','01',18),(33,'Private apartment','Via Roma','21','00184','Rome','RM',9),(34,'Private apartment','Calle San Bernardo','12','28015','Madrid','MD',8),(35,'Private apartment','Rue Oberkampf','88','75011','Paris','IDF',7),(36,'Private apartment','Karl Johans gate','17','0159','Oslo','03',6),(37,'Private apartment','Shibuya Crossing Lane','5','150-0002','Tokyo','13',16),(38,'Private apartment','Dame Street','29','D02','Dublin','D',15),(39,'Private apartment','Nerudova','14','118 00','Prague','10',21),(40,'Private apartment','Isarstraße','6','81675','Munich','BY',1),(41,'Mountain cabin','Alpenblickweg','2','82467','Garmisch-Partenkirchen','BY',1),(42,'City loft','Reeperbahn','112','20359','Hamburg','HH',1),(43,'Garden studio','Kollwitzstraße','45','10405','Berlin','BE',1),(44,'Historic guest flat','Mozartgasse','7','5020','Salzburg','S',2),(45,'Lakefront apartment','Uferstrasse','18','6003','Lucerne','LU',3),(46,'Canal house suite','Herengracht','311','1016 AX','Amsterdam','NH',4),(47,'Old town room','Västerlånggatan','29','111 29','Stockholm','AB',5),(48,'Central Paris flat','Rue de Rivoli','140','75001','Paris','IDF',7),(49,'Gothic Quarter stay','Carrer del Pi','6','08002','Barcelona','CT',8),(50,'Roman holiday apartment','Via dei Coronari','52','00186','Rome','RM',9),(51,'Acropolis view studio','Adrianou Street','24','10555','Athens','I',10),(52,'Beachfront condo','Ocean Drive','728','33139','Miami','FL',11),(53,'Downtown rental','Queen Street West','510','M5V 2B7','Toronto','ON',12),(54,'Harbour apartment','George Street','88','2000','Sydney','NSW',13),(55,'Classic London flat','Baker Street','221B','NW1 6XE','London','ENG',14),(56,'Dublin city room','Grafton Street','44','D02','Dublin','D',15),(57,'Harajuku micro flat','Takeshita Street','13','150-0001','Tokyo','13',16),(58,'Dubai beach apartment','Jumeirah Beach Road','301','00000','Dubai','DU',17),(59,'Lisbon balcony flat','Rua Augusta','99','1100-053','Lisbon','11',22),(60,'Brussels market studio','Grand Place','4','1000','Brussels','BRU',23),(61,'EarthBnB Munich Office','Leopoldstraße','44','80802','Munich','BY',1),(62,'EarthBnB Hamburg Office','Jungfernstieg','16','20354','Hamburg','HH',1),(63,'EarthBnB Cologne Office','Hohenzollernring','58','50672','Cologne','NW',1),(64,'EarthBnB Frankfurt Office','Mainzer Landstraße','90','60327','Frankfurt','HE',1),(65,'EarthBnB Stuttgart Office','Königstraße','71','70173','Stuttgart','BW',1),(66,'EarthBnB Salzburg Office','Linzer Gasse','12','5020','Salzburg','S',2),(67,'EarthBnB Geneva Office','Rue du Mont-Blanc','19','1201','Geneva','GE',3),(68,'EarthBnB Rotterdam Office','Coolsingel','88','3011 AD','Rotterdam','ZH',4),(69,'EarthBnB Gothenburg Office','Avenyn','24','411 36','Gothenburg','O',5),(70,'EarthBnB Oslo Office','Dronningens gate','14','0152','Oslo','03',6),(71,'EarthBnB Lyon Office','Rue Mercière','11','69002','Lyon','ARA',7),(72,'EarthBnB Valencia Office','Carrer Colón','63','46004','Valencia','VC',8),(73,'EarthBnB Milan Office','Corso Buenos Aires','102','20124','Milan','MI',9),(74,'EarthBnB Boston Office','Boylston Street','210','02116','Boston','MA',11),(75,'EarthBnB Vancouver Office','Granville Street','777','V6Z 1K3','Vancouver','BC',12),(76,'EarthBnB Manchester Office','Deansgate','88','M3 2QG','Manchester','ENG',14),(77,'EarthBnB Cork Office','Patrick Street','27','T12','Cork','C',15),(78,'EarthBnB Kyoto Office','Shijo Street','31','600-8001','Kyoto','26',16),(79,'EarthBnB Lisbon Office','Rua Garrett','17','1200-203','Lisbon','11',22),(80,'EarthBnB Brussels South Office','Avenue Louise','204','1050','Brussels','BRU',23),(81,'Private apartment','Getreidegasse','9','5020','Salzburg','S',2),(82,'Private apartment','Witte de Withstraat','31','3012 BM','Rotterdam','ZH',4),(83,'Private apartment','Kungsportsavenyen','19','411 36','Gothenburg','O',5),(84,'Private apartment','Rue de la République','44','69002','Lyon','ARA',7),(85,'Private apartment','Carrer Colón','21','46004','Valencia','VC',8),(86,'Private apartment','Beacon Street','215','02116','Boston','MA',11),(87,'Private apartment','Robson Street','688','V6B 1A1','Vancouver','BC',12),(88,'Private apartment','Oxford Road','117','M1 7DU','Manchester','ENG',14),(89,'Private apartment','Oliver Plunkett Street','12','T12','Cork','C',15),(90,'Private apartment','Karasuma Street','66','600-8008','Kyoto','26',16),(91,'Private apartment','Avenida da Liberdade','155','1250-096','Lisbon','11',22),(92,'Private apartment','Avenue Louise','204','1050','Brussels','BRU',23),(93,'Minimal Berlin Studio','Simon-Dach-Straße','18','10245','Berlin','BE',1),(94,'Vienna Courtyard Apartment','Neubaugasse','44','1070','Vienna','W',2),(95,'Zurich Riverside Room','Limmatquai','72','8001','Zurich','ZH',3),(96,'Amsterdam Artist Flat','Tweede Anjeliersdwarsstraat','9','1015 NR','Amsterdam','NH',4),(97,'Stockholm Harbour Studio','Skeppsbron','12','111 30','Stockholm','AB',5),(98,'San Francisco Hilltop Room','Vallejo Street','920','94133','San Francisco','CA',11),(99,'Nuremberg Old Town Flat','Weißgerbergasse','24','90403','Nuremberg','BY',1),(100,'Copenhagen Cozy Flat','Istedgade','61','1650','Copenhagen','84',24),(101,'Athens Plaka Apartment','Kidathineon','16','10558','Athens','I',10),(102,'Brooklyn Brownstone Room','Bedford Avenue','388','11211','New York','NY',11),(103,'Madrid Sunny Apartment','Calle de Fuencarral','88','28004','Madrid','MD',8),(104,'Warsaw City Studio','Nowy Świat','41','00-042','Warsaw','MZ',20);
/*!40000 ALTER TABLE `addresses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `availabilities`
--

DROP TABLE IF EXISTS `availabilities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `availabilities` (
  `availability_id` int NOT NULL AUTO_INCREMENT,
  `accomm_id` int NOT NULL,
  `valid_from` date NOT NULL,
  `valid_until` date NOT NULL,
  PRIMARY KEY (`availability_id`),
  UNIQUE KEY `availability_id` (`availability_id`),
  KEY `fk_availabilities_accommodation` (`accomm_id`),
  CONSTRAINT `fk_availabilities_accommodation` FOREIGN KEY (`accomm_id`) REFERENCES `accommodations` (`accomm_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `chk_availability_dates` CHECK ((`valid_until` >= `valid_from`))
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `availabilities`
--

LOCK TABLES `availabilities` WRITE;
/*!40000 ALTER TABLE `availabilities` DISABLE KEYS */;
INSERT INTO `availabilities` VALUES (1,1,'2026-01-10','2026-02-28'),(2,1,'2026-04-15','2026-07-14'),(3,2,'2026-02-01','2026-04-30'),(4,2,'2026-08-01','2026-10-31'),(5,3,'2026-01-15','2026-03-31'),(6,3,'2026-07-10','2026-09-30'),(7,4,'2026-03-01','2026-05-31'),(8,4,'2026-12-20','2026-12-31'),(9,5,'2026-02-01','2026-05-15'),(10,5,'2026-06-15','2026-08-31'),(11,6,'2026-01-01','2026-03-31'),(12,6,'2026-09-01','2026-11-30'),(13,7,'2026-04-01','2026-06-30'),(14,8,'2026-02-01','2026-03-15'),(15,8,'2026-05-01','2026-08-31'),(16,8,'2026-11-15','2026-12-20'),(17,9,'2026-03-01','2026-07-31'),(18,10,'2026-04-01','2026-09-30'),(19,11,'2026-05-01','2026-10-31'),(20,12,'2026-01-15','2026-03-15'),(21,12,'2026-04-10','2026-08-20'),(22,12,'2026-09-15','2026-12-15'),(23,13,'2026-02-01','2026-12-15'),(24,14,'2026-03-01','2026-05-20'),(25,14,'2026-06-15','2026-09-15'),(26,15,'2026-01-01','2026-06-30'),(27,16,'2026-04-01','2026-11-30'),(28,17,'2026-02-01','2026-08-31'),(29,18,'2026-01-10','2026-04-20'),(30,18,'2026-05-15','2026-10-15'),(31,19,'2026-03-01','2026-10-31'),(32,20,'2026-01-01','2026-12-31'),(33,21,'2026-02-01','2026-11-30'),(34,22,'2026-01-15','2026-06-15'),(35,22,'2026-07-15','2026-12-15'),(36,23,'2026-03-01','2026-09-30'),(37,24,'2026-04-01','2026-10-31'),(38,25,'2026-05-01','2026-12-15'),(39,26,'2026-02-01','2026-08-31'),(40,27,'2026-01-01','2026-05-31'),(41,28,'2026-06-01','2026-12-31'),(42,29,'2026-03-15','2026-10-15'),(43,30,'2026-04-01','2026-09-30'),(44,31,'2026-02-01','2026-11-30'),(45,32,'2026-01-01','2026-12-31');
/*!40000 ALTER TABLE `availabilities` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_availability_within_pricing_insert` BEFORE INSERT ON `availabilities` FOR EACH ROW BEGIN
  IF NOT EXISTS (
    SELECT 1
    FROM pricing_information pi
    WHERE pi.accomm_id = NEW.accomm_id
      AND pi.pricing_type = 'General'
      AND NEW.valid_from >= pi.valid_from
      AND NEW.valid_until <= pi.valid_until
  ) THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Availability period must be fully covered by a General pricing period.';
  END IF;

  IF EXISTS (
    SELECT 1
    FROM availabilities a
    WHERE a.accomm_id = NEW.accomm_id
      AND (
        NEW.valid_from <= a.valid_until
        AND NEW.valid_until >= a.valid_from
        OR NEW.valid_from = DATE_ADD(a.valid_until, INTERVAL 1 DAY)
        OR DATE_ADD(NEW.valid_until, INTERVAL 1 DAY) = a.valid_from
      )
  ) THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Availability periods may not overlap or be directly consecutive.';
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_availability_within_pricing_update` BEFORE UPDATE ON `availabilities` FOR EACH ROW BEGIN
  IF NOT EXISTS (
    SELECT 1
    FROM pricing_information pi
    WHERE pi.accomm_id = NEW.accomm_id
      AND pi.pricing_type = 'General'
      AND NEW.valid_from >= pi.valid_from
      AND NEW.valid_until <= pi.valid_until
  ) THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Availability period must be fully covered by a General pricing period.';
  END IF;

  IF EXISTS (
    SELECT 1
    FROM availabilities a
    WHERE a.accomm_id = NEW.accomm_id
      AND a.availability_id <> OLD.availability_id
      AND (
        NEW.valid_from <= a.valid_until
        AND NEW.valid_until >= a.valid_from
        OR NEW.valid_from = DATE_ADD(a.valid_until, INTERVAL 1 DAY)
        OR DATE_ADD(NEW.valid_until, INTERVAL 1 DAY) = a.valid_from
      )
  ) THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Availability periods may not overlap or be directly consecutive.';
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `available_features`
--

DROP TABLE IF EXISTS `available_features`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `available_features` (
  `feature_id` int NOT NULL,
  `accomm_id` int NOT NULL,
  `details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`feature_id`,`accomm_id`),
  KEY `fk_available_features_accommodation` (`accomm_id`),
  CONSTRAINT `fk_available_features_accommodation` FOREIGN KEY (`accomm_id`) REFERENCES `accommodations` (`accomm_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_available_features_feature` FOREIGN KEY (`feature_id`) REFERENCES `features` (`feature_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `available_features`
--

LOCK TABLES `available_features` WRITE;
/*!40000 ALTER TABLE `available_features` DISABLE KEYS */;
INSERT INTO `available_features` VALUES (1,1,NULL),(1,2,NULL),(1,3,NULL),(1,4,NULL),(1,5,NULL),(1,6,NULL),(1,7,NULL),(1,8,NULL),(1,9,NULL),(1,10,NULL),(1,11,NULL),(1,12,NULL),(1,13,NULL),(1,14,NULL),(1,15,NULL),(1,16,NULL),(1,17,'Pocket WiFi provided'),(1,18,NULL),(1,19,NULL),(1,20,NULL),(1,21,NULL),(1,22,NULL),(1,23,NULL),(1,24,NULL),(1,25,NULL),(1,26,NULL),(1,27,NULL),(1,28,NULL),(1,29,NULL),(1,30,NULL),(1,31,NULL),(1,32,NULL),(2,1,'Small desk in the bedroom'),(2,2,'Small desk area near the window'),(2,3,'Dedicated workspace facing the garden'),(2,8,'Desk space suitable for laptop work'),(2,13,'Desk near the living room window'),(2,21,'Fold-out desk by the window'),(2,23,'Workspace suitable for laptop use'),(2,24,'Creative desk area'),(2,26,'Desk with city view'),(2,30,'Small desk in the room'),(2,32,'Compact desk space'),(3,2,NULL),(3,6,'Self check-in with digital entry code'),(3,16,'Self check-in with key safe'),(3,20,NULL),(3,21,NULL),(3,25,NULL),(4,1,'Fully equipped kitchen with basic cookware'),(4,2,'Compact kitchen with essentials'),(4,3,'Small kitchenette with stove and fridge'),(4,4,'Kitchen with oven and coffee machine'),(4,5,'Family-sized kitchen and dining area'),(4,6,'Kitchenette with basic appliances'),(4,8,'Full kitchen with cookware'),(4,9,'Kitchen with basic cooking equipment'),(4,10,'Kitchen with stove and refrigerator'),(4,11,'Small kitchen area'),(4,12,'Kitchen with full-size refrigerator'),(4,13,'Kitchen with basic appliances'),(4,14,'Modern kitchen with dishwasher'),(4,15,'Kitchen with oven and kettle'),(4,17,'Compact kitchenette'),(4,18,'Modern kitchen with essential cookware'),(4,19,'Kitchen with basic cookware'),(4,20,'Small kitchenette'),(4,21,'Minimal kitchenette'),(4,22,'Kitchen with coffee machine'),(4,24,'Kitchen with full cookware set'),(4,27,'Kitchen with stove and fridge'),(4,28,'Kitchen with basic cooking equipment'),(4,29,'Kitchen with essential appliances'),(4,31,'Kitchen with oven and cookware'),(4,32,'Small kitchenette'),(5,5,NULL),(5,12,NULL),(5,15,NULL),(5,28,NULL),(7,5,NULL),(7,6,NULL),(7,8,NULL),(7,14,NULL),(7,24,NULL),(8,9,NULL),(8,10,NULL),(8,11,NULL),(8,12,NULL),(8,14,NULL),(8,17,NULL),(8,18,NULL),(8,26,NULL),(8,29,NULL),(8,31,NULL),(9,1,NULL),(9,4,NULL),(9,8,NULL),(9,13,NULL),(9,15,NULL),(9,20,NULL),(9,22,NULL),(9,23,NULL),(9,25,NULL),(9,27,NULL),(9,28,NULL),(9,32,NULL),(10,1,'Indoor fireplace in the living area'),(11,4,'Small balcony facing the street'),(11,5,'Balcony with partial lake view'),(11,6,'Canal-facing balcony access'),(11,9,'Small balcony overlooking the street'),(11,11,'Balcony with city view'),(11,12,'Private balcony facing the beach'),(11,14,'Balcony with harbour view'),(11,18,'Private balcony'),(11,19,'Sunny balcony'),(11,25,'Harbour-facing window balcony'),(11,29,'Balcony facing the street'),(11,31,'Sunny balcony'),(12,1,'Small private garden area'),(12,3,'Private garden access'),(12,22,'Shared courtyard garden'),(13,10,'Shared rooftop terrace access'),(14,12,'Shared pool access'),(14,18,'Shared pool access'),(18,1,'Private parking space near the cabin'),(18,12,NULL),(18,14,'Parking available nearby'),(18,18,NULL),(20,1,'Pets allowed with prior notice'),(20,28,'Pets allowed with prior notice'),(21,5,'Travel crib available on request'),(21,31,'Travel crib available on request'),(22,5,'High chair available on request'),(23,3,NULL),(23,7,NULL),(23,9,NULL),(23,10,NULL),(23,11,NULL),(23,15,NULL),(23,16,NULL),(23,19,NULL),(23,21,NULL),(23,22,NULL),(23,24,NULL),(23,26,NULL),(23,27,NULL),(23,29,NULL),(23,30,NULL),(23,32,NULL),(25,3,NULL),(25,4,NULL),(25,16,NULL),(25,22,NULL),(25,27,NULL),(25,30,NULL),(29,8,NULL),(29,13,NULL),(29,17,NULL),(29,23,NULL),(30,2,NULL),(30,6,NULL),(30,7,NULL),(30,10,NULL),(30,12,NULL),(30,14,NULL),(30,17,NULL),(30,18,NULL),(30,19,NULL),(30,24,NULL),(30,26,NULL),(30,28,NULL),(30,31,NULL);
/*!40000 ALTER TABLE `available_features` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bookings`
--

DROP TABLE IF EXISTS `bookings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bookings` (
  `booking_id` int NOT NULL AUTO_INCREMENT,
  `accomm_id` int NOT NULL,
  `coupon_id` int DEFAULT NULL,
  `guest_id` int NOT NULL,
  `booked_on` datetime NOT NULL,
  `no_of_guests` int NOT NULL,
  `full_price` decimal(8,2) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `confirmed` tinyint(1) NOT NULL,
  `cancelled` tinyint(1) NOT NULL,
  PRIMARY KEY (`booking_id`),
  UNIQUE KEY `booking_id` (`booking_id`),
  KEY `fk_bookings_accommodation` (`accomm_id`),
  KEY `fk_bookings_coupon` (`coupon_id`),
  KEY `fk_bookings_guest` (`guest_id`),
  CONSTRAINT `fk_bookings_accommodation` FOREIGN KEY (`accomm_id`) REFERENCES `accommodations` (`accomm_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_bookings_coupon` FOREIGN KEY (`coupon_id`) REFERENCES `coupons` (`coupon_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_bookings_guest` FOREIGN KEY (`guest_id`) REFERENCES `guests` (`user_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `chk_booking_dates` CHECK ((`end_date` > `start_date`)),
  CONSTRAINT `chk_booking_guest_count` CHECK ((`no_of_guests` > 0)),
  CONSTRAINT `chk_booking_price` CHECK ((`full_price` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookings`
--

LOCK TABLES `bookings` WRITE;
/*!40000 ALTER TABLE `bookings` DISABLE KEYS */;
INSERT INTO `bookings` VALUES (1,1,1,2,'2026-01-05 10:15:00',2,500.58,'2026-01-12','2026-01-16',1,0),(2,1,NULL,5,'2026-03-20 09:00:00',4,695.25,'2026-04-18','2026-04-22',1,0),(3,1,16,8,'2026-04-25 14:30:00',3,599.33,'2026-07-02','2026-07-06',1,0),(4,2,2,1,'2026-02-10 11:20:00',2,412.00,'2026-02-15','2026-02-18',1,0),(5,2,NULL,3,'2026-04-20 08:45:00',1,417.15,'2026-08-10','2026-08-13',1,0),(6,3,10,6,'2025-11-15 16:10:00',1,380.07,'2026-01-20','2026-01-25',1,0),(7,3,17,9,'2026-04-20 12:00:00',2,391.78,'2026-08-05','2026-08-09',1,0),(8,4,5,10,'2026-03-05 17:35:00',2,280.16,'2026-03-12','2026-03-15',1,0),(9,4,NULL,1,'2026-04-30 13:00:00',3,432.60,'2026-12-22','2026-12-26',0,1),(10,5,9,2,'2026-02-15 15:25:00',4,691.13,'2026-03-01','2026-03-05',1,0),(11,5,17,7,'2026-04-25 10:10:00',5,896.74,'2026-07-05','2026-07-10',1,0),(12,6,8,4,'2026-03-10 09:30:00',2,408.42,'2026-03-20','2026-03-23',1,0),(13,6,NULL,10,'2026-04-28 12:15:00',1,443.93,'2026-09-10','2026-09-13',1,0),(14,7,14,1,'2026-04-10 18:00:00',2,246.58,'2026-05-05','2026-05-08',1,0),(15,8,13,6,'2026-02-01 13:15:00',3,545.90,'2026-02-10','2026-02-13',1,0),(16,8,15,2,'2026-04-28 09:45:00',4,916.70,'2026-05-20','2026-05-24',1,0),(17,8,16,5,'2026-04-29 10:00:00',2,638.60,'2026-11-20','2026-11-23',1,0),(18,9,16,3,'2026-03-01 11:50:00',2,518.09,'2026-03-10','2026-03-14',1,0),(19,10,NULL,4,'2026-04-01 10:10:00',4,839.45,'2026-04-15','2026-04-20',1,0),(20,11,19,5,'2026-05-01 08:30:00',2,353.29,'2026-05-10','2026-05-14',1,0),(21,12,6,6,'2026-04-02 12:00:00',4,1400.80,'2026-04-15','2026-04-20',1,0),(22,12,8,7,'2026-04-29 09:10:00',3,745.15,'2026-10-01','2026-10-05',1,0),(23,13,NULL,8,'2026-02-15 14:00:00',3,530.45,'2026-03-01','2026-03-05',1,0),(24,14,18,9,'2026-05-01 10:00:00',5,1357.54,'2026-06-20','2026-06-25',0,1),(25,15,21,10,'2026-01-12 09:15:00',2,612.85,'2026-02-01','2026-02-04',1,0),(26,16,NULL,11,'2026-04-15 18:20:00',1,155.53,'2026-05-01','2026-05-03',1,0),(27,17,22,12,'2026-03-01 16:00:00',2,296.62,'2026-03-15','2026-03-18',1,0),(28,18,16,13,'2026-05-01 11:00:00',4,1156.69,'2026-08-01','2026-08-05',1,0),(29,19,24,14,'2026-03-05 15:00:00',3,629.85,'2026-03-20','2026-03-25',1,0),(30,20,NULL,15,'2026-02-01 13:00:00',2,187.46,'2026-02-10','2026-02-12',0,0),(31,21,7,16,'2026-02-01 08:00:00',2,280.16,'2026-02-12','2026-02-15',1,0),(32,22,1,17,'2026-01-10 10:20:00',3,345.05,'2026-02-10','2026-02-13',1,0),(33,23,NULL,18,'2026-03-15 09:45:00',2,474.83,'2026-04-01','2026-04-04',1,0),(34,24,5,19,'2026-04-02 12:40:00',2,429.00,'2026-04-10','2026-04-14',1,0),(35,25,NULL,20,'2026-05-01 10:30:00',2,336.81,'2026-05-15','2026-05-18',1,0),(36,26,8,21,'2026-05-01 16:45:00',2,641.53,'2026-05-20','2026-05-24',1,0),(37,27,NULL,22,'2026-01-03 09:10:00',3,303.85,'2026-01-15','2026-01-18',0,1),(38,28,NULL,23,'2026-05-01 11:00:00',2,383.16,'2026-06-20','2026-06-23',1,0),(39,29,NULL,25,'2026-03-15 11:20:00',3,328.57,'2026-04-01','2026-04-04',1,0),(40,30,NULL,26,'2026-04-01 09:00:00',2,461.44,'2026-04-10','2026-04-13',1,0),(41,31,NULL,29,'2026-02-05 10:00:00',4,546.93,'2026-02-15','2026-02-19',1,0),(42,32,NULL,30,'2026-01-10 11:30:00',2,267.80,'2026-01-20','2026-01-23',1,0);
/*!40000 ALTER TABLE `bookings` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_bookings_before_insert` BEFORE INSERT ON `bookings` FOR EACH ROW BEGIN
  DECLARE v_host_id INT;
  DECLARE v_maximum_guests INT;

  -- Retrieves the host and maximum guest count of the selected
  -- accommodation. These values are needed for later checks.
  SELECT host_id, maximum_guests
  INTO v_host_id , v_maximum_guests
  FROM accommodations
  WHERE
	accomm_id = NEW.accomm_id;

  -- Ensures that the booking period is valid.
  IF NEW.start_date >= NEW.end_date THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Booking end date must be after booking start date.';
  END IF;

  -- Ensures that every booking contains at least one guest.
  IF NEW.no_of_guests <= 0 THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Number of guests must be at least 1.';
  END IF;

  -- Prevents hosts from booking their own accommodations.
  IF NEW.guest_id = v_host_id THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Guests cannot book their own accommodation.';
  END IF;

  -- Ensures that the booking does not exceed the accommodation's
  -- maximum allowed number of guests.
  IF NEW.no_of_guests > v_maximum_guests THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Number of guests exceeds accommodation maximum.';
  END IF;

  -- Checks that the booking period is fully covered by an
  -- availability period for the selected accommodation.
  IF NOT EXISTS (
    SELECT 1
    FROM availabilities a
    WHERE a.accomm_id = NEW.accomm_id
      AND NEW.start_date >= a.valid_from
      AND NEW.end_date <= a.valid_until
  ) THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Booking period must be fully covered by an availability period.';
  END IF;

  -- Prevents double-booking by checking for overlapping,
  -- non-cancelled bookings for the same accommodation.
  IF EXISTS (
    SELECT 1
    FROM bookings b
    WHERE b.accomm_id = NEW.accomm_id
      AND b.cancelled = FALSE
      AND NEW.start_date < b.end_date
      AND NEW.end_date > b.start_date
  ) THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Accommodation is already booked during this period.';
  END IF;

  -- Coupon checks are only needed if the booking uses a coupon.
  IF NEW.coupon_id IS NOT NULL THEN

      -- Prevents the same guest from using the same coupon more
      -- than once.
	  IF EXISTS (
		SELECT 1
		FROM coupon_usages cu
		WHERE cu.user_id = NEW.guest_id
		  AND cu.coupon_id = NEW.coupon_id
	  ) THEN
		SIGNAL SQLSTATE '45000'
		  SET MESSAGE_TEXT = 'Guest has already used this coupon.';
	  END IF;

      -- Ensures that the coupon exists and is valid at the time
      -- the booking is made.
	  IF NOT EXISTS (
		SELECT 1
		FROM coupons c
		WHERE c.coupon_id = NEW.coupon_id
		  AND NEW.booked_on BETWEEN c.valid_from AND c.valid_until
	  ) THEN
		SIGNAL SQLSTATE '45000'
		  SET MESSAGE_TEXT = 'Coupon does not exist or is not currently valid.';
	  END IF;

	END IF;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_bookings_after_insert` AFTER INSERT ON `bookings` FOR EACH ROW BEGIN
  IF NEW.coupon_id IS NOT NULL THEN
    INSERT INTO coupon_usages
    (user_id, coupon_id)
    VALUES
    (NEW.guest_id, NEW.coupon_id);
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `countries`
--

DROP TABLE IF EXISTS `countries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `countries` (
  `country_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `tax_fixed` decimal(6,2) DEFAULT '0.00',
  `tax_percentage` decimal(6,5) DEFAULT '0.00000',
  `per_person` tinyint(1) DEFAULT NULL,
  `applied_once` tinyint(1) DEFAULT NULL,
  `currency` varchar(3) NOT NULL,
  PRIMARY KEY (`country_id`),
  UNIQUE KEY `country_id` (`country_id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `countries`
--

LOCK TABLES `countries` WRITE;
/*!40000 ALTER TABLE `countries` DISABLE KEYS */;
INSERT INTO `countries` VALUES (1,'Germany',5.00,0.00000,1,1,'EUR'),(2,'Austria',2.50,0.00000,1,0,'EUR'),(3,'Switzerland',3.00,0.00000,1,0,'CHF'),(4,'Netherlands',0.00,0.05125,0,0,'EUR'),(5,'Sweden',0.00,0.02500,0,0,'SEK'),(6,'Norway',0.00,0.03000,0,0,'NOK'),(7,'France',1.50,0.00000,1,0,'EUR'),(8,'Spain',2.00,0.00000,1,0,'EUR'),(9,'Italy',3.50,0.00000,1,0,'EUR'),(10,'Greece',0.00,0.02000,0,1,'EUR'),(11,'United States',0.00,0.06000,0,0,'USD'),(12,'Canada',0.00,0.05000,0,0,'CAD'),(13,'Australia',0.00,0.04000,0,0,'AUD'),(14,'United Kingdom',2.00,0.00000,1,1,'GBP'),(15,'Ireland',0.00,0.03500,0,0,'EUR'),(16,'Japan',10.00,0.00000,1,1,'JPY'),(17,'United Arab Emirates',0.00,0.05000,0,0,'AED'),(18,'Saudi Arabia',0.00,0.05000,0,0,'SAR'),(19,'Egypt',1.00,0.00000,1,1,'EGP'),(20,'Poland',2.00,0.00000,1,0,'PLN'),(21,'Czech Republic',1.25,0.00000,1,0,'CZK'),(22,'Portugal',2.00,0.00000,1,0,'EUR'),(23,'Belgium',0.00,0.03000,0,0,'EUR'),(24,'Denmark',0.00,0.02300,0,0,'DKK'),(25,'Finland',1.00,0.00000,1,0,'EUR');
/*!40000 ALTER TABLE `countries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coupon_usages`
--

DROP TABLE IF EXISTS `coupon_usages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `coupon_usages` (
  `user_id` int NOT NULL,
  `coupon_id` int NOT NULL,
  PRIMARY KEY (`user_id`,`coupon_id`),
  KEY `fk_coupon_usages_coupon` (`coupon_id`),
  CONSTRAINT `fk_coupon_usages_coupon` FOREIGN KEY (`coupon_id`) REFERENCES `coupons` (`coupon_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_coupon_usages_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coupon_usages`
--

LOCK TABLES `coupon_usages` WRITE;
/*!40000 ALTER TABLE `coupon_usages` DISABLE KEYS */;
INSERT INTO `coupon_usages` VALUES (2,1),(17,1),(1,2),(10,5),(19,5),(6,6),(16,7),(4,8),(7,8),(21,8),(2,9),(6,10),(6,13),(1,14),(2,15),(3,16),(5,16),(8,16),(13,16),(7,17),(9,17),(9,18),(5,19),(10,21),(12,22),(14,24);
/*!40000 ALTER TABLE `coupon_usages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coupons`
--

DROP TABLE IF EXISTS `coupons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `coupons` (
  `coupon_id` int NOT NULL AUTO_INCREMENT,
  `code` varchar(32) NOT NULL,
  `minimum_amt` decimal(6,2) DEFAULT '0.00',
  `amt_fixed` decimal(6,2) DEFAULT '0.00',
  `amt_percentage` decimal(6,5) DEFAULT '0.00000',
  `valid_from` datetime NOT NULL,
  `valid_until` datetime NOT NULL,
  PRIMARY KEY (`coupon_id`),
  UNIQUE KEY `coupon_id` (`coupon_id`),
  UNIQUE KEY `code` (`code`),
  CONSTRAINT `chk_coupon_dates` CHECK ((`valid_until` >= `valid_from`))
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coupons`
--

LOCK TABLES `coupons` WRITE;
/*!40000 ALTER TABLE `coupons` DISABLE KEYS */;
INSERT INTO `coupons` VALUES (1,'WELCOME10',50.00,10.00,0.00000,'2026-01-01 00:00:00','2026-12-31 23:59:59'),(2,'CITYBREAK5',75.00,5.00,0.00000,'2026-02-01 00:00:00','2026-06-30 23:59:59'),(3,'SUMMER12PCT',100.00,0.00,0.12500,'2026-06-01 00:00:00','2026-08-31 23:59:59'),(4,'WINTER20',120.00,20.00,0.00000,'2026-11-01 00:00:00','2027-02-28 23:59:59'),(5,'LONGSTAY15',300.00,0.00,0.15000,'2026-01-01 00:00:00','2026-12-31 23:59:59'),(6,'FLASH25',150.00,25.00,0.00000,'2026-04-01 08:00:00','2026-04-07 23:59:59'),(7,'LOWBUDGET3',30.00,3.00,0.00000,'2026-01-01 00:00:00','2026-12-31 23:59:59'),(8,'EUROPE8PCT',80.00,0.00,0.08000,'2026-03-01 00:00:00','2026-10-31 23:59:59'),(9,'FAMILY30',200.00,30.00,0.00000,'2026-01-01 00:00:00','2026-09-30 23:59:59'),(10,'EARLYBIRD10PCT',100.00,0.00,0.10000,'2025-10-01 00:00:00','2026-03-31 23:59:59'),(11,'EXPIRED2025',50.00,7.50,0.00000,'2025-01-01 00:00:00','2025-12-31 23:59:59'),(12,'NEXTYEAR15',100.00,15.00,0.00000,'2027-01-01 00:00:00','2027-12-31 23:59:59'),(13,'FIREPLACE15',90.00,15.00,0.00000,'2026-01-01 00:00:00','2026-04-30 23:59:59'),(14,'HOTDEALAIR',60.00,0.00,0.05000,'2026-02-01 00:00:00','2026-08-31 23:59:59'),(15,'WATERWAY10',80.00,10.00,0.00000,'2026-03-01 00:00:00','2026-09-30 23:59:59'),(16,'EARTHLY20',150.00,20.00,0.00000,'2026-01-01 00:00:00','2026-12-31 23:59:59'),(17,'BREEZY7PCT',70.00,0.00,0.07000,'2026-04-01 00:00:00','2026-10-31 23:59:59'),(18,'WINDOWNPRICE',100.00,12.00,0.00000,'2026-05-01 00:00:00','2026-11-30 23:59:59'),(19,'AQUAINTED5',40.00,5.00,0.00000,'2026-01-01 00:00:00','2026-12-31 23:59:59'),(20,'IGNITEYOURSTAY',110.00,0.00,0.09000,'2026-06-01 00:00:00','2026-12-31 23:59:59'),(21,'ROCKBOTTOM12',120.00,12.00,0.00000,'2026-01-01 00:00:00','2026-05-31 23:59:59'),(22,'MISTOPPORTUNITY',90.00,0.00,0.06500,'2026-02-15 00:00:00','2026-07-15 23:59:59'),(23,'LAVELYSTAY',130.00,18.00,0.00000,'2026-07-01 00:00:00','2026-12-31 23:59:59'),(24,'STAYGROUNDED',55.00,6.00,0.00000,'2026-01-01 00:00:00','2026-12-31 23:59:59');
/*!40000 ALTER TABLE `coupons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employees`
--

DROP TABLE IF EXISTS `employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employees` (
  `user_id` int NOT NULL,
  `home_address` int NOT NULL,
  `workplace_id` int DEFAULT NULL,
  `job_title` varchar(64) NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `user_id` (`user_id`),
  KEY `fk_employees_home_address` (`home_address`),
  KEY `fk_employees_workplace` (`workplace_id`),
  CONSTRAINT `fk_employees_home_address` FOREIGN KEY (`home_address`) REFERENCES `addresses` (`address_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_employees_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_employees_workplace` FOREIGN KEY (`workplace_id`) REFERENCES `workplaces` (`workplace_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employees`
--

LOCK TABLES `employees` WRITE;
/*!40000 ALTER TABLE `employees` DISABLE KEYS */;
INSERT INTO `employees` VALUES (41,1,1,'Customer Support Agent'),(42,40,1,'Operations Coordinator'),(43,6,2,'Customer Support Agent'),(44,19,2,'Host Verification Specialist'),(45,10,3,'Trust and Safety Agent'),(46,20,3,'Booking Support Agent'),(47,17,4,'Finance Assistant'),(48,14,4,'Billing Specialist'),(49,15,5,'Technical Support Agent'),(50,15,5,'Platform Administrator'),(51,81,6,'Host Relations Agent'),(52,81,6,'Booking Support Agent'),(53,12,7,'Legal Assistant'),(54,12,7,'Compliance Specialist'),(55,82,8,'Sales Coordinator'),(56,82,8,'Partner Relations Agent'),(57,83,9,'Nordic Support Agent'),(58,83,9,'Host Onboarding Specialist'),(59,36,10,'Compliance Assistant'),(60,36,10,'Dispute Resolution Agent'),(61,84,11,'French Support Agent'),(62,84,11,'Customer Support Agent'),(63,85,12,'Iberia Support Agent'),(64,85,12,'Booking Verification Agent'),(65,28,13,'Italian Support Agent'),(66,28,13,'Host Relations Agent'),(67,86,14,'North America Support Agent'),(68,86,14,'Payment Review Specialist'),(69,87,15,'Canada Support Agent'),(70,87,15,'Guest Relations Agent'),(71,88,16,'UK Support Agent'),(72,88,16,'Trust and Safety Agent'),(73,89,17,'Ireland Support Agent'),(74,89,17,'Refund Review Agent'),(75,90,18,'Japan Support Agent'),(76,90,18,'Asia-Pacific Coordinator'),(77,91,19,'Portugal Support Agent'),(78,91,19,'Host Onboarding Agent'),(79,92,20,'Benelux Support Agent'),(80,92,20,'Regional Office Coordinator');
/*!40000 ALTER TABLE `employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `features`
--

DROP TABLE IF EXISTS `features`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `features` (
  `feature_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `category` varchar(32) NOT NULL,
  PRIMARY KEY (`feature_id`),
  UNIQUE KEY `feature_id` (`feature_id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `features`
--

LOCK TABLES `features` WRITE;
/*!40000 ALTER TABLE `features` DISABLE KEYS */;
INSERT INTO `features` VALUES (1,'WiFi','Work-friendly'),(2,'Dedicated Workspace','Work-friendly'),(3,'Self Check-in','Convenience'),(4,'Kitchen','Appliances'),(5,'Washer','Appliances'),(6,'Dryer','Appliances'),(7,'Dishwasher','Appliances'),(8,'Air Conditioning','Comfort'),(9,'Heating','Comfort'),(10,'Fireplace','Comfort'),(11,'Balcony','Outdoor'),(12,'Garden','Outdoor'),(13,'Terrace','Outdoor'),(14,'Pool','Luxury'),(15,'Hot Tub','Luxury'),(16,'Sauna','Luxury'),(17,'Gym Access','Luxury'),(18,'Parking','Convenience'),(19,'EV Charger','Convenience'),(20,'Pet Friendly','Family'),(21,'Crib','Family'),(22,'High Chair','Family'),(23,'Smoke Alarm','Safety'),(24,'Carbon Monoxide Alarm','Safety'),(25,'First Aid Kit','Safety'),(26,'Fire Extinguisher','Safety'),(27,'Wheelchair Accessible','Accessibility'),(28,'Step-free Entrance','Accessibility'),(29,'Elevator','Accessibility'),(30,'Smart TV','Entertainment');
/*!40000 ALTER TABLE `features` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guests`
--

DROP TABLE IF EXISTS `guests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `guests` (
  `user_id` int NOT NULL,
  `profile_picture` int DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `user_id` (`user_id`),
  KEY `fk_guests_profile_picture` (`profile_picture`),
  CONSTRAINT `fk_guests_profile_picture` FOREIGN KEY (`profile_picture`) REFERENCES `pictures` (`picture_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_guests_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guests`
--

LOCK TABLES `guests` WRITE;
/*!40000 ALTER TABLE `guests` DISABLE KEYS */;
INSERT INTO `guests` VALUES (1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7),(8,8),(9,9),(10,10),(11,11),(12,12),(13,13),(14,14),(15,15),(16,16),(17,17),(18,18),(19,19),(20,20),(21,21),(22,22),(23,23),(24,24),(25,25),(26,26),(27,27),(28,28),(29,29),(30,30);
/*!40000 ALTER TABLE `guests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hosts`
--

DROP TABLE IF EXISTS `hosts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hosts` (
  `user_id` int NOT NULL,
  `address_id` int NOT NULL,
  `profile_picture` int NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `user_id` (`user_id`),
  KEY `fk_hosts_address` (`address_id`),
  KEY `fk_hosts_profile_picture` (`profile_picture`),
  CONSTRAINT `fk_hosts_address` FOREIGN KEY (`address_id`) REFERENCES `addresses` (`address_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_hosts_profile_picture` FOREIGN KEY (`profile_picture`) REFERENCES `pictures` (`picture_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_hosts_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hosts`
--

LOCK TABLES `hosts` WRITE;
/*!40000 ALTER TABLE `hosts` DISABLE KEYS */;
INSERT INTO `hosts` VALUES (11,11,11),(12,12,12),(13,13,13),(14,14,14),(15,15,15),(16,16,16),(17,17,17),(18,18,18),(19,19,19),(20,20,20),(21,21,21),(22,21,22),(23,23,23),(24,23,24),(25,25,25),(27,27,27),(31,31,31),(32,32,32),(33,33,33),(34,34,34),(35,35,35),(36,36,36),(37,37,37),(38,38,38),(39,39,39),(40,40,40),(41,1,41),(42,40,42),(43,6,43),(44,19,44),(45,10,45),(46,20,46),(47,17,47),(48,14,48),(49,15,49),(50,15,50),(83,2,51),(84,3,52),(85,4,53),(86,5,54),(87,7,55),(88,8,56),(89,9,57),(90,22,58),(91,24,59),(92,26,60),(93,29,61),(94,30,62);
/*!40000 ALTER TABLE `hosts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `messages` (
  `message_id` bigint NOT NULL AUTO_INCREMENT,
  `booking_id` int NOT NULL,
  `message` text NOT NULL,
  `sender_is_guest` tinyint(1) NOT NULL,
  `sent` datetime NOT NULL,
  PRIMARY KEY (`message_id`),
  UNIQUE KEY `message_id` (`message_id`),
  KEY `fk_messages_booking` (`booking_id`),
  CONSTRAINT `fk_messages_booking` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`booking_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
INSERT INTO `messages` VALUES (1,1,'Hi! We are really looking forward to the cabin stay. Could you let us know if the parking space is directly by the cabin?',1,'2026-01-05 10:30:00'),(2,1,'Hi Ben, yes, the private parking space is just a short walk from the entrance. I will send you detailed directions before check-in.',0,'2026-01-05 11:05:00'),(3,1,'Perfect, thank you! We will probably arrive around 17:00.',1,'2026-01-05 11:20:00'),(4,3,'Hi, we booked the cabin for July and saw it has a fireplace. Is it usable in summer as well?',1,'2026-04-25 14:45:00'),(5,3,'The fireplace is available, but we usually recommend using it only on colder evenings. Firewood is stored next to the living area.',0,'2026-04-25 16:10:00'),(6,4,'Hi! Our train arrives in Hamburg around 15:30. Would it be possible to check in shortly before 16:00?',1,'2026-02-10 11:35:00'),(7,4,'That should be fine. I will make sure the loft is ready a little earlier.',0,'2026-02-10 12:15:00'),(8,4,'Amazing, thank you. Is there a key box or will someone meet us?',1,'2026-02-10 12:40:00'),(9,4,'There is a key box by the entrance. I will send you the code on the day of arrival.',0,'2026-02-10 13:10:00'),(10,6,'Hello, I booked the Berlin garden studio early for January. Could you confirm that the workspace faces the garden?',1,'2025-11-15 16:25:00'),(11,6,'Yes, the desk is placed by the garden-facing window. It is a quiet spot and suitable for laptop work.',0,'2025-11-15 17:00:00'),(12,8,'Hi, we are arriving in Salzburg by car. Is there parking nearby?',1,'2026-03-05 17:50:00'),(13,8,'There is a public parking garage about five minutes away on foot. I can send you the address.',0,'2026-03-05 18:25:00'),(14,8,'Yes please, that would be very helpful.',1,'2026-03-05 18:40:00'),(15,9,'Hi, I am sorry, but I need to cancel this Salzburg stay. What happens with the payment?',1,'2026-04-30 13:20:00'),(16,9,'Thanks for letting me know. Since the booking is not confirmed yet, the payment can be refunded.',0,'2026-04-30 14:00:00'),(17,9,'That is a relief, thank you. Please go ahead with the cancellation.',1,'2026-04-30 14:15:00'),(18,9,'Done. The booking is cancelled and the refund should be processed through the platform.',0,'2026-04-30 15:00:00'),(19,10,'Hello! We are travelling as a family to Lucerne. Could you please confirm that the crib and high chair are available?',1,'2026-02-15 15:45:00'),(20,10,'Absolutely, both can be prepared for your stay. I will leave them in the main bedroom.',0,'2026-02-15 16:30:00'),(21,12,'Hi, is the Amsterdam canal-facing balcony private or shared?',1,'2026-03-10 09:50:00'),(22,12,'It is private for the suite. You will have direct access from the room.',0,'2026-03-10 10:25:00'),(23,12,'Lovely, thank you. We are really excited for the canal view.',1,'2026-03-10 10:40:00'),(24,13,'Hello, I noticed the second payment is scheduled later. Is everything okay with the Amsterdam booking already?',1,'2026-04-28 12:35:00'),(25,13,'Yes, the booking is confirmed. The scheduled payment is only the second installment.',0,'2026-04-28 13:10:00'),(26,14,'Hi! Is the Stockholm old town room easy to reach from the central station?',1,'2026-04-10 18:20:00'),(27,14,'Yes, it is very central. I will send you a short transit route before arrival.',0,'2026-04-10 19:00:00'),(28,15,'Hello, we are three guests for the Paris flat. Is there enough seating in the living area?',1,'2026-02-01 13:25:00'),(29,15,'Yes, the flat has enough seating for three guests in the living area and dining space.',0,'2026-02-01 14:05:00'),(30,15,'Great. Also, is the kitchen stocked with basic cookware?',1,'2026-02-01 14:20:00'),(31,15,'Yes, basic cookware, dishes, and cutlery are available.',0,'2026-02-01 15:00:00'),(32,17,'Hi, we are arriving in Paris quite late in November. Is check-in after 20:00 possible?',1,'2026-04-29 10:20:00'),(33,17,'Yes, late arrival is possible. I will send the access details in advance.',0,'2026-04-29 11:15:00'),(34,20,'Hi, is the Athens studio balcony the one with the Acropolis view?',1,'2026-05-01 08:45:00'),(35,20,'Yes, that is correct. The balcony has the city view shown in the listing photos.',0,'2026-05-01 09:30:00'),(36,20,'Wonderful, thanks! That was the main reason we picked it.',1,'2026-05-01 09:45:00'),(37,21,'Hello, I booked the Miami condo and paid in two parts. Could you confirm both payments are visible?',1,'2026-04-02 12:20:00'),(38,21,'Yes, I can see the installment plan. Your booking is confirmed.',0,'2026-04-02 13:00:00'),(39,21,'Perfect. Is pool access included for all four guests?',1,'2026-04-02 13:15:00'),(40,21,'Yes, pool access is included for all registered guests.',0,'2026-04-02 13:50:00'),(41,24,'Hi, I am very sorry, but we have to cancel the Sydney stay. Could you confirm the refund process?',1,'2026-05-01 10:20:00'),(42,24,'I am sorry to hear that. The booking has been marked as cancelled and the payment will be refunded.',0,'2026-05-01 11:00:00'),(43,26,'Hello, is the Dublin room suitable for arriving with a small suitcase before check-in?',1,'2026-04-15 18:35:00'),(44,26,'You can drop off luggage from 13:00 onward. The room itself will be ready by check-in time.',0,'2026-04-15 19:10:00'),(45,26,'That helps a lot. Thank you!',1,'2026-04-15 19:20:00'),(46,27,'Hi, does the Tokyo micro flat have enough space for two suitcases?',1,'2026-03-01 16:15:00'),(47,27,'It is quite compact, but two cabin-sized suitcases should be fine. Large luggage may be tight.',0,'2026-03-01 17:00:00'),(48,28,'Hi, does the Dubai apartment have pool access included?',1,'2026-05-01 11:20:00'),(49,28,'Yes, shared pool access is included for registered guests.',0,'2026-05-01 12:00:00'),(50,28,'Great. Is the beach within walking distance too?',1,'2026-05-01 12:15:00'),(51,28,'Yes, the waterfront is nearby and easy to reach on foot.',0,'2026-05-01 12:45:00'),(52,30,'Hello, is the Brussels studio still available even though the listing is not visible?',1,'2026-02-01 13:15:00'),(53,30,'Yes, your booking request was made before the listing was hidden. The stay can still go ahead if confirmed.',0,'2026-02-01 14:00:00'),(54,31,'Hi, does the Berlin studio have a proper desk or just a table?',1,'2026-02-01 08:20:00'),(55,31,'It has a fold-out desk by the window, suitable for laptop work.',0,'2026-02-01 09:00:00'),(56,31,'Nice, that works for me. Is the WiFi reliable enough for video calls?',1,'2026-02-01 09:15:00'),(57,31,'Yes, the connection is stable and previous guests have used it for remote work.',0,'2026-02-01 10:00:00'),(58,32,'Hi, we are three guests for the Vienna courtyard apartment. Is the courtyard shared?',1,'2026-01-10 10:40:00'),(59,32,'Yes, the courtyard garden is shared, but it is usually quiet.',0,'2026-01-10 11:15:00'),(60,37,'Hi, unfortunately I need to cancel the Nuremberg stay. Could you confirm whether the payment will be refunded?',1,'2026-01-03 09:30:00'),(61,37,'Yes, since the booking has been cancelled, the payment will be refunded through the platform.',0,'2026-01-03 10:05:00');
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_methods`
--

DROP TABLE IF EXISTS `payment_methods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment_methods` (
  `pay_meth_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `name` varchar(64) NOT NULL,
  `provider` varchar(64) NOT NULL,
  `details` varchar(255) NOT NULL,
  PRIMARY KEY (`pay_meth_id`),
  UNIQUE KEY `pay_meth_id` (`pay_meth_id`),
  KEY `fk_payment_methods_guest` (`user_id`),
  CONSTRAINT `fk_payment_methods_guest` FOREIGN KEY (`user_id`) REFERENCES `guests` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_methods`
--

LOCK TABLES `payment_methods` WRITE;
/*!40000 ALTER TABLE `payment_methods` DISABLE KEYS */;
INSERT INTO `payment_methods` VALUES (1,1,'Alice Visa','Visa','Card ending in 1842, expires 08/2028'),(2,1,'Alice PayPal','PayPal','PayPal account linked to alice.meyer@gmail.com'),(3,2,'Ben Mastercard','Mastercard','Card ending in 4421, expires 11/2027'),(4,2,'Ben Travel Visa','Visa','Card ending in 7634, expires 04/2029'),(5,3,'Clara Travel Card','Visa','Card ending in 3908, expires 03/2029'),(6,4,'David PayPal','PayPal','PayPal account linked to david.fischer@hotmail.com'),(7,5,'Emma Amex','American Express','Card ending in 7740, expires 05/2028'),(8,5,'Emma Backup Mastercard','Mastercard','Card ending in 1186, expires 09/2027'),(9,6,'Felix Visa','Visa','Card ending in 2259, expires 01/2027'),(10,6,'Felix PayPal','PayPal','PayPal account linked to felix.wagner@aol.com'),(11,7,'Greta Mastercard','Mastercard','Card ending in 6134, expires 12/2028'),(12,8,'Henry Business Card','Visa','Card ending in 9044, expires 09/2029'),(13,8,'Henry PayPal','PayPal','PayPal account linked to henry.hoffmann@gmail.com'),(14,9,'Isabel PayPal','PayPal','PayPal account linked to isabel.neumann@outlook.com'),(15,10,'Jonas Debit Card','Maestro','Debit card ending in 5520, expires 04/2027'),(16,11,'Klara Visa','Visa','Card ending in 7186, expires 10/2028'),(17,12,'Leon Mastercard','Mastercard','Card ending in 3091, expires 07/2029'),(18,13,'Mara PayPal','PayPal','PayPal account linked to mara.peters@gmail.com'),(19,14,'Noah Travel Card','Visa','Card ending in 8826, expires 02/2028'),(20,15,'Olivia Mastercard','Mastercard','Card ending in 4603, expires 06/2027'),(21,16,'Paul Visa','Visa','Card ending in 1277, expires 09/2028'),(22,17,'Quinn PayPal','PayPal','PayPal account linked to quinn.seidel@outlook.com'),(23,18,'Rosa Debit Card','Visa Debit','Debit card ending in 6935, expires 01/2029'),(24,19,'Simon Mastercard','Mastercard','Card ending in 8401, expires 03/2028'),(25,20,'Tina Visa','Visa','Card ending in 2719, expires 12/2027'),(26,21,'Ulf Travel Card','Mastercard','Card ending in 9568, expires 05/2029'),(27,22,'Vera PayPal','PayPal','PayPal account linked to vera.madsen@outlook.com'),(28,23,'Will Amex','American Express','Card ending in 3412, expires 08/2028'),(29,25,'Yara Mastercard','Mastercard','Card ending in 6027, expires 04/2028'),(30,26,'Zane PayPal','PayPal','PayPal account linked to zane.miller@gmail.com'),(31,29,'Carlos Mastercard','Mastercard','Card ending in 8294, expires 10/2028'),(32,29,'Carlos Backup Visa','Visa','Card ending in 2057, expires 01/2029'),(33,30,'Daria Visa','Visa','Card ending in 4762, expires 06/2029'),(34,30,'Daria PayPal','PayPal','PayPal account linked to daria.kowalska@outlook.com');
/*!40000 ALTER TABLE `payment_methods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payments` (
  `payment_id` int NOT NULL AUTO_INCREMENT,
  `booking_id` int NOT NULL,
  `pay_meth_id` int NOT NULL,
  `payment_date` datetime NOT NULL,
  `amount` decimal(8,2) NOT NULL,
  `status` varchar(20) NOT NULL,
  PRIMARY KEY (`payment_id`),
  UNIQUE KEY `payment_id` (`payment_id`),
  KEY `fk_payments_booking` (`booking_id`),
  KEY `fk_payments_payment_method` (`pay_meth_id`),
  CONSTRAINT `fk_payments_booking` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`booking_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_payments_payment_method` FOREIGN KEY (`pay_meth_id`) REFERENCES `payment_methods` (`pay_meth_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `chk_payment_amount` CHECK ((`amount` >= 0)),
  CONSTRAINT `chk_payment_status` CHECK ((`status` in (_utf8mb4'Pending',_utf8mb4'Scheduled',_utf8mb4'Completed',_utf8mb4'Failed',_utf8mb4'Refunded')))
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
INSERT INTO `payments` VALUES (1,1,3,'2026-01-05 10:20:00',500.58,'Completed'),(2,2,7,'2026-03-20 09:05:00',347.63,'Completed'),(3,2,7,'2026-04-10 09:00:00',347.62,'Completed'),(4,3,12,'2026-04-25 14:35:00',599.33,'Completed'),(5,4,1,'2026-02-10 11:25:00',412.00,'Completed'),(6,5,5,'2026-04-20 08:50:00',417.15,'Completed'),(7,6,9,'2025-11-15 16:15:00',190.04,'Completed'),(8,6,9,'2026-01-05 12:00:00',190.03,'Completed'),(9,7,14,'2026-04-20 12:05:00',391.78,'Completed'),(10,8,15,'2026-03-05 17:40:00',280.16,'Completed'),(11,9,1,'2026-04-30 13:05:00',432.60,'Refunded'),(12,10,3,'2026-02-15 15:30:00',345.57,'Completed'),(13,10,3,'2026-02-25 10:00:00',345.56,'Completed'),(14,11,11,'2026-04-25 10:15:00',896.74,'Completed'),(15,12,6,'2026-03-10 09:35:00',408.42,'Completed'),(16,13,15,'2026-04-28 12:20:00',221.97,'Completed'),(17,13,15,'2026-09-01 12:00:00',221.96,'Scheduled'),(18,14,2,'2026-04-10 18:05:00',246.58,'Completed'),(19,15,10,'2026-02-01 13:20:00',545.90,'Completed'),(20,16,4,'2026-04-28 09:50:00',458.35,'Completed'),(21,16,4,'2026-05-15 09:00:00',458.35,'Scheduled'),(22,17,8,'2026-04-29 10:05:00',638.60,'Completed'),(23,18,5,'2026-03-01 11:55:00',518.09,'Completed'),(24,19,6,'2026-04-01 10:15:00',419.73,'Completed'),(25,19,6,'2026-04-08 10:00:00',419.72,'Completed'),(26,20,7,'2026-05-01 08:35:00',353.29,'Completed'),(27,21,9,'2026-04-02 12:05:00',700.40,'Completed'),(28,21,9,'2026-04-10 12:00:00',700.40,'Completed'),(29,22,11,'2026-04-29 09:15:00',745.15,'Completed'),(30,23,12,'2026-02-15 14:05:00',530.45,'Completed'),(31,24,14,'2026-05-01 10:05:00',678.77,'Refunded'),(32,25,15,'2026-01-12 09:20:00',612.85,'Completed'),(33,26,16,'2026-04-15 18:25:00',155.53,'Completed'),(34,27,17,'2026-03-01 16:05:00',296.62,'Completed'),(35,28,18,'2026-05-01 11:05:00',578.35,'Completed'),(36,28,18,'2026-07-25 11:00:00',578.34,'Scheduled'),(37,29,19,'2026-03-05 15:05:00',629.85,'Completed'),(38,30,20,'2026-02-01 13:05:00',187.46,'Pending'),(39,31,21,'2026-02-01 08:05:00',280.16,'Completed'),(40,32,22,'2026-01-10 10:25:00',345.05,'Completed'),(41,33,23,'2026-03-15 09:50:00',237.42,'Completed'),(42,33,23,'2026-03-25 09:00:00',237.41,'Completed'),(43,34,24,'2026-04-02 12:45:00',429.00,'Completed'),(44,35,25,'2026-05-01 10:35:00',336.81,'Completed'),(45,36,26,'2026-05-01 16:50:00',641.53,'Completed'),(46,37,27,'2026-01-03 09:15:00',303.85,'Refunded'),(47,38,28,'2026-05-01 11:05:00',191.58,'Completed'),(48,38,28,'2026-06-15 11:00:00',191.58,'Scheduled'),(49,39,29,'2026-03-15 11:25:00',328.57,'Completed'),(50,40,30,'2026-04-01 09:05:00',461.44,'Completed'),(51,41,31,'2026-02-05 10:05:00',273.47,'Completed'),(52,41,31,'2026-02-10 10:00:00',273.46,'Completed'),(53,42,33,'2026-01-10 11:35:00',267.80,'Completed');
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_payments_before_insert` BEFORE INSERT ON `payments` FOR EACH ROW BEGIN
  IF NOT EXISTS (
    SELECT 1
    FROM bookings b
    JOIN payment_methods pm
      ON pm.user_id = b.guest_id
    WHERE b.booking_id = NEW.booking_id
      AND pm.pay_meth_id = NEW.pay_meth_id
  ) THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Payment method must belong to the guest who made the booking.';
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_payments_before_update` BEFORE UPDATE ON `payments` FOR EACH ROW BEGIN
  IF NOT EXISTS (
    SELECT 1
    FROM bookings b
    JOIN payment_methods pm
      ON pm.user_id = b.guest_id
    WHERE b.booking_id = NEW.booking_id
      AND pm.pay_meth_id = NEW.pay_meth_id
  ) THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Payment method must belong to the guest who made the booking.';
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `pictures`
--

DROP TABLE IF EXISTS `pictures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pictures` (
  `picture_id` int NOT NULL AUTO_INCREMENT,
  `accomm_id` int DEFAULT NULL,
  `format` varchar(20) NOT NULL,
  `width` int NOT NULL,
  `height` int NOT NULL,
  `file_location` varchar(255) NOT NULL,
  PRIMARY KEY (`picture_id`),
  UNIQUE KEY `picture_id` (`picture_id`),
  KEY `fk_pictures_accommodation` (`accomm_id`),
  CONSTRAINT `fk_pictures_accommodation` FOREIGN KEY (`accomm_id`) REFERENCES `accommodations` (`accomm_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=162 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pictures`
--

LOCK TABLES `pictures` WRITE;
/*!40000 ALTER TABLE `pictures` DISABLE KEYS */;
INSERT INTO `pictures` VALUES (1,NULL,'jpg',800,800,'/uploads/profile_pictures/user_001_alice_meyer.jpg'),(2,NULL,'jpg',800,800,'/uploads/profile_pictures/user_002_ben_schulz.jpg'),(3,NULL,'png',1000,1000,'/uploads/profile_pictures/user_003_clara_weber.png'),(4,NULL,'jpg',800,800,'/uploads/profile_pictures/user_004_david_fischer.jpg'),(5,NULL,'webp',900,900,'/uploads/profile_pictures/user_005_emma_klein.webp'),(6,NULL,'jpg',800,800,'/uploads/profile_pictures/user_006_felix_wagner.jpg'),(7,NULL,'png',1000,1000,'/uploads/profile_pictures/user_007_greta_becker.png'),(8,NULL,'jpg',800,800,'/uploads/profile_pictures/user_008_henry_hoffmann.jpg'),(9,NULL,'jpg',800,800,'/uploads/profile_pictures/user_009_isabel_neumann.jpg'),(10,NULL,'webp',900,900,'/uploads/profile_pictures/user_010_jonas_richter.webp'),(11,NULL,'jpg',800,800,'/uploads/profile_pictures/user_011_klara_braun.jpg'),(12,NULL,'png',1000,1000,'/uploads/profile_pictures/user_012_leon_kruger.png'),(13,NULL,'jpg',800,800,'/uploads/profile_pictures/user_013_mara_peters.jpg'),(14,NULL,'jpg',800,800,'/uploads/profile_pictures/user_014_noah_lang.jpg'),(15,NULL,'webp',900,900,'/uploads/profile_pictures/user_015_olivia_schmitt.webp'),(16,NULL,'jpg',800,800,'/uploads/profile_pictures/user_016_paul_koch.jpg'),(17,NULL,'png',1000,1000,'/uploads/profile_pictures/user_017_quinn_seidel.png'),(18,NULL,'jpg',800,800,'/uploads/profile_pictures/user_018_rosa_hartmann.jpg'),(19,NULL,'jpg',800,800,'/uploads/profile_pictures/user_019_simon_bauer.jpg'),(20,NULL,'webp',900,900,'/uploads/profile_pictures/user_020_tina_lorenz.webp'),(21,NULL,'jpg',800,800,'/uploads/profile_pictures/user_021_ulf_johansson.jpg'),(22,NULL,'png',1000,1000,'/uploads/profile_pictures/user_022_vera_madsen.png'),(23,NULL,'jpg',800,800,'/uploads/profile_pictures/user_023_will_carter.jpg'),(24,NULL,'jpg',800,800,'/uploads/profile_pictures/user_024_xena_papadopoulos.jpg'),(25,NULL,'webp',900,900,'/uploads/profile_pictures/user_025_yara_hassan.webp'),(26,NULL,'jpg',800,800,'/uploads/profile_pictures/user_026_zane_miller.jpg'),(27,NULL,'png',1000,1000,'/uploads/profile_pictures/user_027_amir_rahman.png'),(28,NULL,'jpg',800,800,'/uploads/profile_pictures/user_028_bianca_rossi.jpg'),(29,NULL,'jpg',800,800,'/uploads/profile_pictures/user_029_carlos_navarro.jpg'),(30,NULL,'webp',900,900,'/uploads/profile_pictures/user_030_daria_kowalska.webp'),(31,NULL,'jpg',800,800,'/uploads/profile_pictures/user_031_ethan_brooks.jpg'),(32,NULL,'jpg',800,800,'/uploads/profile_pictures/user_032_farah_al_sayed.jpg'),(33,NULL,'webp',900,900,'/uploads/profile_pictures/user_033_giulia_bianchi.webp'),(34,NULL,'jpg',800,800,'/uploads/profile_pictures/user_034_hugo_martinez.jpg'),(35,NULL,'png',1000,1000,'/uploads/profile_pictures/user_035_ines_dupont.png'),(36,NULL,'jpg',800,800,'/uploads/profile_pictures/user_036_jakob_lind.jpg'),(37,NULL,'webp',900,900,'/uploads/profile_pictures/user_037_keiko_tanaka.webp'),(38,NULL,'jpg',800,800,'/uploads/profile_pictures/user_038_liam_oconnor.jpg'),(39,NULL,'png',1000,1000,'/uploads/profile_pictures/user_039_mila_novak.png'),(40,NULL,'jpg',800,800,'/uploads/profile_pictures/user_040_nico_steiner.jpg'),(41,NULL,'jpg',800,800,'/uploads/profile_pictures/user_041_anna_schneider.jpg'),(42,NULL,'jpg',800,800,'/uploads/profile_pictures/user_042_lukas_weber.jpg'),(43,NULL,'png',1000,1000,'/uploads/profile_pictures/user_043_mia_fischer.png'),(44,NULL,'jpg',800,800,'/uploads/profile_pictures/user_044_jonas_mueller.jpg'),(45,NULL,'webp',900,900,'/uploads/profile_pictures/user_045_sophie_keller.webp'),(46,NULL,'jpg',800,800,'/uploads/profile_pictures/user_046_paul_becker.jpg'),(47,NULL,'jpg',800,800,'/uploads/profile_pictures/user_047_laura_koch.jpg'),(48,NULL,'png',1000,1000,'/uploads/profile_pictures/user_048_tobias_wagner.png'),(49,NULL,'jpg',800,800,'/uploads/profile_pictures/user_049_hannah_schmitt.jpg'),(50,NULL,'webp',900,900,'/uploads/profile_pictures/user_050_felix_braun.webp'),(51,NULL,'jpg',800,800,'/uploads/profile_pictures/user_083_marlene_vogel.jpg'),(52,NULL,'jpg',800,800,'/uploads/profile_pictures/user_084_theresa_bauer.jpg'),(53,NULL,'webp',900,900,'/uploads/profile_pictures/user_085_sandro_meier.webp'),(54,NULL,'jpg',800,800,'/uploads/profile_pictures/user_086_lotte_visser.jpg'),(55,NULL,'png',1000,1000,'/uploads/profile_pictures/user_087_freja_nilsson.png'),(56,NULL,'jpg',800,800,'/uploads/profile_pictures/user_088_mason_reed.jpg'),(57,NULL,'jpg',800,800,'/uploads/profile_pictures/user_089_katrin_lehmann.jpg'),(58,NULL,'webp',900,900,'/uploads/profile_pictures/user_090_emil_christensen.webp'),(59,NULL,'jpg',800,800,'/uploads/profile_pictures/user_091_nikos_anagnostou.jpg'),(60,NULL,'png',1000,1000,'/uploads/profile_pictures/user_092_madison_brooks.png'),(61,NULL,'jpg',800,800,'/uploads/profile_pictures/user_093_diego_santos.jpg'),(62,NULL,'webp',900,900,'/uploads/profile_pictures/user_094_kasia_zielinska.webp'),(63,1,'jpg',1920,1080,'/uploads/accommodations/accomm_001/mountain_cabin_exterior.jpg'),(64,1,'jpg',1920,1080,'/uploads/accommodations/accomm_001/mountain_cabin_living_room.jpg'),(65,1,'webp',1600,1200,'/uploads/accommodations/accomm_001/mountain_cabin_bedroom.webp'),(66,1,'jpg',1920,1080,'/uploads/accommodations/accomm_001/mountain_cabin_balcony_view.jpg'),(67,2,'jpg',1920,1080,'/uploads/accommodations/accomm_002/city_loft_main_room.jpg'),(68,2,'png',1600,1200,'/uploads/accommodations/accomm_002/city_loft_kitchen.png'),(69,2,'jpg',1920,1080,'/uploads/accommodations/accomm_002/city_loft_bedroom.jpg'),(70,3,'jpg',1920,1080,'/uploads/accommodations/accomm_003/garden_studio_front.jpg'),(71,3,'webp',1600,1200,'/uploads/accommodations/accomm_003/garden_studio_sleeping_area.webp'),(72,3,'jpg',1920,1080,'/uploads/accommodations/accomm_003/garden_studio_patio.jpg'),(73,3,'jpg',1600,1200,'/uploads/accommodations/accomm_003/garden_studio_bathroom.jpg'),(74,4,'jpg',1920,1080,'/uploads/accommodations/accomm_004/salzburg_flat_exterior.jpg'),(75,4,'jpg',1920,1080,'/uploads/accommodations/accomm_004/salzburg_flat_living_room.jpg'),(76,4,'webp',1600,1200,'/uploads/accommodations/accomm_004/salzburg_flat_street_view.webp'),(77,5,'jpg',1920,1080,'/uploads/accommodations/accomm_005/lucerne_lakefront_window_view.jpg'),(78,5,'jpg',1920,1080,'/uploads/accommodations/accomm_005/lucerne_lakefront_bedroom.jpg'),(79,5,'png',1600,1200,'/uploads/accommodations/accomm_005/lucerne_lakefront_kitchen.png'),(80,5,'jpg',1920,1080,'/uploads/accommodations/accomm_005/lucerne_lakefront_dining_area.jpg'),(81,6,'jpg',1920,1080,'/uploads/accommodations/accomm_006/amsterdam_canal_house_front.jpg'),(82,6,'webp',1600,1200,'/uploads/accommodations/accomm_006/amsterdam_canal_suite_bedroom.webp'),(83,6,'jpg',1920,1080,'/uploads/accommodations/accomm_006/amsterdam_canal_view.jpg'),(84,7,'jpg',1920,1080,'/uploads/accommodations/accomm_007/stockholm_old_town_room.jpg'),(85,7,'jpg',1600,1200,'/uploads/accommodations/accomm_007/stockholm_old_town_bed.jpg'),(86,7,'webp',1600,1200,'/uploads/accommodations/accomm_007/stockholm_old_town_window.webp'),(87,8,'jpg',1920,1080,'/uploads/accommodations/accomm_008/paris_central_flat_living_room.jpg'),(88,8,'jpg',1920,1080,'/uploads/accommodations/accomm_008/paris_central_flat_bedroom.jpg'),(89,8,'png',1600,1200,'/uploads/accommodations/accomm_008/paris_central_flat_kitchen.png'),(90,8,'jpg',1920,1080,'/uploads/accommodations/accomm_008/paris_central_flat_street_view.jpg'),(91,9,'jpg',1920,1080,'/uploads/accommodations/accomm_009/barcelona_gothic_room_main.jpg'),(92,9,'webp',1600,1200,'/uploads/accommodations/accomm_009/barcelona_gothic_balcony.webp'),(93,9,'jpg',1600,1200,'/uploads/accommodations/accomm_009/barcelona_gothic_bathroom.jpg'),(94,10,'jpg',1920,1080,'/uploads/accommodations/accomm_010/rome_apartment_living_room.jpg'),(95,10,'jpg',1920,1080,'/uploads/accommodations/accomm_010/rome_apartment_bedroom.jpg'),(96,10,'webp',1600,1200,'/uploads/accommodations/accomm_010/rome_apartment_rooftop_view.webp'),(97,10,'jpg',1600,1200,'/uploads/accommodations/accomm_010/rome_apartment_kitchen.jpg'),(98,11,'jpg',1920,1080,'/uploads/accommodations/accomm_011/athens_acropolis_studio_view.jpg'),(99,11,'jpg',1600,1200,'/uploads/accommodations/accomm_011/athens_acropolis_studio_bed.jpg'),(100,11,'png',1600,1200,'/uploads/accommodations/accomm_011/athens_acropolis_studio_kitchen.png'),(101,12,'jpg',1920,1080,'/uploads/accommodations/accomm_012/miami_beachfront_condo_balcony.jpg'),(102,12,'webp',1600,1200,'/uploads/accommodations/accomm_012/miami_beachfront_condo_living_room.webp'),(103,12,'jpg',1920,1080,'/uploads/accommodations/accomm_012/miami_beachfront_condo_bedroom.jpg'),(104,12,'jpg',1600,1200,'/uploads/accommodations/accomm_012/miami_beachfront_condo_pool.jpg'),(105,13,'jpg',1920,1080,'/uploads/accommodations/accomm_013/toronto_downtown_rental_living_room.jpg'),(106,13,'jpg',1600,1200,'/uploads/accommodations/accomm_013/toronto_downtown_rental_bedroom.jpg'),(107,13,'webp',1600,1200,'/uploads/accommodations/accomm_013/toronto_downtown_rental_skyline.webp'),(108,14,'jpg',1920,1080,'/uploads/accommodations/accomm_014/sydney_harbour_apartment_view.jpg'),(109,14,'jpg',1600,1200,'/uploads/accommodations/accomm_014/sydney_harbour_apartment_lounge.jpg'),(110,14,'png',1600,1200,'/uploads/accommodations/accomm_014/sydney_harbour_apartment_kitchen.png'),(111,14,'jpg',1920,1080,'/uploads/accommodations/accomm_014/sydney_harbour_apartment_balcony.jpg'),(112,15,'jpg',1920,1080,'/uploads/accommodations/accomm_015/london_classic_flat_exterior.jpg'),(113,15,'webp',1600,1200,'/uploads/accommodations/accomm_015/london_classic_flat_living_room.webp'),(114,15,'jpg',1600,1200,'/uploads/accommodations/accomm_015/london_classic_flat_bedroom.jpg'),(115,16,'jpg',1920,1080,'/uploads/accommodations/accomm_016/dublin_city_room_main.jpg'),(116,16,'jpg',1600,1200,'/uploads/accommodations/accomm_016/dublin_city_room_bed.jpg'),(117,16,'webp',1600,1200,'/uploads/accommodations/accomm_016/dublin_city_room_street.webp'),(118,17,'jpg',1920,1080,'/uploads/accommodations/accomm_017/tokyo_harajuku_micro_flat_main.jpg'),(119,17,'jpg',1600,1200,'/uploads/accommodations/accomm_017/tokyo_harajuku_micro_flat_bed.jpg'),(120,17,'png',1600,1200,'/uploads/accommodations/accomm_017/tokyo_harajuku_micro_flat_bathroom.png'),(121,17,'webp',1600,1200,'/uploads/accommodations/accomm_017/tokyo_harajuku_micro_flat_street.webp'),(122,18,'jpg',1920,1080,'/uploads/accommodations/accomm_018/dubai_beach_apartment_balcony.jpg'),(123,18,'jpg',1920,1080,'/uploads/accommodations/accomm_018/dubai_beach_apartment_living_room.jpg'),(124,18,'webp',1600,1200,'/uploads/accommodations/accomm_018/dubai_beach_apartment_bedroom.webp'),(125,19,'jpg',1920,1080,'/uploads/accommodations/accomm_019/lisbon_balcony_flat_main.jpg'),(126,19,'jpg',1600,1200,'/uploads/accommodations/accomm_019/lisbon_balcony_flat_balcony.jpg'),(127,19,'webp',1600,1200,'/uploads/accommodations/accomm_019/lisbon_balcony_flat_kitchen.webp'),(128,19,'jpg',1920,1080,'/uploads/accommodations/accomm_019/lisbon_balcony_flat_street_view.jpg'),(129,20,'jpg',1920,1080,'/uploads/accommodations/accomm_020/brussels_market_studio_main.jpg'),(130,20,'jpg',1600,1200,'/uploads/accommodations/accomm_020/brussels_market_studio_bed.jpg'),(131,20,'webp',1600,1200,'/uploads/accommodations/accomm_020/brussels_market_studio_window.webp'),(132,21,'jpg',1920,1080,'/uploads/accommodations/accomm_021/berlin_minimal_studio_main.jpg'),(133,21,'webp',1600,1200,'/uploads/accommodations/accomm_021/berlin_minimal_studio_sleeping_area.webp'),(134,21,'jpg',1600,1200,'/uploads/accommodations/accomm_021/berlin_minimal_studio_kitchen.jpg'),(135,22,'jpg',1920,1080,'/uploads/accommodations/accomm_022/vienna_courtyard_living_room.jpg'),(136,22,'jpg',1600,1200,'/uploads/accommodations/accomm_022/vienna_courtyard_bedroom.jpg'),(137,22,'webp',1600,1200,'/uploads/accommodations/accomm_022/vienna_courtyard_view.webp'),(138,23,'jpg',1920,1080,'/uploads/accommodations/accomm_023/zurich_riverside_room_main.jpg'),(139,23,'jpg',1600,1200,'/uploads/accommodations/accomm_023/zurich_riverside_workspace.jpg'),(140,24,'jpg',1920,1080,'/uploads/accommodations/accomm_024/amsterdam_artist_flat_living_room.jpg'),(141,24,'webp',1600,1200,'/uploads/accommodations/accomm_024/amsterdam_artist_flat_bedroom.webp'),(142,24,'jpg',1600,1200,'/uploads/accommodations/accomm_024/amsterdam_artist_flat_kitchen.jpg'),(143,25,'jpg',1920,1080,'/uploads/accommodations/accomm_025/stockholm_harbour_studio_main.jpg'),(144,25,'jpg',1600,1200,'/uploads/accommodations/accomm_025/stockholm_harbour_studio_window.jpg'),(145,26,'jpg',1920,1080,'/uploads/accommodations/accomm_026/san_francisco_hilltop_room_view.jpg'),(146,26,'webp',1600,1200,'/uploads/accommodations/accomm_026/san_francisco_hilltop_room_bed.webp'),(147,26,'jpg',1600,1200,'/uploads/accommodations/accomm_026/san_francisco_hilltop_room_desk.jpg'),(148,27,'jpg',1920,1080,'/uploads/accommodations/accomm_027/nuremberg_old_town_flat_main.jpg'),(149,27,'jpg',1600,1200,'/uploads/accommodations/accomm_027/nuremberg_old_town_flat_bedroom.jpg'),(150,28,'jpg',1920,1080,'/uploads/accommodations/accomm_028/copenhagen_cozy_flat_living_room.jpg'),(151,28,'webp',1600,1200,'/uploads/accommodations/accomm_028/copenhagen_cozy_flat_bedroom.webp'),(152,29,'jpg',1920,1080,'/uploads/accommodations/accomm_029/athens_plaka_apartment_balcony.jpg'),(153,29,'jpg',1600,1200,'/uploads/accommodations/accomm_029/athens_plaka_apartment_bedroom.jpg'),(154,29,'webp',1600,1200,'/uploads/accommodations/accomm_029/athens_plaka_apartment_kitchen.webp'),(155,30,'jpg',1920,1080,'/uploads/accommodations/accomm_030/brooklyn_brownstone_room_main.jpg'),(156,30,'jpg',1600,1200,'/uploads/accommodations/accomm_030/brooklyn_brownstone_room_street.jpg'),(157,31,'jpg',1920,1080,'/uploads/accommodations/accomm_031/madrid_sunny_apartment_living_room.jpg'),(158,31,'webp',1600,1200,'/uploads/accommodations/accomm_031/madrid_sunny_apartment_bedroom.webp'),(159,31,'jpg',1600,1200,'/uploads/accommodations/accomm_031/madrid_sunny_apartment_balcony.jpg'),(160,32,'jpg',1920,1080,'/uploads/accommodations/accomm_032/warsaw_city_studio_main.jpg'),(161,32,'jpg',1600,1200,'/uploads/accommodations/accomm_032/warsaw_city_studio_sleeping_area.jpg');
/*!40000 ALTER TABLE `pictures` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pricing_information`
--

DROP TABLE IF EXISTS `pricing_information`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pricing_information` (
  `pricing_id` int NOT NULL AUTO_INCREMENT,
  `accomm_id` int NOT NULL,
  `valid_from` date NOT NULL,
  `valid_until` date NOT NULL,
  `pricing_type` varchar(20) NOT NULL DEFAULT 'General',
  `base_price_per_stay` decimal(8,2) DEFAULT '0.00',
  `base_price_per_night` decimal(8,2) DEFAULT '0.00',
  `price_per_person_per_stay` decimal(8,2) DEFAULT '0.00',
  `price_per_person_per_night` decimal(8,2) DEFAULT '0.00',
  PRIMARY KEY (`pricing_id`),
  UNIQUE KEY `pricing_id` (`pricing_id`),
  KEY `fk_pricing_information_accommodation` (`accomm_id`),
  CONSTRAINT `fk_pricing_information_accommodation` FOREIGN KEY (`accomm_id`) REFERENCES `accommodations` (`accomm_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `chk_pricing_dates` CHECK ((`valid_until` >= `valid_from`)),
  CONSTRAINT `chk_pricing_type` CHECK ((`pricing_type` in (_utf8mb4'General',_utf8mb4'Seasonal',_utf8mb4'Event',_utf8mb4'Override')))
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pricing_information`
--

LOCK TABLES `pricing_information` WRITE;
/*!40000 ALTER TABLE `pricing_information` DISABLE KEYS */;
INSERT INTO `pricing_information` VALUES (1,1,'2026-01-01','2026-12-31','General',40.00,110.00,8.00,0.00),(2,1,'2026-04-01','2026-09-30','Seasonal',55.00,145.00,10.00,0.00),(3,2,'2026-01-01','2026-12-31','General',30.00,125.00,0.00,0.00),(4,3,'2026-01-01','2026-12-31','General',20.00,78.00,0.00,0.00),(5,3,'2026-07-01','2026-12-31','Seasonal',25.00,88.00,0.00,4.00),(6,4,'2026-01-01','2026-12-31','General',25.00,95.00,5.00,0.00),(7,5,'2026-01-01','2026-12-31','General',45.00,140.00,0.00,6.00),(8,5,'2026-06-01','2026-09-30','Seasonal',60.00,175.00,12.00,0.00),(9,6,'2026-01-01','2026-12-31','General',35.00,132.00,0.00,0.00),(10,7,'2026-01-01','2026-12-31','General',15.00,72.00,0.00,3.50),(11,8,'2026-01-01','2026-12-31','General',50.00,165.00,0.00,0.00),(12,8,'2026-04-01','2026-10-31','Seasonal',60.00,195.00,15.00,0.00),(13,8,'2026-11-01','2026-12-31','Seasonal',55.00,180.00,0.00,7.50),(14,9,'2026-01-01','2026-12-31','General',35.00,118.00,8.00,0.00),(15,10,'2026-01-01','2026-12-31','General',40.00,135.00,0.00,5.00),(16,11,'2026-01-01','2026-12-31','General',20.00,82.00,0.00,0.00),(17,12,'2026-01-01','2026-12-31','General',80.00,145.00,25.00,0.00),(18,12,'2026-04-01','2026-08-31','Seasonal',95.00,210.00,0.00,12.00),(19,12,'2026-09-01','2026-12-31','Seasonal',75.00,165.00,20.00,0.00),(20,13,'2026-01-01','2026-12-31','General',35.00,120.00,0.00,0.00),(21,14,'2026-01-01','2026-12-31','General',75.00,185.00,0.00,8.00),(22,14,'2026-06-01','2026-09-30','Seasonal',90.00,230.00,18.00,0.00),(23,15,'2026-01-01','2026-12-31','General',55.00,170.00,0.00,7.00),(24,16,'2026-01-01','2026-12-31','General',15.00,68.00,0.00,0.00),(25,17,'2026-01-01','2026-12-31','General',20.00,92.00,6.00,0.00),(26,18,'2026-01-01','2026-12-31','General',70.00,175.00,0.00,0.00),(27,18,'2026-05-01','2026-10-31','Seasonal',85.00,220.00,0.00,11.00),(28,19,'2026-01-01','2026-12-31','General',35.00,112.00,7.50,0.00),(29,20,'2026-01-01','2026-12-31','General',20.00,75.00,0.00,3.00),(30,21,'2026-01-01','2026-12-31','General',20.00,85.00,0.00,0.00),(31,22,'2026-01-01','2026-12-31','General',30.00,105.00,0.00,0.00),(32,22,'2026-07-01','2026-12-31','Seasonal',35.00,120.00,5.00,0.00),(33,23,'2026-01-01','2026-12-31','General',35.00,130.00,0.00,6.00),(34,24,'2026-01-01','2026-12-31','General',30.00,115.00,0.00,0.00),(35,25,'2026-01-01','2026-12-31','General',25.00,98.00,4.00,0.00),(36,26,'2026-01-01','2026-12-31','General',45.00,140.00,0.00,9.00),(37,27,'2026-01-01','2026-12-31','General',25.00,90.00,0.00,0.00),(38,28,'2026-01-01','2026-12-31','General',30.00,105.00,0.00,4.50),(39,29,'2026-01-01','2026-12-31','General',25.00,92.00,6.00,0.00),(40,30,'2026-01-01','2026-12-31','General',40.00,125.00,0.00,5.50),(41,31,'2026-01-01','2026-12-31','General',35.00,115.00,9.00,0.00),(42,32,'2026-01-01','2026-12-31','General',20.00,80.00,0.00,0.00),(43,1,'2026-07-10','2026-07-12','Event',75.00,190.00,15.00,0.00),(44,8,'2026-06-12','2026-06-14','Event',90.00,240.00,20.00,0.00),(45,12,'2026-07-04','2026-07-06','Override',125.00,260.00,0.00,15.00);
/*!40000 ALTER TABLE `pricing_information` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_pricing_no_same_type_overlap_insert` BEFORE INSERT ON `pricing_information` FOR EACH ROW BEGIN
  IF EXISTS (
    SELECT 1
    FROM pricing_information pi
    WHERE pi.accomm_id = NEW.accomm_id
      AND pi.pricing_type = NEW.pricing_type
      AND NEW.valid_from <= pi.valid_until
      AND NEW.valid_until >= pi.valid_from
  ) THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Pricing periods of the same type may not overlap for the same accommodation.';
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_pricing_before_update` BEFORE UPDATE ON `pricing_information` FOR EACH ROW BEGIN
  IF OLD.pricing_type = 'General' THEN

    IF EXISTS (
      SELECT 1
      FROM availabilities a
      WHERE a.accomm_id = OLD.accomm_id
        AND a.valid_from <= OLD.valid_until
        AND a.valid_until >= OLD.valid_from
        AND NOT (
          (
            NEW.pricing_type = 'General'
            AND a.accomm_id = NEW.accomm_id
            AND a.valid_from >= NEW.valid_from
            AND a.valid_until <= NEW.valid_until
          )
          OR EXISTS (
            SELECT 1
            FROM pricing_information p
            WHERE p.accomm_id = a.accomm_id
              AND p.pricing_type = 'General'
              AND p.pricing_id <> OLD.pricing_id
              AND a.valid_from >= p.valid_from
              AND a.valid_until <= p.valid_until
          )
        )
    ) THEN
      SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot update General pricing period: existing availability would no longer be covered by General pricing.';
    END IF;

  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_pricing_no_same_type_overlap_update` BEFORE UPDATE ON `pricing_information` FOR EACH ROW BEGIN
  IF EXISTS (
    SELECT 1
    FROM pricing_information pi
    WHERE pi.accomm_id = NEW.accomm_id
      AND pi.pricing_type = NEW.pricing_type
      AND pi.pricing_id <> OLD.pricing_id
      AND NEW.valid_from <= pi.valid_until
      AND NEW.valid_until >= pi.valid_from
  ) THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Pricing periods of the same type may not overlap for the same accommodation.';
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_pricing_before_delete` BEFORE DELETE ON `pricing_information` FOR EACH ROW BEGIN
  IF OLD.pricing_type = 'General' THEN

    IF EXISTS (
      SELECT 1
      FROM availabilities a
      WHERE a.accomm_id = OLD.accomm_id
        AND a.valid_from <= OLD.valid_until
        AND a.valid_until >= OLD.valid_from
        AND NOT EXISTS (
          SELECT 1
          FROM pricing_information p
          WHERE p.accomm_id = a.accomm_id
            AND p.pricing_type = 'General'
            AND p.pricing_id <> OLD.pricing_id
            AND a.valid_from >= p.valid_from
            AND a.valid_until <= p.valid_until
        )
    ) THEN
      SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot delete General pricing period: existing availability would no longer be covered by General pricing.';
    END IF;

  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reviews` (
  `booking_id` int NOT NULL,
  `rating_by_guest` int DEFAULT NULL,
  `rating_by_host` int DEFAULT NULL,
  `review_by_guest` text,
  `review_by_host` text,
  PRIMARY KEY (`booking_id`),
  UNIQUE KEY `booking_id` (`booking_id`),
  CONSTRAINT `fk_reviews_booking` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`booking_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `chk_rating_by_guest` CHECK (((`rating_by_guest` is null) or (`rating_by_guest` between 1 and 5))),
  CONSTRAINT `chk_rating_by_host` CHECK (((`rating_by_host` is null) or (`rating_by_host` between 1 and 5)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews`
--

LOCK TABLES `reviews` WRITE;
/*!40000 ALTER TABLE `reviews` DISABLE KEYS */;
INSERT INTO `reviews` VALUES (1,5,5,'Beautiful cabin with a cozy fireplace and very clear check-in instructions. The parking directions were helpful and the stay felt peaceful.','Ben and his travel companion were excellent guests. Communication was friendly and they left the cabin very tidy.'),(2,4,NULL,'Lovely mountain cabin with plenty of space for our group. The location was quiet and the kitchen had everything we needed.',NULL),(4,4,5,'Great city loft in Hamburg. Check-in with the key box was easy and the location was perfect for a short trip.','Alice was a reliable and pleasant guest. She communicated her arrival time clearly and respected the apartment rules.'),(6,5,4,'The garden-facing workspace was exactly what I needed. Quiet, bright, and very comfortable for remote work.','Felix was a good guest and left the studio in nice condition. Communication before arrival was smooth.'),(8,4,5,'Lovely Salzburg flat with a lot of charm. The parking garage was close enough and the host was very helpful.','Jonas was friendly, easy to communicate with, and took good care of the flat.'),(10,5,5,'The Lucerne apartment was perfect for our family. The crib and high chair were ready when we arrived, which made things much easier.','Ben and his family were wonderful guests. They were respectful, kind, and left the apartment in excellent shape.'),(12,5,4,'The canal view was lovely and the private balcony made the stay feel special. Would absolutely book again.','David was a considerate guest and communicated well throughout the booking.'),(15,4,4,'Comfortable flat in a great Paris location. The kitchen had everything we needed for a short stay.','Felix and his group were polite and easy guests. The flat was left in good condition.'),(18,4,5,'Great Barcelona apartment with a sunny balcony. The location was very walkable and lively.','Clara was a great guest. Friendly communication and no issues during the stay.'),(19,5,5,'The Rome apartment had a wonderful atmosphere and the rooftop terrace was a highlight of the trip.','David and his group were excellent guests. They were respectful and left the apartment very clean.'),(21,5,NULL,'The Miami condo was bright, clean, and very close to the beach. Pool access for all guests worked exactly as expected.',NULL),(25,4,4,'Classic London flat with a nice location and comfortable rooms. Everything matched the listing.','Jonas was a reliable guest and followed the house rules carefully.'),(27,4,5,'The Tokyo micro flat was compact but well designed. It worked well for a short stay with light luggage.','Leon was very easy to host and communicated clearly before check-in.'),(29,5,NULL,'The Lisbon balcony flat was sunny, welcoming, and in a great area for walking around the city.',NULL),(31,4,5,'The Berlin studio was small but practical, and the WiFi worked well for video calls.','Paul was a very respectful guest and left the studio neat.'),(32,NULL,4,NULL,'Quinn and the other guests were polite and easy to host. The apartment was left in good condition.'),(33,4,NULL,'The Zurich riverside room was clean and quiet. The workspace was useful and the location near the river was a nice bonus.',NULL),(39,5,5,'The Athens Plaka apartment was sunny, central, and close to the historic sights. The balcony was lovely in the evening.','Yara was a wonderful guest. Communication was kind and clear, and the apartment was treated with care.'),(40,4,NULL,'The Brooklyn room was cozy and well located. It was easy to get around by subway and the neighborhood had great cafés.',NULL),(41,5,4,'The Madrid apartment was bright, spacious enough for our group, and very comfortable for a city trip.','Carlos and his group were friendly and respectful guests. Everything was left in good order.'),(42,NULL,5,NULL,'Daria was an excellent guest. Communication was smooth, and the Warsaw studio was left very clean.');
/*!40000 ALTER TABLE `reviews` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_reviews_before_insert` BEFORE INSERT ON `reviews` FOR EACH ROW BEGIN
  IF NOT EXISTS (
    SELECT 1
    FROM bookings b
    WHERE b.booking_id = NEW.booking_id
      AND b.confirmed = TRUE
      AND b.cancelled = FALSE
      AND b.end_date < CURDATE()
  ) THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Reviews can only be added for confirmed, completed, non-cancelled bookings.';
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_reviews_before_update` BEFORE UPDATE ON `reviews` FOR EACH ROW BEGIN
  IF NOT EXISTS (
    SELECT 1
    FROM bookings b
    WHERE b.booking_id = NEW.booking_id
      AND b.confirmed = TRUE
      AND b.cancelled = FALSE
      AND b.end_date < CURDATE()
  ) THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Reviews can only be updated for confirmed, completed, non-cancelled bookings.';
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `social_media_connections`
--

DROP TABLE IF EXISTS `social_media_connections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `social_media_connections` (
  `social_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `platform` varchar(64) NOT NULL,
  `account_name` varchar(64) NOT NULL,
  `details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`social_id`),
  UNIQUE KEY `social_id` (`social_id`),
  KEY `fk_social_media_connections_guest` (`user_id`),
  CONSTRAINT `fk_social_media_connections_guest` FOREIGN KEY (`user_id`) REFERENCES `guests` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `social_media_connections`
--

LOCK TABLES `social_media_connections` WRITE;
/*!40000 ALTER TABLE `social_media_connections` DISABLE KEYS */;
INSERT INTO `social_media_connections` VALUES (1,1,'Instagram','alice.travels','OAuth connected, profile synced'),(2,2,'Google','ben.schulz@gmail.com','Single Sign-On enabled'),(3,3,'Instagram','clara.citylife','OAuth connected'),(4,3,'TikTok','claragoesplaces','Short video profile linked'),(5,5,'Google','emma.klein@gmail.com','Single Sign-On enabled'),(6,6,'Facebook','Felix Wagner','Connected for login'),(7,7,'Instagram','greta_nordic','OAuth connected'),(8,8,'Google','henry.hoffmann@gmail.com','Single Sign-On enabled'),(9,8,'Facebook','Henry Hoffmann','Login via Facebook'),(10,10,'TikTok','jonas.moves','Connected social profile'),(11,11,'Google','klara.braun@yahoo.com','Single Sign-On enabled'),(12,11,'Instagram','klara.escape','Photos synced'),(13,13,'Facebook','Mara Peters','Connected for login'),(14,14,'Google','noah.lang@proton.me','Single Sign-On enabled'),(15,15,'Instagram','olivia_citystays','OAuth connected'),(16,17,'Google','quinn.seidel@outlook.com','Single Sign-On enabled'),(17,18,'Instagram','rosa.suntrip','Photos synced'),(18,20,'Facebook','Tina Lorenz','Connected for login'),(19,21,'Instagram','ulf_scandi','OAuth connected'),(20,23,'Google','will.carter@gmail.com','Single Sign-On enabled'),(21,23,'Instagram','willnycstay','Travel profile linked'),(22,24,'LinkedIn','Xena Papadopoulos','Identity verified'),(23,25,'Facebook','Yara Hassan','Connected for login'),(24,27,'Instagram','amir.uae','OAuth connected'),(25,28,'Facebook','Bianca Rossi','Connected for login'),(26,29,'Google','carlos.navarro@gmail.com','Single Sign-On enabled'),(27,30,'TikTok','daria.citybreaks','Connected short video profile');
/*!40000 ALTER TABLE `social_media_connections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `user_name` varchar(20) NOT NULL,
  `password` varchar(100) NOT NULL,
  `email_address` varchar(100) NOT NULL,
  `phone_number` varchar(20) NOT NULL,
  `verified` tinyint(1) NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `user_id` (`user_id`),
  UNIQUE KEY `user_name` (`user_name`),
  UNIQUE KEY `email_address` (`email_address`),
  UNIQUE KEY `phone_number` (`phone_number`),
  CONSTRAINT `chk_email_format` CHECK (regexp_like(`email_address`,_utf8mb4'^[^@]+@[^@]+.[^@]+$'))
) ENGINE=InnoDB AUTO_INCREMENT=95 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Alice','Meyer','alice.m','A1ice!Pass','alice.meyer@gmail.com','+49-151-88451234',1),(2,'Ben','Schulz','benji_s','B3n#Secure','ben.schulz@outlook.com','+49-176-33219877',1),(3,'Clara','Weber','claraw','Cl@ra2024','clara.weber@yahoo.com','+43-664-1122334',1),(4,'David','Fischer','dfisch','Dav!dPwd','david.fischer@hotmail.com','+41-79-9988776',1),(5,'Emma','Klein','emma.k','Emm@Safe','emma.klein@gmail.com','+31-6-12345678',1),(6,'Felix','Wagner','felix_w','F3lixPW','felix.wagner@aol.com','+49-171-5566778',1),(7,'Greta','Becker','g_beck','Gr3ta!','greta.becker@icloud.com','+46-70-4455667',1),(8,'Henry','Hoffmann','henryh','H3nry#1','henry.hoffmann@gmail.com','+1-415-555-0181',1),(9,'Isabel','Neumann','isa_neu','Isa!Pwd','isabel.neumann@outlook.com','+49-160-9988776',1),(10,'Jonas','Richter','jon_r','J0nas*Pw','jonas.richter@gmail.com','+49-152-2233445',1),(11,'Klara','Braun','klara_b','Kl@raPW','klara.braun@yahoo.com','+43-650-7766554',1),(12,'Leon','Kruger','leon_k','L30n#Key','leon.kruger@hotmail.com','+41-78-3344556',1),(13,'Mara','Peters','mara_p','M@raSafe','mara.peters@gmail.com','+31-6-87654321',1),(14,'Noah','Lang','noah_l','No@hPwd','noah.lang@proton.me','+49-175-9988221',1),(15,'Olivia','Schmitt','olisch','Ol!via1','olivia.schmitt@icloud.com','+49-163-4455667',1),(16,'Paul','Koch','paulko','P@ulPwd','paul.koch@gmail.com','+49-157-7788990',1),(17,'Quinn','Seidel','qseid','Q!nnKey','quinn.seidel@outlook.com','+49-170-2233445',1),(18,'Rosa','Hartmann','rosah','R0sa#Pw','rosa.hartmann@yahoo.com','+34-612-334455',1),(19,'Simon','Bauer','simonb','S!monPwd','simon.bauer@gmail.com','+49-172-9988776',1),(20,'Tina','Lorenz','tinal','T!naKey','tina.lorenz@aol.com','+49-155-6677889',1),(21,'Ulf','Johansson','ulf_j','Ulf#Pwd','ulf.johansson@gmail.com','+46-72-1122334',1),(22,'Vera','Madsen','veram','V3raSafe','vera.madsen@outlook.com','+45-28-556677',1),(23,'Will','Carter','willc','W!ll2024','will.carter@gmail.com','+1-212-555-0199',1),(24,'Xena','Papadopoulos','xenap','X3na#Pw','xena.p@icloud.com','+30-694-5566778',1),(25,'Yara','Hassan','yara_h','Y@raPwd','yara.hassan@yahoo.com','+20-100-2233445',1),(26,'Zane','Miller','z_mill','Z@neKey','zane.miller@gmail.com','+1-646-555-0177',1),(27,'Amir','Rahman','amir_r','Am!rPw','amir.rahman@proton.me','+971-50-3344556',1),(28,'Bianca','Rossi','birossi','B!ancaPw','bianca.rossi@hotmail.com','+39-347-5566778',1),(29,'Carlos','Navarro','cnav','C@rlos1','carlos.navarro@gmail.com','+34-622-998877',1),(30,'Daria','Kowalska','dkow','D@riaPw','daria.kowalska@outlook.com','+48-608-112233',1),(31,'Ethan','Brooks','ebrooks','Eth@nPwd','ethan.brooks@gmail.com','+1-303-555-0144',1),(32,'Farah','Al-Sayed','farahs','F@rahKey','farah.alsayed@yahoo.com','+966-55-6677889',1),(33,'Giulia','Bianchi','giub','G!uliaPw','giulia.bianchi@icloud.com','+39-320-9988776',1),(34,'Hugo','Martinez','hugom','Hugo#1','hugo.martinez@gmail.com','+34-611-445566',1),(35,'Ines','Dupont','inesd','In3sPwd','ines.dupont@hotmail.com','+33-6-22334455',1),(36,'Jakob','Lind','jlind','J@kobKey','jakob.lind@gmail.com','+47-412-334455',1),(37,'Keiko','Tanaka','ktanaka','K3ikoPwd','keiko.tanaka@yahoo.co.jp','+81-90-11223344',1),(38,'Liam','OConnor','liamoc','L!amPwd','liam.oconnor@outlook.ie','+353-85-6677889',1),(39,'Mila','Novak','mnovak','M!la2024','mila.novak@gmail.com','+420-777-445566',1),(40,'Nico','Steiner','nsteiner','N!coPwd','nico.steiner@gmail.com','+49-159-3344556',1),(41,'Anna','Schneider','aschneider','An!na01','anna.schneider@earthbnb.com','+49-151-7002001',1),(42,'Lukas','Weber','lweber','Luk@s02','lukas.weber@earthbnb.com','+49-160-7002002',1),(43,'Mia','Fischer','mfischer','Mi@03Pwd','mia.fischer@earthbnb.com','+49-171-7002003',1),(44,'Jonas','Müller','jmueller','Jon@s04','jonas.mueller@earthbnb.com','+49-172-7002004',1),(45,'Sophie','Keller','skeller','Soph!e05','sophie.keller@earthbnb.com','+49-176-7002005',1),(46,'Paul','Becker','pbecker','Pa!ul06','paul.becker@earthbnb.com','+49-151-7002006',1),(47,'Laura','Koch','lkoch','Lau#07Pw','laura.koch@earthbnb.com','+49-160-7002007',1),(48,'Tobias','Wagner','twagner','Tob!08Pw','tobias.wagner@earthbnb.com','+49-171-7002008',1),(49,'Hannah','Schmitt','hschmitt','Han!09Pw','hannah.schmitt@earthbnb.com','+49-172-7002009',1),(50,'Felix','Braun','fbraun','Fel#10Pw','felix.braun@earthbnb.com','+49-176-7002010',1),(51,'Leonie','Gruber','lgruber','Leo!11Pw','leonie.gruber@earthbnb.com','+43-664-7002011',1),(52,'Matthias','Huber','mhuber2','Matt#12','matthias.huber@earthbnb.com','+43-650-7002012',1),(53,'Nina','Baumann','nbaumann','Nin@13Pw','nina.baumann@earthbnb.com','+41-79-7002013',1),(54,'David','Keller','dkeller','Dav!d14','david.keller@earthbnb.com','+41-78-7002014',1),(55,'Eva','deVries','edevries','Ev@15Pwd','eva.devries@earthbnb.com','+31-6-7002015',1),(56,'Thomas','Jansen','tjansen','Th0mas16','thomas.jansen@earthbnb.com','+31-6-7002016',1),(57,'Linnea','Andersson','landersson','Lin#17Pw','linnea.andersson@earthbnb.com','+46-70-7002017',1),(58,'Erik','Larsson','elarsson','Er!k18Pw','erik.larsson@earthbnb.com','+46-72-7002018',1),(59,'Marius','Hansen','mhansen','Mar!us19','marius.hansen@earthbnb.com','+47-412-7002019',1),(60,'Ingrid','Solberg','isolberg','Ingr!d20','ingrid.solberg@earthbnb.com','+47-415-7002020',1),(61,'Claire','Dubois','cdubois','Cla!re21','claire.dubois@earthbnb.com','+33-6-7002021',1),(62,'Julien','Moreau','jmoreau','Jul!en22','julien.moreau@earthbnb.com','+33-6-7002022',1),(63,'Lucia','Garcia','lgarcia','Luc!a23','lucia.garcia@earthbnb.com','+34-611-7002023',1),(64,'Carlos','Martinez','cmartinez2','Carl#24','carlos.martinez@earthbnb.com','+34-622-7002024',1),(65,'Marco','Rossi','mrossi2','Mar#25Pw','marco.rossi@earthbnb.com','+39-347-7002025',1),(66,'Giulia','Conti','gconti','Giu!26Pw','giulia.conti@earthbnb.com','+39-320-7002026',1),(67,'Emily','Carter','ecarter','Em!ly27','emily.carter@earthbnb.com','+1-617-7002027',1),(68,'Ryan','Miller','rmiller2','Ry@n28Pw','ryan.miller@earthbnb.com','+1-617-7002028',1),(69,'Sarah','Johnson','sjohnson','Sar!h29','sarah.johnson@earthbnb.com','+1-604-7002029',1),(70,'Daniel','Lee','dlee','Dan!el30','daniel.lee@earthbnb.com','+1-604-7002030',1),(71,'Oliver','Hughes','ohughes','Oliv#31','oliver.hughes@earthbnb.com','+44-7700-7002031',1),(72,'Amelia','Taylor','ataylor','Amel!32','amelia.taylor@earthbnb.com','+44-7700-7002032',1),(73,'Sean','Murphy','smurphy','Se@n33Pw','sean.murphy@earthbnb.com','+353-85-7002033',1),(74,'Aoife','Byrne','abyrne','Ao!fe34','aoife.byrne@earthbnb.com','+353-86-7002034',1),(75,'Yuki','Sato','ysato','YuK!35Pw','yuki.sato@earthbnb.com','+81-90-7002035',1),(76,'Haruto','Tanaka','htanaka','Har#36Pw','haruto.tanaka@earthbnb.com','+81-90-7002036',1),(77,'Miguel','Silva','msilva2','Mig!el37','miguel.silva@earthbnb.com','+351-91-7002037',1),(78,'Ines','Costa','icosta','In3s38Pw','ines.costa@earthbnb.com','+351-92-7002038',1),(79,'Sophie','Peeters','speeters','Soph!39','sophie.peeters@earthbnb.com','+32-470-7002039',1),(80,'Lucas','Vermeulen','lvermeulen','Luc@s40','lucas.vermeulen@earthbnb.com','+32-472-7002040',1),(81,'Maja','Nowak','maja_n','M@jaNew41','maja.nowak@gmail.com','+48-601-778899',0),(82,'Tom','Wallace','tomwall','T0mPending42','tom.wallace@hotmail.com','+44-7700-778899',0),(83,'Marlene','Vogel','mvogel83','Marl3ne!83','marlene.vogel@gmail.com','+49-160-7712083',1),(84,'Theresa','Bauer','tbauer84','Ther3sa!84','theresa.bauer@outlook.com','+43-660-7712084',1),(85,'Sandro','Meier','smeier85','Sandro!85','sandro.meier@proton.me','+41-76-7712085',1),(86,'Lotte','Visser','lvisser86','Lotte!86','lotte.visser@gmail.com','+31-6-7712086',1),(87,'Freja','Nilsson','fnilsson87','Freja!87','freja.nilsson@icloud.com','+46-73-7712087',1),(88,'Mason','Reed','mreed88','Mas0n!88','mason.reed@hotmail.com','+1-415-555-0288',1),(89,'Katrin','Lehmann','klehmann89','Katr!n89','katrin.lehmann@yahoo.com','+49-171-7712089',1),(90,'Emil','Christensen','echristensen90','Emil!90','emil.christensen@gmail.com','+45-28-771290',1),(91,'Nikos','Anagnostou','nanagnostou91','Nik0s!91','nikos.anagnostou@outlook.com','+30-694-7712091',1),(92,'Madison','Brooks','mbrooks92','Mad!son92','madison.brooks@gmail.com','+1-646-555-0292',1),(93,'Diego','Santos','dsantos93','Dieg0!93','diego.santos@hotmail.com','+34-633-7712093',1),(94,'Kasia','Zielinska','kzielinska94','Kas!a94','kasia.zielinska@gmail.com','+48-602-7712094',1);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wishlisted_accommodations`
--

DROP TABLE IF EXISTS `wishlisted_accommodations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wishlisted_accommodations` (
  `accomm_id` int NOT NULL,
  `wishlist_id` int NOT NULL,
  PRIMARY KEY (`accomm_id`,`wishlist_id`),
  KEY `fk_wishlisted_accommodations_wishlist` (`wishlist_id`),
  CONSTRAINT `fk_wishlisted_accommodations_accommodation` FOREIGN KEY (`accomm_id`) REFERENCES `accommodations` (`accomm_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_wishlisted_accommodations_wishlist` FOREIGN KEY (`wishlist_id`) REFERENCES `wishlists` (`wishlist_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wishlisted_accommodations`
--

LOCK TABLES `wishlisted_accommodations` WRITE;
/*!40000 ALTER TABLE `wishlisted_accommodations` DISABLE KEYS */;
INSERT INTO `wishlisted_accommodations` VALUES (1,1),(3,1),(16,1),(1,2),(5,2),(27,2),(2,3),(8,3),(15,3),(21,3),(4,4),(10,4),(19,4),(6,5),(23,5),(24,5),(12,6),(26,6),(30,6),(4,7),(22,7),(27,7),(32,7),(3,8),(13,8),(23,8),(26,8),(9,9),(11,9),(18,9),(29,9),(7,10),(25,10),(28,10),(8,11),(13,11),(15,11),(30,11),(10,12),(11,12),(29,12),(12,13),(14,13),(18,13),(10,14),(19,14),(31,14),(16,15),(20,15),(21,15),(32,15),(3,16),(21,16),(27,16),(4,17),(22,17),(12,18),(26,18),(11,19),(29,19),(27,20),(32,20);
/*!40000 ALTER TABLE `wishlisted_accommodations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wishlists`
--

DROP TABLE IF EXISTS `wishlists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wishlists` (
  `wishlist_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `title` varchar(100) NOT NULL,
  PRIMARY KEY (`wishlist_id`),
  UNIQUE KEY `wishlist_id` (`wishlist_id`),
  KEY `fk_wishlists_guest` (`user_id`),
  CONSTRAINT `fk_wishlists_guest` FOREIGN KEY (`user_id`) REFERENCES `guests` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wishlists`
--

LOCK TABLES `wishlists` WRITE;
/*!40000 ALTER TABLE `wishlists` DISABLE KEYS */;
INSERT INTO `wishlists` VALUES (1,1,'Weekend Escapes'),(2,1,'Mountain Dreams'),(3,3,'City Break Ideas'),(4,3,'Romantic Getaways'),(5,5,'Canal and River Stays'),(6,8,'US Travel Picks'),(7,8,'Central Europe Favorites'),(8,11,'Work-friendly Stays'),(9,14,'Sunny Places'),(10,14,'Nordic Trips'),(11,18,'Big City Apartments'),(12,21,'Historic Views'),(13,21,'Luxury Beach Ideas'),(14,23,'Italy Wishlist'),(15,24,'Budget City Studios'),(16,24,'Berlin and Beyond'),(17,27,'Courtyard Calm'),(18,28,'California Favorites'),(19,28,'Greek Holidays'),(20,30,'Poland Travel List');
/*!40000 ALTER TABLE `wishlists` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `workplaces`
--

DROP TABLE IF EXISTS `workplaces`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `workplaces` (
  `workplace_id` int NOT NULL AUTO_INCREMENT,
  `address_id` int NOT NULL,
  `location_title` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`workplace_id`),
  UNIQUE KEY `workplace_id` (`workplace_id`),
  UNIQUE KEY `address_id` (`address_id`),
  CONSTRAINT `fk_workplaces_address` FOREIGN KEY (`address_id`) REFERENCES `addresses` (`address_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `workplaces`
--

LOCK TABLES `workplaces` WRITE;
/*!40000 ALTER TABLE `workplaces` DISABLE KEYS */;
INSERT INTO `workplaces` VALUES (1,61,'Munich Office'),(2,62,'Hamburg Office'),(3,63,'Cologne Office'),(4,64,'Frankfurt Office'),(5,65,'Stuttgart Office'),(6,66,'Salzburg Office'),(7,67,'Geneva Office'),(8,68,'Rotterdam Office'),(9,69,'Gothenburg Office'),(10,70,'Oslo Office'),(11,71,'Lyon Office'),(12,72,'Valencia Office'),(13,73,'Milan Office'),(14,74,'Boston Office'),(15,75,'Vancouver Office'),(16,76,'Manchester Office'),(17,77,'Cork Office'),(18,78,'Kyoto Office'),(19,79,'Lisbon Office'),(20,80,'Brussels South Office');
/*!40000 ALTER TABLE `workplaces` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'earthbnb'
--

--
-- Dumping routines for database 'earthbnb'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-06-20 16:34:31
