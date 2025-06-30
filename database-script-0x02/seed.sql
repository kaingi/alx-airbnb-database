
-- Sample Users
INSERT INTO User (user_id, first_name, last_name, email, password_hash, phone_number, role, created_at) VALUES
  ('uuid-user-001', 'Alice', 'Smith', 'alice@example.com', 'hashed_pw_001', '0700000001', 'host', CURRENT_TIMESTAMP),
  ('uuid-user-002', 'Bob', 'Johnson', 'bob@example.com', 'hashed_pw_002', '0700000002', 'guest', CURRENT_TIMESTAMP),
  ('uuid-user-003', 'Carol', 'Williams', 'carol@example.com', 'hashed_pw_003', NULL, 'host', CURRENT_TIMESTAMP),
  ('uuid-user-004', 'David', 'Brown', 'david@example.com', 'hashed_pw_004', '0700000004', 'guest', CURRENT_TIMESTAMP);

-- Sample Properties
INSERT INTO Property (property_id, host_id, name, description, location, pricepernight, created_at, updated_at) VALUES
  ('uuid-prop-001', 'uuid-user-001', 'Cozy Cottage', 'A quiet place in the countryside.', 'Nairobi, Kenya', 45.00, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('uuid-prop-002', 'uuid-user-003', 'Downtown Apartment', 'Modern apartment close to shopping center.', 'Mombasa, Kenya', 75.50, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Sample Bookings
INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, total_price, status, created_at) VALUES
  ('uuid-book-001', 'uuid-prop-001', 'uuid-user-002', '2025-07-01', '2025-07-05', 180.00, 'confirmed', CURRENT_TIMESTAMP),
  ('uuid-book-002', 'uuid-prop-002', 'uuid-user-004', '2025-08-10', '2025-08-15', 377.50, 'pending', CURRENT_TIMESTAMP);

-- Sample Payments
INSERT INTO Payment (payment_id, booking_id, amount, payment_date, payment_method) VALUES
  ('uuid-pay-001', 'uuid-book-001', 180.00, CURRENT_TIMESTAMP, 'credit_card'),
  ('uuid-pay-002', 'uuid-book-002', 377.50, CURRENT_TIMESTAMP, 'paypal');

-- Sample Reviews
INSERT INTO Review (review_id, property_id, user_id, rating, comment, created_at) VALUES
  ('uuid-rev-001', 'uuid-prop-001', 'uuid-user-002', 5, 'Wonderful stay! Quiet and clean.', CURRENT_TIMESTAMP),
  ('uuid-rev-002', 'uuid-prop-002', 'uuid-user-004', 4, 'Great location but a bit noisy.', CURRENT_TIMESTAMP);

-- Sample Messages
INSERT INTO Message (message_id, sender_id, recipient_id, message_body, sent_at) VALUES
  ('uuid-msg-001', 'uuid-user-002', 'uuid-user-001', 'Hi, is your cottage available for next weekend?', CURRENT_TIMESTAMP),
  ('uuid-msg-002', 'uuid-user-001', 'uuid-user-002', 'Yes, it is! Looking forward to hosting you.', CURRENT_TIMESTAMP);
