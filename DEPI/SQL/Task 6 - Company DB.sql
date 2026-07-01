USE Company_SD

-- 1
DECLARE @MinSalary INT
SET @MinSalary = 1500
SELECT @MinSalary AS Min_Salary

SELECT Fname, Lname, Salary
FROM Employee
WHERE Salary >= @MinSalary;

-- 2
Declare @DeptNo INT = 30
SELECT COUNT(SSN) AS EmpCount,
	   AVG(Salary) AS AvgSalary
FROM Employee
WHERE Dno = @DeptNo;

-- 3
SELECT *
FROM Employee
WHERE Dno = 20;

SELECT @@ROWCOUNT AS RowsReturned;

-- 4
SELECT Fname, Lname, Salary,
       CASE
           WHEN Salary >= 2000 THEN 'High'
           WHEN Salary BETWEEN 1000 AND 1999 THEN 'Mid'
           ELSE 'Low'
       END AS SalaryLevel
FROM Employee;

-- 5
SELECT Fname, Lname, Dno,
       CASE
           WHEN Dno IS NULL THEN 'No Department'
           ELSE 'Has Department'
       END AS DeptStatus
FROM Employee;

-- 6
SELECT Fname, Lname, Superssn,
       IIF(Superssn IS NOT NULL, 'Yes', 'No') AS HasSupervisor
FROM Employee;

-- 7
DECLARE @DeptNum INT = 10;

IF EXISTS (SELECT 1 FROM Employee WHERE Dno = @DeptNo)
BEGIN
    SELECT *
    FROM Employee
    WHERE Dno = @DeptNo;
END
ELSE
BEGIN
    SELECT 'No employees' AS Message;
END

-- 8
DECLARE @Inc INT = 50;
DECLARE @TargetSalary INT = 2000;

WHILE EXISTS (SELECT 1 FROM Employee WHERE Salary < @TargetSalary)
BEGIN
    UPDATE Employee
    SET Salary = Salary + @Inc
    WHERE Salary < @TargetSalary;
END

SELECT Fname, Lname, Salary
FROM Employee;