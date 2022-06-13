
CREATE TABLE Actions (Visitor_ID TINYINT, Adv_Type CHAR(1), [Action] VARCHAR(7));

SELECT * FROM Actions;

INSERT Actions VALUES (1, 'A', 'Left'), (2, 'A', 'Order'), (3, 'B', 'Left'),
					  (4, 'A', 'Order'), (5, 'A', 'Review'), (6, 'A', 'Left'),
					  (7, 'B', 'Left'), (8, 'B', 'Order'), (9, 'B', 'Review'),
					  (10, 'A', 'Review')

SELECT * FROM Actions

CREATE VIEW Total_Order AS
	SELECT Adv_Type, COUNT([Action]) Total_Order, [Action]
	FROM Actions
	WHERE [Action] = 'Order'
	GROUP BY Adv_Type, [Action] 

SELECT * FROM Total_Order

CREATE VIEW Total_A AS
	SELECT Adv_Type, COUNT([Action]) Total
	FROM Actions
	GROUP BY Adv_Type

SELECT * FROM Total_A

SELECT Total_Order.Adv_Type, Total_Order, Total
FROM Total_Order,Total_A
WHERE Total_Order.Adv_Type = Total_A.Adv_Type

SELECT Total_Order.Adv_Type, ROUND(CAST(Total_Order AS FLOAT)/CAST(Total AS FLOAT), 2) AS Conversion_Rate
FROM Total_Order,Total_A
WHERE Total_Order.Adv_Type = Total_A.Adv_Type