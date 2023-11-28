IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Visits')
BEGIN
    CREATE TABLE Visits (
        visit_id INT,
        customer_id INT
    );
END

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Transactions')
BEGIN
    CREATE TABLE Transactions (
        transaction_id INT,
        visit_id INT,
        amount INT
    );
END

TRUNCATE TABLE Visits;

INSERT INTO Visits (visit_id, customer_id) VALUES (1, 23);
INSERT INTO Visits (visit_id, customer_id) VALUES (2, 9);
INSERT INTO Visits (visit_id, customer_id) VALUES (4, 30);
INSERT INTO Visits (visit_id, customer_id) VALUES (5, 54);
INSERT INTO Visits (visit_id, customer_id) VALUES (6, 96);
INSERT INTO Visits (visit_id, customer_id) VALUES (7, 54);
INSERT INTO Visits (visit_id, customer_id) VALUES (8, 54);

TRUNCATE TABLE Transactions;

INSERT INTO Transactions (transaction_id, visit_id, amount) VALUES (2, 5, 310);
INSERT INTO Transactions (transaction_id, visit_id, amount) VALUES (3, 5, 300);
INSERT INTO Transactions (transaction_id, visit_id, amount) VALUES (9, 5, 200);
INSERT INTO Transactions (transaction_id, visit_id, amount) VALUES (12, 1, 910);
INSERT INTO Transactions (transaction_id, visit_id, amount) VALUES (13, 2, 970);

SELECT * FROM Visits;
SELECT * FROM Transactions;
GO

SELECT V.customer_id,COUNT(*) AS TOTAL
FROM Visits V 
FULL JOIN Transactions T ON V.visit_id = T.visit_id
WHERE T.transaction_id IS NULL
GROUP BY V.customer_id 
ORDER BY TOTAL DESC;

GO
-- WEATHER TABLE
BEGIN
	IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Weather')
	BEGIN
		Create table Weather (id int, recordDate date, temperature int);
		Truncate table Weather;
		insert into Weather (id, recordDate, temperature) values ('1', '2015-01-01', '10')
		insert into Weather (id, recordDate, temperature) values ('2', '2015-01-02', '25')
		insert into Weather (id, recordDate, temperature) values ('3', '2015-01-03', '20')
		insert into Weather (id, recordDate, temperature) values ('4', '2015-01-04', '30')
	END
END
GO

SELECT * FROM Weather;
SELECT W2.id 
FROM Weather W1 --W1 = PREVIOUS W2 = TODAY
INNER JOIN Weather W2 ON DATEDIFF(DAY,W1.recordDate,W2.recordDate) = 1
WHERE W2.temperature > W1.temperature;

-- MACHINE TABLE

-- Check if the table exists before creating
-- Check if the table exists before creating
DROP TABLE ACTIVITY;
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Activity')
BEGIN
    -- Create the Activity table
    CREATE TABLE Activity (
        machine_id INT,
        process_id INT,
        activity_type VARCHAR(5), -- or CHAR(5)
        timestamp_type DECIMAL(10,3)
    );
END

-- Truncate the Activity table
TRUNCATE TABLE Activity;

-- Insert data into the Activity table
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp_type) VALUES (0, 0, 'start', 0.712);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp_type) VALUES (0, 0, 'end', 1.52);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp_type) VALUES (0, 1, 'start', 3.14);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp_type) VALUES (0, 1, 'end', 4.12);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp_type) VALUES (1, 0, 'start', 0.55);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp_type) VALUES (1, 0, 'end', 1.55);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp_type) VALUES (1, 1, 'start', 0.43);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp_type) VALUES (1, 1, 'end', 1.42);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp_type) VALUES (2, 0, 'start', 4.1);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp_type) VALUES (2, 0, 'end', 4.512);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp_type) VALUES (2, 1, 'start', 2.5);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp_type) VALUES (2, 1, 'end', 5);


SELECT * FROM Activity;

SELECT A1.machine_id,A1.timestamp_type AS START_TIME,A2.timestamp_type AS END_TIME,(A2.timestamp_type - A1.timestamp_type ) AS DIFF
FROM Activity A1
INNER JOIN Activity A2 ON A1.machine_id = A2.machine_id AND A1.process_id = A2.process_id 
AND A1.timestamp_type < A2.timestamp_type;

SELECT A1.machine_id,CAST(ROUND(AVG(A2.timestamp_type - A1.timestamp_type) , 3) AS decimal(10,3)) AS AVERAGE
FROM Activity A1
INNER JOIN Activity A2 ON A1.machine_id = A2.machine_id AND A1.process_id = A2.process_id 
AND A1.timestamp_type < A2.timestamp_type
GROUP BY A1.machine_id;


--------------------------- 577.Write a solution to report the name and bonus amount of each employee with a bonus less than 1000. ----------------------
-- Check if the Bonus table exists before creating
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Employee')
BEGIN
    -- Create the Employee table
    CREATE TABLE Employee (
        empId INT,
        name VARCHAR(255),
        supervisor INT,
        salary INT
    );
END

-- Check if the Bonus table exists before creating
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Bonus')
BEGIN
    -- Create the Bonus table
    CREATE TABLE Bonus (
        empId INT,
        bonus INT
    );
END

-- Truncate the Employee table
TRUNCATE TABLE Employee;

-- Truncate the Bonus table
TRUNCATE TABLE Bonus;

-- Insert data into the Employee table
INSERT INTO Employee (empId, name, supervisor, salary) VALUES (3, 'Brad', NULL, 4000);
INSERT INTO Employee (empId, name, supervisor, salary) VALUES (1, 'John', 3, 1000);
INSERT INTO Employee (empId, name, supervisor, salary) VALUES (2, 'Dan', 3, 2000);
INSERT INTO Employee (empId, name, supervisor, salary) VALUES (4, 'Thomas', 3, 4000);

-- Insert data into the Bonus table
INSERT INTO Bonus (empId, bonus) VALUES (2, 500);
INSERT INTO Bonus (empId, bonus) VALUES (4, 2000);

-------------------QUERY---------------

SELECT * FROM Employee;
SELECT * FROM Bonus;

SELECT E.NAME,B.bonus
FROM Employee E
LEFT JOIN Bonus B ON E.empId = B.empId
WHERE B.bonus < 2000 OR B.bonus IS NULL;

---------------------------------------------------------------------------------------------------

-- Check if the Students table exists before creating
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Students')
BEGIN
    -- Create the Students table
    CREATE TABLE Students (
        student_id INT,
        student_name VARCHAR(20)
    );
END

-- Check if the Subjects table exists before creating
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Subjects')
BEGIN
    -- Create the Subjects table
    CREATE TABLE Subjects (
        subject_name VARCHAR(20)
    );
END

-- Check if the Examinations table exists before creating
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Examinations')
BEGIN
    -- Create the Examinations table
    CREATE TABLE Examinations (
        student_id INT,
        subject_name VARCHAR(20)
    );
END

-- Truncate the Students table
TRUNCATE TABLE Students;

-- Truncate the Subjects table
TRUNCATE TABLE Subjects;

-- Truncate the Examinations table
TRUNCATE TABLE Examinations;

-- Insert data into the Students table
INSERT INTO Students (student_id, student_name) VALUES (1, 'Alice');
INSERT INTO Students (student_id, student_name) VALUES (2, 'Bob');
INSERT INTO Students (student_id, student_name) VALUES (13, 'John');
INSERT INTO Students (student_id, student_name) VALUES (6, 'Alex');

-- Insert data into the Subjects table
INSERT INTO Subjects (subject_name) VALUES ('Math');
INSERT INTO Subjects (subject_name) VALUES ('Physics');
INSERT INTO Subjects (subject_name) VALUES ('Programming');

-- Insert data into the Examinations table
INSERT INTO Examinations (student_id, subject_name) VALUES (1, 'Math');
INSERT INTO Examinations (student_id, subject_name) VALUES (1, 'Physics');
INSERT INTO Examinations (student_id, subject_name) VALUES (1, 'Programming');
INSERT INTO Examinations (student_id, subject_name) VALUES (2, 'Programming');
INSERT INTO Examinations (student_id, subject_name) VALUES (1, 'Physics');
INSERT INTO Examinations (student_id, subject_name) VALUES (1, 'Math');
INSERT INTO Examinations (student_id, subject_name) VALUES (13, 'Math');
INSERT INTO Examinations (student_id, subject_name) VALUES (13, 'Programming');
INSERT INTO Examinations (student_id, subject_name) VALUES (13, 'Physics');
INSERT INTO Examinations (student_id, subject_name) VALUES (2, 'Math');
INSERT INTO Examinations (student_id, subject_name) VALUES (1, 'Math');

------------------------------- Query ----------------------
SELECT * FROM Students;
SELECT * FROM Subjects;
SELECT * FROM Examinations;

SELECT 
	s.student_id,
	s.student_name,
	sub.subject_name,
	COALESCE(COUNT(e.subject_name), 0) AS attended_exams
FROM Students s
CROSS JOIN Subjects sub
LEFT JOIN Examinations e ON s.student_id = e.student_id AND sub.subject_name = e.subject_name
GROUP BY s.student_id,s.student_name,sub.subject_name
ORDER BY s.student_id,sub.subject_name;


---------------------------------Write a solution to find managers with at least five direct reports. -----------------------------------
-- Check if the Employee table exists before creating

DROP TABLE IF EXISTS Employee;
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Employee')
BEGIN
    -- Create the Employee table
    CREATE TABLE Employee (
        id INT,
        name VARCHAR(255),
        department VARCHAR(255),
        managerId INT
    );
END

-- Truncate the Employee table
TRUNCATE TABLE Employee;

-- Insert data into the Employee table
INSERT INTO Employee (id, name, department, managerId) VALUES (101, 'John', 'A', NULL);
INSERT INTO Employee (id, name, department, managerId) VALUES (102, 'Dan', 'A', 101);
INSERT INTO Employee (id, name, department, managerId) VALUES (103, 'James', 'A', 101);
INSERT INTO Employee (id, name, department, managerId) VALUES (104, 'Amy', 'A', 101);
INSERT INTO Employee (id, name, department, managerId) VALUES (105, 'Anne', 'A', 101);
INSERT INTO Employee (id, name, department, managerId) VALUES (106, 'Ron', 'B', 101);


SELECT managerId AS TOTAL FROM Employee
GROUP BY managerId
HAVING COUNT(*) >= 5;

SELECT name FROM Employee 
WHERE id IN (
	SELECT managerId AS TOTAL FROM Employee
	GROUP BY managerId
	HAVING COUNT(*) >= 5
);


-------------------------------------- Write a solution to find the confirmation rate of each user. ------------------------------------

-- Check if the Signups table exists before creating
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Signups')
BEGIN
    -- Create the Signups table
    CREATE TABLE Signups (
        user_id INT,
        time_stamp DATETIME
    );
END

-- Check if the Confirmations table exists before creating
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Confirmations')
BEGIN
    -- Create the Confirmations table
    CREATE TABLE Confirmations (
        user_id INT,
        time_stamp DATETIME,
        action VARCHAR(20)
    );
END

-- Truncate the Signups table
TRUNCATE TABLE Signups;

-- Truncate the Confirmations table
TRUNCATE TABLE Confirmations;

-- Insert data into the Signups table
INSERT INTO Signups (user_id, time_stamp) VALUES (3, '2020-03-21 10:16:13');
INSERT INTO Signups (user_id, time_stamp) VALUES (7, '2020-01-04 13:57:59');
INSERT INTO Signups (user_id, time_stamp) VALUES (2, '2020-07-29 23:09:44');
INSERT INTO Signups (user_id, time_stamp) VALUES (6, '2020-12-09 10:39:37');

-- Insert data into the Confirmations table
INSERT INTO Confirmations (user_id, time_stamp, action) VALUES (3, '2021-01-06 03:30:46', 'timeout');
INSERT INTO Confirmations (user_id, time_stamp, action) VALUES (3, '2021-07-14 14:00:00', 'timeout');
INSERT INTO Confirmations (user_id, time_stamp, action) VALUES (7, '2021-06-12 11:57:29', 'confirmed');
INSERT INTO Confirmations (user_id, time_stamp, action) VALUES (7, '2021-06-13 12:58:28', 'confirmed');
INSERT INTO Confirmations (user_id, time_stamp, action) VALUES (7, '2021-06-14 13:59:27', 'confirmed');
INSERT INTO Confirmations (user_id, time_stamp, action) VALUES (2, '2021-01-22 00:00:00', 'confirmed');
INSERT INTO Confirmations (user_id, time_stamp, action) VALUES (2, '2021-02-28 23:59:59', 'timeout');

-------------------QUERY-------------------------------
SELECT * FROM Signups;
SELECT user_id,action,count(*) FROM Confirmations
GROUP BY user_id,action
order by user_id;


SELECT * FROM Confirmations;

SELECT 
	S.user_id,
	CAST(SUM(CASE WHEN C.action = 'confirmed' THEN 1 ELSE 0 END)*1.0 / COUNT(*)  AS DECIMAL(10,2)) AS confirmation_rate 
FROM Signups S
LEFT JOIN Confirmations C ON S.user_id = C.user_id
GROUP BY S.user_id;


SELECT ISNULL(20+5,0) AS SDG;

SELECT AVG(CAST(5/2 AS DECIMAL(10,2)));

--------------------------Write a solution to find the percentage of the users registered in each contest rounded to two decimals.----------------------------------

-- Check if the Users table exists before creating
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Users')
BEGIN
    -- Create the Users table
    CREATE TABLE Users (
        user_id INT,
        user_name VARCHAR(20)
    );
END

-- Check if the Register table exists before creating
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Register')
BEGIN
    -- Create the Register table
    CREATE TABLE Register (
        contest_id INT,
        user_id INT
    );
END

-- Truncate the Users table
TRUNCATE TABLE Users;

-- Truncate the Register table
TRUNCATE TABLE Register;

-- Insert data into the Users table
INSERT INTO Users (user_id, user_name) VALUES (6, 'Alice');
INSERT INTO Users (user_id, user_name) VALUES (2, 'Bob');
INSERT INTO Users (user_id, user_name) VALUES (7, 'Alex');

-- Insert data into the Register table
INSERT INTO Register (contest_id, user_id) VALUES (215, 6);
INSERT INTO Register (contest_id, user_id) VALUES (209, 2);
INSERT INTO Register (contest_id, user_id) VALUES (208, 2);
INSERT INTO Register (contest_id, user_id) VALUES (210, 6);
INSERT INTO Register (contest_id, user_id) VALUES (208, 6);
INSERT INTO Register (contest_id, user_id) VALUES (209, 7);
INSERT INTO Register (contest_id, user_id) VALUES (209, 6);
INSERT INTO Register (contest_id, user_id) VALUES (215, 7);
INSERT INTO Register (contest_id, user_id) VALUES (208, 7);
INSERT INTO Register (contest_id, user_id) VALUES (210, 2);
INSERT INTO Register (contest_id, user_id) VALUES (207, 2);
INSERT INTO Register (contest_id, user_id) VALUES (210, 7);


---------------------------------Query. ----------------------------------
SELECT * FROM Users;
SELECT * FROM Register;

SELECT R.contest_id,U.user_id,U.user_name 
FROM Register R
INNER JOIN Users U ON U.user_id = R.user_id;


SELECT * FROM Users;
SELECT * FROM Register;

WITH TEMP_USER AS (
	SELECT R.contest_id,COUNT(*) AS PAR_USER
	FROM Register R
	--CROSS JOIN (SELECT COUNT(*) AS TOTAL FROM Users) AS TOTAL_USERS 
	GROUP BY R.contest_id
)
SELECT * 
FROM (
	SELECT T.contest_id,
	ROUND((CAST(T.PAR_USER AS FLOAT) / U.TOTAL )*100,2) AS PER
	FROM TEMP_USER T
	CROSS JOIN (SELECT COUNT(*) AS TOTAL FROM Users) AS U
) AS MAIN ORDER BY PER DESC;


SELECT CAST((CAST(1 AS float) / 3)  AS decimal(10,2) )AS P;
-----------------------------------

-- Drop table if it exists
IF OBJECT_ID('Transactions', 'U') IS NOT NULL
    DROP TABLE Transactions;

-- Create table
CREATE TABLE Transactions (
    id INT,
    country VARCHAR(4),
    state VARCHAR(10), -- Using VARCHAR to represent state
    amount INT,
    trans_date DATE
);

-- Truncate table
TRUNCATE TABLE Transactions;

-- Insert sample data

INSERT INTO Transactions (id, country, state, amount, trans_date) VALUES (121, 'US', 'approved', 1000, '2018-12-18');
INSERT INTO Transactions (id, country, state, amount, trans_date) VALUES (122, 'US', 'declined', 2000, '2018-12-19');
INSERT INTO Transactions (id, country, state, amount, trans_date) VALUES (123, 'US', 'approved', 2000, '2019-01-01');
INSERT INTO Transactions (id, country, state, amount, trans_date) VALUES (124, 'DE', 'approved', 2000, '2019-01-07');

--------------------------QUERY -----------------
SELECT * FROM Transactions;

SELECT CONCAT(DATENAME(YEAR,DATEFROMPARTS(2003,10,20)) , DATENAME( M,DATEFROMPARTS(2003,10,20))) ;
SELECT MONTH(DATEFROMPARTS(2003,10,20));

SELECT 
	month_name
	country,
	count(*) as trans_count ,
	SUM(CASE WHEN state = 'approved' THEN 1 ELSE 0 END ) AS approved_count ,
	SUM(amount) as trans_total_amount,
	SUM(CASE WHEN state = 'approved' THEN amount ELSE 0 END) AS approved_total_amount 
FROM (
	SELECT id,country,state,amount,LEFT(trans_date,7) AS month_name 
	FROM Transactions
) AS TEMP
--WHERE state = 'approved '
GROUP BY month_name,country;


---------------------------------------------Find imidiate orders ----------------------------------
-- Create table if not exists
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Delivery')
BEGIN
    CREATE TABLE Delivery (
        delivery_id INT,
        customer_id INT,
        order_date DATE,
        customer_pref_delivery_date DATE
    );
END;

-- Truncate table
TRUNCATE TABLE Delivery;

-- Insert sample data
INSERT INTO Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) VALUES (1, 1, '2019-08-01', '2019-08-02');
INSERT INTO Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) VALUES (2, 2, '2019-08-02', '2019-08-02');
INSERT INTO Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) VALUES (3, 1, '2019-08-11', '2019-08-12');
INSERT INTO Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) VALUES (4, 3, '2019-08-24', '2019-08-24');
INSERT INTO Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) VALUES (5, 3, '2019-08-21', '2019-08-22');
INSERT INTO Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) VALUES (6, 2, '2019-08-11', '2019-08-13');
INSERT INTO Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) VALUES (7, 4, '2019-08-09', '2019-08-09');


--------------------------query--------------
SELECT 
	customer_id,
	delivery_id,
	order_date,
	ROW_NUMBER() OVER (PARTITION BY delivery_id ORDER BY order_date )
FROM Delivery 
--ORDER BY customer_id,order_date;
SELECT 
	*
	--SUM(CASE WHEN order_date = customer_pref_delivery_date THEN 1 ELSE 0 END) AS TOTAL_IMMIDIATE
FROM Delivery 
ORDER BY order_date 


------------------------------Game play------------------------

-- Create table if not exists

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Activity')
BEGIN
    CREATE TABLE Activity (
        player_id INT,
        device_id INT,
        event_date DATE,
        games_played INT
    );
END;

-- Truncate table
TRUNCATE TABLE Activity;

-- Insert sample data
INSERT INTO Activity (player_id, device_id, event_date, games_played) VALUES (1, 2, '2016-03-01', 5);
INSERT INTO Activity (player_id, device_id, event_date, games_played) VALUES (1, 2, '2016-03-02', 6);
INSERT INTO Activity (player_id, device_id, event_date, games_played) VALUES (2, 3, '2017-06-25', 1);
INSERT INTO Activity (player_id, device_id, event_date, games_played) VALUES (3, 1, '2016-03-02', 0);
INSERT INTO Activity (player_id, device_id, event_date, games_played) VALUES (3, 4, '2018-07-03', 5);

------------------------ query ---------------------------

SELECT * 
FROM Activity A1 
INNER JOIN Activity A2 ON A1.;