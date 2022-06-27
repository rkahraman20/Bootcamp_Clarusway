
USE SampleRetail

WITH
	
	T1 AS
	(SELECT DISTINCT A.product_id, B.discount, COUNT(C.order_id) OVER (PARTITION BY A.product_id, B.discount ORDER BY B.discount) order_count
	FROM product.product A, sale.order_item B, sale.orders C
	WHERE A.product_id = B.product_id AND B.order_id = C.order_id),
	
	T2 AS
	(SELECT product_id, discount, order_count, LAG(order_count) OVER(PARTITION BY product_id ORDER BY discount) pre_order_count,
		CASE
			WHEN order_count >  LAG(order_count) OVER(PARTITION BY product_id ORDER BY discount) THEN  1
			WHEN order_count <  LAG(order_count) OVER(PARTITION BY product_id ORDER BY discount) THEN -1
			WHEN order_count = 	LAG(order_count) OVER(PARTITION BY product_id ORDER BY discount) THEN  0	
			ELSE NULL
		END Comparing
	FROM T1),
	
	T3 AS
	(SELECT  product_id,
		CASE
			WHEN SUM(Comparing) OVER(PARTITION BY product_id) = 0 THEN 'Neutral'
			WHEN SUM(Comparing) OVER(PARTITION BY product_id) > 0 THEN 'Positive'
			WHEN SUM(Comparing) OVER(PARTITION BY product_id) < 0 THEN 'Negative'
			ELSE NULL
		END Comparing
	FROM  T2)
	
	SELECT DISTINCT A.product_id, (ISNULL (CONVERT (VARCHAR(20), B.Comparing), 'Insufficient Data')) Discount_Effect
	FROM product.product A LEFT JOIN T3 B ON A.product_id = B.product_id
	ORDER BY product_id