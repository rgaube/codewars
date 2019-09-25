------------------------------------------------------
-- [8kyu] Grasshopper - Terminal game move function --
------------------------------------------------------
-- https://www.codewars.com/kata/grasshopper-terminal-game-move-function/train/sql

-- Instructions ---------------------------------------------------------------

/* 
In this game, the hero moves from left to right. 
The player rolls the dice and moves the number of spaces indicated by the dice two times.
In SQL, you will be given a table moves with columns position and roll. 
Return a table which uses the current position of the hero and the roll (1-6) 
and returns the new position in a column res. 
You will be given a table 'moves' with columns 'position' and 'roll'. 
Return a table with a column 'res'.
*/

-- Test data set -------------------------------------------------------------

--CREATE TABLE public.moves(
--    position integer,
--  roll    integer, 
--  CHECK (roll >= 1 AND roll <= 6)
--);

--INSERT INTO moves VALUES(0,4);
--INSERT INTO moves VALUES(3,6);
--INSERT INTO moves VALUES(2,5);

-- Attempt 1 -----------------------------------------------------------------
-- Misleading instructions: I built a function move() that returns table res.

--CREATE OR REPLACE FUNCTION move(position integer, roll integer, OUT res integer) 
--RETURNS TABLE(res int) AS $$
--  SELECT position + (roll*2) FROM moves;
--$$ LANGUAGE SQL 
--SELECT * FROM move(0,4);

-- Attempt 2 (solution) ------------------------------------------------------

SELECT position + (roll*2) AS res FROM moves;
