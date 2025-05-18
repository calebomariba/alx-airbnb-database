-- performance.sql
-- This file contains queries for retrieving bookings with user, property, and payment details,
-- along with performance analysis and optimized versions for the Airbnb Clone project.

-- Initial Query: Retrieve all bookings with user, property, and payment details
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status AS booking_status,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    p.property_id,
    p.name AS property_name,
    p.pricepernight,
    p.host_id,
    pay.payment_id,
    pay.amount AS payment_amount,
    pay.payment_date,
    pay.status AS payment_status
FROM bookings b
INNER JOIN users u ON b.user_id = u.user_id
INNER JOIN properties p ON b.property_id = p.property_id
LEFT JOIN payments pay ON b.booking_id = pay.booking_id
ORDER BY b.start_date, b.booking_id;

-- Note: Below sections will be added after analysis and optimization

EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status AS booking_status,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    p.property_id,
    p.name AS property_name,
    p.pricepernight,
    p.host_id,
    pay.payment_id,
    pay.amount AS payment_amount,
    pay.payment_date,
    pay.status AS payment_status
FROM bookings b
INNER JOIN users u ON b.user_id = u.user_id
INNER JOIN properties p ON b.property_id = p.property_id
LEFT JOIN payments pay ON b.booking_id = pay.booking_id
ORDER BY b.start_date, b.booking_id;



-- Refactored Query: Retrieve confirmed bookings from the last 6 months with user, property, and payment details
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status AS booking_status,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    p.property_id,
    p.name AS property_name,
    p.pricepernight,
    p.host_id,
    pay.payment_id,
    pay.amount AS payment_amount,
    pay.payment_date,
    pay.status AS payment_status
FROM bookings b
INNER JOIN users u ON b.user_id = u.user_id
INNER JOIN properties p ON b.property_id = p.property_id
LEFT JOIN payments pay ON b.booking_id = pay.booking_id
WHERE b.status = 'confirmed'
  AND b.start_date >= CURRENT_DATE - INTERVAL '6 months'
ORDER BY b.start_date, b.booking_id;



SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status AS booking_status,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    p.property_id,
    p.name AS property_name,
    p.pricepernight,
    p.host_id,
    pay.payment_id,
    pay.amount AS payment_amount,
    pay.payment_date,
    pay.status AS payment_status
FROM bookings b
INNER JOIN users u ON b.user_id = u.user_id
INNER JOIN properties p ON b.property_id = p.property_id
LEFT JOIN payments pay ON b.booking_id = pay.booking_id
WHERE b.status = 'confirmed'
  AND b.start_date >= CURRENT_DATE - INTERVAL '6 months'
ORDER BY b.start_date, b.booking_id;