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
    1.2
What are the names of the other users in the database? 
What permissions do these roles have (e.g. rolcreaterole, rolcanlogin, rolcreatedb, etc.)?
*/
SELECT * FROM pg_catalog.pg_roles;