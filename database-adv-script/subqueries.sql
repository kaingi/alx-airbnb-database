SELECT
p.property_id,
p.name,
p.location
from Property p
where p.property_id IN(
SELECT r.property_id
FROM Review r
GROUP BY r.property_id
Having AVG(r.rating) > 4.0
);

SELECT 
    u.user_id,
    u.first_name,
    u.last_name
FROM Users u
WHERE (
    SELECT COUNT(*) 
    FROM Booking b 
    WHERE b.user_id = u.user_id
) > 3;
