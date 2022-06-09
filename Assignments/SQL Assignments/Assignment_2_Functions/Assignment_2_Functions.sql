
CREATE VIEW customer_product AS
SELECT DISTINCT D.customer_id, D.first_name, D.last_name
FROM product.product A, sale.order_item B, sale.orders C, sale.customer D
WHERE
	A.product_id = B.product_id AND
	B.order_id = C.order_id AND
	C.customer_id = D.customer_id AND
	A.product_name = '2TB Red 5400 rpm SATA III 3.5 Internal NAS HDD'

CREATE VIEW FIRST AS
SELECT DISTINCT D.customer_id, D.first_name, D.last_name, CAST('Yes' AS VARCHAR(10)) AS first_product
FROM product.product A, sale.order_item B, sale.orders C, sale.customer D
WHERE
	A.product_id = B.product_id AND
	B.order_id = C.order_id AND
	C.customer_id = D.customer_id AND
	A.product_name = 'Polk Audio - 50 W Woofer - Black'

CREATE VIEW SECOND AS
SELECT DISTINCT D.customer_id, D.first_name, D.last_name, CAST('Yes' AS VARCHAR(10)) AS second_product
FROM product.product A, sale.order_item B, sale.orders C, sale.customer D
WHERE
	A.product_id = B.product_id AND
	B.order_id = C.order_id AND
	C.customer_id = D.customer_id AND
	A.product_name = 'SB-2000 12 500W Subwoofer (Piano Gloss Black)'

CREATE VIEW THIRD AS
SELECT DISTINCT D.customer_id, D.first_name, D.last_name, CAST('Yes' AS VARCHAR(10)) AS third_product
FROM product.product A, sale.order_item B, sale.orders C, sale.customer D
WHERE
	A.product_id = B.product_id AND
	B.order_id = C.order_id AND
	C.customer_id = D.customer_id AND
	A.product_name = 'Virtually Invisible 891 In-Wall Speakers (Pair)'

SELECT A.customer_id, A.first_name, A.last_name,
	ISNULL (B.first_product,'No') AS first_product,
	ISNULL (C.second_product,'No') AS second_product,
	ISNULL (D.third_product,'No') AS third_product
FROM customer_product A
	LEFT JOIN FIRST B ON A.customer_id = B.customer_id
	LEFT JOIN SECOND C ON A.customer_id = C.customer_id
	LEFT JOIN THIRD D ON A.customer_id = D.customer_id