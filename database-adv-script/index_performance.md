
✅ 1. Identify High-Usage Columns
Based on typical usage (joins, filters, ordering), the high-usage columns are:

Table	Column	Why it's high-usage
Users	user_id	Used in JOINs (Booking, Review, Message)
Booking	user_id	Used in JOIN, WHERE
Booking	property_id	Used in JOIN, WHERE, GROUP BY
Booking	status	Used in filtering (WHERE)
Property	property_id	Used in JOIN, GROUP BY, ORDER BY
Property	host_id	Used in JOIN with Users
Review	property_id	Used in JOIN, WHERE

✅ 2. CREATE INDEX Statements
Save this in a file named database_index.sql:

sql
Copy
Edit
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
✅ 3. Measure Performance Before and After (Using STATISTICS + EXPLAIN)
You’ll use SQL Server's performance tools:

A. Before Adding Indexes
sql
Copy
Edit
SET STATISTICS IO ON;
SET STATISTICS TIME ON;

-- Example query to test
SELECT 
    p.name,
    COUNT(b.booking_id) AS total_bookings
FROM Property p
JOIN Booking b ON p.property_id = b.property_id
GROUP BY p.name
ORDER BY total_bookings DESC;

SET STATISTICS IO OFF;
SET STATISTICS TIME OFF;
📌 Copy down the output from the Messages tab in SSMS:
Look for:

Logical reads

CPU time

Elapsed time

B. Run database_index.sql
Execute the file or paste those CREATE INDEX commands into SSMS.

C. Rerun the Same Query (After Indexing)
Repeat the same block with STATISTICS IO/TIME on.

✅ Compare the Results
If indexing helped, you’ll see:

Lower logical reads

Faster CPU and elapsed time

"Index Seek" in the actual execution plan (Ctrl + M)

🧪 Bonus: Include the Execution Plan
Click "Include Actual Execution Plan" before running queries — and compare:

Table Scan (bad)

Index Seek (good)

🔚 Summary
Step	Action
Identify high-usage columns	Based on joins/filters
Create indexes	CREATE INDEX on target columns
Measure before	SET STATISTICS IO/TIME ON
Apply indexes	Run database_index.sql
Measure after	Run same query again
Analyze improvement	Lower time, less I/O, index seek
