# Partition Performance Report for Airbnb Clone Database

This file documents the performance improvements achieved by implementing range partitioning on the `bookings` table based on the `start_date` column for the Airbnb Clone project, as part of the `alx-airbnb-database` repository. The analysis uses `EXPLAIN ANALYZE` (PostgreSQL) to compare query performance before and after partitioning.

## Partitioning Implementation

Defined in `partitioning.sql`, the `bookings` table is partitioned by range on `start_date`:
- **Parent Table**: `bookings` (template, no data).
- **Partitions**:
  - `bookings_2024`: `2024-01-01` to `2024-12-31`.
  - `bookings_2025`: `2025-01-01` to `2025-12-31`.
  - `bookings_2026`: `2026-01-01` to `2026-12-31`.
  - `bookings_default`: Catches out-of-range dates.
- **Process**:
  - Renamed original `bookings` to `bookings_old`.
  - Created partitioned `bookings` table.
  - Migrated data from `bookings_old`.
  - Recreated indexes (`idx_bookings_user_id`, `idx_bookings_property_id`, `idx_bookings_start_date`, `idx_bookings_property_start_date`).

## Test Query

The test query retrieves confirmed bookings within a date range, joining with `users` and `properties`:

```sql
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