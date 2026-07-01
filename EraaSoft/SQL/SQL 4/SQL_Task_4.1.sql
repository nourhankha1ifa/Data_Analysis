use Company_SD;

-- 1
select 
	dep.Dnum, dep.Dname, dep.MGRSSN, 
	e.Fname, e.Lname 
from Departments dep
join Employee e on e.SSN = dep.MGRSSN;

-- 2
select dep.Dname,p.Pname from Departments dep
join Project p on p.Dnum = dep.Dnum;

-- 3
select 
	dpn.ESSN, dpn.Dependent_name, 
	dpn.Sex, dpn.Sex,
	e.Fname, e.Lname
from "Dependent" dpn
join Employee e on e.SSN = dpn.ESSN;

-- 4
select Pnumber, Pname, Plocation from Project
where City in ('Cairo', 'Alex');

-- 5
select * from Project
where Pname like 'a%';

-- 6
select Fname, Lname, Salary from Employee
where Dno = 30 and Salary between 1000 and 2000;

-- 7
select 
	distinct e.Fname, e.Lname, e.Salary, 
	w.Hours, dep.Dnum, p.Plocation
from Employee e
join Works_for w on w.ESSn = e.SSN
join Departments dep on dep.Dnum = e.Dno
join Project p on p.Dnum = dep.Dnum
where dep.Dnum = 10 and w.Hours >= 10 
and p.Pname = 'AL Rabwah';

-- 8
SELECT 
	e.Fname+' '+e.Lname AS Employee,
	sup.Fname+' '+sup.Lname AS Supervisor
FROM Employee sup
JOIN Employee e ON e.Superssn = sup.SSN
WHERE sup.Fname = 'Kamel' AND sup.Lname = 'Mohamed';

-- 9
select e.Fname, e.Lname, p.Pname from Employee e
join Project p on p.Dnum = e.Dno
order by p.Pname;

-- 10
select 
	p.City, p.Pname , dep.Dname, 
	e.Lname, e.Address, e.Bdate
from Project p
join Departments dep on dep.Dnum = p.Dnum
join Employee e on e.SSN = dep.MGRSSN
where p.City = 'Cairo';

-- 11
select * from Employee e
join Departments dep on dep.MGRSSN = e.SSN;

-- 12
select * from Employee e
join [Dependent] dpn on dpn.ESSN = e.SSN;

-- 13
insert into Employee(Dno,SSN,Superssn,Salary)
values (30,102672,112233,3000);

-- 14
insert into Employee(Dno,SSN)
values (30,102660);

-- 15
update Employee
set Salary = Salary * 1.20
where SSN in (102672, 102660);

select SSN, Salary
from Employee;
