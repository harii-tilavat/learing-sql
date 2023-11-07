-- CREATE TABLE personal(
-- 	id INT NOT NULL UNIQUE,
--     name VARCHAR(10) NOT NULL,
--     age INT NOT NULL CHECK(age >= 18),
--     phone VARCHAR(12) NOT NULL UNIQUE,
--     city VARCHAR(20) NOT NULL DEFAULT 'surat'
-- );

-- INSERT INTO personal (id, name, age, phone, city)
-- VALUES (1006, 'John', 25, '5555555343', 'New York');


CREATE TABLE City(
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    cityName VARCHAR(20) NOT NULL
);

CREATE TABLE Personal(
	id INT NOT NULL AUTO_INCREMENT ,
    name VARCHAR(20) NOT NULL,
    percentage 	INT NOT NULL,
    age INT NOT NULL,
    gender INT NOT NULL,
    city INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (city) REFERENCES City(id)
);

SELECT p.id,p.name,p.percentage,p.age,p.gender,c.id,c.cityName FROM Personal p INNER JOIN City c
ON p.city=c.id 
ORDER BY p.id;

SELECT * FROM Personal;
SELECT * from City;

-- SELECT c.cityName,count(p.city) as total FROM Personal p INNER JOIN City c
-- ON p.city = c.id 
-- WHERE p.age>0
-- GROUP BY c.cityName
-- having total > 1
-- ORDER BY c.cityName

-- select all record by city name
 
SELECT * from Personal p 
INNER JOIN City c
ON p.city=c.id
where EXISTS (select id from City where cityName LIKE '%surat%');

-- GRADE 
SELECT *,
CASE 
		WHEN percentage >=90 THEN "A"
        WHEN percentage >=80 THEN "B"
        WHEN percentage >=60 THEN "C"
        WHEN percentage < 33 THEN "FAIL"
        ELSE "FAIL"
END as Grade
FROM stud;

-- UPDATE Multiple record with CASE

UPDATE stud SET percentage=(CASE id
	WHEN 1 THEN 80
    WHEN 2 THEN 65
    WHEN 3 THEN 90
    WHEN 4 THEN 30
    WHEN 5 THEN 55
END) where id IN(1,2,3,4,5);

-- select FLOOR(5+RAND()*50) as OPERATOR;
-- SELECT SIGN(-100) as RANDOM ;

select * from stud;
ALTER TABLE stud
ADD email VARCHAR(255);

SELECT * FROM stud;

ALTER TABLE stud 
MODIFY email VARCHAR(50) 
AFTER name;

delete from stud where id=5;



