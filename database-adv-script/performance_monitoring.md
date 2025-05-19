# Database Performance Monitoring Report for Airbnb Clone Database

This file documents the monitoring and refinement of database performance for the Airbnb Clone project, as part of the `alx-airbnb-database` repository. The analysis uses `EXPLAIN ANALYZE` (PostgreSQL) to identify bottlenecks in three frequently used queries, implements optimizations (indexes, query refactoring), and reports improvements.

## Methodology

- **Queries Analyzed**: Three queries from `subqueries.sql`, `aggregations_and_window_functions.sql`, and `performance.sql`.
- **Dataset**: ~1 million bookings (partitioned by `start_date`), 3000 users, 3000 properties, ~800,000 payments.
- **Tools**: `EXPLAIN ANALYZE` to measure execution plans and times.
- **Monitoring Script**: `monitor_queries.sql` contains original and refactored queries.
- **Changes**: Added indexes (`idx_bookings_status`, `idx_bookings_start_date_status`), refactored queries, and suggested schema adjustments.

## Query 1: Correlated Subquery

**Original Query**:
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