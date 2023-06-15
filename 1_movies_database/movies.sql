--Part 1 — Creating Tables
-- Create database
CREATE DATABASE movies;

-- Create first table
CREATE TABLE films(
    name TEXT,
    release_year INTEGER
);

-- Part 2 — Saving Our Favorite Movies
-- Insert values to films table
INSERT INTO films(name, release_year)
VALUES 
    ('Star Wars: Episode IV - A New Hope', 1977),
    ('Valhalla rising', 2009),
    ('The red violin', 1998),
    ('The Matrix', 1999);

-- Part 3 — Browsing movies
-- Using the WHERE clause
SELECT * FROM films WHERE release_year > 1990;
SELECT * FROM films WHERE release_year >= 1999;
SELECT * FROM films WHERE release_year <= 1977;

-- Part 4 — Adding Supplementary Information
-- Adding attributes to the films table
ALTER TABLE films 
ADD COLUMN runtime INTEGER,
ADD COLUMN category TEXT,
ADD COLUMN rating DECIMAL,
ADD COLUMN box_office_earnings BIGINT;

-- Part 5 — Backfilling Data
-- Updating previous records to fill the values in the new columns
UPDATE films
SET runtime = 120, category = 'Adventure', rating = 8.6, box_office_earnings = 775398007
WHERE name = 'Star Wars: Episode IV - A New Hope';

UPDATE films
SET runtime = 93, category = 'Action', rating = 6.0, box_office_earnings = 731613
WHERE name = 'Valhalla rising';

UPDATE films
SET runtime = 130, category = 'Drama', rating = 7.9, box_office_earnings = 10000000
WHERE name = 'The red violin';

UPDATE films
SET runtime = 236, category = 'Sci-Fi', rating = 8.7, box_office_earnings = 460000000
WHERE name = 'The Matrix';

-- Part 6 — Adding Constraints
-- Adding constraints to 'films' table;
ALTER TABLE films 
ADD CONSTRAINT unique_name UNIQUE (name);