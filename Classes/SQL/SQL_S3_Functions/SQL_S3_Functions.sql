
USE SampleRetail

SELECT * FROM product.product

SELECT COUNT (product_name) FROM product.product

SELECT product_name FROM product.product
WHERE SUBSTRING(product_name, 1, CHARINDEX(' ', product_name)) = 'Samsung'
ORDER BY product_name ASC

SELECT COUNT (product_name) FROM product.product WHERE SUBSTRING(product_name, 1, 8) = 'Samsung'

SELECT * FROM sale.customer

SELECT COUNT (street) FROM sale.customer

SELECT street FROM sale.customer
WHERE
	(CAST(SUBSTRING(street, PATINDEX('%#%', street) + 1, LEN(street)) AS INT) BETWEEN 1 AND 5) AND
	(CAST(PATINDEX('%#%', street) AS INT) != 0)
ORDER BY street ASC

SELECT street FROM sale.customer
WHERE
	(CAST(RIGHT(street, LEN(street) - CHARINDEX('#', street)) AS INT) BETWEEN 1 AND 5) AND
	(CAST(CHARINDEX('#', street) AS INT) !=0)
ORDER BY street ASC

SELECT COUNT (street) FROM sale.customer
WHERE
	(CAST(SUBSTRING(street, PATINDEX('%#%', street) + 1, LEN(street)) AS INT) BETWEEN 1 AND 5) AND
	(CAST(PATINDEX('%#%', street) AS INT) != 0)

SELECT CHARINDEX('#', street) FROM sale.customer