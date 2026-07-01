use Company_SD;

-- 1
select d.Dnum as 'Department ID',
       d.Dname as 'Department Name',
       e.SSN as 'Manager ID',
       concat(e.Fname, ' ', e.Lname) as 'Manager Name'
from Departments d
inner join Employee e on d.MGRSSN = e.SSN;

-- 2
select d.Dname as 'Department Name',
       p.Pname as 'Project Name'
from Departments d
inner join Project p on d.Dnum = p.Dnum;

-- 3
select dep.*,
       concat(e.Fname, ' ', e.Lname) as 'Employee Name'
from Dependent dep
inner join Employee e on dep.ESSN = e.SSN;

-- 4
select Pnumber as 'Project ID',
       Pname as 'Project Name',
       Plocation as 'Location'
from Project
where City in ('Cairo', 'Alex');

-- 5
select *
from Project
where Pname like 'a%';

-- 6
select *
from Employee
where Dno = 30 and Salary between 1000 and 2000;

-- 7
select concat(e.Fname, ' ', e.Lname) as 'Employee Name'
from Employee e
inner join Works_for w on e.SSN = w.ESSn
inner join Project p on w.Pno = p.Pnumber
where e.Dno = 10 and p.Pname = 'AL Rabwah' and w.Hours >= 10;

-- 8
select concat(e.Fname, ' ', e.Lname) as 'Employee Name'
from Employee e
inner join Employee supervisor on e.Superssn = supervisor.SSN
where concat(supervisor.Fname, ' ', supervisor.Lname) = 'Kamel Mohamed';

-- 9
select concat(e.Fname, ' ', e.Lname) as 'Employee Name',
       p.Pname as 'Project Name'
from Employee e
inner join Works_for w on e.SSN = w.ESSn
inner join Project p on w.Pno = p.Pnumber
order by p.Pname;

-- 10
select p.Pnumber as 'Project Number',
       d.Dname as 'Department Name',
       e.Lname as 'Manager Last Name',
       e.Address as 'Manager Address',
       e.Bdate as 'Manager Birthdate'
from Project p
inner join Departments d on p.Dnum = d.Dnum
inner join Employee e on d.MGRSSN = e.SSN
where p.City = 'Cairo';

-- 11
select distinct e.*
from Employee e
inner join Departments d on e.SSN = d.MGRSSN;

-- 12
select e.*,
       dep.Dependent_name,
       dep.Sex as 'Dependent Sex',
       dep.Bdate as 'Dependent Birthdate'
from Employee e
left join Dependent dep on e.SSN = dep.ESSN;

-- 13
-- a
select dep.Dependent_name as 'Dependent Name',
       dep.Sex as 'Dependent Gender'
from Dependent dep
inner join Employee e on e.SSN = dep.ESSN
where dep.Sex = 'F' and e.Sex = 'F'

union

-- b
select dep.Dependent_name as 'Dependent Name',
       dep.Sex as 'Dependent Gender'
from [Dependent] dep
inner join Employee e on dep.ESSN = e.SSN
where dep.Sex = 'M' and e.Sex = 'M';