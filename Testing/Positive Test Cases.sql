-- ===============================================================
-- EarthBnB Positive Test Cases
-- ===============================================================
-- This file contains positive test cases for the EarthBnB database.
--
-- It assumes that:
-- 1. The database creation script has already been executed.
-- 2. The sample data insertion script has already been executed.
-- 3. This file has not been run yet, as an included insert will
--    lead to an error upon repeated execution.
--
-- The queries demonstrate that the database relationships,
-- business rules, joins, and sample data work as intended.
-- ===============================================================

USE EarthBnB;

-- ===============================================================
-- The User Profile #1
-- ===============================================================
-- Expected result:
-- One row for Henry Hoffmann.
-- ===============================================================

SELECT 
    u.user_id,
    CONCAT(u.first_name, ' ', u.last_name) AS full_name,
    u.user_name,
    u.email_address,
    u.phone_number,
    CASE
        WHEN u.verified = TRUE THEN 'Verified'
        ELSE 'Not verified'
    END AS verification_status,
    p.file_location AS profile_picture
FROM
    users u
        JOIN
    guests g ON u.user_id = g.user_id
        LEFT JOIN
    pictures p ON g.profile_picture = p.picture_id
WHERE
    u.user_name = 'henryh';

-- ===============================================================
-- The User Profile #2
-- ===============================================================
-- Expected result:
-- Social media connections for Henry Hoffmann,
-- namely Facebook and Google
-- ===============================================================

SELECT 
    smc.platform, smc.account_name, smc.details
FROM
    users u
        JOIN
    guests g ON u.user_id = g.user_id
        LEFT JOIN
    social_media_connections smc ON g.user_id = smc.user_id
WHERE
    u.user_name = 'henryh'
ORDER BY smc.platform;

-- ===============================================================
-- Finding a Place to Stay
-- ===============================================================
-- Expected result:
-- German accommodations that are visible, large enough, and have
-- availability for the requested period (2).
-- Booked accommodations are shown as unavailable (1).
-- ===============================================================

SELECT 
    a.accomm_id,
    a.title,
    ad.city,
    a.maximum_guests AS max_guests,
    pi.pricing_type,
    (pi.base_price_per_stay + 
		(pi.base_price_per_night * DATEDIFF('2026-08-13', '2026-08-10')) +
        (pi.price_per_person_per_stay * 2) +
        (pi.price_per_person_per_night * 2 * DATEDIFF('2026-08-13', '2026-08-10')))
        AS calculated_price,
    c.currency,
    CASE
        WHEN COUNT(b.booking_id) = 0 THEN TRUE
        ELSE FALSE
    END AS available
FROM accommodations a
	JOIN addresses ad ON a.address_id = ad.address_id
	JOIN countries c ON ad.country_id = c.country_id
	JOIN pricing_information pi ON pi.accomm_id = a.accomm_id
	AND '2026-08-10' >= pi.valid_from
	AND '2026-08-13' <= pi.valid_until
	AND pi.pricing_id = (
		SELECT pi2.pricing_id
		FROM pricing_information pi2
		WHERE pi2.accomm_id = a.accomm_id
			AND '2026-08-10' >= pi2.valid_from
			AND '2026-08-13' <= pi2.valid_until
		ORDER BY CASE pi2.pricing_type
			WHEN 'Override' THEN 4
			WHEN 'Event' THEN 3
			WHEN 'Seasonal' THEN 2
			WHEN 'General' THEN 1
		END DESC , pi2.valid_from DESC , pi2.pricing_id DESC
		LIMIT 1)
LEFT JOIN bookings b
	ON b.accomm_id = a.accomm_id
	AND b.cancelled = FALSE
	AND '2026-08-10' < b.end_date
	AND '2026-08-13' > b.start_date
WHERE
    c.name = 'Germany' AND a.visible = TRUE
        AND a.maximum_guests >= 2
        AND EXISTS( SELECT 1
        FROM availabilities av
        WHERE av.accomm_id = a.accomm_id
			AND '2026-08-10' >= av.valid_from
			AND '2026-08-13' <= av.valid_until)
GROUP BY a.accomm_id , a.title , ad.city , a.maximum_guests ,
pi.pricing_type , pi.base_price_per_stay , pi.base_price_per_night ,
pi.price_per_person_per_stay , pi.price_per_person_per_night , c.currency
ORDER BY available DESC , calculated_price DESC;

-- ===============================================================
-- Checking the Amenities
-- ===============================================================
-- Expected result:
-- Feature lists for accommodations 3 (6 features) and 21 (5).
-- ===============================================================

SELECT 
    a.accomm_id,
    a.title,
    f.category,
    f.name AS feature_name,
    af.details
FROM
    accommodations a
        JOIN
    available_features af ON a.accomm_id = af.accomm_id
        JOIN
    features f ON af.feature_id = f.feature_id
WHERE
    a.accomm_id IN (3 , 21)
ORDER BY a.accomm_id , f.category , f.name;

-- ===============================================================
-- Saving the Options for Later (Insert)
-- ===============================================================
-- Expected result:
-- One new wishlist is inserted, and two accommodations are linked
-- to that wishlist.

-- Important:
-- Run this test only once after loading the sample data. If it is
-- run a second time without resetting the database, it will fail
-- because wishlist_id 21 already exists.
-- ===============================================================

INSERT INTO wishlists (user_id, title) VALUES
(8, 'Options in Berlin');

INSERT INTO wishlisted_accommodations (accomm_id, wishlist_id) VALUES
(3, 21),
(21, 21);

-- ===============================================================
-- Saving the Options for Later (Check)
-- ===============================================================
-- Expected result:
-- Henry's wishlists, including the newly inserted
-- "Options in Berlin" wishlist.
-- ===============================================================

SELECT 
    w.title, COUNT(wa.accomm_id) AS number_of_accommodations
FROM
    wishlists w
        LEFT JOIN
    wishlisted_accommodations wa ON w.wishlist_id = wa.wishlist_id
WHERE
    w.user_id = 8
GROUP BY w.wishlist_id , w.title
ORDER BY w.wishlist_id;

-- ===============================================================
-- Review Overview
-- ===============================================================
-- Expected result:
-- Reviews for the two bookings belonging to accommodations
-- by user #40, one without host ratings.
-- ===============================================================

SELECT 
    a.title AS accommodation_title,
    ad.city,
    b.start_date,
    b.end_date,
    CONCAT(gu.first_name, ' ', gu.last_name) AS guest_name,
    r.rating_by_guest,
    r.review_by_guest,
    r.rating_by_host,
    r.review_by_host
FROM
    hosts h
	JOIN accommodations a ON h.user_id = a.host_id
	JOIN addresses ad ON a.address_id = ad.address_id
	JOIN bookings b ON a.accomm_id = b.accomm_id
	JOIN guests g ON b.guest_id = g.user_id
	JOIN users gu ON g.user_id = gu.user_id
	JOIN reviews r ON b.booking_id = r.booking_id
WHERE
    h.user_id = 40
ORDER BY b.end_date DESC;

-- ===============================================================
-- Ensuring Availability
-- ===============================================================
-- Expected result:
-- Pricing and availability information the Central Paris Flat,
-- including general, seasonal and event pricing.
-- ===============================================================

SELECT 
    a.title,
    pi.pricing_type,
    pi.valid_from AS pricing_valid_from,
    pi.valid_until AS pricing_valid_until,
    av.valid_from AS available_from,
    av.valid_until AS available_until,
    pi.base_price_per_stay,
    pi.base_price_per_night,
    pi.price_per_person_per_stay,
    pi.price_per_person_per_night
FROM
    hosts h
	JOIN accommodations a ON h.user_id = a.host_id
	JOIN pricing_information pi ON a.accomm_id = pi.accomm_id
	LEFT JOIN availabilities av ON a.accomm_id = av.accomm_id
        AND av.valid_from <= pi.valid_until
        AND av.valid_until >= pi.valid_from
WHERE
    h.user_id = 35
ORDER BY a.accomm_id , pi.valid_from , av.valid_from;

-- ===============================================================
-- Offered and Received
-- ===============================================================
-- Expected result:
-- The 16 users who act as both guests and hosts in the platform.
-- ===============================================================

SELECT 
    u.user_id,
    CONCAT(u.first_name, ' ', u.last_name) AS full_name,
    u.email_address,
    COUNT(DISTINCT a.accomm_id) AS accommodation_count,
    COUNT(DISTINCT guest_bookings.booking_id) AS bookings_made_as_guest,
    COUNT(DISTINCT host_bookings.booking_id) AS bookings_received_as_host
FROM
    users u
        JOIN
    guests g ON u.user_id = g.user_id
        JOIN
    hosts h ON u.user_id = h.user_id
        LEFT JOIN
    accommodations a ON h.user_id = a.host_id
        LEFT JOIN
    bookings guest_bookings ON g.user_id = guest_bookings.guest_id
        LEFT JOIN
    bookings host_bookings ON a.accomm_id = host_bookings.accomm_id
GROUP BY u.user_id , u.first_name , u.last_name , u.email_address
ORDER BY accommodation_count DESC,
bookings_received_as_host DESC,
bookings_made_as_guest DESC,
u.user_id;

-- ===============================================================
-- Coupon Tracking
-- ===============================================================
-- Expected result:
-- 26 Coupon usage records with their relevant data.
-- ===============================================================

SELECT 
    c.code,
    CONCAT(u.first_name, ' ', u.last_name) AS used_by,
    b.booking_id,
    b.booked_on
FROM
    coupon_usages cu
        JOIN
    coupons c ON cu.coupon_id = c.coupon_id
        JOIN
    users u ON cu.user_id = u.user_id
        JOIN
    bookings b ON b.guest_id = cu.user_id
        AND b.coupon_id = cu.coupon_id
ORDER BY c.code , b.booked_on;

-- ===============================================================
-- Local Employees
-- ===============================================================
-- Expected result:
-- The 10 Employees connected to German workplace addresses.
-- ===============================================================

SELECT 
    e.user_id,
    CONCAT(u.first_name, ' ', u.last_name) AS employee_name,
    e.job_title,
    w.location_title AS workplace,
    ad.city,
    c.name AS country
FROM
    employees e
	JOIN users u ON e.user_id = u.user_id
	JOIN workplaces w ON e.workplace_id = w.workplace_id
	JOIN addresses ad ON w.address_id = ad.address_id
	JOIN countries c ON ad.country_id = c.country_id
WHERE
    c.name = 'Germany'
ORDER BY ad.city , w.location_title , employee_name;

-- ===============================================================
-- Checking Payments
-- ===============================================================
-- Expected result:
-- Two payment records for booking_id 13.
-- ===============================================================

SELECT 
    p.payment_id,
    p.payment_date,
    p.amount,
    p.status,
    pm.name AS payment_method,
    pm.provider,
    pm.details
FROM
    payments p
        JOIN
    payment_methods pm ON p.pay_meth_id = pm.pay_meth_id
WHERE
    p.booking_id = 13
ORDER BY p.payment_date;

-- ===============================================================
-- Messaging the Host
-- ===============================================================
-- Expected result:
-- One back and forth for booking_id 13.
-- ===============================================================

SELECT 
    m.message_id,
    m.sent,
    CASE
        WHEN m.sender_is_guest = TRUE THEN 'Guest'
        ELSE 'Host'
    END AS sender,
    m.message
FROM
    messages m
WHERE
    m.booking_id = 13
ORDER BY m.sent;
