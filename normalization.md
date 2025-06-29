✅ Normalization of AirBnB Database to 3NF
🎯 Objective:
Ensure the database schema is in Third Normal Form (3NF) — meaning:

It is in 1NF (all attributes atomic).

It is in 2NF (no partial dependencies).

It is in 3NF (no transitive dependencies).

📦 Entities Before Normalization
We had the following tables:

User

Property

Booking

Payment

Review

Message

🔍 Step-by-Step Normalization
✅ 1NF — First Normal Form
Rule:

No repeating groups or arrays.

All attributes must contain atomic values.

Status:
✅ All tables are already in 1NF — every field holds atomic data (e.g., no list of emails, names, or prices).

✅ 2NF — Second Normal Form
Rule:

Must be in 1NF.

No partial dependencies (non-key attributes should depend on the whole primary key).

Status:
✅ All tables use single-column primary keys (UUIDs), so no partial dependencies exist.

✅ 3NF — Third Normal Form
Rule:

Must be in 2NF.

No transitive dependencies (non-key attributes cannot depend on other non-key attributes).

Reviewing Each Table:

User Table
Attribute	Depends On
user_id (PK)	-
first_name	user_id
last_name	user_id
email	user_id
password_hash	user_id
phone_number	user_id
role	user_id
created_at	user_id

✅ No transitive dependencies. Already in 3NF.

Property Table
Attribute	Depends On
property_id (PK)	-
host_id (FK)	property_id
name	property_id
description	property_id
location	property_id
pricepernight	property_id
created_at	property_id
updated_at	property_id

✅ Already in 3NF.

Booking Table
Attribute	Depends On
booking_id (PK)	-
property_id (FK)	booking_id
user_id (FK)	booking_id
start_date	booking_id
end_date	booking_id
total_price	booking_id
status	booking_id
created_at	booking_id

✅ No derived/transitive attributes. In 3NF.

Payment Table
Attribute	Depends On
payment_id (PK)	-
booking_id (FK)	payment_id
amount	payment_id
payment_date	payment_id
payment_method	payment_id

⚠️ Potential improvement:
If amount is calculated from Booking.total_price, it should not be stored unless it's necessary for auditing (e.g., to handle currency changes, discounts, or partial payments).

✅ For traceability, we keep amount. Still considered in 3NF if amount is an independent transaction record.
