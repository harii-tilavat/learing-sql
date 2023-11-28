SELECT * FROM Employee;
SELECT * FROM Department;

BEGIN
SELECT * FROM Employee;
END


SELECT REPLACE(10505,0,'');
SELECT ROUND(100.55,2,10);

SELECT CAST(ROUND(103.5667545456456,2)AS DECIMAL(38,2));
--SELECT MAX(SALARY) FROM Employee;

SELECT * FROM (
	SELECT  *,ROW_NUMBER() OVER (ORDER BY EmployeeID) AS ROW_NUM FROM Employee
) AS TEMP WHERE ROW_NUM = 5;


select * from (SELECT H.hacker_id,h.name,COUNT(c.challenge_id) as cnt
FROM Challenges C
INNER JOIN Hackers H ON C.hacker_id = H.hacker_id
group by h.name,H.hacker_id)as t order by t.cnt desc