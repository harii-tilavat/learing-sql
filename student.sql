CREATE DATABASE test;
USE test;

CREATE TABLE student(
	student_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL,
    date_of_birth DATE
);
CREATE TABLE courses(
	course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(100),
    instructor_name VARCHAR(100),
    credits INT 
);

CREATE TABLE enrollments(
	enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    FOREIGN KEY (student_id) REFERENCES student(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

-- INSERTING RECORD
INSERT INTO student (first_name, last_name, email, date_of_birth)
VALUES 
    ('John', 'Doe', 'john.doe@example.com', '1990-05-15'),
    ('Jane', 'Smith', 'jane.smith@example.com', '1992-08-21'),
    ('Michael', 'Johnson', 'michael.johnson@example.com', '1988-12-10'),
    ('Sarah', 'Brown', 'sarah.brown@example.com', '1995-04-03'),
    ('David', 'Lee', 'david.lee@example.com', '1993-06-25');
    
INSERT INTO Courses (course_name, instructor_name, credits)
VALUES 
    ('Introduction to Computer Science', 'Prof. Smith', 3),
    ('Mathematics for Engineers', 'Prof. Johnson', 4),
    ('History of Art', 'Prof. Davis', 2),
    ('English Composition', 'Prof. Williams', 3),
    ('Physics I', 'Prof. Adams', 4);
SELECT * FROM COURSES;

INSERT INTO Enrollments (student_id, course_id)
VALUES 
    (1, 1), -- John Doe enrolled in Introduction to Computer Science
    (2, 2), -- Jane Smith enrolled in Mathematics for Engineers
    (3, 3), -- Michael Johnson enrolled in History of Art
    (4, 4), -- Sarah Brown enrolled in English Composition
(5, 5); -- David Lee enrolled in Physics I

-- 1. Retrieve all information from the Students table:
SELECT * FROM student;

-- 2 Retrieve the names of students who are enrolled in a course:
SELECT s.first_name,s.last_name,c.course_name
FROM student s 
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON c.course_id = e.course_id; 

-- 3.Find out how many students are enrolled in each course:
SELECT c.course_id,c.course_name,COUNT(c.course_id) AS total
FROM courses c 
JOIN enrollments e ON c.course_id = e.course_id 
GROUP BY c.course_id,c.course_name
ORDER BY c.course_id; 

-- 4. Get the courses that a specific student (e.g., Jane Smith) is enrolled in:

SELECT s.first_name, s.last_name,c.course_name 
FROM student s 
INNER JOIN enrollments e ON s.student_id = e.student_id 
INNER JOIN courses c ON e.course_id = c.course_id
WHERE s.student_id = e.student_id
ORDER BY s.student_id;

-- 5. Find names of student that are enrolled in all course enrolled
SELECT s.first_name,c.course_name
FROM student s
LEFT JOIN enrollments e ON s.student_id = e.student_id
LEFT JOIN courses c ON e.course_id = c.course_id
ORDER BY s.student_id;

-- 6.count courses of all student that are enrolled in it. 

SELECT first_name,COUNT(first_name)
FROM student s
INNER JOIN enrollments e ON s.student_id = e.student_id
INNER JOIN courses c ON e.course_id = c.course_id
GROUP BY first_name;
