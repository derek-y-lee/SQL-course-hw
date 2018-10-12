/* Derek Lee 
CS 31 Assignment 5
dlee_assignment5.sql*/

SHOW warnings; /* enable warnings!*/ 

USE bookstore;

/*Query 1:Returns category_name, product_name, and list_price for the joined table*/

SELECT category_name, product_name, list_price
FROM CATEGORY
INNER JOIN product ON category.category_id = product.category_id
ORDER BY category_name, product_name ASC;

/*Query 2: Returns 1 row of information for customer with email: allan.sherwood@yahoo.com
and returns rest of customer information?
Can't figure this one out. Nested SELECT statements??*/

SELECT first_name, last_name, line1, city, state, zip_code
FROM customer
JOIN address ON customer.customer_id = address.customer_id;


SELECT first_name, last_name, line1, city, state, zip_code
FROM customer
JOIN address ON customer.customer_id = address.customer_id
WHERE email_address LIKE 'allan.sherwood@yahoo.com'
LIMIT 1;


/*Query 3: Returns customer information with the shipping address as the only address*/

SELECT first_name, last_name, line1, city, state, zip_code
FROM customer 
JOIN address ON customer.customer_id = address.customer_id
WHERE shipping_address_id = billing_address_id;


/*Query 4: Joins the CUSTOMER, ORDERS, ORDERITEMS, and PRODUCT tables.
Returns: last_name, first_name, order_date, product_name, item_price, and quantity*/

SELECT last_name, first_name, order_date, product_name, list_price, quantity
FROM customer AS c
INNER JOIN orders ON c.customer_id = orders.customer_id
INNER JOIN orderitems ON orders.order_id = orderitems.order_id
INNER JOIN product ON orderitems.product_id = product.product_id
ORDER BY last_name, order_date ASC;

/*Query 5: Returns product_name and list_price columns from the product table.
Returns one row for each product that has the same list price as another product.
Sorts results by product_name*/

SELECT DISTINCT p.product_name, p.list_price 
FROM product 
INNER JOIN product AS p
ON (product.list_price = p.list_price)
ORDER BY product_name ASC;

/*Query 6: Selects product_id, product_name, list_price, 
vendor's first name and last name and category name for all products
and sorts results by product ID*/

SELECT product_id, company_name, list_price, product_name, category_name
FROM product
JOIN orderitems USING (product_id)
JOIN vendor USING (vendor_id)
JOIN category USING (category_id)
ORDER BY product_id ASC;

/*Query 7: Displays product ID, product name, and list price for product
in the category whose category name is Computer.
Sorts results by product ID*/

SELECT product_id, product_name, list_price 
FROM product
JOIN category USING (category_id)
WHERE category_name = 'Computer'
ORDER BY product_id ASC;

/*Query 8: For each line item of sales transaction
displays order ID, date of order, name of product sold, quantity sold, amount charged*/

ALTER TABLE orders
ADD COLUMN total FLOAT;

SET SQL_SAFE_UPDATES = 0;

UPDATE orders
JOIN orderitems USING (order_id)
JOIN product USING (product_id)
SET total = ((orderitems.quantity*orderitems.item_price) + orders.ship_amount + orders.tax_amount);

SELECT order_id, order_date, product_name, quantity, total
FROM orders
JOIN orderitems USING (order_id)
JOIN product USING (product_id);

/*Query 9: Determines which orders have not shipped and customer who placed order.
Sorts results by date order was placed.
Displays first name, last name, order ID, order date, and ship date*/

SELECT first_name, last_name, order_id, order_date, Ship_date 
FROM customer
JOIN orders ON customer.customer_id = orders.customer_id
WHERE Ship_date IS NULL
ORDER BY order_date DESC; 

/*Query 10: Displays last name and first name of customers who have purchased a product
that costs more than $1500*/

SELECT first_name, last_name 
FROM customer
JOIN orders ON customer.customer_id=orders.customer_id 
JOIN orderitems ON orders.order_id = orderitems.order_id 
JOIN product ON orderitems.product_id = product.product_id
WHERE list_price > 1500;

/*Query 11: Determines which products Christine Brown has purchased
using customer name NOT customer ID.*/

SELECT product_name
FROM product 
JOIN orderitems USING (product_id)
JOIN orders USING (order_id) 
JOIN customer USING (customer_id)
WHERE first_name = 'Christine' AND last_name = 'Brown';

  

