CREATE DATABASE employeeDB;
USE employeeDB;


CREATE TABLE employee_info(
	empId INTEGER PRIMARY KEY ,
	empName VARCHAR(20) NOT NULL,
	empSalary DECIMAL(10,2) NOT NULL,
	job VARCHAR(20),
	phone INTEGER UNIQUE,
	deptId INTEGER NOT NULL
);

INSERT INTO employee_info (empId,empName,empSalary,	job,phone,deptId)
VALUES
	(2,'bbb',20000,'Manager',878987452,002),
	(3,'ccc',15000,'Developer',48956854,003);


SELECT * FROM employee_info;
SELECT * FROM employee_info WHERE empId=1;

UPDATE employee_info 
SET empSalary = empSalary + 1000 ;

SELECT TOP 2 * FROM employee_info;
SELECT * FROM employee_info;

SELECT LEN('MICROSOFT');
SELECT UPPER('harit');
SELECT LOWER('hARIT');
SELECT REPLACE('MAJORSOFT','MAJOR','MICRO'); 
SELECT SUBSTRING('MICROSOFT',6,4);
SELECT * FROM employee_info;

SELECT GETDATE();
SELECT SYSDATETIME();
SELECT CURRENT_TIMESTAMP;
SELECT SYSDATETIMEOFFSET();

SELECT DATENAME(YEAR,CURRENT_TIMESTAMP);
SELECT DATENAME(MONTH,CURRENT_TIMESTAMP);
SELECT DATENAME(DAY,CURRENT_TIMESTAMP);

SELECT DATEDIFF(YEAR,'20 OCT 2003', CURRENT_TIMESTAMP);
SELECT DATEDIFF(MONTH,'20 OCT 2003', CURRENT_TIMESTAMP);
SELECT DATEDIFF(DAY,'20 OCT 2003', CURRENT_TIMESTAMP);

SELECT DATENAME(YEAR,DATEADD(YEAR,1,'20 OCT 2003'));

SELECT TOP(1) * FROM employee_info ORDER BY empId DESC;

------------------------- To copy table from another table. ----------------------------

SELECT *
INTO test_info
FROM employee_info;

---------------Add column ------------------

ALTER TABLE test_info 
ADD gender VARCHAR(1);

SELECT * FROM test_info;

---------------Modify column ------------------
ALTER TABLE test_info
ALTER COLUMN gender VARCHAR(1);

ALTER TABLE test_info
ADD PRIMARY KEY (empId);

ALTER TABLE test_info
ADD project_completed INTEGER NOT NULL DEFAULT 0;

ALTER TABLE test_info 
ADD projectId INTEGER ;

