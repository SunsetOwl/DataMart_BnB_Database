-- ===============================================================
-- EarthBnB Negative Test Cases
-- ===============================================================
-- This file contains test cases that are intentionally expected
-- to fail.

-- The purpose of these tests is to demonstrate that the database
-- triggers and constraints correctly prevent invalid data from
-- being inserted.

-- Important:
-- Run these test cases individually. In MySQL Workbench, a failed
-- statement may stop the execution of the rest of the script.
-- ===============================================================

USE EarthBnB;

-- ===============================================================
-- Guest Cannot Book Their Own Accommodation
-- ===============================================================
-- Business rule tested:
-- A host must not be able to book their own accommodation.
--
-- Expected result:
-- Error from trg_bookings_before_insert:
-- "Guests cannot book their own accommodation."
-- ===============================================================

INSERT INTO bookings (accomm_id, coupon_id, guest_id, booked_on, no_of_guests, full_price, start_date, end_date, confirmed, cancelled)
VALUES (4, NULL, 11, '2026-03-20 10:00:00', 2, 250.00, '2026-03-25', '2026-03-27', TRUE, FALSE);

-- ===============================================================
-- Booking Exceeds Maximum Guest Count
-- ===============================================================
-- Business rule tested:
-- The number of guests in a booking must not exceed the
-- accommodation's maximum_guests value.
--
-- Expected result:
-- Error from trg_bookings_before_insert:
-- "Number of guests exceeds accommodation maximum."
-- ===============================================================

INSERT INTO bookings (accomm_id, coupon_id, guest_id, booked_on, no_of_guests, full_price, start_date, end_date, confirmed, cancelled)
VALUES (7, NULL, 2, '2026-05-10 10:00:00', 3, 300.00, '2026-06-10', '2026-06-12', TRUE, FALSE);

-- ===============================================================
-- Overlapping Booking Periods
-- ===============================================================
-- Business rule tested:
-- An accommodation cannot have overlapping non-cancelled bookings.
--
-- Expected result:
-- Error from trg_bookings_before_insert:
-- "Accommodation is already booked during this period."
-- ===============================================================

INSERT INTO bookings (accomm_id, coupon_id, guest_id, booked_on, no_of_guests, full_price, start_date, end_date, confirmed, cancelled)
VALUES (1, NULL, 3, '2026-01-06 10:00:00', 2, 400.00, '2026-01-14', '2026-01-18', TRUE, FALSE);

-- ===============================================================
-- No Pricing Period Set
-- ===============================================================
-- Business rule tested:
-- An accommodation cannot be made available without a matching
-- general pricing period.
--
-- Expected result:
-- Error from trg_availability_within_pricing_insert:
-- "Availability period must be fully covered by a General pricing period."
-- ===============================================================

INSERT INTO availabilities (accomm_id, valid_from, valid_until)
VALUES (2, '2027-01-05', '2027-01-10');

-- ===============================================================
-- Consecutive Availabilities
-- ===============================================================
-- Business rule tested:
-- Availability periods must be at least one day apart, otherwise
-- an expansion of the original period is the correct approach.

-- Expected result:
-- Error from trg_availability_within_pricing_insert:
-- "Availability periods may not overlap or be directly consecutive."
-- ===============================================================

INSERT INTO availabilities (accomm_id, valid_from, valid_until)
VALUES (2, '2026-05-01', '2026-05-10');

-- ===============================================================
-- Overlapping Same-Type Pricing Periods
-- ===============================================================
-- Business rule tested:
-- There must be no price ambiguity.
--
-- Expected result:
-- Error from trg_pricing_no_same_type_overlap_insert:
-- "Pricing periods of the same type may not overlap for the same accommodation."
-- ===============================================================

INSERT INTO pricing_information (accomm_id, valid_from, valid_until, pricing_type, base_price_per_stay, base_price_per_night, price_per_person_per_stay, price_per_person_per_night)
VALUES (2, '2026-03-01', '2026-03-31', 'General', 40.00, 130.00, 0.00, 0.00);

-- ===============================================================
-- Coupon Already Used by Same Guest
-- ===============================================================
-- Business rule tested:
-- The same user may only use the same coupon once.
--
-- Expected result:
-- Error from trg_bookings_before_insert:
-- "Guest has already used this coupon."
-- ===============================================================

INSERT INTO bookings (accomm_id, coupon_id, guest_id, booked_on, no_of_guests, full_price, start_date, end_date, confirmed, cancelled)
VALUES (3, 1, 2, '2026-01-10 10:00:00', 1, 250.00, '2026-01-26', '2026-01-28', TRUE, FALSE);

-- ===============================================================
-- Review for Ineligible Booking
-- ===============================================================
-- Business rule tested:
-- Reviews can only be added for confirmed, completed, non-cancelled
-- bookings.
--
-- Expected result:
-- Error from trg_reviews_before_insert:
-- "Reviews can only be added for confirmed, completed, non-cancelled bookings."
-- ===============================================================

INSERT INTO reviews (booking_id, rating_by_guest, rating_by_host, review_by_guest, review_by_host)
VALUES (30, NULL, 5, NULL, 'I know this guy, he is awesome.');
