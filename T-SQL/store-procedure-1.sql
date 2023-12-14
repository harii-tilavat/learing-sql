-----------------------1. Simple stored procedure --------------------------
CREATE PROCEDURE SelectEmp
AS 
BEGIN
	SELECT * FROM Employee;
	
END

EXEC SelectEmp; 
GO

-----------------------2. parameterised SP --------------------------
CREATE PROCEDURE GreaterSalary @salary INT, @deptId INT
AS
BEGIN
	SELECT * FROM Employee WHERE Salary > @salary AND DepartmentID = @deptId;
END
GO

EXEC dbo.GreterThanSalary @salary=90000, @deptId = 2;  --------------Execute SP
GO

-----------------------3. User define function -----------------------

SELECT * FROM Employee;
GO

CREATE FUNCTION getSalaryByName(@name AS VARCHAR(50) ) RETURNS VARCHAR(100)
BEGIN
	DECLARE @sal DECIMAL(10,2);
	SELECT @sal = SALARY FROM Employee WHERE Employee.FirstName = @name;
	RETURN CONCAT(@name,' Salary is :- ', @sal);
END
GO

SELECT DBO.getSalaryByName('JOHN');

WITH TriangleCTE AS (
    SELECT 1 AS Level, '*' AS Pattern
    UNION ALL
    SELECT Level + 1, Pattern + '*' 
    FROM TriangleCTE
    WHERE Level < 5 -- Change the number based on the desired height of the triangle
)

SELECT Pattern
FROM TriangleCTE
ORDER BY Level DESC;