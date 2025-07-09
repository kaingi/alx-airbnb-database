-- Index on Users.user_id (may already be a primary key, but safe)
CREATE INDEX idx_users_user_id ON Users(user_id);

-- Index on Booking.user_id
CREATE INDEX idx_booking_user_id ON Booking(user_id);

-- Index on Booking.property_id
CREATE INDEX idx_booking_property_id ON Booking(property_id);

-- Index on Property.property_id (again, may be primary key)
CREATE INDEX idx_property_property_id ON Property(property_id);

-- Index on Property.host_id
CREATE INDEX idx_property_host_id ON Property(host_id);

-- Index on Review.property_id
CREATE INDEX idx_review_property_id ON Review(property_id);


SET STATISTICS TIME ON;
SET STATISTICS IO ON;

