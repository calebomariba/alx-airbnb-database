-- seed.sql
-- Airbnb Database Seed Data
-- This script populates the Airbnb database with sample data for testing and demonstration.

-- Note: Ensure the schema (schema.sql) is applied before running this script.
-- The uuid-ossp extension must be enabled (CREATE EXTENSION "uuid-ossp";).

-- Insert Users (2 hosts, 2 guests, 1 admin)
INSERT INTO users (user_id, first_name, last_name, email, password_hash, phone_number, role, created_at)
VALUES
    (uuid_generate_v4(), 'John', 'Doe', 'john.doe@example.com', 'hashed_password_123', '+12345678901', 'host', CURRENT_TIMESTAMP),
    (uuid_generate_v4(), 'Jane', 'Smith', 'jane.smith@example.com', 'hashed_password_456', '+12345678902', 'host', CURRENT_TIMESTAMP),
    (uuid_generate_v4(), 'Alice', 'Johnson', 'alice.johnson@example.com', 'hashed_password_789', '+12345678903', 'guest', CURRENT_TIMESTAMP),
    (uuid_generate_v4(), 'Bob', 'Williams', 'bob.williams@example.com', 'hashed_password_012', '+12345678904', 'guest', CURRENT_TIMESTAMP),
    (uuid_generate_v4(), 'Admin', 'User', 'admin@example.com', 'hashed_password_admin', NULL, 'admin', CURRENT_TIMESTAMP);

-- Insert Locations (3 locations)
INSERT INTO locations (location_id, city, state, country, created_at)
VALUES
    (uuid_generate_v4(), 'New York', 'NY', 'USA', CURRENT_TIMESTAMP),
    (uuid_generate_v4(), 'Nairobi', NULL, 'Kenya', CURRENT_TIMESTAMP),
    (uuid_generate_v4(), 'London', NULL, 'United Kingdom', CURRENT_TIMESTAMP);

-- Insert Properties (4 properties, owned by hosts)
-- Note: host_id and location_id must reference existing users and locations
INSERT INTO properties (property_id, host_id, location_id, name, description, pricepernight, created_at, updated_at)
SELECT
    uuid_generate_v4(),
    user_id,
    location_id,
    name,
    description,
    pricepernight,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM
    (SELECT user_id FROM users WHERE email = 'john.doe@example.com') AS host1,
    (SELECT location_id FROM locations WHERE city = 'New York') AS loc1,
    (VALUES
        ('Cozy Apartment in NYC', 'A comfortable 1-bedroom apartment in the heart of Manhattan.', 150.00)
    ) AS props(name, description, pricepernight)
UNION ALL
SELECT
    uuid_generate_v4(),
    user_id,
    location_id,
    name,
    description,
    pricepernight,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM
    (SELECT user_id FROM users WHERE email = 'john.doe@example.com') AS host1,
    (SELECT location_id FROM locations WHERE city = 'Nairobi') AS loc2,
    (VALUES
        ('Safari Villa', 'A luxurious villa near Nairobi National Park.', 200.00)
    ) AS props(name, description, pricepernight)
UNION ALL
SELECT
    uuid_generate_v4(),
    user_id,
    location_id,
    name,
    description,
    pricepernight,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM
    (SELECT user_id FROM users WHERE email = 'jane.smith@example.com') AS host2,
    (SELECT location_id FROM locations WHERE city = 'London') AS loc3,
    (VALUES
        ('Charming London Flat', 'A stylish flat near the Thames.', 180.00)
    ) AS props(name, description, pricepernight)
UNION ALL
SELECT
    uuid_generate_v4(),
    user_id,
    location_id,
    name,
    description,
    pricepernight,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM
    (SELECT user_id FROM users WHERE email = 'jane.smith@example.com') AS host2,
    (SELECT location_id FROM locations WHERE city = 'New York') AS loc1,
    (VALUES
        ('Brooklyn Loft', 'A spacious loft with city views.', 120.00)
    ) AS props(name, description, pricepernight);

-- Insert Bookings (5 bookings, various statuses)
-- total_price = pricepernight * number of nights
INSERT INTO bookings (booking_id, property_id, user_id, start_date, end_date, total_price, status, created_at)
SELECT
    uuid_generate_v4(),
    property_id,
    user_id,
    start_date,
    end_date,
    total_price,
    status,
    CURRENT_TIMESTAMP
FROM
    (SELECT property_id, pricepernight FROM properties WHERE name = 'Cozy Apartment in NYC') AS prop1,
    (SELECT user_id FROM users WHERE email = 'alice.johnson@example.com') AS guest1,
    (VALUES
        ('2025-06-01'::DATE, '2025-06-05'::DATE, 150.00 * 4, 'confirmed') -- 4 nights
    ) AS bookings(start_date, end_date, total_price, status)
UNION ALL
SELECT
    uuid_generate_v4(),
    property_id,
    user_id,
    start_date,
    end_date,
    total_price,
    status,
    CURRENT_TIMESTAMP
FROM
    (SELECT property_id, pricepernight FROM properties WHERE name = 'Safari Villa') AS prop2,
    (SELECT user_id FROM users WHERE email = 'alice.johnson@example.com') AS guest1,
    (VALUES
        ('2025-07-10'::DATE, '2025-07-15'::DATE, 200.00 * 5, 'pending') -- 5 nights
    ) AS bookings(start_date, end_date, total_price, status)
UNION ALL
SELECT
    uuid_generate_v4(),
    property_id,
    user_id,
    start_date,
    end_date,
    total_price,
    status,
    CURRENT_TIMESTAMP
FROM
    (SELECT property_id, pricepernight FROM properties WHERE name = 'Charming London Flat') AS prop3,
    (SELECT user_id FROM users WHERE email = 'bob.williams@example.com') AS guest2,
    (VALUES
        ('2025-08-01'::DATE, '2025-08-04'::DATE, 180.00 * 3, 'confirmed') -- 3 nights
    ) AS bookings(start_date, end_date, total_price, status)
UNION ALL
SELECT
    uuid_generate_v4(),
    property_id,
    user_id,
    start_date,
    end_date,
    total_price,
    status,
    CURRENT_TIMESTAMP
FROM
    (SELECT property_id, pricepernight FROM properties WHERE name = 'Brooklyn Loft') AS prop4,
    (SELECT user_id FROM users WHERE email = 'bob.williams@example.com') AS guest2,
    (VALUES
        ('2025-09-01'::DATE, '2025-09-03'::DATE, 120.00 * 2, 'canceled') -- 2 nights
    ) AS bookings(start_date, end_date, total_price, status)
UNION ALL
SELECT
    uuid_generate_v4(),
    property_id,
    user_id,
    start_date,
    end_date,
    total_price,
    status,
    CURRENT_TIMESTAMP
FROM
    (SELECT property_id, pricepernight FROM properties WHERE name = 'Cozy Apartment in NYC') AS prop1,
    (SELECT user_id FROM users WHERE email = 'bob.williams@example.com') AS guest2,
    (VALUES
        ('2025-10-01'::DATE, '2025-10-06'::DATE, 150.00 * 5, 'confirmed') -- 5 nights
    ) AS bookings(start_date, end_date, total_price, status);

-- Insert Payments (3 payments for confirmed bookings)
INSERT INTO payments (payment_id, booking_id, amount, payment_date, payment_method)
SELECT
    uuid_generate_v4(),
    booking_id,
    amount,
    CURRENT_TIMESTAMP,
    payment_method
FROM
    (SELECT booking_id, total_price FROM bookings WHERE start_date = '2025-06-01' AND status = 'confirmed') AS booking1,
    (VALUES
        (600.00, 'credit_card') -- Full payment for Cozy Apartment booking
    ) AS payments(amount, payment_method)
UNION ALL
SELECT
    uuid_generate_v4(),
    booking_id,
    amount,
    CURRENT_TIMESTAMP,
    payment_method
FROM
    (SELECT booking_id, total_price FROM bookings WHERE start_date = '2025-08-01' AND status = 'confirmed') AS booking2,
    (VALUES
        (540.00, 'paypal') -- Full payment for London Flat booking
    ) AS payments(amount, payment_method)
UNION ALL
SELECT
    uuid_generate_v4(),
    booking_id,
    amount,
    CURRENT_TIMESTAMP,
    payment_method
FROM
    (SELECT booking_id, total_price FROM bookings WHERE start_date = '2025-10-01' AND status = 'confirmed') AS booking3,
    (VALUES
        (375.00, 'stripe') -- Partial payment for Cozy Apartment booking
    ) AS payments(amount, payment_method);

-- Insert Reviews (4 reviews for properties)
INSERT INTO reviews (review_id, property_id, user_id, rating, comment, created_at)
SELECT
    uuid_generate_v4(),
    property_id,
    user_id,
    rating,
    comment,
    CURRENT_TIMESTAMP
FROM
    (SELECT property_id FROM properties WHERE name = 'Cozy Apartment in NYC') AS prop1,
    (SELECT user_id FROM users WHERE email = 'alice.johnson@example.com') AS guest1,
    (VALUES
        (4, 'Great location, very clean and cozy!')
    ) AS reviews(rating, comment)
UNION ALL
SELECT
    uuid_generate_v4(),
    property_id,
    user_id,
    rating,
    comment,
    CURRENT_TIMESTAMP
FROM
    (SELECT property_id FROM properties WHERE name = 'Safari Villa') AS prop2,
    (SELECT user_id FROM users WHERE email = 'alice.johnson@example.com') AS guest1,
    (VALUES
        (5, 'Amazing experience, highly recommend!')
    ) AS reviews(rating, comment)
UNION ALL
SELECT
    uuid_generate_v4(),
    property_id,
    user_id,
    rating,
    comment,
    CURRENT_TIMESTAMP
FROM
    (SELECT property_id FROM properties WHERE name = 'Charming London Flat') AS prop3,
    (SELECT user_id FROM users WHERE email = 'bob.williams@example.com') AS guest2,
    (VALUES
        (3, 'Nice place, but a bit noisy at night.')
    ) AS reviews(rating, comment)
UNION ALL
SELECT
    uuid_generate_v4(),
    property_id,
    user_id,
    rating,
    comment,
    CURRENT_TIMESTAMP
FROM
    (SELECT property_id FROM properties WHERE name = 'Brooklyn Loft') AS prop4,
    (SELECT user_id FROM users WHERE email = 'bob.williams@example.com') AS guest2,
    (VALUES
        (4, 'Spacious and stylish, great value.')
    ) AS reviews(rating, comment);

-- Insert Messages (3 messages between users)
INSERT INTO messages (message_id, sender_id, recipient_id, message_body, sent_at)
SELECT
    uuid_generate_v4(),
    sender_id,
    recipient_id,
    message_body,
    CURRENT_TIMESTAMP
FROM
    (SELECT user_id AS sender_id FROM users WHERE email = 'alice.johnson@example.com') AS sender,
    (SELECT user_id AS recipient_id FROM users WHERE email = 'john.doe@example.com') AS recipient,
    (VALUES
        ('Hi, is the Cozy Apartment available for June 1-5?')
    ) AS messages(message_body)
UNION ALL
SELECT
    uuid_generate_v4(),
    sender_id,
    recipient_id,
    message_body,
    CURRENT_TIMESTAMP
FROM
    (SELECT user_id AS sender_id FROM users WHERE email = 'john.doe@example.com') AS sender,
    (SELECT user_id AS recipient_id FROM users WHERE email = 'alice.johnson@example.com') AS recipient,
    (VALUES
        ('Yes, it’s available! I’ll confirm your booking.')
    ) AS messages(message_body)
UNION ALL
SELECT
    uuid_generate_v4(),
    sender_id,
    recipient_id,
    message_body,
    CURRENT_TIMESTAMP
FROM
    (SELECT user_id AS sender_id FROM users WHERE email = 'bob.williams@example.com') AS sender,
    (SELECT user_id AS recipient_id FROM users WHERE email = 'jane.smith@example.com') AS recipient,
    (VALUES
        ('Can you tell me more about the London Flat’s amenities?')
    ) AS messages(message_body);