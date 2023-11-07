CREATE DATABASE worker;
USE worker;

-- ------------------------Worker table -----------------------
CREATE TABLE Worker(
	WORKER_ID INT NOT NULL PRIMARY KEY,
    FIRST_NAME VARCHAR(20),
	LAST_NAME VARCHAR(20),
    SALART INT(25),
    JOINING_DATE DATETIME,
    DEPARTMENT VARCHAR(25)
); 

INSERT INTO Worker 
	(WORKER_ID, FIRST_NAME, LAST_NAME, SALARY, JOINING_DATE, DEPARTMENT) VALUES
		(001, 'Monika', 'Arora', 100000, '21-02-20 09.00.00', 'HR'),
		(002, 'Niharika', 'Verma', 80000, '21-06-11 09.00.00', 'Admin'),
		(003, 'Vishal', 'Singhal', 300000, '21-02-20 09.00.00', 'HR'),
		(004, 'Amitabh', 'Singh', 500000, '21-02-20 09.00.00', 'Admin'),
		(005, 'Vivek', 'Bhati', 500000, '21-06-11 09.00.00', 'Admin'),
		(006, 'Vipul', 'Diwan', 200000, '21-06-11 09.00.00', 'Account'),
		(007, 'Satish', 'Kumar', 75000, '21-01-20 09.00.00', 'Account'),
		(008, 'Geetika', 'Chauhan', 90000, '21-04-11 09.00.00', 'Admin');
        
-- ------------------------Bonus table -----------------------

CREATE TABLE Bonus(
	WORKER_REF_ID INT ,
    BONUS_AMOUNT INT,
    BONUS_DATE DATETIME,
    FOREIGN KEY (WORKER_REF_ID) REFERENCES Worker(WORKER_ID)
);

INSERT INTO Bonus 
	(WORKER_REF_ID, BONUS_AMOUNT, BONUS_DATE) VALUES
		(001, 5000, '23-02-20'),
		(002, 3000, '23-06-11'),
		(003, 4000, '23-02-20'),
		(001, 4500, '23-02-20'),
		(002, 3500, '23-06-11');

-- ------------------------Title table -----------------------
CREATE TABLE Title(
	WORKER_REF_ID INT,
    WORKER_TITLE VARCHAR(50),
    AFFECTED_FROM DATETIME,
    FOREIGN KEY (WORKER_REF_ID) REFERENCES Worker(WORKER_ID)
);

INSERT INTO Title 
	(WORKER_REF_ID, WORKER_TITLE, AFFECTED_FROM) VALUES
 (001, 'Manager', '2023-02-20 00:00:00'),
 (002, 'Executive', '2023-06-11 00:00:00'),
 (008, 'Executive', '2023-06-11 00:00:00'),
 (005, 'Manager', '2023-06-11 00:00:00'),
 (004, 'Asst. Manager', '2023-06-11 00:00:00'),
 (007, 'Executive', '2023-06-11 00:00:00'),
 (006, 'Lead', '2023-06-11 00:00:00'),
 (003, 'Lead', '2023-06-11 00:00:00');
 
 SELECT * FROM worker;
 SELECT * FROM title;
 SELECT * FROM bonus;
 
 --  -------------------------------Performing all queries ----------------------------
 
 -- Q-1. Write an SQL query to fetch “FIRST_NAME” from the Worker table using the alias name <WORKER_NAME>.
 SELECT FIRST_NAME AS WORKER_NAME FROM Worker;
 
 -- Q-2. Write an SQL query to fetch “FIRST_NAME” from the Worker table in upper case.
 SELECT UPPER(FIRST_NAME)FROM Worker;
 
 --  Q-3. Write an SQL query to fetch unique values of DEPARTMENT from the Worker table.
 SELECT DISTINCT DEPARTMENT FROM Worker;
 
-- Q-4. Write an SQL query to print the first three characters of  FIRST_NAME from the Worker table.
SELECT SUBSTRING(FIRST_NAME,1,3) FROM Worker;

-- Q-5. Write an SQL query to find the position of the alphabet (‘a’) in the first name column ‘Amitabh’ from the Worker table.
SELECT INSTR(FIRST_NAME, BINARY'') from Worker where FIRST_NAME = 'Amitabh';

-- Q-6. Write an SQL query to print the FIRST_NAME from the Worker table after removing white spaces from the right side.
SELECT RTRIM(FIRST_NAME) from Worker;

-- Q-7. Write an SQL query to print the DEPARTMENT from the Worker table after removing white spaces from the left side.
SELECT RTRIM(DEPARTMENT) FROM Worker;

-- Q-8. Write an SQL query that fetches the unique values of DEPARTMENT from the Worker table and prints its length.
SELECT DISTINCT DEPARTMENT,length(DEPARTMENT) FROM Worker;

-- Q-9. Write an SQL query to print the FIRST_NAME from the Worker table after replacing ‘a’ with ‘A’.
SELECT REPLACE(FIRST_NAME,"a","A") FROM Worker;

-- Q-10. Write an SQL query to print the FIRST_NAME and LAST_NAME from the Worker table into a single column COMPLETE_NAME. A space char should separate them.
SELECT CONCAT(FIRST_NAME," ",LAST_NAME) AS FULL_NAME FROM Worker;

-- Q-11. Write an SQL query to print all Worker details from the Worker table order by FIRST_NAME Ascending.
SELECT * FROM Worker ORDER BY FIRST_NAME ASC;

-- Q-12. Write an SQL query to print all Worker details from the Worker table order by FIRST_NAME Ascending and DEPARTMENT Descending.
SELECT * FROM Worker ORDER BY FIRST_NAME DESC,DEPARTMENT DESC;

-- Q-13. Write an SQL query to print details for Workers with the first names “Vipul” and “Satish” from the Worker table.
SELECT * FROM Worker WHERE FIRST_NAME IN("Vipul","Satish");

-- Q-14. Write an SQL query to print details of workers excluding first names, “Vipul” and “Satish” from the Worker table.
SELECT * FROM Worker WHERE FIRST_NAME NOT IN("Vipul","Satish");

-- Q-15. Write an SQL query to print details of Workers with DEPARTMENT name as “Admin”.
SELECT * FROM Worker where DEPARTMENT LIKE "Admin%";

-- Q-16. Write an SQL query to print details of the Workers whose FIRST_NAME contains ‘a’.
SELECT * FROM Worker where FIRST_NAME LIKE '%a%';

-- Q-17. Write an SQL query to print details of the Workers whose FIRST_NAME ends with ‘a’.
SELECT * FROM Worker WHERE FIRST_NAME LIKE '%a';

-- Q-18. Write an SQL query to print details of the Workers whose FIRST_NAME ends with ‘h’ and contains six alphabets.
SELECT * FROM Worker WHERE FIRST_NAME LIKE '_____h';

-- Q-19. Write an SQL query to print details of the Workers whose SALARY lies between 100000 and 500000.
SELECT * FROM Worker WHERE SALARY BETWEEN 100000 AND 500000;

-- Q-20. Write an SQL query to print details of the Workers who joined in Feb 2021.
SELECT * FROM Worker WHERE YEAR(JOINING_DATE) = 2021 AND MONTH(JOINING_DATE) = 2;

-- Q-21. Write an SQL query to fetch the count of employees working in the department ‘Admin’.
SELECT DEPARTMENT,COUNT(*) FROM Worker WHERE DEPARTMENT LIKE "Admin" GROUP BY DEPARTMENT ;

-- Q-22. Write an SQL query to fetch worker names with salaries >= 50000 and <= 100000.
SELECT CONCAT(FIRST_NAME," ",LAST_NAME) AS WORKER_NAME,SALARY FROM Worker WHERE SALARY BETWEEN 50000 AND 100000;

-- Q-23. Write an SQL query to fetch the number of workers for each department in descending order.
SELECT DEPARTMENT,COUNT(WORKER_ID) AS TOTAL FROM Worker GROUP BY DEPARTMENT ORDER BY TOTAL;

-- Q-24. Write an SQL query to print details of the Workers who are also Managers.
SELECT * FROM Worker W INNER JOIN Title T
ON W.WORKER_ID=T.WORKER_REF_ID WHERE WORKER_TITLE LIKE "Manager";

-- Q-25. Write an SQL query to fetch duplicate records having matching data in some fields of a table.
SELECT WORKER_TITLE, AFFECTED_FROM, COUNT(*)
FROM Title
GROUP BY WORKER_TITLE, AFFECTED_FROM
HAVING COUNT(*) > 1;

-- Q-26. Write an SQL query to show only odd rows from a table.
SELECT * FROM Worker WHERE MOD(WORKER_ID,2) = 1;

-- Q-27. Write an SQL query to show only even rows from a table.
SELECT * FROM Worker WHERE MOD(WORKER_ID,2) = 0;

-- Q-28. Write an SQL query to clone a new table from another table.
SELECT * INTO WorkerClone FROM Worker;

-- There are 3 queries are pending. 