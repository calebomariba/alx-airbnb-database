-- partitioning.sql
-- This file implements range partitioning on the bookings table based on start_date
-- to optimize query performance for the Airbnb Clone project.

-- Step 1: Create the parent table (bookings) as a partitioned table
-- Note: Rename existing bookings table to bookings_old first
ALTER TABLE bookings RENAME TO bookings_old;

CREATE TABLE bookings (
    booking_id UUID PRIMARY KEY,
    property_id UUID NOT NULL,
    user_id UUID NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    status VARCHAR(20) NOT NULL CHECK (status IN ('pending', 'confirmed', 'canceled')),
    FOREIGN KEY (property_id) REFERENCES properties (property_id),
    FOREIGN KEY (user_id) REFERENCES users (user_id)
) PARTITION BY RANGE (start_date);

-- Step 2: Create partitions for specific years
-- Partition for 2024
CREATE TABLE bookings_2024 PARTITION OF bookings
    FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

-- Partition for 2025
CREATE TABLE bookings_2025 PARTITION OF bookings
    FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');

-- Partition for 2026
CREATE TABLE bookings_2026 PARTITION OF bookings
    FOR VALUES FROM ('2026-01-01') TO ('2027-01-01');

-- Default partition for any other dates
CREATE TABLE bookings_default PARTITION OF bookings DEFAULT;

-- Step 3: Migrate data from bookings_old to the partitioned bookings table
INSERT INTO bookings
SELECT * FROM bookings_old;

-- Step 4: Drop the old table (optional, after verifying data)
-- DROP TABLE bookings_old;

-- Step 5: Recreate indexes on the parent table
-- Indexes will be applied to all partitions
CREATE INDEX idx_bookings_user_id ON bookings (user_id);
CREATE INDEX idx_bookings_property_id ON bookings (property_id);
CREATE INDEX idx_bookings_start_date ON bookings (start_date);
CREATE INDEX idx_bookings_property_start_date ON bookings (property_id, start_date);

-- Step 6: Test query for performance analysis
-- Query: Fetch confirmed bookings for a specific date range
EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    u.first_name,
    u.last_name,
    p.name AS property_name
FROM bookings b
INNER JOIN users u ON b.user_id = u.user_id
INNER JOIN properties p ON b.property_id = p.property_id
WHERE b.status = 'confirmed'
  AND b.start_date BETWEEN '2025-06-01' AND '2025-08-31'
ORDER BY b.start_date;