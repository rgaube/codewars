/* Conditional Count (6kyu)
 * https://www.codewars.com/kata/conditional-count/train/sql
 * 
 * Produce a result set for the report that shows a side-by-side comparison of the number and total amounts of payments 
 * made in Mike's and Jon's stores broken down by months. 
 * See payment table: http://www.postgresqltutorial.com/postgresql-sample-database/
 * The resulting data set should be ordered by month using natural order (Jan, Feb, Mar, etc.).
 * Note: You don't need to worry about the year component. Months are never repeated (only data of one year).
 * 
 * The desired output for the report
 * month | total_count | total_amount | mike_count | mike_amount | jon_count | jon_amount
 * ------+-------------+--------------+------------+-------------+-----------+-----------
 * 2     |             |              |            |             |           |           
 * 5     |             |              |            |             |           |           
 * 
 * month - number of the month (1 - January, 2 - February, etc.)
 * total_count - total number of payments
 * total_amount - total payment amount
 * mike_count - total number of payments accepted by Mike (staff_id = 1)
 * mike_amount - total amount of payments accepted by Mike (staff_id = 1)
 * jon_count - total number of payments accepted by Jon (staff_id = 2)
 * jon_amount - total amount of payments accepted by Jon (staff_id = 2)
 */

------------------------------

/* Conditionals overview
 * IF ... THEN ... END IF
 * IF ... THEN ... ELSE ... END IF
 * IF ... THEN ... ELSIF ... THEN ... ELSE ... END IF
 * CASE ... WHEN ... THEN ... ELSE ... END CASE
 * CASE WHEN ... THEN ... ELSE ... END CASE
 */

-- My solution
SELECT 
	EXTRACT(month from payment_date) AS month,
	COUNT(DISTINCT(payment_id)) AS total_count,
	SUM(amount) AS total_amount,
	COUNT(DISTINCT(CASE staff_id WHEN 1 THEN payment_id ELSE NULL END)) AS mike_count,
	SUM(CASE staff_id WHEN 1 THEN amount ELSE NULL END) AS mike_amount,
	COUNT(DISTINCT(CASE staff_id WHEN 2 THEN payment_id ELSE 0 END)) AS jon_count,
	SUM(CASE staff_id WHEN 2 THEN amount ELSE 0 END) AS jon_amount
FROM payment

-------------- Interesting solutions from others --------------------------

SELECT
  EXTRACT(MONTH FROM payment_date)        AS month,
  COUNT(*)                                AS total_count,
  SUM(amount)                             AS total_amount,
  COUNT(*)    FILTER (WHERE staff_id = 1) AS mike_count,
  SUM(amount) FILTER (WHERE staff_id = 1) AS mike_amount,
  COUNT(*)    FILTER (WHERE staff_id = 2) AS jon_count,
  SUM(amount) FILTER (WHERE staff_id = 2) AS jon_amount
FROM payment
GROUP BY month
ORDER BY month;

SELECT
  date_part('month',payment_date) AS month,
  COUNT(*) AS total_count,
  SUM(amount)::NUMERIC AS total_amount,
  SUM(CASE WHEN staff_id=1 THEN 1 ELSE 0 END) AS mike_count,
  SUM(CASE WHEN  staff_id=1 THEN amount ELSE 0 END)::NUMERIC AS mike_amount,
  SUM(CASE WHEN staff_id=2 THEN 1 ELSE 0 END) AS jon_count,
  SUM(CASE WHEN  staff_id=2 THEN amount ELSE 0 END)::NUMERIC AS jon_amount
  FROM payment
  GROUP BY month
  ORDER BY month ASC
GROUP BY month
