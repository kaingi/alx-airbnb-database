
CREATE TABLE User (
    user_id UUID PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    phone_number VARCHAR(20),
    role ENUM('guest', 'host', 'admin') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    INDEX (user_id)
);

INSERT INTO User (user_id, first_name, last_name, email, password_hash, phone_number, role, created_at) VALUES
  ('uuid-user-001', 'Alice', 'Smith', 'alice@example.com', 'hashed_pw_001', '0700000001', 'host', CURRENT_TIMESTAMP),
  ('uuid-user-002', 'Bob', 'Johnson', 'bob@example.com', 'hashed_pw_002', '0700000002', 'guest', CURRENT_TIMESTAMP),
  ('uuid-user-003', 'Carol', 'Williams', 'carol@example.com', 'hashed_pw_003', NULL, 'host', CURRENT_TIMESTAMP),
  ('uuid-user-004', 'David', 'Brown', 'david@example.com', 'hashed_pw_004', '0700000004', 'guest', CURRENT_TIMESTAMP);

CREATE TABLE Property (
    property_id UUID PRIMARY KEY,
    host_id UUID NOT NULL,
    name VARCHAR(150) NOT NULL,
    description TEXT NOT NULL,
    location VARCHAR(255) NOT NULL,
    pricepernight DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (host_id) REFERENCES User(user_id),
    INDEX (property_id),
    INDEX (host_id)
);

INSERT INTO Property (property_id, host_id, name, description, location, pricepernight, created_at, updated_at) VALUES
  ('uuid-prop-001', 'uuid-user-001', 'Cozy Cottage', 'A quiet place in the countryside.', 'Nairobi, Kenya', 45.00, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('uuid-prop-002', 'uuid-user-003', 'Downtown Apartment', 'Modern apartment close to shopping center.', 'Mombasa, Kenya', 75.50, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

CREATE TABLE Booking (
    booking_id UUID PRIMARY KEY,
    property_id UUID NOT NULL,
    user_id UUID NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    status ENUM('pending', 'confirmed', 'canceled') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (property_id) REFERENCES Property(property_id),
    FOREIGN KEY (user_id) REFERENCES User(user_id),
    INDEX (booking_id),
    INDEX (property_id),
    INDEX (user_id)
);

INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, total_price, status, created_at) VALUES
  ('uuid-book-001', 'uuid-prop-001', 'uuid-user-002', '2025-07-01', '2025-07-05', 180.00, 'confirmed', CURRENT_TIMESTAMP),
  ('uuid-book-002', 'uuid-prop-002', 'uuid-user-004', '2025-08-10', '2025-08-15', 377.50, 'pending', CURRENT_TIMESTAMP);

CREATE TABLE Payment (
    payment_id UUID PRIMARY KEY,
    booking_id UUID NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_method ENUM('credit_card', 'paypal', 'stripe') NOT NULL,
    
    FOREIGN KEY (booking_id) REFERENCES Booking(booking_id),
    INDEX (payment_id),
    INDEX (booking_id)
);
INSERT INTO Payment (payment_id, booking_id, amount, payment_date, payment_method) VALUES
  ('uuid-pay-001', 'uuid-book-001', 180.00, CURRENT_TIMESTAMP, 'credit_card'),
  ('uuid-pay-002', 'uuid-book-002', 377.50, CURRENT_TIMESTAMP, 'paypal');

CREATE TABLE Review (
    review_id UUID PRIMARY KEY,
    property_id UUID NOT NULL,
    user_id UUID NOT NULL,
    rating INTEGER NOT NULL CHECK (rating >= 1 AND rating <= 5),
    comment TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (property_id) REFERENCES Property(property_id),
    FOREIGN KEY (user_id) REFERENCES User(user_id),
    INDEX (review_id),
    INDEX (property_id),
    INDEX (user_id)
);

INSERT INTO Review (review_id, property_id, user_id, rating, comment, created_at) VALUES
  ('uuid-rev-001', 'uuid-prop-001', 'uuid-user-002', 5, 'Wonderful stay! Quiet and clean.', CURRENT_TIMESTAMP),
  ('uuid-rev-002', 'uuid-prop-002', 'uuid-user-004', 4, 'Great location but a bit noisy.', CURRENT_TIMESTAMP);

CREATE TABLE Message (
    message_id UUID PRIMARY KEY,
    sender_id UUID NOT NULL,
    recipient_id UUID NOT NULL,
    message_body TEXT NOT NULL,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (sender_id) REFERENCES User(user_id),
    FOREIGN KEY (recipient_id) REFERENCES User(user_id),
    INDEX (message_id),
    INDEX (sender_id),
    INDEX (recipient_id)
);

INSERT INTO Message (message_id, sender_id, recipient_id, message_body, sent_at) VALUES
  ('uuid-msg-001', 'uuid-user-002', 'uuid-user-001', 'Hi, is your cottage available for next weekend?', CURRENT_TIMESTAMP),
  ('uuid-msg-002', 'uuid-user-001', 'uuid-user-002', 'Yes, it is! Looking forward to hosting you.', CURRENT_TIMESTAMP);
