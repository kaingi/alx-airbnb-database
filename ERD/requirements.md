🧩 Entities and Their Attributes
1. User
-user_id (PK)
-first_name
-last_name
-email (unique)
-password_hash
-phone_number
-role (guest, host, admin)
-created_at

2. Property
-property_id (PK)
-host_id (FK → User.user_id)
-name
-description
-location
-pricepernight
-created_at
-updated_at

3. Booking
-booking_id (PK)
-property_id (FK → Property.property_id)
-user_id (FK → User.user_id)
-start_date
-end_date
-total_price
-status (pending, confirmed, canceled)
-created_at

4. Payment
-payment_id (PK)
-booking_id (FK → Booking.booking_id)
-amount
-payment_date
-payment_method (credit_card, paypal, stripe)

5. Review
-review_id (PK)
-property_id (FK → Property.property_id)
-user_id (FK → User.user_id)
-rating (1–5)
-comment
-created_at

6. Message
-message_id (PK)
-sender_id (FK → User.user_id)
-recipient_id (FK → User.user_id)
-message_body
-sent_at

Relationships Between Entities
Relationship Description	Type
A User can host many Properties	1 → N (User → Property)
A User (guest) can make many Bookings	1 → N (User → Booking)
A Property can have many Bookings	1 → N (Property → Booking)
A Booking has one Payment	1 → 1 (Booking → Payment)
A User can leave multiple Reviews for different Properties	M → N (User ↔ Property via Review)
A User can send and receive many Messages	1 → N (User → Message as sender or recipient)



Below is a link directing you to the entity relationship diagram.

https://drive.google.com/file/d/11XkFljxljYiqNt9y3v3St69PEbOZS3ZV/view?usp=sharing
