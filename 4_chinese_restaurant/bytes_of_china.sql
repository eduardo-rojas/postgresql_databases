-- Section 1: Create Tables and Primary Keys
-- -- Create restaurant and address tables
CREATE TABLE restaurant(
    id integer primary key,
    name varchar(100), 
    description varchar(350),
    hours varchar(350),
    telephone char(10),
    ratings decimal

);

CREATE TABLE address(
    id integer primary key,
    street_number varchar(20),
    street_name varchar(20),
    city varchar(20),
    state varchar(15),
    google_maps varchar(150)
);

-- -- Validate that primary keys exist for restaurant and address tables
SELECT constraint_name, column_name 
FROM information_schema.key_column_usage 
WHERE table_name = 'restaurant' 
AND 
table_name = 'address';

-- --Create table for menu categories
CREATE TABLE category(
    id char(2) primary key, 
    name varchar(25),
    description varchar(250)
);
-- -- Validate that primary keys exist for category table
SELECT constraint_name, column_name 
FROM information_schema.key_column_usage 
WHERE table_name = 'category' ;

-- --Create table for dishes
CREATE TABLE dish(
    id integer primary key, 
    name varchar(30),
    price money,
    description varchar(250),
    hot_and_spicy boolean
);

-- -- Validate that primary keys exist for category table
SELECT constraint_name, column_name 
FROM information_schema.key_column_usage 
WHERE table_name = 'dish' ;

-- --Create table for customer reviews
CREATE TABLE review(
    id integer primary key,
    customer_review varchar(350),
    rating decimal,
    date date
);

-- -- Validate that primary keys exist for category table
SELECT constraint_name, column_name 
FROM information_schema.key_column_usage 
WHERE table_name = 'review' ;


-- Section 2: Create Tables and Primary Keys
-- -- Define Relationships and Foreign Keys