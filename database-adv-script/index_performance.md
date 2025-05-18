# Index Performance Analysis for Airbnb Clone Database

This file documents the performance analysis of queries before and after adding indexes to optimize the Airbnb Clone database, as part of the `alx-airbnb-database` repository. The analysis uses `EXPLAIN ANALYZE` (PostgreSQL) to compare query plans and execution times for two representative queries from `database-adv-script/`.

## Indexes Created

Indexes are defined in `database_index.sql` for high-usage columns:
- `idx_bookings_user_id`: On `bookings.user_id` for joins and subqueries.
- `idx_bookings_property_id`: On `bookings.property_id` for joins and filters.
- `idx_reviews_property_id`: On `reviews.property_id` for joins and subqueries.
- `idx_bookings_start_date`: On `bookings.start_date` for sorting and range queries.
- `idx_users_email`: On `users.email` for authentication.
- `idx_properties_host_id`: On `properties.host_id` for host-specific queries.
- `idx_bookings_property_start_date`: On `bookings (property_id, start_date)` for availability checks.

## Queries Analyzed

Two queries were selected to measure the impact of indexes:
1. **Correlated Subquery** (from `subqueries.sql`): Finds users with more than 3 bookings, using `bookings.user_id`.
2. **Window Function Query** (from `aggregations_and_window_functions.sql`): Ranks properties by booking count, using `bookings.property_id`.

### Query 1: Correlated Subquery
```sql
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


-- analyze_performance.sql
-- This file measures query performance before and after adding indexes using EXPLAIN ANALYZE
-- for the Airbnb Clone project. It analyzes two queries from database-adv-script/
-- (subqueries.sql and aggregations_and_window_functions.sql).

-- Note: Run in PostgreSQL with schema from database-script-0x01/schema.sql and sample data.
-- Indexes are dropped and re-created to compare performance.

-- Step 1: Drop relevant indexes to measure performance without them
DROP INDEX IF EXISTS idx_bookings_user_id;
DROP INDEX IF EXISTS idx_bookings_property_id;

-- Step 2: Query 1 (Correlated Subquery) - Before Index
\echo '\n=== Query 1: Correlated Subquery (Before Index) ==='
EXPLAIN ANALYZE
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

-- Step 3: Create indexes for Query 1 and Query 2
CREATE INDEX idx_bookings_user_id ON bookings (user_id);
CREATE INDEX idx_bookings_property_id ON bookings (property_id);

-- Step 4: Query 1 (Correlated Subquery) - After Index
\echo '\n=== Query 1: Correlated Subquery (After Index) ==='
EXPLAIN ANALYZE
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

-- Step 5: Query 2 (Window Function) - Before Index
-- Note: Drop idx_bookings_property_id to ensure accurate "before" measurement
DROP INDEX IF EXISTS idx_bookings_property_id;
\echo '\n=== Query 2: Window Function (Before Index) ==='
EXPLAIN ANALYZE
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

-- Step 6: Re-create index for Query 2
CREATE INDEX idx_bookings_property_id ON bookings (property_id);

-- Step 7: Query 2 (Window Function) - After Index
\echo '\n=== Query 2: Window Function (After Index) ==='
EXPLAIN ANALYZE
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

-- Step 8: Note: Indexes are retained; drop manually if needed
-- DROP INDEX idx_bookings_user_id;
-- DROP INDEX idx_bookings_property_id;