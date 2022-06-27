
--E-COMMERCE PROJECT SOLUTION

--FIRST PART - ANALYZING THE DATA

--1. a new table called combined_table was created.

SELECT * INTO combined_table
FROM
	(SELECT
		cd.cust_id, cd.customer_name, cd.province, cd.region, cd.customer_segment,
		mf.ord_id, mf.prod_id, mf.sales, mf.discount, mf.order_quantity, mf.product_base_margin,
		od.order_date, od.order_priority,
		pd.product_category, pd.product_sub_category,
		sd.ship_id, sd.ship_mode, sd.ship_date
	FROM market_fact mf
		INNER JOIN cust_dimen cd ON mf.cust_id = cd.cust_id
		INNER JOIN orders_dimen od ON od.ord_id = mf.ord_id
		INNER JOIN prod_dimen pd ON pd.prod_id = mf.prod_id
		INNER JOIN shipping_dimen sd ON sd.Ship_id = mf.ship_id
	) A;

SELECT * FROM combined_table;

--2. the top 3 customers who have the maximum count of orders

SELECT TOP 3 cust_id, customer_name, COUNT (ord_id) AS total_order
FROM combined_table
GROUP BY cust_id, customer_name
ORDER BY total_order DESC;

--3. a new column was added to combined_table as "daystakenfordelivery" that contains the difference between order_date and ship_date.

ALTER TABLE combined_table ADD	daystakenfordelivery INT;

UPDATE combined_table SET daystakenfordelivery = DATEDIFF(Day, order_date, ship_date);

SELECT * FROM combined_table;

--4. the customer whose order took the maximum time to get delivered

SELECT	cust_id, customer_name, order_date, ship_date, daystakenfordelivery
FROM	combined_table
WHERE	daystakenfordelivery = (SELECT MAX(daystakenfordelivery) FROM combined_table);

--OR

SELECT TOP 1 cust_id, customer_name, order_date, ship_date, daystakenfordelivery
FROM combined_table
ORDER BY daystakenfordelivery DESC;

--5. the total number of unique customers in january and how many of them came back every month over the entire year in 2011

WITH T1 AS
	(SELECT cust_id
	FROM combined_table
	WHERE YEAR(order_date) = 2011 AND MONTH(order_date ) = 1)

SELECT MONTH(order_date) ord_month, COUNT(DISTINCT A.cust_id) monthly_num_of_cust
FROM  combined_table A, T1
WHERE	A.cust_id = T1.cust_id AND YEAR(order_date) = 2011
GROUP BY MONTH(order_date);

--OR

SELECT MONTH(order_date) ord_month, COUNT(DISTINCT cust_id) monthly_num_of_cust
FROM	combined_table A
WHERE EXISTS
			(SELECT cust_id
			FROM combined_table B
			WHERE YEAR(order_date) = 2011 AND MONTH (order_date) = 1 AND A.cust_id = B.cust_id
			) AND YEAR (order_date) = 2011
GROUP BY MONTH(order_date);

--6. the time elapsed between the first purchasing and the third purchasing for each user

SELECT DISTINCT
	cust_id, order_date, dense_number, first_order_date,
	DATEDIFF(DAY, first_order_date, order_date) days_elapsed
FROM
	(SELECT	cust_id, ord_id, order_date,
				MIN (order_date) OVER (PARTITION BY cust_id) first_order_date,
				DENSE_RANK() OVER (PARTITION BY cust_id ORDER BY order_date) dense_number
	FROM combined_table
	) A
WHERE dense_number = 3;
 
--7. customers who purchased both product 11 and product 14

WITH T1 AS
	(SELECT
		cust_id,
		SUM (CASE WHEN prod_id = 'prod_11' THEN order_quantity ELSE 0 END) p11,
		SUM (CASE WHEN prod_id = 'prod_14' THEN order_quantity ELSE 0 END) p14,
		SUM (Order_Quantity) TOTAL_PROD
	FROM combined_table
	GROUP BY cust_id
	HAVING
		SUM (CASE WHEN Prod_id = 'prod_11' THEN order_quantity ELSE 0 END) >= 1 AND
		SUM (CASE WHEN Prod_id = 'prod_14' THEN order_quantity ELSE 0 END) >= 1)

SELECT	cust_id, p11, p14, total_prod,
		CAST (1.0 * p11 / total_prod AS NUMERIC (3,2)) AS ratio_p11,
		CAST (1.0 * p14 / total_prod AS NUMERIC (3,2)) AS ratio_p14
FROM T1;

--SECOND PART - CUSTOMER SEGMENTATION

--1. a view that keeps visit logs of customers on a monthly basis

CREATE VIEW customer_logs AS
SELECT cust_id, YEAR(order_date) [year], MONTH(order_date) [month]
FROM	combined_table;

--2. a view that keeps the number of monthly visits by users

CREATE VIEW number_of_visits AS
SELECT	cust_id, [year], [month], COUNT(*) num_of_log
FROM	customer_logs
GROUP BY cust_id, [year], [month];

--3. "the next month of the visit" column was created as a separate column for each visit of customers.

CREATE VIEW next_visit AS 
SELECT *, LEAD(current_month, 1) OVER (PARTITION BY cust_id ORDER BY current_month) next_visit_month
FROM (SELECT *, DENSE_RANK() OVER (ORDER BY [year] , [month]) current_month FROM number_of_visits) A;

--4. the monthly time gap between two consecutive visits by each customer

CREATE VIEW time_gaps AS
SELECT *, next_visit_month - current_month AS time_gaps
FROM	next_visit;

--5. customers using average time gaps were categorized.

SELECT cust_id, avg_time_gap,
	CASE
		WHEN avg_time_gap = 1 THEN 'retained'
		WHEN avg_time_gap > 1 THEN 'irregular'
		WHEN avg_time_gap IS NULL THEN 'churn'
		ELSE 'unknown data'
	END cust_labels
FROM (SELECT cust_id, AVG(time_gaps) avg_time_gap FROM time_gaps GROUP BY cust_id) A;

--THIRD PART - MONTH-WISE RETENTION RATE

--1. the number of customers retained month-wise

SELECT DISTINCT cust_id, [year], [month], current_month, next_visit_month, time_gaps,
	COUNT (cust_id)	OVER (PARTITION BY next_visit_month) retention_month_wise
FROM time_gaps
WHERE time_gaps = 1
ORDER BY cust_id, next_visit_month;

--2. the month-wise retention rate

CREATE VIEW current_num_of_cust AS
SELECT	DISTINCT
	cust_id, [year], [month], current_month,
	COUNT (cust_id)	OVER (PARTITION BY current_month) curr_cust
FROM time_gaps;

CREATE VIEW next_num_of_cust AS
SELECT	DISTINCT
	cust_id, [year], [month], current_month, next_visit_month,
	COUNT (cust_id)	OVER (PARTITION BY current_month) next_cust
FROM time_gaps
WHERE time_gaps = 1 AND current_month > 1;

SELECT DISTINCT
		B.[year],
		B.[month],
		B.current_month,
		1.0 * B.next_cust / A.curr_cust retention_rate
FROM current_num_of_cust A LEFT JOIN next_num_of_cust B
ON		A.current_month + 1 = B.next_visit_month;