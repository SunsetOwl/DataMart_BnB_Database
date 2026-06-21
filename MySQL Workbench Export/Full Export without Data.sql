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

-- Dump completed on 2026-06-21 11:31:58
