------------------------  SQL QUERY MEDIUM ------------------------------
DROP DATABASE IF EXISTS leetcode_medium;
CREATE DATABASE leetcode_medium;
USE leetcode_medium;

-----------------------------------------------------Q. 1164. Product Price at a Given Date --------------------------

-- Drop table if it exists
IF OBJECT_ID('Products', 'U') IS NOT NULL
    DROP TABLE Products;

-- Create table
CREATE TABLE Products (
    product_id INT,
    new_price INT,
    change_date DATE
);

-- Truncate table
TRUNCATE TABLE Products;

-- Insert data
INSERT INTO Products (product_id, new_price, change_date) VALUES (1, 20, '2019-08-14');
INSERT INTO Products (product_id, new_price, change_date) VALUES (2, 50, '2019-08-14');
INSERT INTO Products (product_id, new_price, change_date) VALUES (1, 30, '2019-08-15');
INSERT INTO Products (product_id, new_price, change_date) VALUES (1, 35, '2019-08-16');
INSERT INTO Products (product_id, new_price, change_date) VALUES (2, 65, '2019-08-17');
INSERT INTO Products (product_id, new_price, change_date) VALUES (3, 20, '2019-08-18');

------------------ Query.

SELECT * FROM Products;

SELECT 
	*,
	CASE
		WHEN change_date <= '2019-08-16' THEN new_price ELSE 10
	END AS TEMP,
	CASE
		WHEN change_date <= '2019-08-16' THEN DENSE_RANK() OVER (PARTITION BY product_id ORDER BY change_date DESC)
		ELSE 10
	END AS TEMP2
	
FROM Products 


--WHERE change_date = '2019-08-16';
SELECT * FROM Products;
SELECT 
	P.product_id,
	CASE 
		WHEN change_date <= '2019-08-16' THEN new_price ELSE 10
	END AS price 
FROM Products P
INNER JOIN (
	SELECT product_id,MIN(DATE) AS DATE_JOIN
	FROM (	
		SELECT 
			product_id,
			MAX(change_date) AS DATE
		FROM Products
		WHERE change_date <= '2019-08-16'
		GROUP BY product_id

		UNION

		SELECT 
			product_id,
			MAX(change_date)
		FROM Products
		WHERE change_date > '2019-08-16'
		GROUP BY product_id
	) AS TEMP
	GROUP BY product_id
) T ON P.change_date = T.DATE_JOIN AND P.product_id = T.product_id



-------------------------------------- 1174. Immediate Food Delivery II- ---------------------------------------------

-- Drop table if it exists
IF OBJECT_ID('Delivery', 'U') IS NOT NULL
    DROP TABLE Delivery;

-- Create table
CREATE TABLE Delivery (
    delivery_id INT,
    customer_id INT,
    order_date DATE,
    customer_pref_delivery_date DATE
);

-- Truncate table
TRUNCATE TABLE Delivery;

-- Insert data
INSERT INTO Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) VALUES (1, 1, '2019-08-01', '2019-08-02');
INSERT INTO Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) VALUES (2, 2, '2019-08-02', '2019-08-02');
INSERT INTO Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) VALUES (3, 1, '2019-08-11', '2019-08-12');
INSERT INTO Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) VALUES (4, 3, '2019-08-24', '2019-08-24');
INSERT INTO Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) VALUES (5, 3, '2019-08-21', '2019-08-22');
INSERT INTO Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) VALUES (6, 2, '2019-08-11', '2019-08-13');
INSERT INTO Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) VALUES (7, 4, '2019-08-09', '2019-08-09');

------------------------ Query 
SELECT ROUND((CAST( (
	SELECT COUNT(*) AS total_immediate 
	FROM (
		SELECT 
			*,
			DENSE_RANK() OVER (PARTITION BY customer_id ORDER BY order_date) as rank_num
		FROM Delivery
	) AS TEMP
	WHERE rank_num = 1 AND order_date = customer_pref_delivery_date
	) AS FLOAT)/ (
		SELECT COUNT(DISTINCT customer_id) FROM Delivery
	)) * 100,2) AS  immediate_percentage ;

-------------------------------------- 1204. Last Person to Fit in the Bus ---------------------------------------------

-- Drop table if it exists
IF OBJECT_ID('Queue', 'U') IS NOT NULL
    DROP TABLE Queue;

-- Create table
CREATE TABLE Queue (
    person_id INT,
    person_name VARCHAR(30),
    weight INT,
    turn INT
);

-- Truncate table
TRUNCATE TABLE Queue;

-- Insert data
INSERT INTO Queue (person_id, person_name, weight, turn) VALUES (5, 'Alice', 250, 1);
INSERT INTO Queue (person_id, person_name, weight, turn) VALUES (4, 'Bob', 175, 5);
INSERT INTO Queue (person_id, person_name, weight, turn) VALUES (3, 'Alex', 350, 2);
INSERT INTO Queue (person_id, person_name, weight, turn) VALUES (6, 'John Cena', 400, 3);
INSERT INTO Queue (person_id, person_name, weight, turn) VALUES (1, 'Winston', 500, 6);
INSERT INTO Queue (person_id, person_name, weight, turn) VALUES (2, 'Marie', 200, 4);

------------------------QUERY

SELECT TOP 1 person_name 
FROM (
	SELECT *,SUM(weight) OVER (ORDER BY turn) as total
	FROM Queue Q1	
) as TEMP
WHERE total <= 1000
ORDER BY turn DESC

SELECT * FROM Queue;
-----------------------Another solution -------------------------
SELECT person_name
FROM Queue WHERE turn  = (
	SELECT MAX(turn) as turn
	FROM (
		SELECT Q1.turn,SUM(Q2.weight) as total_wight
		FROM Queue Q1 
		 JOIN Queue Q2 ON Q1.turn >= Q2.turn
		GROUP BY Q1.turn
		HAVING SUM(Q2.weight) <= 1000
	) AS TEMP
);

-------------------------------------- 1321. Restaurant Growth ---------------------------------------------
IF OBJECT_ID('Customer', 'U') IS NOT NULL
    DROP TABLE Customer;

CREATE TABLE Customer (
    customer_id INT,
    name VARCHAR(20),
    visited_on DATE,
    amount INT
);

TRUNCATE TABLE Customer;

INSERT INTO Customer (customer_id, name, visited_on, amount) VALUES (1, 'Jhon', '2019-01-01', 100);
INSERT INTO Customer (customer_id, name, visited_on, amount) VALUES (2, 'Daniel', '2019-01-02', 110);
INSERT INTO Customer (customer_id, name, visited_on, amount) VALUES (3, 'Jade', '2019-01-03', 120);
INSERT INTO Customer (customer_id, name, visited_on, amount) VALUES (4, 'Khaled', '2019-01-04', 130);
INSERT INTO Customer (customer_id, name, visited_on, amount) VALUES (5, 'Winston', '2019-01-05', 110);
INSERT INTO Customer (customer_id, name, visited_on, amount) VALUES (6, 'Elvis', '2019-01-06', 140);
INSERT INTO Customer (customer_id, name, visited_on, amount) VALUES (7, 'Anna', '2019-01-07', 150);
INSERT INTO Customer (customer_id, name, visited_on, amount) VALUES (8, 'Maria', '2019-01-08', 80);
INSERT INTO Customer (customer_id, name, visited_on, amount) VALUES (9, 'Jaze', '2019-01-09', 110);
INSERT INTO Customer (customer_id, name, visited_on, amount) VALUES (10, 'Jhon', '2019-01-10', 130);
INSERT INTO Customer (customer_id, name, visited_on, amount) VALUES (11, 'Jade', '2019-01-10', 150);

------------ Query

select c1.visited_on
    ,sum(c2.amount) amount
    ,ROUND(sum(c2.amount+0.00)/7, 2) average_amount
from (select distinct visited_on from customer) c1
inner join customer c2 on c2.visited_on <= c1.visited_on 
    and c2.visited_on >  dateadd(day, -7, c1.visited_on)
group by c1.visited_on
having count(distinct c2.visited_on) = 7
order by c1.visited_on

SELECT c1.visited_on,COUNT(*),SUM(C2.amount) AS amount, ROUND(CAST(SUM(C2.amount) AS FLOAT) / 7,2) AS average_amount 
FROM (SELECT DISTINCT visited_on FROM Customer) AS C1
INNER JOIN Customer C2 ON C2.visited_on <= C1.visited_on AND C2.visited_on > DATEADD(DAY,-7,C1.visited_on)
GROUP BY C1.visited_on
HAVING COUNT(DISTINCT C2.visited_on) = 7
ORDER BY C1.visited_on
--------------------------------------1393. Capital Gain/Loss ---------------------------------------------

IF OBJECT_ID('Stocks', 'U') IS NOT NULL
    DROP TABLE Stocks;

CREATE TABLE Stocks (
    stock_name VARCHAR(15),
    operation VARCHAR(4) CHECK (operation IN ('Sell', 'Buy')),
    operation_day INT,
    price INT
);

TRUNCATE TABLE Stocks;

INSERT INTO Stocks (stock_name, operation, operation_day, price) VALUES ('Leetcode', 'Buy', 1, 1000);
INSERT INTO Stocks (stock_name, operation, operation_day, price) VALUES ('Corona Masks', 'Buy', 2, 10);
INSERT INTO Stocks (stock_name, operation, operation_day, price) VALUES ('Leetcode', 'Sell', 5, 9000);
INSERT INTO Stocks (stock_name, operation, operation_day, price) VALUES ('Handbags', 'Buy', 17, 30000);
INSERT INTO Stocks (stock_name, operation, operation_day, price) VALUES ('Corona Masks', 'Sell', 3, 1010);
INSERT INTO Stocks (stock_name, operation, operation_day, price) VALUES ('Corona Masks', 'Buy', 4, 1000);
INSERT INTO Stocks (stock_name, operation, operation_day, price) VALUES ('Corona Masks', 'Sell', 5, 500);
INSERT INTO Stocks (stock_name, operation, operation_day, price) VALUES ('Corona Masks', 'Buy', 6, 1000);
INSERT INTO Stocks (stock_name, operation, operation_day, price) VALUES ('Handbags', 'Sell', 29, 7000);
INSERT INTO Stocks (stock_name, operation, operation_day, price) VALUES ('Corona Masks', 'Sell', 10, 10000);

------------------QUERY
SELECT 
	stock_name,
	SUM(CASE WHEN operation = 'Sell' THEN TOTAL ELSE 0 END) -
	SUM(CASE WHEN operation = 'Buy' THEN TOTAL ELSE 0 END) capital_gain_loss 
FROM (
	SELECT stock_name,operation,SUM(price) AS TOTAL
	FROM Stocks
	GROUP BY stock_name,operation
) AS TEMP
GROUP BY stock_name
ORDER BY stock_name
----------------ANOTHER
SELECT stock_name,
	SUM(
	Case
		When operation='Buy' then -price
		When operation='Sell' then price
	End
) As capital_gain_loss
FROM Stocks
Group By stock_name

--------------------------------------1907. Count Salary Categories---------------------------------------------

IF OBJECT_ID('Accounts', 'U') IS NOT NULL
    DROP TABLE Accounts;

CREATE TABLE Accounts (
    account_id INT,
    income INT
);

TRUNCATE TABLE Accounts;

INSERT INTO Accounts (account_id, income) VALUES (3, 108939);
INSERT INTO Accounts (account_id, income) VALUES (2, 12747);
INSERT INTO Accounts (account_id, income) VALUES (8, 87709);
INSERT INTO Accounts (account_id, income) VALUES (6, 91796);

--------------QUERY
SELECT 'Low Salary' AS category,income FROM Accounts WHERE income < 20000;
SELECT 'Average Salary' AS category,income FROM Accounts WHERE income >= 20;
SELECT 'High Salary' AS category,income FROM Accounts WHERE income > 50000;

SELECT 'Low Salary' as category, sum(CASE WHEN income < 20000 THEN 1 ELSE 0 END) AS accounts_count FROM Accounts
union
SELECT 'Average Salary' as category, sum(CASE WHEN income BETWEEN 20000 AND 50000 THEN 1 ELSE 0 END) AS accounts_count FROM Accounts
union
SELECT 'High Salary' as category, sum(CASE WHEN income > 50000 THEN 1 ELSE 0 END) AS accounts_count FROM Accounts


--------------------------------------ANY. EMPLOYEE AND DEPARTMENT---------------------------------------------

IF OBJECT_ID('Employee', 'U') IS NOT NULL
    DROP TABLE Employee;

IF OBJECT_ID('Department', 'U') IS NOT NULL
    DROP TABLE Department;

-- Create Employee table
CREATE TABLE Employee (
    id INT,
    name VARCHAR(255),
    salary INT,
    departmentId INT
);

-- Truncate Employee table
TRUNCATE TABLE Employee;

-- Insert data into Employee table
INSERT INTO Employee (id, name, salary, departmentId) VALUES (1, 'Joe', 85000, 1);
INSERT INTO Employee (id, name, salary, departmentId) VALUES (2, 'Henry', 80000, 2);
INSERT INTO Employee (id, name, salary, departmentId) VALUES (3, 'Sam', 60000, 2);
INSERT INTO Employee (id, name, salary, departmentId) VALUES (4, 'Max', 90000, 1);
INSERT INTO Employee (id, name, salary, departmentId) VALUES (5, 'Janet', 69000, 1);
INSERT INTO Employee (id, name, salary, departmentId) VALUES (6, 'Randy', 85000, 1);
INSERT INTO Employee (id, name, salary, departmentId) VALUES (7, 'Will', 70000, 1);

-- Create Department table
CREATE TABLE Department (
    id INT,
    name VARCHAR(255)
);

-- Truncate Department table
TRUNCATE TABLE Department;

-- Insert data into Department table
INSERT INTO Department (id, name) VALUES (1, 'IT');
INSERT INTO Department (id, name) VALUES (2, 'Sales');

-----------------QUERY
EXEC [GetEmpByDept] 2

SELECT * 
FROM Employee E
INNER JOIN Department D ON E.departmentId = D.id
WHERE D.name = 'IT'
;

sp_helptext spUpdateSalaryByDept 'IT',10


UPDATE Employee
SET salary = 10000
FROM Employee E 
INNER JOIN Department D ON E.departmentId = D.id
WHERE D.name = 'IT'


------------------------
BEGIN
	DECLARE @i INT  = 1
	WHILE @i <= 5
	BEGIN
		SELECT * FROM Employee WHERE id = @i;
		SET @i = @i + 1
	END
END

SELECT * 
INTO backupTable
FROM Employee
WHERE 1=0;


CREATE TRIGGER tr_backupEmployee
ON Employee
AFTER DELETE
AS
BEGIN
	INSERT INTO backupTable (id,name,salary,departmentId,date_deleted)
	SELECT  id,name,salary,departmentId, GETDATE()
	FROM deleted
END

SELECT * FROM Employee;
DELETE FROM Employee WHERE id = 1
SELECT * FROM Employee;
SELECT * FROM backupTable;



--------------------------------Understanding INDEX. -----------------------------
CREATE TABLE EmployeeWithoutIndex (
    EmployeeID INT PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    DepartmentID INT
);

SELECT * FROM EmployeeWithoutIndex;
INSERT INTO EmployeeWithoutIndex (EmployeeID, FirstName, LastName, DepartmentID)
SELECT TOP 99999
    ROW_NUMBER() OVER (ORDER BY (SELECT NULL)),
    'FirstName' + CAST(ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS NVARCHAR(5)),
    'LastName' + CAST(ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS NVARCHAR(5)),
    ROUND(RAND() * 10, 0)
FROM master.dbo.spt_values a, master.dbo.spt_values b;
SELECT * FROM master.dbo.spt_values;

TRUNCATE TABLE EmployeeWithoutIndex;
SELECT * FROM EmployeeWithoutIndex WHERE EmployeeID = 1;

SELECT * FROM EmployeeWithoutIndex


-------------------------------------- Dynamic query ----------------------
DECLARE @query VARCHAR(100)
DECLARE @columnList VARCHAR(100) = 'id, name, salary, departmentId'	
SELECT @query = CONCAT('SELECT ',@columnList ,' FROM Employee') 

EXEC (@query)
EXEC GetListOfFieldName 

SELECT * FROM Customer
SELECT 
	*,
	SUM(amount) OVER (ORDER BY visited_on)
--	STRING_AGG(name,',') OVER (ORDER BY name)
FROM Customer

SELECT * FROM Customer

---------------------------UPDATE AMOUNT IN INCREMENT ORDER BY 100 -------------------------------
DECLARE @firstNumber INT ;
DECLARE @lastNumber INT ;
DECLARE @amount INT = 0;
WITH T AS (
	SELECT *,ROW_NUMBER() OVER (ORDER BY customer_id DESC) as LAST,ROW_NUMBER() OVER (ORDER BY customer_id) AS FIRST FROM Customer
)
SELECT TOP 1 @firstNumber =  FIRST, @lastNumber =  LAST
FROM T 
BEGIN
	WHILE @firstNumber <= @lastNumber
	BEGIN
		SET @amount = @amount + 100
		UPDATE Customer 
		SET amount = @amount
		WHERE customer_id = @firstNumber
		SET @firstNumber = @firstNumber + 1
	END
END

SELECT 
	*,
	SUM(amount) OVER (ORDER BY customer_id )
FROM Customer

DECLARE @EmployeeID INT = 1;
DECLARE @NewSalary INT;

WHILE @EmployeeID <= 1000
BEGIN
    SET @NewSalary = @EmployeeID * 100; -- Adjust the increment as needed

    UPDATE Customer
    SET amount = @NewSalary
    WHERE customer_id = @EmployeeID;

    SET @EmployeeID = @EmployeeID + 1;
END;

SELECT * FROM Customer

SELECT NULLIF(2,2)
SELECT DATEADD(MONTH,1,'2003-10-20')

----------------------------CURSOR example -------------------

DECLARE 
    @product_name VARCHAR(MAX), 
    @list_price   DECIMAL;

DECLARE cursor_product CURSOR
FOR SELECT 
        name,salary
    FROM 
        Employee;

OPEN cursor_product;

FETCH NEXT FROM cursor_product INTO 
    @product_name, 
    @list_price;

WHILE @@FETCH_STATUS = 0
    BEGIN
        PRINT @product_name + CAST(@list_price AS varchar);
        FETCH NEXT FROM cursor_product INTO 
            @product_name, 
            @list_price;
    END;

CLOSE cursor_product;

DEALLOCATE cursor_product;

--------------------------------------- TRY CATCH -------------------------------
CREATE PROC usp_divide(
    @a decimal,
    @b decimal,
    @c decimal output
) AS
BEGIN
    BEGIN TRY
        SET @c = @a / @b;
    END TRY
    BEGIN CATCH
        SELECT  
            ERROR_NUMBER() AS ErrorNumber  
            ,ERROR_SEVERITY() AS ErrorSeverity  
            ,ERROR_STATE() AS ErrorState  
            ,ERROR_PROCEDURE() AS ErrorProcedure  
            ,ERROR_LINE() AS ErrorLine  
            ,ERROR_MESSAGE() AS ErrorMessage;  
    END CATCH
END;
GO

DECLARE @r decimal;
EXEC usp_divide 10, 0, @r output;
PRINT @r;