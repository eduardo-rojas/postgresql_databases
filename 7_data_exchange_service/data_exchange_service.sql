/* 
    Data Exchange Service
*/

/* 
    SECTION 1: Who's Here?
*/

/* 
    1.1 The database has just one superuser. Write a query that allows you to determine the name of that role.
*/
SELECT rolname 
FROM pg_roles
WHERE rolsuper;

/* 
    1.2 What are the names of the other users in the database? 
What permissions do these roles have (e.g. rolcreaterole, rolcanlogin, rolcreatedb, etc.)?
*/
SELECT * FROM pg_catalog.pg_roles;


/* 
    1.3 Check the name of the role you’re currently using. Is this role the superuser?
*/
SELECT current_user;

/* 
    SECTION 2: Adding a Publisher
*/

/* 
    2.1 Create a login role named abc_open_data without superuser permissions
*/
CREATE ROLE abc_open_data WITH NOSUPERUSER LOGIN;

/* 
    2.2 Create a login role named abc_open_data without superuser permissions
*/
CREATE ROLE publishers WITH ROLE abc_open_data;


/* 
    SECTION 3: Granting a Publisher Access to Analytics
*/

/* 
    3.1 There’s a schema in the database named analytics. 
    All publishers should have access to this schema. 
    Grant USAGE on this schema to publishers
*/

GRANT USAGE ON SCHEMA analytics TO publishers;

/* 
    3.2 Write the query that grants publishers the ability 
    to SELECT on all existing tables in analytics.
*/
--SELECT * FROM information_schema.tables;

GRANT SELECT ON ALL TABLES IN SCHEMA analytics TO publishers;

/*
    3.3 Query the information schema table table_privileges 
to check whether abc_open_data has SELECT on analytics.downloads
*/
SELECT grantor, grantee, table_schema, table_name, privilege_type 
FROM information_schema.table_privileges
WHERE  grantee = 'publishers';

/*
    3.4 Let’s confirm that abc_open_data has the ability to 
SELECT on analytics.downloads through inheritance from publishers.
*/
SET ROLE abc_open_data;

SELECT * FROM analytics.downloads 
LIMIT 10;

/*
    SECTION 4: Granting a Publisher Access to Dataset Listings
*/

/*
    4.1 There is a table named directory.datasets in the database 
with the following schema. SELECT from this table to see a few sample rows.
*/
SELECT  * FROM directory.datasets LIMIT 5;

/* 
    4.2 Grant USAGE on directory to publishers. 
 */
GRANT USAGE ON SCHEMA directory TO publishers;

/* 
    4.3 Let’s write a statement to GRANT SELECT on all columns 
in this table (except data_checksum) to publishers.
*/
GRANT SELECT (id, create_date, hosting_path, publisher, src_size) 
ON directory.datasets TO publishers;

/* 
    4.4 Let’s mimic what might happen if a publisher tries to query the dataset directory for all dataset names and paths.
*/
SET ROLE abc_open_data;
/*The next query fails because permisson to view 'data_checksum' was not granted
SELECT id, publisher, hosting_path, data_checksum FROM directory.datasets;
*/
--Correct Query:
SELECT id, publisher, hosting_path FROM directory.datasets;
SET ROLE ccuser;

/*
    SECTION 5: Adding Row Level Security on Downloads Data
*/

/*
    5.1 Let’s implement row level security on analytics.downloads.
*/
CREATE POLICY publisher_analytics ON analytics.downloads 
FOR SELECT TO publishers USING ( publisher=current_user )

CREATE POLICY publisher_analytics ON analytics.downloads 
FOR SELECT TO publishers USING ( publisher = current_user);

ALTER TABLE analytics.downloads 
ENABLE ROW LEVEL SECURITY;

/* 
    5.2 Write a query to SELECT the first few rows of this table. 
Now SET your role to abc_open_data and re-run the same query,
are the results the same?
*/
SET ROLE abc_open_data;
SELECT * FROM analytics.downloads ;