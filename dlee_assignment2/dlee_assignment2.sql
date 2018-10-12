/* Assignment 2.sql 
  Derek Lee
   CS 31A, Winter 2018
*/
 
SHOW warnings; /* enable warnings!*/ 

/* put the database name into this command */
/* This script creates the bookstore database */

CREATE DATABASE IF NOT EXISTS bookstore;

USE bookstore;


/* Query 0 */
SELECT user(), current_date(), version(), @@sql_mode;

/* Query 1: Display rows from CUSTOMER table whose customer ID is not equal to 77779*/
/* Display customer's last name, first name, customer ID*/

SELECT last_name, first_name, customer_id FROM CUSTOMER WHERE customer_id != 77779;


/* Query 2: Displays product name and description columns from PRODUCT table where category ID is greater than 21 */

SELECT product_name, description FROM PRODUCT WHERE category_id > 21;

/* Query 3: Display rows from CUSTOMER table where values in customer ID column is 11119 */
/* Displays customer's last name, first name, customer ID, and email address*/

SELECT last_name, first_name, customer_id, email_address FROM CUSTOMER WHERE customer_id = 11119;
 
/* Query 4: Displays item_id, item_price, discount_amount, quantity, price_total, discount_total, item_total from ORDERITEMS table */
/* Only returns rows where item_total is greater than 900 in descending order */

SELECT item_id, item_price, discount_amount, quantity, discount_amount * quantity AS discount_total, item_price * quantity AS price_total, (item_price - discount_amount) * quantity AS item_total from ORDERITEMS
WHERE ((item_price - discount_amount) * quantity) > 900
ORDER BY ((item_price - discount_amount) * quantity) DESC;

/* Query 5: Displays store ID, region ID, region name columns from STORE table */

SELECT store_id, region_id, region_name FROM STORE;

/* Query 6: Displays customer ID and email address for each customer in CUSTOMER table */

SELECT customer_id, email_address FROM CUSTOMER; 

/* Query 7: Displays customer ID from ORDERS table once for each customer who's placed an order */

SELECT DISTINCT customer_id FROM ORDERS; 

/* Query 8: Create mailing list from ADDRESS table displaying customer ID, line1, line2, city, state, and zipcode */
/* City and state is listed as one column of output with values separated by a comma */

SELECT customer_id, line1, line2, zip_code, city, state, CONCAT(city, ', ', state) AS citystate from ADDRESS;

/* Query 9: Displays product_name, list_price, discount_percent, discount_amount, discount_price from PRODUCT table */

SELECT product_name, list_price, discount_percent, list_price * 0.01 * discount_percent AS discount_amount, list_price - (list_price * 0.01 * discount_percent) AS discount_price from PRODUCT;

/* Query 10: Displays one column from CUSTOMER table named full_name joining last_name and first_name columns */

SELECT CONCAT(first_name, ' ', last_name) AS FULLNAME FROM customer;

/* Query 11: Create list of each product name stored in PRODUCT table and category ID in which each product belongs */
/* Reverse sequence of columns so category of product listed first */

SELECT category_id, product_name FROM PRODUCT 
ORDER BY category_id;

/* Query 12: Display new list price of each product as 20% more than original price */
/* Display product_name, list_price, and new list price */

SELECT  product_name, list_price, list_price + list_price * 0.20 AS new_list_price
FROM PRODUCT;
