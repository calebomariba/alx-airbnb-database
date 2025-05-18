-- database_index.sql
-- This file contains SQL commands to create indexes for optimizing query performance in the Airbnb Clone project.
-- The indexes target high-usage columns in the users, bookings, properties, and reviews tables based on prior queries.

-- Index on bookings.user_id for joins and correlated subqueries
CREATE INDEX idx_bookings_user_id ON bookings (user_id);

-- Index on bookings.property_id for joins and filters
CREATE INDEX idx_bookings_property_id ON bookings (property_id);

-- Index on reviews.property_id for joins and subqueries
CREATE INDEX idx_reviews_property_id ON reviews (property_id);

-- Index on bookings.start_date for sorting and range queries
CREATE INDEX idx_bookings_start_date ON bookings (start_date);

-- Index on users.email for authentication queries
CREATE INDEX idx_users_email ON users (email);

-- Index on properties.host_id for host-specific queries
CREATE INDEX idx_properties_host_id ON properties (host_id);

-- Composite index on bookings (property_id, start_date) for availability checks
CREATE INDEX idx_bookings_property_start_date ON bookings (property_id, start_date);