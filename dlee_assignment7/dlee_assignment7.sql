/* Assignment 7.sql 
  Derek Lee
   CS 31A, Winter 2018
*/
 
SHOW warnings; /* enable warnings!*/ 

/* put the database name into this command */

USE bookstore;

/*Query 1: Returns same result as 

SELECT DISTINCT category_name
FROM category c JOIN product p
ON c.category_id = p.category_id
ORDER BY category_name;

without using a JOIN but uses a WHERE clause and IN keyword*/

SELECT DISTINCT c.category_name 
FROM category c 
WHERE c.category_id IN (SELECT p.category_id 
    FROM product p WHERE p.category_id=c.category_id)
    ORDER BY category_name;
    
/*Query 2: Returns products with list price greater
than average list price for all products by returning product_name
and list_price columns for each product*/

SELECT product_name, list_price 
FROM product p
WHERE p.list_price > (SELECT AVG(list_price)
						FROM product pr
						WHERE pr.product_name = p.product_name);
                        
/*Query 3: Displays category_name column from Category table,
Returns one row for each category assigned to at least one product
in Product table using subquery with EXISTS operator*/

SELECT c.category_name
FROM CATEGORY c
WHERE EXISTS (SELECT *
				FROM PRODUCT p WHERE p.category_id = c.category_id);


            
/*Query 4: Displays the three columns: 
email_address, order_id, and the order total for each customer.*/

SELECT email_address, o.order_id, (SUM((oi.item_price - oi.discount_amount)* oi.quantity) + o.tax_amount + o.ship_amount) AS order_total
FROM CUSTOMER
JOIN ORDERS o ON customer.customer_id = o.customer_id
JOIN orderitems oi ON o.order_id = oi.order_id
GROUP BY order_id;

/*Query 5: Uses a subquery to return one row per customer, representing 
the customer’s oldest order (the one with the earliest date). 
Each row should include these three columns: email_address, order_id, and order_date.*/

SELECT c.email_address, o.order_id, o.order_date
FROM customer c
JOIN orders o ON c.customer_id = o.customer_id
WHERE order_date IN (SELECT MIN(order_date) AS oldest_order FROM orders);

/*Query 6: For each product, whose items were sold in more than one sales transaction, 
displays the product ID, product name, and list price.*/

SELECT product_id, product_name, list_price
FROM product 
WHERE product_id IN (SELECT product_id FROM orderitems GROUP BY product_id HAVING COUNT(*)>1);


/*Query 7: Displays the last name and first name of customers 
who have purchased an item that costs more than $300 (item_price)
using subquery*/

SELECT DISTINCT last_name, first_name
FROM customer 
JOIN orders USING (customer_id)
JOIN orderitems USING (order_id)
WHERE orderitems.order_id IN 
(SELECT order_id FROM orderitems 
	WHERE item_price > 300);

/*Query 8: Displays the last name, first name, and email address 
of the customers who made the purchase with order IDs 1, 2, and 3.*/

SELECT c.last_name, c.first_name, c.email_address
FROM CUSTOMER c
WHERE c.customer_id IN (SELECT o.customer_id 
						FROM orders o WHERE o.customer_id = c.customer_id 
                        AND o.order_id IN (1,2,3));
                        

/*Query 9: Displays the last name, first name, and email address
of customers who have purchased an item that was supplied by a 
vendor with a company name that begins with the letter H.*/

SELECT DISTINCT last_name, first_name, email_address
FROM customer c
JOIN orders o ON o.customer_id = c.customer_id
JOIN orderitems oi ON o.order_id = oi.order_id
JOIN product p ON oi.product_id = p.product_id
JOIN vendor v ON p.vendor_id = v.vendor_id
WHERE company_name IN (SELECT company_name FROM vendor WHERE company_name LIKE 'H%');

/*Query 10: For each product that has more than two items 
sold within all sales transactions, 
retrieves the product id, product name, and product price.*/

SELECT p.product_id, p.product_name, p.list_price
FROM product p
WHERE product_id IN(SELECT product_id
					FROM orderitems
                    GROUP BY product_id
                    HAVING COUNT(product_id) > 2);


/*Query 11: Determines which orders had a higher total amount due than order #7*/

SELECT o.order_id, (SUM((oi.item_price - oi.discount_amount)* oi.quantity) + o.tax_amount + o.ship_amount) AS total
FROM orders o
JOIN orderitems oi ON o.order_id = oi.order_id
GROUP BY order_id HAVING total >
(SELECT SUM((oi.item_price - oi.discount_amount)* oi.quantity) + o.tax_amount + o.ship_amount 
FROM orders o, orderitems oi WHERE o.order_id = oi.order_id AND o.order_id = 7);
				

/*Query 12: Displays the order ID, order date, and ship date 
for the order that had the longest shipping delay.*/ 

SELECT order_id, order_date, ship_date
FROM ORDERS 
WHERE ship_date - order_date = (SELECT MAX(ship_date - order_date) FROM ORDERS);


