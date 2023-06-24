/* 
DATABASE TRIGGERS
    1. Update Triggers
*/

/* 
    1.1 There are two tables we will be working with: 
customers and customers_log. To make your life 
easier we would recommend ordering the customers 
table by customer_id
*/
SELECT * FROM customers 
ORDER BY customer_id;

SELECT * FROM customers_log;

/* 
    2. Update Triggers
*/

/* 
    2.1 you with creating a trigger to log anytime someone 
updates the customers table. There is already a procedure 
to insert into the customers_log table called log_customers_change().
*/
CREATE TRIGGER update_customers
AFTER UPDATE ON customers
FOR EACH ROW
EXECUTE PROCEDURE 
log_customers_change();


/* 
    2.2 Can you confirm your trigger is working as expected? 
Remember, it should only create a log for changes to first_name 
and/or last_name.
*/
UPDATE customers 
SET first_name = 'Eduardo'
WHERE customer_id = 1 ;

SELECT * FROM customers 
ORDER BY customer_id;
SELECT * FROM customers_log;


/* 
    2.3 Can you confirm your trigger is working as expected? 
Remember, it should only create a log for changes to first_name 
and/or last_name.
*/
UPDATE customers 
SET email_address = 'Eduardo.Lewis@example.com'
WHERE customer_id = 1;

SELECT * FROM customers 
ORDER BY customer_id;
SELECT * FROM customers_log;


/* 
    3. Insert Triggers
*/

/* 
    3.1 Create the trigger to call the log_customers_change procedure 
    once for every statement on INSERT to the customers table. Call it 
    customer_insert.
*/
CREATE TRIGGER insert_customers
AFTER INSERT ON customers 
FOR EACH STATEMENT  
EXECUTE PROCEDURE 
log_customers_change();


/* 
    3.2 Add three names to the customers table in one statement. 
    Is your trigger working as expected and only inserting one 
    row per insert statement, not per record?
*/

INSERT INTO customers 
(first_name, last_name, email_address, home_phone, city, state_name, years_old)
VALUES('Jeffrey','Cook','Jeffrey.Cook@example.com','202-555-0398','Jersey city','New Jersey',66),
('John','Doe','Johnny.Doek@example.com','278-675-5278','Los Angeles','California',12),
('Linda','Johnson','Linda.Johnson@example.com','412-328-9145','San Diego','California',97);

SELECT * FROM customers 
ORDER BY customer_id;
SELECT * FROM customers_log;


/* 
    4. Conditionals on your Triggers
*/

/* 
    4.1 The trigger should detect when age is updated to be below 13 
and call this function: override_with_min_age(). This function will 
assume this was a mistake and override the change and set the age to be 13.
*/
CREATE TRIGGER customer_min_age
BEFORE UPDATE ON customers 
FOR EACH ROW 
WHEN (NEW.years_old <13)
EXECUTE PROCEDURE
override_with_min_age();


/* 
    4.2  Two more changes to the customers table have come in. 
Modify one record to set their age under 13 and another over 13, 
then check the results in the customers and customers_log table.
*/
UPDATE customers 
SET years_old = 7
WHERE customer_id = 5 ;

UPDATE customers 
SET years_old = 27
WHERE customer_id = 2;

SELECT * FROM customers 
ORDER BY customer_id;
SELECT * FROM customers_log;


/*
    4.3 What would happen if you had an update on more columns at
once, say modifications to the first_name and years_old in the same query?
*/
UPDATE customers 
SET first_name = 'Daniela', last_name = 'Anders', years_old = 27
WHERE customer_id = 3 ;

SELECT * FROM customers 
ORDER BY customer_id;
SELECT * FROM customers_log;

/* 
    5. Trigger Cleanup
*/

/* 
    5.1 The trigger should detect when age is updated to be below 13 
and call this function: override_with_min_age(). This function will 
assume this was a mistake and override the change and set the age to be 13.
*/
DROP TRIGGER customer_min_age ON customers;


/* 
    5.2 Take a look at the triggers on the system 
    to ensure your removal worked correctly.
*/
SELECT * FROM information_schema.triggers;