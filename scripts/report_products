/*
====================================================================================
Customer Report
====================================================================================
Purpose:
	- This report consolidates key product metrics and behaviours

Highlights:
	1. Gathers essential fields such as product names, category, subcategpry and transaction details.
		2. Segments products into categories (Low perfomers, Mid Range, High Performers) and age groups.
	3. Aggregates customer-level metrics:
		- total orders
		- total sales
		- total customers
		- total quantity purchased
		- total products
		- lifespan (in months)
	4. Calculates valuable KPIs
		- recency (months since last purchased)
		- average order revenue
		- average monthly revenue
===================================================================================
*/
-- ================================================================================
-- Create Report: report_products
-- ================================================================================
IF OBJECT_ID('gold.report_products', 'V') IS NOT NULL

	DROP VIEW gold.report_products;

GO

CREATE VIEW gold.report_products AS
WITH base_query AS
(
SELECT
	p.product_key,
	p.product_name,
	p.category,
	p.subcategory,
	p.product_cost,
	s.order_number,
	s.customer_key,
	s.order_date, 
	s.sales_amount,
	s.quantity
FROM gold.fact_sales s
LEFT JOIN gold.dim_products p
ON s.product_key = p.product_key
WHERE order_date IS NOT NULL
),
product_aggregations AS 
(
SELECT
	product_key,
	product_name,
	category,
	subcategory,
	product_cost,
	COUNT(DISTINCT order_number) AS total_orders,
	COUNT(DISTINCT customer_key) AS total_customers,
	MAX(order_date) AS last_sale_date,
	DATEDIFF(MONTH,MIN(order_date), MAX(order_date)) AS lifespan, 
	SUM(sales_amount) AS total_sales,
	SUM(quantity) AS total_quantity,
	ROUND(AVG(CAST(sales_amount AS FLOAT) / NULLIF(quantity,0)),1) AS avg_selling_price
	FROM base_query
	GROUP BY product_key, product_name,
	category,
	subcategory,
	product_cost
)
SELECT
	product_key,
	product_name,
	category,
	subcategory,
	product_cost,
	total_orders,
	total_customers,
	last_sale_date,
	DATEDIFF(MONTH, last_sale_date, GETDATE()) AS recency_in_months,
	lifespan,
	total_sales,
	total_quantity,
	CASE
		WHEN total_sales > 50000 THEN 'High-Performers'
		WHEN total_sales >= 10000 THEN 'Mid-Range'
		ELSE 'Low-Performers'
	END AS product_segment,
	CASE
		WHEN total_orders = 0 THEN 0
		ELSE total_sales / total_orders
	END AS avg_order_revenue,
		CASE
		WHEN lifespan = 0 THEN total_sales
		ELSE total_sales / lifespan
	END AS avg_monthly_revenue
FROM product_aggregations;
