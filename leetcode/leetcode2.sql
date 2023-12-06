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
SELECT * FROM Customer;
SELECT 
	*,
	SUM(amount) OVER (ORDER BY visited_on) AS TOTAL
FROM Customer
ORDER BY visited_on;

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
End) 
As capital_gain_loss
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