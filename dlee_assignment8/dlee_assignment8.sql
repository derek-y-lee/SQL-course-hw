/* Assignment 8.sql 
  Derek Lee
   CS 31A, Winter 2018
*/
 
 SHOW warnings; /* enable warnings!*/ 
 
 USE bookstore;
 
/*Query 1: View named customer_address shows shipping for each customer:
Returns customer_id, email_address, last_name, first_name from Customer
From ADDRESS: ship_line1, ship_line2, ship_city, ship_state, and ship_zip

SELECT statement returns these columns 
from the customer_address view: customer_id, last_name, first_name, 
ship_city and ship_state*/


CREATE VIEW customer_address (customer_id, email_address, last_name, first_name,
ship_line1, ship_line2, ship_city, ship_state, ship_zip) AS
SELECT c.customer_id, c.email_address, c.last_name, c.first_name, 
a.line1, a.line2, a.city, a.state, a.zip_code
FROM customer c, address a 
WHERE c.customer_id = a.customer_id;

SELECT *
FROM customer_address;

/*Query 2: Updates customer table using customer_address view
by setting first line of shipping address to "1990 Westwood Blvd"
for the customer with an ID of 11119.*/

UPDATE customer_address
SET ship_line1 = '1990 Westwood Blvd'
WHERE customer_id = 11119;


/*Query 3: Create view named product_summary
Each row includes product_id, order_count 
(the number of times the product has been ordered) 
and order_total (the total sales for the product).
SELECT statement returns all columns from product_summary view*/


CREATE VIEW product_summary AS
SELECT product_id, COUNT(product_id) AS order_count, 
SUM((item_price - discount_amount)*quantity) AS order_total
FROM ORDERITEMS
GROUP BY product_id;


SELECT * FROM product_summary;

/*Query 4: Creates a view named cheap_products whose subquery 
retrieves products only where the price is
less than $50. Add a CHECK OPTION constraint.
SELECT statement returns all the columns from the cheap_products.*/

CREATE VIEW cheap_products AS
SELECT * FROM PRODUCT
WHERE list_price < 50 WITH CHECK OPTION;

SELECT * FROM cheap_products;

/*Query 5: INSERT statement that adds this row to the cheap_ products view
Product ID: 17888
Category ID: 41
product_code: book db
Product Name: Fundamental of Database Systems
List_price: 45.99
Description: Fundamental of Database Systems Elmasri
discount_percent: 20.00
date_added : 2015-06-01 11:12:59
vendor_id : 2
*/

INSERT INTO cheap_products VALUES 
(17888, 41, 'book db', 'Fundamental of Database Systems', 
 'Fundamental of Database Systems Elmasri', 45.99, 20.00, '2015-06-01 11:12:59', 2);

/*Query 6: Creates a view named contact that lists the first name 
and phone number of the contact person at each vendor but excludes vendor’s ID in the view. 
Change the contact view so that no users can accidentally perform DML operations on the view.
Write a SELECT statement that returns all the columns from the contact view.*/

CREATE VIEW Contact AS 
SELECT contact_fname, contact_lname, phone
FROM vendor WITH CHECK OPTION;

SELECT * FROM Contact;

/*Query 7: Creates a view named order_items that returns 
columns from the ORDERS, ORDERITEMS, and PRODUCT tables.
Returns from the ORDERS table: order_id, order_date, tax_amount, and ship_date.
Returns from the ORDERITEMS table: item_price, discount_amount, 
final_price (the discount amount subtracted from the item price), 
quantity, and item_total (the calculated total for the item).

View returns the product_name column from the PRODUCT Table.
SELECT statement returns all the columns from the order_items view.*/

CREATE VIEW order_items AS 
SELECT o.order_id, o.order_date, o.tax_amount, o.ship_date, oi.item_price, oi.discount_amount,
(oi.item_price - oi.discount_amount) AS final_price, oi.quantity, 
((oi.item_price - oi.discount_amount)*oi.quantity) AS item_total, p.product_name
FROM orders o
JOIN orderitems oi ON o.order_id = oi.order_id
JOIN product p ON oi.product_id = p.product_id;

SELECT * FROM order_items;

/*Query 8: Creates a view named reorder_info that lists 
the product ID and product name for each product along with 
the first name and phone number of the person to contact 
if the product needs to be reordered. 

SELECT statement returns all the columns from the reorder_info view.*/

CREATE VIEW reorder_info AS
SELECT p.product_id, p.product_name, v.contact_fname, v.phone
FROM product p
JOIN vendor v ON v.vendor_id = p.vendor_id;

SELECT * FROM reorder_info;







