use Company_SD

-- 1
select * from Employee

-- 2
select Fname, Lname, Salary, Dno from Employee

-- 3
select Pname, Plocation, Dnum from Project

-- 4
select Fname + ' ' + Lname as 'Fullname',
(Salary * 0.10) AS 'ANNUAL COMM'
from Employee

-- 5
select SSN, Fname, Salary from Employee
where Salary > 1000

-- 6
select SSN, Fname,
(Salary * 12) as 'Annual Salary'
from Employee
where (Salary * 12) > 1000

-- 7
select Fname, Lname, Salary from Employee
where Sex = 'F'

-- 8
select Dnum, Dname from Departments
where MGRSSN = 968574

-- 9
select Pnumber, Pname, Plocation from Project
where Dnum = 10