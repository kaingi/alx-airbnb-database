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
    RANK() OVER (ORDER BY total_bookings DESC) AS booking_rank
FROM PropertyBookingCount;
