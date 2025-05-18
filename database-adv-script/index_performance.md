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