-- ========================================================
-- File: hotel_queries.sql
-- Description: SQL Queries for Hotel Management System
-- ========================================================
Q1 :
SELECT b.user_id, b.room_no
FROM bookings b
JOIN (
    SELECT user_id, MAX(booking_date) AS last_booking
    FROM bookings
    GROUP BY user_id
) t
ON b.user_id = t.user_id 
AND b.booking_date = t.last_booking;


Q2 : 
SELECT bc.booking_id,
       SUM(bc.item_quantity * i.item_rate) AS total_amount
FROM booking_commercials bc
JOIN items i ON bc.item_id = i.item_id
WHERE MONTH(bc.bill_date) = 11
  AND YEAR(bc.bill_date) = 2021
GROUP BY bc.booking_id;

Q3 :
SELECT bc.bill_id,
       SUM(bc.item_quantity * i.item_rate) AS bill_amount
FROM booking_commercials bc
JOIN items i ON bc.item_id = i.item_id
WHERE MONTH(bc.bill_date) = 10
  AND YEAR(bc.bill_date) = 2021
GROUP BY bc.bill_id
HAVING SUM(bc.item_quantity * i.item_rate) > 1000;

Q4 : 
SELECT MONTH(bill_date) AS month, item_id,
SUM(item_quantity) AS total_qty
FROM booking_commercials
WHERE YEAR(bill_date)=2021
GROUP BY MONTH(bill_date), item_id
ORDER BY month, total_qty DESC;

Q5 :
SELECT month, bill_id, total_amount
FROM (
    SELECT MONTH(bc.bill_date) AS month,
           bc.bill_id,
           SUM(bc.item_quantity * i.item_rate) AS total_amount,
           DENSE_RANK() OVER (PARTITION BY MONTH(bc.bill_date)
                              ORDER BY SUM(bc.item_quantity * i.item_rate) DESC) AS rnk
    FROM booking_commercials bc
    JOIN items i ON bc.item_id = i.item_id
    WHERE YEAR(bc.bill_date) = 2021
    GROUP BY MONTH(bc.bill_date), bc.bill_id
) t
WHERE rnk = 2;








