-- aggregations_and_window_functions.sql
-- This file contains SQL queries using aggregation and window functions for the Airbnb Clone project.
-- The queries operate on the users, properties, and bookings tables from the alx-airbnb-database schema.

-- Query 1: Find the total number of bookings per user using COUNT and GROUP BY
-- Purpose: Fetch all users and their total number of bookings, including users with zero bookings.
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.role,
    COUNT(b.booking_id) AS total_bookings
FROM users u
LEFT JOIN bookings b ON u.user_id = b.user_id
GROUP BY u.user_id, u.first_name, u.last_name, u.email, u.role
ORDER BY total_bookings DESC, u.user_id;

-- Query 2: Rank properties by total number of bookings using a window function
-- Purpose: Fetch all properties, their booking counts, and a rank based on booking counts.
SELECT 
    p.property_id,
    p.name AS property_name,
    p.pricepernight,
    p.host_id,
    COUNT(b.booking_id) AS total_bookings,
    RANK() OVER (ORDER BY COUNT(b.booking_id) DESC) AS booking_rank
FROM properties p
LEFT JOIN bookings b ON p.property_id = b.property_id
GROUP BY p.property_id, p.name, p.pricepernight, p.host_id
ORDER BY booking_rank, p.property_id;