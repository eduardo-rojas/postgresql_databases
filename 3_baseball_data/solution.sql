-- Step 1 — Downloading The Data 
-- -- 1 CREATE DATABASE
CREATE DATABASE baseball;

-- Step 2 — Investigate The Data
-- -- 1 Take a look at the first few rows of the people, batting, pitching, and teams table.
SELECT *  FROM people LIMIT 10;
SELECT *  FROM batting LIMIT 10;
SELECT *  FROM pitching LIMIT 10;
SELECT *  FROM teams LIMIT 10;
