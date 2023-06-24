-- Section 1: Create Tables and Primary Keys

/* 1.1. Create restaurant and address tables */

CREATE TABLE restaurant(
    id integer primary key,
    name varchar(20), 
    description varchar(100),
    rating decimal,
    telephone char(15),
    hours varchar(350)
);

CREATE TABLE address(
    id integer primary key,
    street_number varchar(20),
    street_name varchar(20),
    city varchar(20),
    state varchar(15),
    google_map_link varchar(150)
);

/* 1.2. Validate that primary keys exist 
for restaurant and address tables */

SELECT constraint_name, column_name 
FROM information_schema.key_column_usage 
WHERE table_name = 'restaurant' 
AND 
table_name = 'address';

/* 1.3. Create table for menu categories */
CREATE TABLE category(
    id char(2) primary key, 
    name varchar(25),
    description varchar(250)
);

/* 1.4. Validate that primary keys exist for category table */
SELECT constraint_name, column_name 
FROM information_schema.key_column_usage 
WHERE table_name = 'category' ;

/* 1.5. Create table for dishes */
CREATE TABLE dish(
    id integer primary key, 
    name varchar(50),
    description varchar(250),
    hot_and_spicy boolean
);

/* 1.6. Validate that primary keys exist for category table */
SELECT constraint_name, column_name 
FROM information_schema.key_column_usage 
WHERE table_name = 'dish' ;

/* 1.7. Create table for customer reviews */
CREATE TABLE review(
    id integer primary key,
    rating decimal,
    description varchar(350),
    date date
);

/* 1.8. Validate that primary keys exist for category table */
SELECT constraint_name, column_name 
FROM information_schema.key_column_usage 
WHERE table_name = 'review' ;


/*Section 2: Create Tables and Primary Keys
Define Relationships and Foreign Keys */

/* 2.1. ONE TO ONE RELATIONSHIP
Restaurant - Address */
ALTER TABLE address 
ADD restaurant_id INTEGER UNIQUE;

ALTER TABLE address
ADD CONSTRAINT fk_restaurant_address 
FOREIGN KEY (restaurant_id) 
REFERENCES restaurant(id) ;

/* 2.2. Validate that primary keys exist for restaurant table */
SELECT constraint_name, table_name,column_name 
FROM information_schema.key_column_usage 
WHERE table_name = 'restaurant' ;

/* 2.3. ONE TO MANY RELATIONSHIP
Restaurant - Reviews */
ALTER TABLE review
ADD restaurant_id INTEGER;

ALTER TABLE review
ADD CONSTRAINT fk_review_restaurant 
FOREIGN KEY (restaurant_id)
REFERENCES restaurant(id);

/* 2.4 Validate that primary keys exist for restaurant table */
SELECT constraint_name, table_name,column_name 
FROM information_schema.key_column_usage 
WHERE table_name = 'review' ;


/*2.5  MANY TO MANY RELATIONSHIP
Category - Dish */
CREATE TABLE categories_dishes(
    category_id char(2) REFERENCES category(id),
    dish_id integer REFERENCES dish(id),
    price money,
    PRIMARY KEY (category_id, dish_id)
);

/* 2.6 Validate that primary keys exist for dish table */
SELECT constraint_name, table_name, column_name 
FROM information_schema.key_column_usage 
WHERE table_name = 'dish' OR table_name = 'category' ;


/* 
 *--------------------------------------------
 Insert values for restaurant
 *--------------------------------------------
 */
INSERT INTO restaurant VALUES (
  1,
  'Bytes of China',
  'Delectable Chinese Cuisine',
  3.9,
  '6175551212',
  'Mon - Fri 9:00 am to 9:00 pm, Weekends 10:00 am to 11:00 pm'
);

/* 
 *--------------------------------------------
 Insert values for address
 *--------------------------------------------
 */
INSERT INTO address VALUES (
  1,
  '2020',
  'Busy Street',
  'Chinatown',
  'MA',
  'http://bit.ly/BytesOfChina',
  1
);

/* 
 *--------------------------------------------
 Insert values for review
 *--------------------------------------------
 */
INSERT INTO review VALUES (
  1,
  5.0,
  'Would love to host another birthday party at Bytes of China!',
  '05-22-2020',
  1
);

INSERT INTO review VALUES (
  2,
  4.5,
  'Other than a small mix-up, I would give it a 5.0!',
  '04-01-2020',
  1
);

INSERT INTO review VALUES (
  3,
  3.9,
  'A reasonable place to eat for lunch, if you are in a rush!',
  '03-15-2020',
  1
);

/* 
 *--------------------------------------------
 Insert values for category
 *--------------------------------------------
 */
INSERT INTO category VALUES (
  'C',
  'Chicken',
  null
);

INSERT INTO category VALUES (
  'LS',
  'Luncheon Specials',
  'Served with Hot and Sour Soup or Egg Drop Soup and Fried or Steamed Rice  between 11:00 am and 3:00 pm from Monday to Friday.'
);

INSERT INTO category VALUES (
  'HS',
  'House Specials',
  null
);

/* 
 *--------------------------------------------
 Insert values for dish
 *--------------------------------------------
 */
INSERT INTO dish VALUES (
  1,
  'Chicken with Broccoli',
  'Diced chicken stir-fried with succulent broccoli florets',
  false
);

INSERT INTO dish VALUES (
  2,
  'Sweet and Sour Chicken',
  'Marinated chicken with tangy sweet and sour sauce together with pineapples and green peppers',
  false
);

INSERT INTO dish VALUES (
  3,
  'Chicken Wings',
  'Finger-licking mouth-watering entree to spice up any lunch or dinner',
  true
);

INSERT INTO dish VALUES (
  4,
  'Beef with Garlic Sauce',
  'Sliced beef steak marinated in garlic sauce for that tangy flavor',
  true
);

INSERT INTO dish VALUES (
  5,
  'Fresh Mushroom with Snow Peapods and Baby Corns',
  'Colorful entree perfect for vegetarians and mushroom lovers',
  false
);

INSERT INTO dish VALUES (
  6,
  'Sesame Chicken',
  'Crispy chunks of chicken flavored with savory sesame sauce',
  false
);

INSERT INTO dish VALUES (
  7,
  'Special Minced Chicken',
  'Marinated chicken breast sauteed with colorful vegetables topped with pine nuts and shredded lettuce.',
  false
);

INSERT INTO dish VALUES (
  8,
  'Hunan Special Half & Half',
  'Shredded beef in Peking sauce and shredded chicken in garlic sauce',
  true
);

/*
 *--------------------------------------------
 Insert valus for cross-reference table, categories_dishes
 *--------------------------------------------
 */
INSERT INTO categories_dishes VALUES (
  'C',
  1,
  6.95
);

INSERT INTO categories_dishes VALUES (
  'C',
  3,
  6.95
);

INSERT INTO categories_dishes VALUES (
  'LS',
  1,
  8.95
);

INSERT INTO categories_dishes VALUES (
  'LS',
  4,
  8.95
);

INSERT INTO categories_dishes VALUES (
  'LS',
  5,
  8.95
);

INSERT INTO categories_dishes VALUES (
  'HS',
  6,
  15.95
);

INSERT INTO categories_dishes VALUES (
  'HS',
  7,
  16.95
);

INSERT INTO categories_dishes VALUES (
  'HS',
  8,
  17.95
);

--Section 4: Make Sample Queries

/*1. Type in a query that displays 
the restaurant name, its address 
(street number and name) and telephone number. */

SELECT restaurant.name AS "Restaurant Name",
       address.street_number AS "Street Number",
       address.street_name AS "Street Name",
       restaurant.telephone AS "Telephone"
FROM
      restaurant, address ;

/* 4.2.write a query to get the best 
rating the restaurant ever received. 
Display the rating as best_rating.  */
/*a) Solution 1*/
SELECT MAX(rating) AS "best_rating" FROM review;
/*b) Solution 2*/
SELECT rating AS "best_rating" 
FROM review
ORDER BY rating DESC LIMIT 5;


/* 4.3. Write a query to display a dish name,
 its price and category sorted by the dish name.
 You should get 8 rows of results. */
SELECT  dish.name AS "dish_name",
        categories_dishes.price AS "price",
        category.name AS "category"
FROM  dish, categories_dishes, category
WHERE dish.id = categories_dishes.dish_id
AND category.id = categories_dishes.category_id
ORDER BY dish_name
LIMIT 8;


/* 4.4.  Instead of sorting the results by dish name, 
type in a new query to display the results
sorted by category name.*/
SELECT category.name AS "category",
        dish.name AS "dish_name",
        categories_dishes.price AS "price"
FROM category, dish, categories_dishes
WHERE category.id = categories_dishes.category_id
AND dish.id = categories_dishes.dish_id
ORDER BY category.name
LIMIT 8;


/* 4.5. Type a query that displays all
the spicy dishes, their prices and category. 
You should get 3 rows of results.*/
select  d.name,
        c.name,
        cd.price
FROM dish AS d , category AS c, categories_dishes AS cd
WHERE d.hot_and_spicy = 'true'
AND d.id = cd.dish_id
AND cd.category_id = c.id;


/* 4.6 Write a query that displays the dish_id
 and COUNT(dish_id) as dish_count from the 
 categories_dishes table.  */
 SELECT dish_id , COUNT(dish_id) AS "dish_count"
 FROM categories_dishes 
 GROUP BY dish_id;


 /* 4.7 Write a query that displays the dish_id
 and COUNT(dish_id) as dish_count from the 
 categories_dishes table.  */
 SELECT dish_id , COUNT(dish_id) AS "dish_count"
 FROM categories_dishes 
 GROUP BY dish_id
HAVING COUNT(dish_id) > 1;


/* 4.8 Write a query that incorporates multiple 
tables that display the dish name as dish_name 
and dish count as dish_count. */
 SELECT d.name , 
        COUNT(cd.dish_id) AS "dish_count"
 FROM dish AS d, 
      categories_dishes AS cd 
 GROUP BY d.name 
 HAVING COUNT(dish_id) > 1;

 /* 4.9  Write a query that displays 
the best rating as 
best_rating and the description too.*/
SELECT  MAX(rating) AS "best_rating",
        description,
FROM 
        review 
WHERE 
        MAX(rating) = ( SELECT
        MAX(rating) FROM review
        );