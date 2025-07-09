-- Initial query with WHERE and AND for performance analysis
EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,

    u.first_name,
    u.last_name,
    u.email,

    p.name AS property_name,
    p.location,
    p.pricepernight,

    pay.amount,
    pay.payment_method,
    pay.payment_date

FROM Booking b
JOIN Users u ON b.user_id = u.user_id
JOIN Property p ON b.property_id = p.property_id
LEFT JOIN Payment pay ON b.booking_id = pay.booking_id

-- ✅ Filtering logic
WHERE b.status = 'confirmed'
  AND p.location = 'Nairobi, Kenya';
