-- Query 1: Retrieve all bookings and their respective users using INNER JOIN
SELECT 
    b.booking_id,
    b.property_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email
FROM bookings b
INNER JOIN users u ON b.user_id = u.user_id
ORDER BY b.start_date ASC;


-- Query 2: Retrieve all properties and their reviews using LEFT JOIN
SELECT 
    p.property_id,
    p.name AS property_name,
    p.description,
    p.pricepernight,
    r.review_id,
    r.user_id AS reviewer_id,
    r.rating,
    r.comment,
    r.created_at
FROM properties p
LEFT JOIN reviews r ON p.property_id = r.property_id
ORDER BY p.property_id, r.created_at DESC;


-- Query 3: Retrieve all users and bookings using FULL OUTER JOIN
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    b.booking_id,
    b.property_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status
FROM users u
FULL OUTER JOIN bookings b ON u.user_id = b.user_id
ORDER BY u.user_id, b.start_date ASC;