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
  1.2 Alter the code column so that each value inserted 
  into this field is unique and not empty.
*/
ALTER TABLE parts 
ADD UNIQUE (code);

ALTER TABLE parts 
ALTER COLUMN code
SET NOT NULL;


/* 
    1.3 The parts table is missing values in the description column. 
    Alter the table so that all rows have a value for description.
*/
UPDATE parts 
SET description = 'Not provided.'
WHERE description IS NULL;

/*
    1.4 Add a constraint on parts that ensures that all values in 
    description are filled and non-empty.
*/
ALTER TABLE parts 
ALTER COLUMN description
SET NOT NULL;


/* 
    1.5 Because you’ve set description to NOT NULL, PostgreSQL 
    should reject this insert. Examine the error and change 
    the description to a different value so that the row can be inserted.
*/

-- First query, this query should fail due to NOT NULL constraint. 
/*
INSERT INTO parts 
VALUES (
    54, NULL, V1=009, 9
);
*/

--Second query
INSERT INTO parts 
VALUES (
    54, 'Not provided.', 'V1=009', 9
);

/*
    SECTION 2: Improving Reordering Options
*/

/* 
    2.1 Let’s implement a check that ensures that price_usd 
    and quantity are both NOT NULL. Table: reorder_options.
*/
ALTER TABLE reorder_options
ADD CHECK (price_usd IS NOT NULL AND quantity IS NOT NULL );

/* 
    2.2 Let’s implement a check that ensures that price_usd and quantity are both positive.
*/
ALTER TABLE reorder_options
ADD CHECK (price_usd > 0 AND quantity > 0  );

/* 
    2.2 
Let’s assume our storeroom mostly tracks parts with a price per unit between 0.02 USD and 
25.00 USD. Add a constraint to reorder_options that limits price per unit to within that range. 
Assume that price per unit for a given ordering option is the price divided by the quantity.
*/
ALTER TABLE reorder_options
ADD CHECK ( price_usd / quantity >= 0.02 AND  price_usd / quantity <= 25.0  );

/*
    2.3 . Form a relationship between parts and reorder_options that ensures all parts in 
reorder_options refer to parts tracked in parts.
*/
ALTER TABLE parts 
ADD PRIMARY KEY (id);

ALTER TABLE reorder_options
ADD FOREIGN KEY (part_id)
REFERENCES parts(id);

/*
    SECTION 3: Improving Location Tracking
*/

/* 
    3.1 The locations table stores information about the locations of a part for all the 
parts available in our storeroom. Let’s add a constraint that ensures that each value in
qty is greater than 0.
*/
ALTER TABLE locations 
ADD CHECK (qty > 0);

/* 
3.2 Let’s ensure that locations records only one row for each combination of location 
and part. This should make it easier to access information about a location or part from the table.
*/
ALTER TABLE locations 
ADD CONSTRAINT unique_location_part 
UNIQUE  (part_id, location);

/*
    3.3 Let’s ensure that for a part to be stored in locations, it must already be 
registered in parts. Write a constraint that forms the relationship between these 
two tables and ensures only valid parts are entered into locations.
*/
ALTER TABLE locations 
ADD FOREIGN KEY (part_id)
REFERENCES parts(id);

/*
    SECTION 4: Improving Manufacturer Tracking
*/

/* 
    4.1 
Let’s ensure that all parts in parts have a valid manufacturer. Write a constraint that 
forms a relationship between parts and manufacturers that ensures that all parts have a valid manufacturer.
*/
ALTER TABLE parts
ADD FOREIGN KEY (manufacturer_id)
REFERENCES manufacturers(id);

/* 
    4.3  Assume that 'Pip Industrial' and 'NNC Manufacturing' merge and become 
'Pip-NNC Industrial'. Create a new manufacturer in manufacturers with an id=11
*/
INSERT INTO manufacturers
VALUES(
    11, 'Pip-NNC Industrial'
);

SELECT * FROM parts;
SELECT * FROM manufacturers;

/* 
    4.4 Update the old manufacturers’ parts in 'parts' to reference the new
company you’ve just added to 'manufacturers'.
*/
UPDATE parts 
SET manufacturer_id = 11
WHERE  (manufacturer_id = 1 OR manufacturer_id = 2);

SELECT * FROM parts;