--- CTA Assignment 3

--- Question 1 How many orders were shipped after the required due date
SELECT COUNT(*)
FROM CTA.dbo.orders
WHERE shipped_date > required_date;

--- Question 2 Name all customers who live in New York and provided a phone number
SELECT 
first_name,
last_name,
phone,
state
FROM CTA.dbo.customers
WHERE phone IS NOT NULL AND state = 'NY'

--- Question 3 List all staff members names (no duplicates) who had a discount greater than 5% (0.05)
SELECT DISTINCT 
CONCAT (first_name, last_name) AS Full_name
FROM CTA.dbo.orders 
LEFT JOIN CTA.dbo.order_items
ON CTA.dbo.orders.order_id = CTA.dbo.order_items.order_id
LEFT JOIN CTA.dbo.staffs
ON CTA.dbo.orders.staff_id = CTA.dbo.staffs.staff_id
WHERE discount > '0.05'

--- Question 4 How many products from each product category need to be reordered (stock < 3)? 
--- Please provide the category name, number of total products in that category, and the number of products that need to be reordered.


SELECT DISTINCT
category_name,
COUNT(products.product_id) as reorder_products


FROM CTA.dbo.products 
LEFT JOIN CTA.dbo.stocks
ON CTA.dbo.products.product_id = CTA.dbo.stocks.product_id
LEFT JOIN CTA.dbo.categories
ON CTA.dbo.products.category_id = CTA.dbo.categories.category_id

WHERE quantity < '3'
GROUP BY category_name

SELECT DISTINCT
category_name,
COUNT(products.product_id) as total_products


FROM CTA.dbo.products 
LEFT JOIN CTA.dbo.stocks
ON CTA.dbo.products.product_id = CTA.dbo.stocks.product_id
LEFT JOIN CTA.dbo.categories
ON CTA.dbo.products.category_id = CTA.dbo.categories.category_id

GROUP BY category_name

--- I was unable to figure out how to have total products and products to be reorderd in the same query
--- I made two queries to find one with all the products in the category and one with the total number of products to be reordered

--- Question 5 Rank each of the customers by number of orders. Make sure to list customer name.
SELECT
first_name,
COUNT(orders.order_id) AS Total_orders

FROM CTA.dbo.customers
LEFT JOIN CTA.dbo.orders
ON CTA.dbo.customers.customer_id = CTA.dbo.orders.customer_id

GROUP BY first_name

--- Could not figure out CONCAT function for name, after this would be figured out, you sort Total_orders by decsending


--- Question 6 List all customers who ordered from multiple stores
SELECT
first_name
FROM CTA.dbo.customers
JOIN CTA.dbo.orders
ON CTA.dbo.customers.customer_id = CTA.dbo.orders.customer_id
GROUP BY first_name
HAVING COUNT(DISTINCT orders.store_id) > '1'

--- Question 9 

DROP TABLE CTA.dbo.customers




