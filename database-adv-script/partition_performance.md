 Partitioning Summary
To improve query performance on the large Booking table, we implemented table partitioning by start_date. Using SQL Server's partition function and scheme, we created a new table BookingPartitioned with quarterly partitions.

We tested a date-range query:

SELECT * FROM BookingPartitioned
WHERE start_date BETWEEN '2025-07-01' AND '2025-07-31';
Result:

✅ Faster query execution

✅ Lower I/O and CPU time

✅ Partition elimination used (no full table scan)

Conclusion: Partitioning by start_date greatly improved performance for time-based queries.









Ask ChatGPT
