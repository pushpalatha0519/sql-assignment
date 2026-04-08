Q1 : 
SELECT sales_channel,
       SUM(amount) AS revenue
FROM clinic_sales
WHERE YEAR(datetime) = 2021
GROUP BY sales_channel;


Q2 :
SELECT uid,
       SUM(amount) AS total_spent
FROM clinic_sales
WHERE YEAR(datetime) = 2021
GROUP BY uid
ORDER BY total_spent DESC
LIMIT 10;


Q3 :
SELECT MONTH(cs.datetime) AS month,
       SUM(cs.amount) AS revenue,
       SUM(e.amount) AS expense,
       SUM(cs.amount) - SUM(e.amount) AS profit,
       CASE 
           WHEN SUM(cs.amount) - SUM(e.amount) > 0 THEN 'Profitable'
           ELSE 'Not Profitable'
       END AS status
FROM clinic_sales cs
LEFT JOIN expenses e ON cs.cid = e.cid
WHERE YEAR(cs.datetime) = 2021
GROUP BY MONTH(cs.datetime);


Q4 :
SELECT city, cid, profit
FROM (
    SELECT c.city, cs.cid,
           SUM(cs.amount) - SUM(IFNULL(e.amount,0)) AS profit,
           RANK() OVER (PARTITION BY c.city ORDER BY SUM(cs.amount) - SUM(IFNULL(e.amount,0)) DESC) rnk
    FROM clinic_sales cs
    JOIN clinics c ON cs.cid = c.cid
    LEFT JOIN expenses e ON cs.cid = e.cid
    GROUP BY c.city, cs.cid
) t
WHERE rnk = 1;

Q5 : 
SELECT state, cid, profit
FROM (
    SELECT c.state, cs.cid,
           SUM(cs.amount) - SUM(IFNULL(e.amount,0)) AS profit,
           DENSE_RANK() OVER (PARTITION BY c.state ORDER BY SUM(cs.amount) - SUM(IFNULL(e.amount,0)) ASC) rnk
    FROM clinic_sales cs
    JOIN clinics c ON cs.cid = c.cid
    LEFT JOIN expenses e ON cs.cid = e.cid
    GROUP BY c.state, cs.cid
) t
WHERE rnk = 2;



