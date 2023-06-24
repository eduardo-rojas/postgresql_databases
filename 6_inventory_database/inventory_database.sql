/*
INVENTORY DATABASE
*/

/*
    SECTION 1: Improving Parts Tracking
*/

/*
    1.1 Write a query to inspect the first 10 rows of parts.
    This is also a good opportunity to inspect the entire schema. 
    What other tables are available to you?
*/

SELECT * FROM parts LIMIT 10;
SELECT * FROM locations LIMIT 10;
SELECT * FROM manufacturers LIMIT 10;
SELECT * FROM reorder_options LIMIT 10;

/* 
  2.1 Alter the code column so that each value inserted 
  into this field is unique and not empty.
*/
ALTER TABLE parts 
ADD UNIQUE (code);

ALTER TABLE parts 
ALTER COLUMN code
SET NOT NULL;


