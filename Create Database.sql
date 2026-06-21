-- ===============================================================
-- EarthBnB Database Setup
-- ===============================================================
-- This script sets up the entire EarthBnB database from scratch.
-- It first removes any existing version of the database so that
-- the script can be rerun from a clean state during testing.
-- ===============================================================

DROP DATABASE IF EXISTS EarthBnB;
CREATE DATABASE EarthBnB;
USE EarthBnB;

-- ============================================================
-- Countries
-- ============================================================
-- Stores country-specific information used by addresses and
-- price calculations.
-- See data dictionary for details.
-- ============================================================

CREATE TABLE countries (
    country_id INT NOT NULL UNIQUE AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    tax_fixed DECIMAL(6 , 2 ) DEFAULT 0.00,
    tax_percentage DECIMAL(6 , 5 ) DEFAULT 0.00000,
    per_person BOOLEAN,
    applied_once BOOLEAN,
    currency VARCHAR(3) NOT NULL,
    PRIMARY KEY (country_id)
);

-- ============================================================
-- Addresses
-- ============================================================
-- Stores all physical addresses used in the system.
-- Each address belongs to exactly one country.
-- See data dictionary for details.
-- ============================================================

CREATE TABLE addresses (
    address_id INT NOT NULL UNIQUE AUTO_INCREMENT,
    identifier VARCHAR(255),
    street VARCHAR(255) NOT NULL,
    street_no VARCHAR(20) NOT NULL,
    postal_code VARCHAR(20) NOT NULL,
    city VARCHAR(100) NOT NULL,
    state VARCHAR(20),
    country_id INT NOT NULL,
    PRIMARY KEY (address_id),
    
	-- Prevents addresses from referencing countries that do not exist.
	-- Countries cannot be deleted while addresses within exist.
    CONSTRAINT fk_addresses_country FOREIGN KEY (country_id)
        REFERENCES countries (country_id)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

-- ============================================================
-- Workplaces
-- ============================================================
-- Stores Earth_BnB office locations.
-- Each workplace is linked to one unique address.
-- Employees may later be assigned to one of these workplaces.
-- See data dictionary for details.
-- ============================================================

CREATE TABLE workplaces (
    workplace_id INT NOT NULL UNIQUE AUTO_INCREMENT,
    address_id INT NOT NULL UNIQUE,
    location_title VARCHAR(64),
    PRIMARY KEY (workplace_id),
    
	-- A workplace must have a valid address.
	-- The address cannot be deleted while it is still used by a workplace.
    CONSTRAINT fk_workplaces_address FOREIGN KEY (address_id)
        REFERENCES addresses (address_id)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

-- ============================================================
-- Users
-- ============================================================
-- Stores general account information for all users.
-- Employees, hosts, and guests are then modelled as
-- extensions of a general user.
-- See data dictionary for details.
-- ============================================================

CREATE TABLE users (
    user_id INT NOT NULL UNIQUE AUTO_INCREMENT,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    user_name VARCHAR(20) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    email_address VARCHAR(100) NOT NULL UNIQUE,
    phone_number VARCHAR(20) NOT NULL UNIQUE,
    verified BOOLEAN NOT NULL,
    PRIMARY KEY (user_id),
    
    -- Basic email format validation to prevent clearly invalid emails.
    CONSTRAINT chk_email_format CHECK (email_address REGEXP '^[^@]+@[^@]+\.[^@]+$')
);

-- ============================================================
-- Employees
-- ============================================================
-- Stores employee-specific user information.
-- Each employee must already exist as a user.
-- To account for remote workers, the workplace is optional.
-- See data dictionary for details.
-- ============================================================

CREATE TABLE employees (
    user_id INT NOT NULL UNIQUE,
    home_address INT NOT NULL,
    workplace_id INT,
    job_title VARCHAR(64) NOT NULL,
    PRIMARY KEY (user_id),
    
    -- Employee records are changed/deleted automatically,
	-- if the related user account is changed.
    CONSTRAINT fk_employees_user FOREIGN KEY (user_id)
        REFERENCES users (user_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
        
	-- An employee must have a valid home address.
    CONSTRAINT fk_employees_home_address FOREIGN KEY (home_address)
        REFERENCES addresses (address_id)
        ON UPDATE CASCADE ON DELETE RESTRICT,
        
	-- The workplace may be set to NULL if the referenced
	-- workplace is deleted, so the employee can be 
	-- reassigned or become remote only.
    CONSTRAINT fk_employees_workplace FOREIGN KEY (workplace_id)
        REFERENCES workplaces (workplace_id)
        ON UPDATE CASCADE ON DELETE SET NULL
);

-- ===============================================================================
-- Pictures
-- ===============================================================================
-- Stores metadata for uploaded image files on the server.
-- Pictures can be used as user profile pictures or as accommodation pictures.
-- The accommodation foreign key is added later, after the accommodations table
-- has been created, to avoid circular creation-order issues with the hosts table.
-- See data dictionary for details.
-- ===============================================================================

CREATE TABLE pictures (
    picture_id INT NOT NULL UNIQUE AUTO_INCREMENT,
    accomm_id INT,
    format VARCHAR(20) NOT NULL,
    width INT NOT NULL,
    height INT NOT NULL,
    file_location VARCHAR(255) NOT NULL,
    PRIMARY KEY (picture_id)
);

-- ============================================================
-- Guests
-- ============================================================
-- Stores guest-specific user information.
-- Each guest must already exist as a user.
-- See data dictionary for details.
-- ============================================================

CREATE TABLE guests (
    user_id INT NOT NULL UNIQUE,
    profile_picture INT,
    PRIMARY KEY (user_id),
    
    -- Guest records are changed/deleted automatically,
	-- if the related user account is changed.
    CONSTRAINT fk_guests_user FOREIGN KEY (user_id)
        REFERENCES users (user_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
        
	-- If a profile picture is deleted, the guest remains in the system
	-- and the profile picture reference is set to NULL.
    CONSTRAINT fk_guests_profile_picture FOREIGN KEY (profile_picture)
        REFERENCES pictures (picture_id)
        ON UPDATE CASCADE ON DELETE SET NULL
);

-- ============================================================
-- Hosts
-- ============================================================
-- Stores host-specific user information.
-- Each host must already exist as a user.
-- Hosts have an address and must have a profile picture.
-- See data dictionary for details.
-- ============================================================

CREATE TABLE hosts (
    user_id INT NOT NULL UNIQUE,
    address_id INT NOT NULL,
    profile_picture INT NOT NULL,
    PRIMARY KEY (user_id),
    
    -- Host records are changed/deleted automatically,
	-- if the related user account is changed.
    CONSTRAINT fk_hosts_user FOREIGN KEY (user_id)
        REFERENCES users (user_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
        
	-- A host must have a valid address.
    CONSTRAINT fk_hosts_address FOREIGN KEY (address_id)
        REFERENCES addresses (address_id)
        ON UPDATE CASCADE ON DELETE RESTRICT,
        
	-- Host profile pictures are required and therefore cannot be
	-- deleted while still referenced by a host.
    CONSTRAINT fk_hosts_profile_picture FOREIGN KEY (profile_picture)
        REFERENCES pictures (picture_id)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

-- ============================================================
-- Social Media Connections
-- ============================================================
-- Stores optional social media accounts linked to guest profiles.
-- Each connection belongs to one guest.
-- See data dictionary for details.
-- ============================================================

CREATE TABLE social_media_connections (
    social_id INT NOT NULL UNIQUE AUTO_INCREMENT,
    user_id INT NOT NULL,
    platform VARCHAR(64) NOT NULL,
    account_name VARCHAR(64) NOT NULL,
    details VARCHAR(255),
    PRIMARY KEY (social_id),
    
    -- Social media connections are tied to guest accounts.
    -- If the guest is deleted, their social media connections
    -- are deleted as well.
    CONSTRAINT fk_social_media_connections_guest
        FOREIGN KEY (user_id)
        REFERENCES guests(user_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- =============================================================
-- Features
-- =============================================================
-- Stores the possible features or amenities that accommodations
-- can offer like wifi and parking.
-- See data dictionary for details.
-- =============================================================

CREATE TABLE features (
    feature_id INT NOT NULL UNIQUE AUTO_INCREMENT,
    name VARCHAR(32) NOT NULL,
    category VARCHAR(32) NOT NULL,
    PRIMARY KEY (feature_id)
);

-- ==============================================================
-- Accommodations
-- ==============================================================
-- Stores the listings offered by hosts.
-- Each accommodation belongs to exactly one host and has one
-- unique address. The visible field allows listings to remain in
-- the database even if they are hidden from search results.
-- See data dictionary for details.
-- ==============================================================

CREATE TABLE accommodations (
    accomm_id INT NOT NULL UNIQUE AUTO_INCREMENT,
    host_id INT NOT NULL,
    address_id INT NOT NULL UNIQUE,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    maximum_guests INT NOT NULL,
    bedrooms INT NOT NULL,
    bathrooms INT NOT NULL,
    check_in_time TIME NOT NULL,
    check_out_time TIME NOT NULL,
    square_footage INT,
    visible BOOLEAN NOT NULL,
    PRIMARY KEY (accomm_id),
    
    -- Ensures that every accommodation is owned by an existing host.
	-- Hosts cannot be deleted while they still own accommodations.
    CONSTRAINT fk_accommodations_host FOREIGN KEY (host_id)
        REFERENCES hosts (user_id)
        ON UPDATE CASCADE ON DELETE RESTRICT,
        
	-- Ensures that every accommodation has a valid address.
    CONSTRAINT fk_accommodations_address FOREIGN KEY (address_id)
        REFERENCES addresses (address_id)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

-- =================================================================
-- Delayed Foreign Key for Accommodation Pictures
-- =================================================================
-- Now adds the foreign key from pictures to accommodations after
-- both tables have been created.
--
-- The pictures table is created earlier because guests and hosts
-- already reference profile pictures. Accommodation pictures also
-- need to reference accommodations, but the accommodations table
-- cannot be referenced before it exists.
--
-- The accomm_id field remains nullable so that the same pictures
-- table can store both profile pictures and accommodation pictures.
-- =================================================================

ALTER TABLE pictures
ADD CONSTRAINT fk_pictures_accommodation
FOREIGN KEY (accomm_id)
REFERENCES accommodations(accomm_id)
ON UPDATE CASCADE
ON DELETE CASCADE;

-- ============================================================
-- Available Features
-- ============================================================
-- Connects accommodations with their available features.
-- Bridge table for the many-to-many relationship between
-- accommodations and features.
-- See data dictionary for details.
-- ============================================================

CREATE TABLE available_features (
    feature_id INT NOT NULL,
    accomm_id INT NOT NULL,
    details VARCHAR(255),
    
    -- Composite primary key prevents the same feature from being
	-- assigned to the same accommodation more than once.
    PRIMARY KEY (feature_id , accomm_id),
    
    -- Ensures that only existing features can be assigned.
    CONSTRAINT fk_available_features_feature FOREIGN KEY (feature_id)
        REFERENCES features (feature_id)
        ON UPDATE CASCADE ON DELETE RESTRICT,
        
	-- If an accommodation is deleted,
    -- its feature assignments are deleted as well.
    CONSTRAINT fk_available_features_accommodation FOREIGN KEY (accomm_id)
        REFERENCES accommodations (accomm_id)
        ON UPDATE CASCADE ON DELETE CASCADE
);

-- ============================================================
-- Pricing Information
-- ============================================================
-- Stores price periods for accommodations as an accommodation
-- may have several pricing periods, for example
-- cheaper off-season prices and higher summer prices.
-- See data dictionary for details.
-- ============================================================

CREATE TABLE pricing_information (
    pricing_id INT NOT NULL UNIQUE AUTO_INCREMENT,
    accomm_id INT NOT NULL,
    valid_from DATE NOT NULL,
    valid_until DATE NOT NULL,
	pricing_type VARCHAR(20) NOT NULL DEFAULT 'General',
    base_price_per_stay DECIMAL(8 , 2 ) DEFAULT 0.00,
    base_price_per_night DECIMAL(8 , 2 ) DEFAULT 0.00,
    price_per_person_per_stay DECIMAL(8 , 2 ) DEFAULT 0.00,
    price_per_person_per_night DECIMAL(8 , 2 ) DEFAULT 0.00,
    PRIMARY KEY (pricing_id),
    
    -- Pricing records belong to one accommodation. If the accommodation
	-- is deleted, its pricing records are deleted as well.
    CONSTRAINT fk_pricing_information_accommodation FOREIGN KEY (accomm_id)
        REFERENCES accommodations (accomm_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
        
	-- Prevents invalid time periods where the end date is before the start date.
    CONSTRAINT chk_pricing_dates CHECK (valid_until >= valid_from),
    
    -- Restricts pricing types to the supported categories.
	-- The priority order is handled in SELECT queries:
	-- General < Seasonal < Event < Override
	CONSTRAINT chk_pricing_type
		CHECK (pricing_type IN ('General', 'Seasonal', 'Event', 'Override'))
);

-- =============================================================
-- Availabilities
-- =============================================================
-- Stores the date periods during which accommodations can be
-- booked.
-- Availability is stored separately from pricing because a host
-- can have prices defined for a broad season, but only make the
-- accommodation available during selected parts of that season.
-- See data dictionary for details.
-- =============================================================

CREATE TABLE availabilities (
    availability_id INT NOT NULL UNIQUE AUTO_INCREMENT,
    accomm_id INT NOT NULL,
    valid_from DATE NOT NULL,
    valid_until DATE NOT NULL,
    PRIMARY KEY (availability_id),
    
    -- Availability records belong to one accommodation. If the accommodation
	-- is deleted, its availability records are deleted as well.
    CONSTRAINT fk_availabilities_accommodation FOREIGN KEY (accomm_id)
        REFERENCES accommodations (accomm_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
        
    -- Prevents invalid time periods where the end date is before the start date.    
    CONSTRAINT chk_availability_dates CHECK (valid_until >= valid_from)
);

-- ==============================================================
-- Availability and Pricing Triggers
-- ==============================================================
-- These triggers enforce the business rule that an accommodation
-- can only be marked as available during periods where at least
-- general baseline pricing information also exists.
-- This prevents bookable date ranges without a valid price.
-- Additionally availability periods may not overlap or be
-- directly consecutive, to simplify the check required for
-- booking the accommodations.
--
-- Finally, as overlapping price periods are allowed to
-- handle different conditions (e.g. seasonal price surges),
-- two periods of the same type must be prevented to avoid
-- price ambiguity.
-- ==============================================================

DELIMITER //

-- Checks new availability periods before they are inserted.
-- The availability period must be fully covered by a General
-- pricing period for the same accommodation.
-- Availability periods may also not overlap or directly touch,
-- so continuous availability must be stored as one period.
CREATE TRIGGER trg_availability_within_pricing_insert
BEFORE INSERT ON availabilities
FOR EACH ROW
BEGIN
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
END//

-- Applies the same validation when an existing availability period
-- is updated.
CREATE TRIGGER trg_availability_within_pricing_update
BEFORE UPDATE ON availabilities
FOR EACH ROW
BEGIN
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
END//

-- Prevents deletion of a General pricing period if that deletion
-- would leave an existing availability period without General
-- pricing coverage.
--
-- Seasonal, Event, and Override prices may be deleted freely,
-- because availability only depends on General baseline pricing.
CREATE TRIGGER trg_pricing_before_delete
BEFORE DELETE ON pricing_information
FOR EACH ROW
BEGIN
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
END//


-- Prevents updates to General pricing periods if the change would
-- leave an existing availability period without General pricing
-- coverage.
--
-- Updates to Seasonal, Event, and Override prices do not affect
-- availability coverage.
CREATE TRIGGER trg_pricing_before_update
BEFORE UPDATE ON pricing_information
FOR EACH ROW
BEGIN
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
END//

-- Prevents inserting a pricing period that overlaps with an
-- existing pricing period of the same type for the same accommodation.
CREATE TRIGGER trg_pricing_no_same_type_overlap_insert
BEFORE INSERT ON pricing_information
FOR EACH ROW
BEGIN
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
END//

-- Applies the same validation when an existing pricing period is
-- updated. The current row is excluded from the comparison so that
-- it does not count as overlapping with itself.
CREATE TRIGGER trg_pricing_no_same_type_overlap_update
BEFORE UPDATE ON pricing_information
FOR EACH ROW
BEGIN
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
END//

DELIMITER ;

-- ============================================================
-- Wishlists
-- ============================================================
-- Stores named collections of accommodations saved by guests.
-- Each wishlist belongs to one guest.
-- See data dictionary for details.
-- ============================================================

CREATE TABLE wishlists (
    wishlist_id INT NOT NULL UNIQUE AUTO_INCREMENT,
    user_id INT NOT NULL,
    title VARCHAR(100) NOT NULL,
    PRIMARY KEY (wishlist_id),
    
	-- Wishlists are tied to guest accounts.
    -- If a guest is deleted, their wishlists are deleted as well.
    CONSTRAINT fk_wishlists_guest FOREIGN KEY (user_id)
        REFERENCES guests (user_id)
        ON UPDATE CASCADE ON DELETE CASCADE
);

-- ============================================================
-- Wishlisted Accommodations
-- ============================================================
-- Connects wishlists with the accommodations saved in them.
-- Junction table for the many-to-many relationship between
-- wishlists and accommodations.
-- See data dictionary for details.
-- ============================================================

CREATE TABLE wishlisted_accommodations (
    accomm_id INT NOT NULL,
    wishlist_id INT NOT NULL,
    
    -- Composite primary key prevents the same accommodation
    -- from being added to the same wishlist more than once.
    PRIMARY KEY (accomm_id , wishlist_id),
    
	-- If an accommodation is deleted, it is also removed from all wishlists.
    CONSTRAINT fk_wishlisted_accommodations_accommodation FOREIGN KEY (accomm_id)
        REFERENCES accommodations (accomm_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
        
	-- If a wishlist is deleted, its saved accommodation connections are deleted as well.
    CONSTRAINT fk_wishlisted_accommodations_wishlist FOREIGN KEY (wishlist_id)
        REFERENCES wishlists (wishlist_id)
        ON UPDATE CASCADE ON DELETE CASCADE
);

-- ============================================================
-- Coupons
-- ============================================================
-- Stores discount codes that can be applied to bookings.
-- Coupons can have a fixed discount amount, a percentage
-- discount, or both.
-- See data dictionary for details.
-- ============================================================

CREATE TABLE coupons (
    coupon_id INT NOT NULL UNIQUE AUTO_INCREMENT,
    code VARCHAR(32) NOT NULL UNIQUE,
    minimum_amt DECIMAL(6 , 2 ) DEFAULT 0.00,
    amt_fixed DECIMAL(6 , 2 ) DEFAULT 0.00,
    amt_percentage DECIMAL(6 , 5 ) DEFAULT 0.00000,
    valid_from DATETIME NOT NULL,
    valid_until DATETIME NOT NULL,
    PRIMARY KEY (coupon_id),
    
	-- Prevents invalid coupon periods where the end date
    -- is before the start date.
    CONSTRAINT chk_coupon_dates CHECK (valid_until >= valid_from)
);

-- ============================================================
-- Coupon Usages
-- ============================================================
-- Tracks which users have already used which coupons.
-- This supports the business rule that the same user may
-- only use a coupon once.
-- See data dictionary for details.
-- ============================================================

CREATE TABLE coupon_usages (
    user_id INT NOT NULL,
    coupon_id INT NOT NULL,
    
	-- Composite primary key prevents the same user from being
    -- linked to the same coupon more than once.
    PRIMARY KEY (user_id , coupon_id),
    
	-- Coupon usage is linked to the general user account,
    -- with coupon usages being deleted if the user is deleted.
    CONSTRAINT fk_coupon_usages_user FOREIGN KEY (user_id)
        REFERENCES users (user_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
        
	-- If a coupon is deleted, its usage records are removed
    -- as well.
    CONSTRAINT fk_coupon_usages_coupon FOREIGN KEY (coupon_id)
        REFERENCES coupons (coupon_id)
        ON UPDATE CASCADE ON DELETE CASCADE
);

-- ============================================================
-- Bookings
-- ============================================================
-- Stores accommodation bookings made by guests.
-- Each booking belongs to one accommodation and one guest.
-- A booking may optionally use one coupon.
-- See data dictionary for details.
-- ============================================================

CREATE TABLE bookings (
    booking_id INT NOT NULL UNIQUE AUTO_INCREMENT,
    accomm_id INT NOT NULL,
    coupon_id INT,
    guest_id INT NOT NULL,
    booked_on DATETIME NOT NULL,
    no_of_guests INT NOT NULL,
    full_price DECIMAL(8 , 2 ) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    confirmed BOOLEAN NOT NULL,
    cancelled BOOLEAN NOT NULL,
    PRIMARY KEY (booking_id),
    
	-- As a booking must refer to an existing accommodation,
    -- accommodations cannot be deleted while bookings still
    -- reference them.
    CONSTRAINT fk_bookings_accommodation FOREIGN KEY (accomm_id)
        REFERENCES accommodations (accomm_id)
        ON UPDATE CASCADE ON DELETE RESTRICT,
        
	-- A booking may keep existing even if the used coupon is
    -- later removed. In that case, the coupon reference is set
    -- to NULL.
    CONSTRAINT fk_bookings_coupon FOREIGN KEY (coupon_id)
        REFERENCES coupons (coupon_id)
        ON UPDATE CASCADE ON DELETE SET NULL,
        
	-- A booking must be made by an existing guest.
    -- Guests cannot be deleted while bookings still reference them.
    CONSTRAINT fk_bookings_guest FOREIGN KEY (guest_id)
        REFERENCES guests (user_id)
        ON UPDATE CASCADE ON DELETE RESTRICT,
        
	-- Ensures that the booking ends after it starts.
    CONSTRAINT chk_booking_dates CHECK (end_date > start_date),
    
    -- Ensures that every booking has at least one guest.
    CONSTRAINT chk_booking_guest_count CHECK (no_of_guests > 0),
    
    -- Prevents negative booking prices.
    CONSTRAINT chk_booking_price CHECK (full_price >= 0)
);

-- ============================================================
-- Booking Triggers
-- ============================================================
-- These triggers enforce booking-related business rules that
-- cannot be fully covered by simple foreign keys or check
-- constraints.
--
-- They validate guest count, booking dates, own-accommodation
-- bookings, accommodation availability, booking overlaps,
-- and coupon usage.
-- ============================================================

DELIMITER //

-- Validates a booking before it is inserted.
-- This prevents invalid bookings from being stored in the database.
CREATE TRIGGER trg_bookings_before_insert
BEFORE INSERT ON bookings
FOR EACH ROW
BEGIN
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

END//

-- Automatically records coupon usage after a booking with a coupon
-- has been successfully inserted.
CREATE TRIGGER trg_bookings_after_insert
AFTER INSERT ON bookings
FOR EACH ROW
BEGIN
  IF NEW.coupon_id IS NOT NULL THEN
    INSERT INTO coupon_usages
    (user_id, coupon_id)
    VALUES
    (NEW.guest_id, NEW.coupon_id);
  END IF;
END//

DELIMITER ;

-- ============================================================
-- Payment Methods
-- ============================================================
-- Stores payment methods saved by guests.
-- Each payment method belongs to one guest account.
-- See data dictionary for details.
-- ============================================================

CREATE TABLE payment_methods (
    pay_meth_id INT NOT NULL UNIQUE AUTO_INCREMENT,
    user_id INT NOT NULL,
    name VARCHAR(64) NOT NULL,
    provider VARCHAR(64) NOT NULL,
    details VARCHAR(255) NOT NULL,
    PRIMARY KEY (pay_meth_id),
    
    -- If a guest is deleted, their saved payment methods
    -- are deleted as well.
    CONSTRAINT fk_payment_methods_guest FOREIGN KEY (user_id)
        REFERENCES guests (user_id)
        ON UPDATE CASCADE ON DELETE CASCADE
);

-- ============================================================
-- Payments
-- ============================================================
-- Stores payments made for bookings.
-- A booking may have multiple payments, for example when
-- a payment is split into several instalments.
-- See data dictionary for details.
-- ============================================================

CREATE TABLE payments (
    payment_id INT NOT NULL UNIQUE AUTO_INCREMENT,
    booking_id INT NOT NULL,
    pay_meth_id INT NOT NULL,
    payment_date DATETIME NOT NULL,
    amount DECIMAL(8 , 2 ) NOT NULL,
    status VARCHAR(20) NOT NULL,
    PRIMARY KEY (payment_id),
    
	-- A payment must belong to an existing booking.
    -- Bookings cannot be deleted while payments still
    -- reference them.
    CONSTRAINT fk_payments_booking FOREIGN KEY (booking_id)
        REFERENCES bookings (booking_id)
        ON UPDATE CASCADE ON DELETE RESTRICT,
        
	-- A payment must use an existing payment method.
    -- Payment methods cannot be deleted while payments still
    -- reference them.
    CONSTRAINT fk_payments_payment_method FOREIGN KEY (pay_meth_id)
        REFERENCES payment_methods (pay_meth_id)
        ON UPDATE CASCADE ON DELETE RESTRICT,
	
    -- Prevents negative payment amounts.
    CONSTRAINT chk_payment_amount CHECK (amount >= 0),
    
    -- Restricts payment status to the supported workflow states.
    CONSTRAINT chk_payment_status CHECK (status IN
		('Pending' , 'Scheduled', 'Completed', 'Failed', 'Refunded'))
);

-- ============================================================
-- Payment Triggers
-- ============================================================
-- These triggers enforce that a payment method can only be used
-- for a booking made by the guest who owns that payment method.
--
-- This prevents one guest's booking from being paid with another
-- guest's saved payment details.
-- ============================================================

DELIMITER //

-- Validates new payments before they are inserted.
-- The payment method must belong to the guest who made the booking.
CREATE TRIGGER trg_payments_before_insert
BEFORE INSERT ON payments
FOR EACH ROW
BEGIN
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
END//

-- Applies the same validation when an existing payment is updated.
-- This prevents later changes from assigning a payment to a payment
-- method owned by a different guest.
CREATE TRIGGER trg_payments_before_update
BEFORE UPDATE ON payments
FOR EACH ROW
BEGIN
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
END//

DELIMITER ;

-- ============================================================
-- Messages
-- ============================================================
-- Stores messages exchanged between guests and hosts in relation
-- to a booking.
-- Each message belongs to one booking.
-- See data dictionary for details.
-- ============================================================

CREATE TABLE messages (
    message_id BIGINT NOT NULL UNIQUE AUTO_INCREMENT,
    booking_id INT NOT NULL,
    message TEXT NOT NULL,
    sender_is_guest BOOLEAN NOT NULL,
    sent DATETIME NOT NULL,
    PRIMARY KEY (message_id),
    
	-- Messages are tied to bookings.
    -- If a booking is deleted, its messages are deleted as well.
    CONSTRAINT fk_messages_booking FOREIGN KEY (booking_id)
        REFERENCES bookings (booking_id)
        ON UPDATE CASCADE ON DELETE CASCADE
);

-- ============================================================
-- Reviews
-- ============================================================
-- Stores guest and host reviews for completed bookings.
-- Each booking can have one review record containing optional
-- ratings and written reviews from both sides.
-- See data dictionary for details.
-- ============================================================

CREATE TABLE reviews (
    booking_id INT NOT NULL UNIQUE,
    rating_by_guest INT,
    rating_by_host INT,
    review_by_guest TEXT,
    review_by_host TEXT,
    PRIMARY KEY (booking_id),
    
	-- Reviews are tied to bookings.
    -- If a booking is deleted, the related review is deleted as well.
    CONSTRAINT fk_reviews_booking FOREIGN KEY (booking_id)
        REFERENCES bookings (booking_id)
        ON UPDATE CASCADE ON DELETE CASCADE, 
        
    -- Guest ratings must be between 1 and 5 if provided.
    CONSTRAINT chk_rating_by_guest CHECK (rating_by_guest IS NULL
        OR rating_by_guest BETWEEN 1 AND 5),
        
	-- Host ratings must be between 1 and 5 if provided.
    CONSTRAINT chk_rating_by_host CHECK (rating_by_host IS NULL
        OR rating_by_host BETWEEN 1 AND 5)
);

-- ============================================================
-- Review Triggers
-- ============================================================
-- These triggers enforce that reviews can only be created or
-- updated for bookings that are confirmed, completed, and not
-- cancelled.
--
-- This prevents reviews for future stays, unconfirmed bookings,
-- and cancelled bookings.
-- ============================================================

DELIMITER //

-- Validates new reviews before they are inserted.
-- A review can only be added after the booking has ended.
CREATE TRIGGER trg_reviews_before_insert
BEFORE INSERT ON reviews
FOR EACH ROW
BEGIN
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
END//

-- Applies the same validation when an existing review is updated.
-- This prevents reviews from remaining editable if the related
-- booking is later no longer eligible for reviews.
CREATE TRIGGER trg_reviews_before_update
BEFORE UPDATE ON reviews
FOR EACH ROW
BEGIN
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
END//

DELIMITER ;