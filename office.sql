CREATE DATABASE office;
USE office;
show tables;

CREATE TABLE project (
	project_id VARCHAR(10) NOT NULL PRIMARY KEY,
    project_name VARCHAR(20) NOT NULL,
    member_id VARCHAR(10)
);

CREATE TABLE department(
	dept_id VARCHAR(10) NOT NULL PRIMARY KEY,
    dept_name VARCHAR(20) NOT NULL

);
CREATE TABLE manager(
	manager_id VARCHAR(10) NOT NULL PRIMARY KEY,
    manager_name VARCHAR(50) NOT NULL,
    dept_id VARCHAR(10) NOT NULL,
    FOREIGN KEY (dept_id) REFERENCES department(dept_id)
);

CREATE TABLE employee(
	emp_id VARCHAR(10) NOT NULL PRIMARY KEY,
    emp_name VARCHAR(50) NOT NULL,
    salary INT NOT NULL,
    dept_id VARCHAR(10) NOT NULL,
    manager_id VARCHAR(10) NOT NULL
);

SHOW TABLES;

--  INSERTING VALUES 
-- Project table 
INSERT INTO project (project_id, project_name,member_id)
VALUES
	("P1","Data Migration","E1"),
    ("P1","Data Migration","E2"),
    ("P1","Data Migration","M3"),
    ("P2","ETL Tool","E1"),
    ("P2","ETL Tool","M4");
    
-- Department table
INSERT INTO department (dept_id, dept_name)
VALUES
	("D1","IT"),
    ("D2","HR"),
    ("D3","Finance"),
    ("D4","Admin");
    
-- Manager table     
INSERT INTO manager (manager_id, manager_name,dept_id)
VALUES
	("M1","Prem","D3"),
    ("M2","Shripadh","D4"),
    ("M3","Nick","D1"),
    ("M4","Cory","D1");
-- Employee table
INSERT INTO employee (emp_id, emp_name,salary, dept_id,manager_id)
VALUES	
	("E1","Rahul",15000,"D1","M1"),
    ("E2","Manoj",15000,"D1","M1"),
    ("E3","James",55000,"D2","M2"),
    ("E4","Micheal",25000,"D2","M2"),
    ("E5","Ali",20000,"D10","M3"),
    ("E6","Robin",35000,"D10","M3");


-- Performing queries;
SELECT e.emp_id,e.emp_name,e.salary,d.dept_name
FROM employee e 
INNER JOIN department d ON e.dept_id = d.dept_id;

-- Fetch details all of employee , their manager, their department, and project. 

SELECT e.emp_id,e.emp_name,m.manager_name,dept_name,p.project_name
FROM employee e
LEFT JOIN manager m ON e.manager_id = m.manager_id
LEFT JOIN department d ON d.dept_id = e.dept_id
LEFT JOIN project p ON p.member_id = e.emp_id;


-- FULL JOIN 
SELECT * 
FROM employee e 
JOIN department d ON d.dept_id = e.dept_id;

--  Sub queris 
SELECT * FROM employee WHERE salary > (SELECT AVG(salary) FROM employee)
ORDER BY emp_id;
-- WITH JOIN
SELECT *
FROM employee e
INNER JOIN (SELECT AVG(salary) avg_sal FROM employee) avg_sal_table
	on e.salary > avg_sal_table.avg_sal
ORDER BY emp_id;

-- Find the employee who earn the highest salary in each department

SELECT d.dept_name,max(e.salary)
FROM employee e 
INNER JOIN department d ON e.dept_id = d.dept_id
GROUP BY d.dept_name;

-- find department who don't have an employees
SELECT * FROM employee WHERE dept_id NOT IN(SELECT distinct d.dept_id
FROM employee e
INNER JOIN department d ON e.dept_id = d.dept_id);

-- Find the employee in each department who earn more than the average salary in each department

SELECT * FROM employee e1 where salary  > (
	SELECT AVG(salary) from employee e2 WHERE 1
);

-- VIEW CREATED
CREATE VIEW office_detail AS 
SELECT e.emp_name,d.dept_name , m.manager_name, p.project_name
FROM employee e
LEFT JOIN department d ON e.dept_id = d.dept_id
LEFT JOIN manager m ON e.manager_id = m.manager_id
LEFT JOIN project p ON p.member_id = e.emp_id;

SELECT * FROM employee WHERE SALARY > (SELECT salary FROM employee WHERE emp_name = "Ali");


SELECT * FROM employee;
SELECT * FROM department;
SELECT * FROM manager;
SELECT * FROM project;

