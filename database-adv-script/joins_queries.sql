
CREATE TABLE Users (
    user_id VARCHAR(36) PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    phone_number VARCHAR(20),
    role VARCHAR(10) NOT NULL CHECK (role IN ('guest', 'host', 'admin')),
    created_at DATETIME DEFAULT GETDATE()
);


INSERT INTO Users (user_id, first_name, last_name, email, password_hash, phone_number, role) VALUES
  ('uuid-user-001', 'Alice', 'Smith', 'alice@example.com', 'hashed_pw_001', '0700000001', 'host'),
  ('uuid-user-002', 'Bob', 'Johnson', 'bob@example.com', 'hashed_pw_002', '0700000002', 'guest'),
  ('uuid-user-003', 'Carol', 'Williams', 'carol@example.com', 'hashed_pw_003', NULL, 'host'),
  ('uuid-user-004', 'David', 'Brown', 'david@example.com', 'hashed_pw_004', '0700000004', 'guest');


 -- PROPERTY TABLE
CREATE TABLE Property (
    property_id VARCHAR(36) PRIMARY KEY,
    host_id VARCHAR(36) NOT NULL,
    name VARCHAR(150) NOT NULL,
    description TEXT NOT NULL,
    location VARCHAR(255) NOT NULL,
    pricepernight DECIMAL(10, 2) NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE(),

    FOREIGN KEY (host_id) REFERENCES Users(user_id)
);

INSERT INTO Property (property_id, host_id, name, description, location, pricepernight) VALUES
  ('uuid-prop-001', 'uuid-user-001', 'Cozy Cottage', 'A quiet place in the countryside.', 'Nairobi, Kenya', 45.00),
  ('uuid-prop-002', 'uuid-user-003', 'Downtown Apartment', 'Modern apartment close to shopping center.', 'Mombasa, Kenya', 75.50);

-- BOOKING TABLE
CREATE TABLE Booking (
    booking_id VARCHAR(36) PRIMARY KEY,
    property_id VARCHAR(36) NOT NULL,
    user_id VARCHAR(36) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    status VARCHAR(10) NOT NULL CHECK (status IN ('pending', 'confirmed', 'canceled')),
    created_at DATETIME DEFAULT GETDATE(),

    FOREIGN KEY (property_id) REFERENCES Property(property_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, total_price, status) VALUES
  ('uuid-book-001', 'uuid-prop-001', 'uuid-user-002', '2025-07-01', '2025-07-05', 180.00, 'confirmed'),
  ('uuid-book-002', 'uuid-prop-002', 'uuid-user-004', '2025-08-10', '2025-08-15', 377.50, 'pending');


  -- PAYMENT TABLE
CREATE TABLE Payment (
    payment_id VARCHAR(36) PRIMARY KEY,
    booking_id VARCHAR(36) NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    payment_date DATETIME DEFAULT GETDATE(),
    payment_method VARCHAR(20) NOT NULL CHECK (payment_method IN ('credit_card', 'paypal', 'stripe')),

    FOREIGN KEY (booking_id) REFERENCES Booking(booking_id)
);

INSERT INTO Payment (payment_id, booking_id, amount, payment_method) VALUES
  ('uuid-pay-001', 'uuid-book-001', 180.00, 'credit_card'),
  ('uuid-pay-002', 'uuid-book-002', 377.50, 'paypal');
  -- REVIEW TABLE
CREATE TABLE Review (
    review_id VARCHAR(36) PRIMARY KEY,
    property_id VARCHAR(36) NOT NULL,
    user_id VARCHAR(36) NOT NULL,
    rating INT NOT NULL CHECK (rating >= 1 AND rating <= 5),
    comment TEXT NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),

    FOREIGN KEY (property_id) REFERENCES Property(property_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

INSERT INTO Review (review_id, property_id, user_id, rating, comment) VALUES
  ('uuid-rev-001', 'uuid-prop-001', 'uuid-user-002', 5, 'Wonderful stay! Quiet and clean.'),
  ('uuid-rev-002', 'uuid-prop-002', 'uuid-user-004', 4, 'Great location but a bit noisy.');

-- MESSAGE TABLE
CREATE TABLE Message (
    message_id VARCHAR(36) PRIMARY KEY,
    sender_id VARCHAR(36) NOT NULL,
    recipient_id VARCHAR(36) NOT NULL,
    message_body TEXT NOT NULL,
    sent_at DATETIME DEFAULT GETDATE(),

    FOREIGN KEY (sender_id) REFERENCES Users(user_id),
    FOREIGN KEY (recipient_id) REFERENCES Users(user_id)
);

INSERT INTO Message (message_id, sender_id, recipient_id, message_body) VALUES
  ('uuid-msg-001', 'uuid-user-002', 'uuid-user-001', 'Hi, is your cottage available for next weekend?'),
  ('uuid-msg-002', 'uuid-user-001', 'uuid-user-002', 'Yes, it is! Looking forward to hosting you.');



  SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email
FROM Booking b
INNER JOIN Users u ON b.user_id = u.user_id;

SELECT 
    p.property_id,
    p.name AS property_name,
    r.review_id,
    r.rating,
    r.comment
FROM Property p
LEFT JOIN Review r ON p.property_id = r.property_id;

SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    b.booking_id,
    b.start_date,
    b.status
FROM Users u
FULL OUTER JOIN Booking b ON u.user_id = b.user_id;
