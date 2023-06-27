/* 
    COMPUTER SCIENCE | DATABASES | CODECADEMY
    POSTGRESQL PROJECT #8: INDEX FILTERING
*/

/* 
    SECTION 1: Existing Structure 
*/

/*
    1.1 Familiarize yourself with what we are starting with,
look at the first 10 rows in each table; customers, orders, 
and books to get a feel for what is in each.
*/
SElECT * FROM customers, orders, books 
LIMIT 10;

/* 
    1.2 Examine the indexes that already exist on the three 
tables customers, books, and orders
*/
SELECT * FROM pg_Indexes 
WHERE tablename = 'customers'
OR tablename = 'books' 
OR tablename = 'orders'; 

/* 
    SECTION 2: Create Indexes
*/

/*
    2.1 Familiarize yourself with what we are starting with,
look at the first 10 rows in each table; customers, orders, 
and books to get a feel for what is in each.
*/
CREATE INDEX orders_customer_id_idx
ON orders(customer_id);

CREATE INDEX orders_book_id_idx
ON orders(book_id);


/* 
    SECTION 3: Is a Multicolumn Index good here?
*/

/*
    3.1 Use EXPLAIN ANALYZE to check the runtime of a query
searching for the original_language, title, and sales_in_millions 
from the books table that have an original_language of 'French'.
*/
EXPLAIN ANALYZE  
SELECT original_language, title, sales_in_millions 
FROM books 
WHERE original_language = 'French';

/*
    3.2 Get the size of the books table.
*/
SELECT pg_size_pretty (pg_total_relation_size('books'));

/*
    3.3 Now let’s take a look at the situation you were preparing for. 
Your translation team needs a list of the language they are written in, 
book titles, and the number of copies sold to see if it is worth the time 
and money in translating these books. Create an index to help speed 
up searching for this information.
*/
CREATE INDEX language_title_sales_idx 
ON books (original_language, title, sales_in_millions);



/*
  3.4 Now that you have your index let’s repeat our process in tasks 1 and 2 
and compare the runtime and size with our index in place. 
*/
EXPLAIN ANALYZE  
SELECT original_language, title, sales_in_millions 
FROM books 
WHERE original_language = 'French';

/*
    SECTION 4:Clean Up
*/

/*
    4.1 Delete the multicolumn index we created above to make it so inserts into the books will run quickly.
*/
DROP INDEX language_title_sales_idx;


/*
    SECTION 5: Bulk Insert
*/

/* 
    4.2  The company you work for has bought out a competitor bookstore. You will need to load all of their orders 
into your orders table with a bulk copy. Let’s see how long this bulk insert will take. 
*/
SELECT NOW();

\COPY orders FROM 'orders_add.txt'
DELIMITER ',' CSV HEADER;

SELECT NOW();


/* 
    4.3 The company you work for has bought out a competitor bookstore. You will need to load all of their orders 
into your orders table with a bulk copy. Let’s see how long this bulk insert will take. 
*/
DROP INDEX orders_customer_id_idx;
DROP INDEX orders_book_id_idx;
DROP INDEX language_title_sales_idx;

SELECT NOW();

\COPY orders FROM 'orders_add.txt'
DELIMITER ',' CSV HEADER;


SELECT NOW();

/* 
    SECTION 5: Do you know what to do?
*/

/* 

*/