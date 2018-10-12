/* Assignment 3.sql 
  Derek Lee
   CS 31A, Winter 2018
*/
 
SHOW warnings; /* enable warnings!*/ 

/* put the database name into this command */
/* This script creates the bookstore database */

CREATE DATABASE IF NOT EXISTS bookstore;

USE bookstore;

/*Query 1: Displays rows from CUSTOMER table where customer ID between 22229 and 66669
Display customer last name, first name, ID*/

SELECT last_name, first_name, customer_id FROM customer WHERE customer_id BETWEEN 22229 AND 66669;
 
/*Query 2: Displays all employees who do not earn exactly $3400, $3000, or $6000 
and who have last name beginning with letter 'S'
Displays each employee's first name, last name, salary*/

SELECT first_name, last_name, salary FROM employee WHERE salary NOT IN (3400, 3000, 6000) AND last_name NOT LIKE 'S%';

/*Query 3: Display these columns from the ORDERS table:
order_id The order_id column
order_date The order_date column
ship_date The ship_date column
Return only the rows where the ship_date column contains a null value.*/

SELECT order_id, order_date, ship_date FROM orders WHERE ship_date IS null;


/*Query 4: Display all customers whose last name contains the letter pattern “IN.” 
Put the results in order of last name, then first name. 
Display each customer’s last name and first name*/

SELECT last_name, first_name FROM customer WHERE last_name LIKE '%IN%'
ORDER BY last_name asc;

/*Query 5: Display these columns from the PRODUCT table:
product ID 
product name 
product price
Return only the rows with a list price that’s greater than $30.00 and less than $900.00*/

SELECT product_id, product_name, list_price FROM product WHERE list_price BETWEEN 30 AND 900;

/*Query 6: 
Display these columns from the ORDERS table:
order ID
order date 
ship date
Add a WHERE clause that retrieves just the orders for March 2015.
Sorts the result set in descending order by the order date column


Three different methods: a) a range operator*/

SELECT order_date, order_id, ship_date FROM orders WHERE order_date BETWEEN '2015-02-29%' AND '2015-04-1%'
ORDER BY order_date desc;

/* b) a logical operator*/

SELECT order_date, order_id, ship_date FROM orders 
WHERE NOT order_date LIKE '2015-02-%'
AND NOT order_date LIKE '2015-04-%'
AND NOT order_date LIKE '2015-05-%'
AND NOT order_date LIKE '2015-06-%'

ORDER BY order_date desc;


/* c) a search pattern operation*/

SELECT order_date, order_id, ship_date FROM orders WHERE order_date LIKE '%2015-03%'
ORDER BY order_date desc;


/*Query 7: Uses a search pattern to find any product’s name with “E” for the second letter and “L” for the
fourth letter. 
Lists each product ID, product code, and product name. Sorts the list by product code
in descending order.*/

SELECT product_id, product_code, product_name FROM product WHERE product_name LIKE '_E_L%'
ORDER by product_code DESC;


/*Query 8: Displays product_id, category_id, vendor_id, and list_price
for all products in the category 11 or 61 and
provided by vendor 2 or vendor 3 greater than list price of $100*/

SELECT product_id, category_id, vendor_id, list_price 
FROM product 
WHERE (category_id =11 OR category_id = 61) 
AND (vendor_id = 2 OR vendor_id = 3) 
AND list_price > 100;

/*Query 9: Displays all orders that were not shipped for at least three days after the order was received*/

SELECT * FROM orders 
WHERE DATEDIFF(ship_date,order_date) >= 3;

/*Query 10: Adds row to CATEGORY table. 
Modify name of category_name column for row to “Camera” and uses the category_id column to identify the row*/

SELECT * FROM CATEGORY; /*Displays original Category table*/

INSERT INTO CATEGORY (category_id, category_name) VALUES (71, 'Video Game');

UPDATE CATEGORY
SET category_name = 'Camera' WHERE category_id = 71;

SELECT * FROM CATEGORY; /*Shows change in Category table*/

/*Query 11: Inserts row to Product Table using column list*/

SELECT 'category_id'
FROM PRODUCT
INNER JOIN category ON product.category_id = category.category_id;

INSERT INTO PRODUCT (product_id,
					category_id, 
					product_code,
                    product_name,
                    description,
					list_price,
                    discount_percent,
                    date_added,
                    vendor_id)
    
VALUES (17234, 71, "Camera640", "Canon", "Canon EOS Rebel T5 DSLR Camera", 755.99, 0, '2015-04-30 13:14:15', 2);


/*Query 12: Deletes row added in query 10. Deletes products related in the row's category*/

DELETE FROM category
WHERE category_name = 'Camera';

 
/*Query 13: Modifies card type on order ID 9 to 'American Express'*/

UPDATE orders
SET card_type = 'American Express'
WHERE order_ID = 9;

/*Query 14:  Modifies all EMPLOYEE rows with salary 6000 to 6500*/

SET SQL_SAFE_UPDATES=0;
UPDATE employee
SET salary = 6500
WHERE salary = 6000;

/*Query 15: Adds row to CUSTOMER table using column list*/

INSERT INTO customer (customer_id, 
					email_address, 
                    password,
                    first_name, 
                    last_name) 
VALUES (99999, 'rick@raven.com',"", 'Rick', 'Raven');


