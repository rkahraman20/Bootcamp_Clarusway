
CREATE FUNCTION factorial (@num int)
RETURNS INT AS
BEGIN
	DECLARE @j INT = 1, @fact INT = 1
	WHILE (@j <= @num)
	BEGIN
		SET @fact = @fact * @j
		SET @j +=1
	END
    RETURN @fact
END

SELECT [dbo].[factorial] (5) AS factorial