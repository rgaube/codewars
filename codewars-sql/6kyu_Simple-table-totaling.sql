/* SQL Basics: Simple table totaling (6kyu)
 * https://www.codewars.com/kata/sql-basics-simple-table-totaling/train/sql
 * 
 * For this challenge you need to create a simple query to display each unique clan with their total points 
 * and ranked by their total points.
 * 
 * Data   -> people table with columns: name, points, clan
 * Result -> Return a table with columns: rank, clan, total_points, total_people
 * If there is no clan name you must replace it with [no clan specified]
 */

-- Build sample data
CREATE TABLE public.people(
    name TEXT,
	points integer,
	clan TEXT
);

INSERT INTO people VALUES('A', 100, 'R');
INSERT INTO people VALUES('B', 50, 'SQL');
INSERT INTO people VALUES('C', 40, '');
INSERT INTO people VALUES('D', 50, 'R');
INSERT INTO people VALUES('E', 50, 'Python');
INSERT INTO people VALUES('F', 40, NULL);

/*name|points|clan  |
----|------|------|
A   |   100|R     |
B   |    50|SQL   |
C   |    40|      |
D   |    50|R     |
E   |    50|Python|
F   |    40|[NULL]|*/

-- My solution

WITH ranking AS (
	SELECT
		CASE WHEN (clan IS NULL OR clan = '') THEN '[no clan specified]' ELSE clan END AS clan,
		SUM(points) AS total_points,
		COUNT(name) AS total_people
	FROM people
	GROUP BY clan)
SELECT 
	RANK() OVER (ORDER BY total_points DESC),
	*
FROM ranking
ORDER BY rank

/*rank|clan               |total_points|total_people|
----|-------------------|------------|------------|
   1|R                  |         150|           2|
   2|Python             |          50|           1|
   2|SQL                |          50|           1|
   4|[no clan specified]|          40|           1|
   4|[no clan specified]|          40|           1|*/

--------- Interesting solutions from others ---------- 

select 
	rank() over (order by sum(points) desc), 
	CASE WHEN clan = '' THEN '[no clan specified]' ELSE clan END, 
	sum(points) total_points, 
	count(name) total_people 
from people
group by clan

SELECT 
	RANK() OVER (ORDER BY SUM(points) DESC),
	-- The COALESCE function returns the first of its arguments that is not null. 
	-- Null is returned only if all arguments are null. It is often used to substitute a default value for null values.
	-- The NULLIF function returns a null value if value1 (clan) equals value2 (''); otherwise it returns value1.
	COALESCE(NULLIF(clan,''), '[no clan specified]') AS clan,
	SUM(points) AS total_points,
	COUNT(*) AS total_people
FROM people 
GROUP BY clan
ORDER BY total_points DESC
