CREATE TABLE Department(
	DepartmentID INT PRIMARY KEY,
	DepartmentName VARCHAR(50) NOT NULL
);

INSERT INTO Department (DepartmentID, DepartmentName) VALUES
(1, 'HR'),
(2, 'IT'),
(3, 'Finance'),
(4, 'Marketing'),
(5, 'Operations');

SELECT * FROM Department;
CREATE TABLE Employee(
	EmployeeID  INT PRIMARY KEY,
	FirstName VARCHAR(50) NOT NULL,
	LastName VARCHAR(50) NOT NULL,
	DepartmentID INT,
	CONSTRAINT FK_Employee_Department FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID)
);

-- Insert 10 records into Employee table

INSERT INTO Employee (EmployeeID, FirstName, LastName, DepartmentID, Salary) VALUES
(1, 'John', 'Doe', 1, 50000),       -- HR
(2, 'Jane', 'Smith', 2, 60000),     -- IT
(3, 'Mike', 'Johnson', 3, 70000),   -- Finance
(4, 'Sara', 'Brown', 2, 55000),     -- Marketing
(5, 'Chris', 'Lee', 3, 75000),
(6, 'Emily', 'Jones', 5, 52000),    -- HR
(7, 'Daniel', 'Williams', 2, 62000),-- IT
(8, 'Sophia', 'Miller', 3, 71000),  -- Finance
(9, 'Ethan', 'Davis', 2, 58000),    -- Marketing
(10, 'Olivia', 'Moore', 3, 76000);

SELECT * FROM Employee ORDER BY DepartmentID;
SELECT * FROM Department;

SELECT E.EmployeeID,e.FirstName,e.LastName,d.DepartmentName
FROM Employee e
FULL JOIN Department d
ON e.DepartmentID = d.DepartmentID
ORDER BY D.DepartmentID;


-- SUBQUERY-------- 
SELECT * FROM Employee WHERE SALARY > (SELECT Salary from Employee WHERE FirstName LIKE '%Sara%') 
AND DepartmentID = (SELECT DepartmentID FROM Employee WHERE FirstName LIKE '%Sara%');

SELECT * FROM Department;