# Query Optimization Report for Airbnb Clone Database

This file documents the optimization of a complex query retrieving bookings with user, property, and payment details for the Airbnb Clone project, as part of the `alx-airbnb-database` repository. The analysis uses `EXPLAIN ANALYZE` (PostgreSQL) to identify inefficiencies and evaluate improvements after refactoring.

## Initial Query

Defined in `performance.sql`, the initial query retrieves all bookings with user, property, and payment details:

```sql
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