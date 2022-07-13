ALTER PROCEDURE dbo.AddSale @employeeid INT,
                   @productid  INT,
                   @quantity   SMALLINT,
                   @saleid     UNIQUEIDENTIFIER OUTPUT
AS
SET @saleid = NEWID()
  BEGIN TRY
  IF (SELECT COUNT(*) FROM HumanResources.Employee e WHERE employeeid = @employeeid) = 0
      RAISEERROR ('EmployeeID does not exist.', 11, 1)
    
    INSERT INTO Sales.Sales
         SELECT
           @saleid,
           @productid,
           @employeeid,
           @quantity
  END TRY
  BEGIN CATCH
    INSERT INTO dbo.DB_Errors
    VALUES
  (SUSER_SNAME(),
   ERROR_NUMBER(),
   ERROR_STATE(),
   ERROR_SEVERITY(),
   ERROR_LINE(),
   ERROR_PROCEDURE(),
   ERROR_MESSAGE(),
   GETDATE());
 
   DECLARE @Message varchar(MAX) = ERROR_MESSAGE(),
        @Severity int = ERROR_SEVERITY(),
        @State smallint = ERROR_STATE()
 
   RAISEERROR (@Message, @Severity, @State)
  END CATCH
GO

SELECT * FROM master.dbo.sysmessages

sys.sp_addmessage
	@msgnum = 50001
	, @severity = 11
	, @msgtext = 'Custom Message sample'

raiseerror(50001, 11, 1) go

sys.sp_dropmessage @msgnum = 50001
