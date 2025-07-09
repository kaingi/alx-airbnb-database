-- Users table
CREATE INDEX idx_users_user_id ON Users(user_id);

-- Booking table
CREATE INDEX idx_booking_user_id ON Booking(user_id);
CREATE INDEX idx_booking_property_id ON Booking(property_id);
CREATE INDEX idx_booking_status ON Booking(status);

-- Property table
CREATE INDEX idx_property_property_id ON Property(property_id);
CREATE INDEX idx_property_host_id ON Property(host_id);

-- Review table
CREATE INDEX idx_review_property_id ON Review(property_id);

-- Query performance check (PostgreSQL-style EXPLAIN ANALYZE)
EXPLAIN ANALYZE
SELECT 
    p.name,
    COUNT(b.booking_id) AS total_bookings
FROM Property p
JOIN Booking b ON p.property_id = b.property_id
GROUP BY p.name;
