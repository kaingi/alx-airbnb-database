-- 1. Create a partition function based on start_date
CREATE PARTITION FUNCTION pfBookingDateRange (DATE)
AS RANGE RIGHT FOR VALUES (
    '2024-01-01', '2024-04-01', '2024-07-01', '2024-10-01',
    '2025-01-01', '2025-04-01', '2025-07-01'
);

-- 2. Create a partition scheme using the function
CREATE PARTITION SCHEME psBookingDateRange
AS PARTITION pfBookingDateRange
ALL TO ([PRIMARY]);  -- Or use different filegroups if available

-- 3. Create a new partitioned version of the Booking table
CREATE TABLE BookingPartitioned (
    booking_id UNIQUEIDENTIFIER PRIMARY KEY,
    property_id UNIQUEIDENTIFIER NOT NULL,
    user_id UNIQUEIDENTIFIER NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    status VARCHAR(20) NOT NULL,
    created_at DATETIME DEFAULT GETDATE()
)
ON psBookingDateRange(start_date);  -- ✅ Partitioned on this column

-- Optional: Add test data or insert from old Booking table
-- INSERT INTO BookingPartitioned SELECT * FROM Booking;

