--DECLARE @i INTEGER;
--SET @i = 1;
 
--WHILE @i <= 10
--BEGIN
--   PRINT CONCAT('Pass...', @i);
--   IF @i = 9 CONTINUE;
--   SET @i = @i + 1;
--END;

DECLARE @date_start DATE;
DECLARE @date_end DATE;
DECLARE @loop_date DATE;
 
SET @date_start = '2020/11/11';
SET @date_end = '2020/12/12';
 
SET @loop_date = @date_start;
 
WHILE @loop_date <= @date_end
BEGIN
   PRINT @loop_date;
   SET @loop_date = DATEADD(DAY, 1, @loop_date);
END;
