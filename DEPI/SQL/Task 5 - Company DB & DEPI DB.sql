-- Company_SD
USE Company_SD;

-- 1
SELECT p.Pname, SUM(w.Hours) AS Total_Hours
FROM Project p
JOIN Works_for w ON p.Pnumber = w.Pno
GROUP BY p.Pname;

-- 2
SELECT d.*
FROM Departments d
WHERE d.Dnum = (SELECT Dno
                   FROM Employee
                   WHERE SSN = (SELECT MIN(SSN) FROM Employee WHERE Dno IS NOT NULL));

-- 3
SELECT d.Dname,
       MAX(e.Salary) AS Max_Salary,
       MIN(e.Salary) AS Min_Salary,
       AVG(e.Salary) AS Avg_Salary
FROM Departments d
JOIN Employee e ON d.Dnum = e.Dno
GROUP BY d.Dname;

-- 4
SELECT e.Lname
FROM Employee e
JOIN Departments d ON e.SSN = d.MGRSSN
WHERE e.SSN NOT IN (SELECT Essn FROM Dependent );

-- 5
SELECT d.Dnum, d.Dname, COUNT(e.SSN) AS Emp_Count
FROM Departments d
JOIN Employee e ON d.Dnum = e.Dno
GROUP BY d.Dnum, d.Dname
HAVING AVG(e.Salary) < (SELECT AVG(Salary) FROM Employee);

-- 6
SELECT d.Dname, e.Lname, e.Fname, p.Pname
FROM Employee e
JOIN Works_for w ON e.SSN = w.Essn
JOIN Project p ON w.Pno = p.Pnumber
JOIN Departments d ON e.Dno = d.Dnum
ORDER BY d.Dname, e.Lname, e.Fname;

-- 7
SELECT DISTINCT Salary
FROM Employee
WHERE Salary IN (SELECT TOP 2 Salary
                 FROM Employee
                 ORDER BY Salary DESC)
ORDER BY Salary DESC;

-- 8
SELECT E.Fname + ' ' + E.Lname AS Full_Name ,  D.Dependent_name
FROM Employee E, Dependent D
WHERE E.SSN = D.ESSN 
AND D.Dependent_name LIKE '%' + E.Fname + '%';

-- 9
UPDATE Employee
SET Salary = Salary * 1.3
WHERE SSN IN (SELECT w.Essn
              FROM Works_for w
              JOIN Project p ON w.Pno = p.Pnumber
              WHERE p.Pname = 'Al Rabwah');

-- 10
SELECT SSN, Fname + ' ' + Lname AS Full_Name
FROM Employee e
WHERE EXISTS (SELECT 1
              FROM Dependent  d
              WHERE d.Essn = e.SSN);

---------------------------------------------------
-- DEPI DB
USE DEPI;

-- 1
SELECT *
FROM (SELECT *,
           DENSE_RANK() OVER (PARTITION BY Dept_ID ORDER BY Salary DESC) AS rnk
    FROM Instructor
    WHERE Salary IS NOT NULL) x
WHERE rnk <= 2;

-- 2
SELECT *
FROM (SELECT *,
           ROW_NUMBER() OVER (PARTITION BY Dept_ID ORDER BY NEWID()) AS rn
    FROM Student) x
WHERE rn = 1;