-- Query 1: Find properties with average rating > 4.0 using a non-correlated subquery
SELECT 
    p.property_id,
    p.name AS property_name,
    p.description,
    p.pricepernight,
    p.host_id
FROM properties p
WHERE p.property_id IN (
    SELECT 
        r.property_id
    FROM reviews r
    GROUP BY r.property_id
    HAVING AVG(r.rating) > 4.0
)
ORDER BY p.property_id;

-- Query 2: Find users with more than 3 bookings using a correlated subquery
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.role
FROM users u
WHERE (
    SELECT COUNT(*) 
    FROM bookings b 
    WHERE b.user_id = u.user_id
) > 3
ORDER BY u.user_id;