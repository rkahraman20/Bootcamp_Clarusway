
USE SampleRetail

SELECT * FROM product.product

SELECT COUNT (*) FROM product.product

SELECT product_name FROM product.product
WHERE SUBSTRING(product_name, 1, CHARINDEX(' ', product_name)) = 'Samsung'
ORDER BY product_name ASC

SELECT COUNT (*) FROM product.product WHERE SUBSTRING(product_name, 1, 8) = 'Samsung'