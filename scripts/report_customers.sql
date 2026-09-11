/*
====================================================================================
Customers Report
====================================================================================
Purpose:
	- This report consolidates key customer metrics and behaviours

Highlights:
	1. Gathers essential fields such as names, ages, and transaction details.
		2. Segments customers into categories (Vips, Regular, New) and age groups.
	3. Aggregates customer-level metrics:
		- total orders
		- total sales
		- total quantity purchased
		- total products
		- lifespan (in months)
	4. Calculates valuable KPIs
		- recency (months since last order)
		- average order value
		- average monthly spend
===================================================================================
*/
-- ================================================================================
-- Create Report: report_customers
-- ================================================================================
IF OBJECT_ID('gold.report_customers', 'V') IS NOT NULL
	DROP VIEW gold.report_customers;
GO

CREATE VIEW gold.report_customers AS 

WITH customer_details AS 
(
	SELECT 
		s.order_number,
		CONCAT(c.firstname,' ',c.lastname) AS full_name,
		c.customer_key,
		c.customer_number,
		DATEDIFF(YEAR,c.birthdate, GETDATE()) AS age,
		s.product_key,
		s.order_date,
		s.quantity,
		s.sales_amount
	FROM gold.fact_sales s
	LEFT JOIN gold.dim_customers c
	ON S.customer_key = c.customer_key
	WHERE order_date IS NOT NULL
),
 customer_agggregation AS 
(
SELECT 
	COUNT(DISTINCT order_number) AS total_orders,
	full_name,
	customer_key,
	customer_number,
	age,
	COUNT(DISTINCT product_key) AS total_product,
	MIN(order_date) AS first_order,
	MAX(order_date) AS last_order,
	DATEDIFF(MONTH, MIN(order_date), MAX(order_date)) lifespan,
	SUM(quantity) AS total_quantity,
	SUM(sales_amount) AS total_sales
FROM customer_details
GROUP BY full_name, customer_key, customer_number, age
)
SELECT
	total_orders,
	full_name,
	customer_key,
	customer_number,
	age,
	CASE 
		WHEN age < 20 THEN 'Under 20'
		WHEN age BETWEEN 20 AND 29 THEN '20-29'
		WHEN age BETWEEN 30 AND 39 THEN '30-39'
		WHEN age BETWEEN 40 AND 49 THEN '40-49'
		ELSE 'Above 50'
	END AS age_group,
	total_product,
	last_order,
	DATEDIFF(MONTH,last_order, GETDATE()) recency, 
	lifespan,
	total_quantity,
	total_sales,
	CASE
		WHEN lifespan >= 12 AND total_sales > 5000 THEN 'VIP'
		WHEN lifespan >= 12 AND total_sales <= 5000 THEN 'Regular'
		ELSE 'New'
	END AS customer_segment,
	CASE
		WHEN total_sales = 0 THEN 0
		ELSE total_sales / total_orders
	END AS avg_order_value,
	CASE
		WHEN lifespan = 0 THEN total_sales
		ELSE total_sales / lifespan
	END AS avg_monthly_spend
FROM customer_agggregation;
