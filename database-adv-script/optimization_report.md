📝 SQL Performance Optimization Report
✅ Objective
To analyze and refactor a SQL query that retrieves all bookings with user details, property details, and payment details — and improve its performance by filtering, reducing joins, and using indexes.

1. 📦 Initial Query
🔍 Purpose:
Fetch all bookings, including:

User info

Property info

Payment info

🧾 Query:

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
WHERE b.status = 'confirmed'
  AND p.location = 'Nairobi, Kenya';


📈 Performance Measurement (Before Indexing):
Run with EXPLAIN ANALYZE or (in SQL Server):

SET STATISTICS IO ON;  
SET STATISTICS TIME ON;

You may observe:

Table Scans on Booking, Property, Users

High logical reads

Execution time > expected
2. 🔧 Optimization Strategy
Area	Optimization
Filtering	Added WHERE b.status = 'confirmed' AND p.location = 'Nairobi, Kenya'
Join Efficiency	Removed unnecessary columns (in refactored version)
Index Usage	Suggested new indexes (see below)
Reduced Payload	Selected only required columns

3. 🚀 Refactored Query
🧾 Query:

EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    b.start_date,
    u.first_name,
    p.name AS property_name,
    pay.amount
FROM Booking b
JOIN Users u ON b.user_id = u.user_id
JOIN Property p ON b.property_id = p.property_id
LEFT JOIN Payment pay ON b.booking_id = pay.booking_id
WHERE b.status = 'confirmed'
  AND p.location = 'Nairobi, Kenya';
🧪 Improvements:
Lowered number of columns

Maintained essential business logic

Uses filtering for selective data retrieval

4. 🗃️ Recommended Indexes
To improve the performance of both queries:
CREATE INDEX idx_booking_user_id ON Booking(user_id);
CREATE INDEX idx_booking_status ON Booking(status);
CREATE INDEX idx_property_property_id ON Property(property_id);
CREATE INDEX idx_property_location ON Property(location);
CREATE INDEX idx_payment_booking_id ON Payment(booking_id);

5. 📊 Performance Comparison Summary
Metric	Before Indexing	After Indexing & Refactoring
Logical Reads	High	Lower
CPU Time	Higher	Reduced
Execution Plan	Table Scans	Index Seek (if indexes used)
Join Efficiency	Full Table Joins	Targeted Index Joins

✅ Conclusion
The initial query was functional but inefficient.

Refactoring reduced data overhead.

Indexes aligned with filtering and joining logic significantly boosted performance.

Using WHERE and AND clauses focused the query scope.


