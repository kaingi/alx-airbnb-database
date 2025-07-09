-- Drop the table if it exists
DROP TABLE IF EXISTS BookingPartitioned;

-- Create a partitioned Booking table by start_date
CREATE TABLE BookingPartitioned (
    booking_id CHAR(36) PRIMARY KEY,
    property_id CHAR(36) NOT NULL,
    user_id CHAR(36) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    status VARCHAR(20) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
)
PARTITION BY RANGE (start_date) (
    PARTITION p_2024_q1 VALUES LESS THAN ('2024-04-01'),
    PARTITION p_2024_q2 VALUES LESS THAN ('2024-07-01'),
    PARTITION p_2024_q3 VALUES LESS THAN ('2024-10-01'),
    PARTITION p_2024_q4 VALUES LESS THAN ('2025-01-01'),
    PARTITION p_2025_q1 VALUES LESS THAN ('2025-04-01'),
    PARTITION p_2025_q2 VALUES LESS THAN ('2025-07-01'),
    PARTITION p_2025_q3 VALUES LESS THAN ('2025-10-01'),
    PARTITION p_max VALUES LESS THAN (MAXVALUE)
);
