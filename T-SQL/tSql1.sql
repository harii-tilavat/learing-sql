--------------------------------- 1. Working with variable ----------------------------------

DECLARE @name VARCHAR(20) = 'Harit';
DECLARE @job VARCHAR(20) = 'Web Developer';
DECLARE @s1 INTEGER = 80, @s2 INTEGER = 90, @s3 INTEGER = 79;
DECLARE @total INT,@percentage DECIMAL;
DECLARE @avgSalary INT;
--SET @total = @s1 + @s2 + @s3;
--SET @percentage = @total / 3;
--SELECT @total = @s1 + @s2 + @s3 , @percentage = @total / 3;
--SELECT @name AS 'Name',@job AS 'Job',@s1,@s2,@s3, @total as 'Total', @percentage as 'Percentage' ;

SET @avgSalary= (SELECT * FROM Employee);
SELECT @avgSalary;

------------------------- Display name and salary whose department id = 3 with using Begin end.-------------------
BEGIN
	DECLARE @eName VARCHAR(20),@salary DECIMAL,@deptId INT = 1;
	SELECT @eName = FirstName, @salary = Salary FROM Employee WHERE DepartmentID = @deptId;
	SELECT @eName AS 'Name' , @salary AS 'Salary';
END

SELECT * FROM Employee WHERE DepartmentID = 1;

--------------------------- Q1. Check number is greater than 5--------------------
BEGIN
	DECLARE @num INT = 10;
	IF @num > 5 
	BEGIN
		PRINT 'NUMBER IS GREATER THAN 5.';
	END
	ELSE
	BEGIN
		PRINT 'NUMBER IS LESS THAN 5.'
	END
END

--------------------------- Q2. Is avg(salary) greter than 50000 ?--------------------
BEGIN 
	DECLARE @avgSalary INT;
	SELECT @avgSalary= AVG(Salary) FROM Employee;
	
	IF @avgSalary> 50000
	BEGIN
		PRINT 'Salary is greter than 50000';
	END
	ELSE 
	BEGIN
		PRINT 'Salary is less than 50000';
	END
END

--------------------------- Q3. WHILE LOOP with salary--------------------
SELECT * FROM Employee;
BEGIN
	WHILE (SELECT MIN(SALARY) FROM Employee)  < 80000
	BEGIN
		UPDATE Employee SET Salary = Salary + 10000;
		PRINT 'SALARY UPDATED';
		IF (SELECT MIN(SALARY) FROM Employee) >= 80000
			PRINT 'MIN. GREATER THAN 80000'
			BREAK;
	END
END
SELECT * FROM Employee;

SELECT MIN(SALARY) FROM Employee;


-------------------------Q4. WHILE LOOP SIMPLE--------------------------
BEGIN
	DECLARE @num INT = 1;
	WHILE @num <= 10
	BEGIN
		PRINT @num;
		SET @num = @num + 1;
	END
END

-----------------Q5. Update the salary of each employee by increasing it by 10%. Here's an example:---------------------

BEGIN
	DECLARE @count INT = 1;
	DECLARE @total INT;
	DECLARE @id INT;
	DECLARE @salary DECIMAL;
	SELECT @total = COUNT(*) FROM Employee;
	WHILE @count <= @total
	BEGIN
		SELECT @id = Employee.EmployeeID,@salary = Employee.Salary FROM Employee;;
		SET @count = @count + 1;
	END
END
SELECT  ROW_NUMBER() OVER (ORDER BY FirstName) FROM Employee;
SELECT * FROM Employee;

------------------ Try tommorow -----------------------------------

BEGIN
	DECLARE @msg VARCHAR(MAX);
	BEGIN TRY
		PRINT 'HELLO' + CAST( 1 AS VARCHAR(10))
	END TRY
	BEGIN CATCH
	SET @msg = (SELECT ERROR_MESSAGE());
		PRINT @msg;
	END CATCH
END

-----------------Q6. WAIT FOR---------------------
SELECT GETDATE();
SELECT 'COMMAND FIRED!';
GO
BEGIN
	WAITFOR DELAY '00:00:02'
	SELECT * FROM Employee;
END
SELECT GETDATE();

SELECT LOWER(RIGHT('HARIT',1));

SELECT SUBSTRING('HARIT',LEN('HARIT')-2,3);

--SELECT *,SUBSTRING( Employee.FirstName, LEN(Employee.FirstName)-2, 3) FROM Employee ORDER BY SUBSTRING( Employee.FirstName, LEN(Employee.FirstName)-2, 3) ;
SELECT * FROM Employee WHERE SALARY > (SELECT AVG(Salary) FROM Employee);