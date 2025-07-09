SELECT 
    b.user_id,
    u.first_name,
    u.last_name,
    COUNT(*) AS total_bookings
FROM Booking b
JOIN Users u ON b.user_id = u.user_id
GROUP BY b.user_id, u.first_name, u.last_name;

WITH PropertyBookingCount AS (
    SELECT 
        b.property_id,
        p.name AS property_name,
        COUNT(*) AS total_bookings
    FROM Booking b
    JOIN Property p ON b.property_id = p.property_id
    GROUP BY b.property_id, p.name
)
SELECT 
    property_id,
    property_name,
    total_bookings,
    RANK() OVER (ORDER BY total_bookings DESC) AS booking_rank,
    ROW_NUMBER() OVER (ORDER BY total_bookings DESC) AS row_num
FROM PropertyBookingCount;

