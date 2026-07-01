-- Part 1
create database DEPI_Company;

use DEPI_Company;

-- Departments table
create table Departments (
    Dnum int primary key,
    Dname varchar(50) not null,
    MGRSSN int,
    MGRStartdate date
);

-- Employees table
create table Employees (
    SSN int primary key,
    Fname varchar(50) not null,
    Lname varchar(50) not null,
    Sex char(1),
    Salary decimal(10, 2),
    Superssn int,
    Dno int,
    foreign key (Dno) references Departments(Dnum),
    foreign key (Superssn) references Employees(SSN)
);

-- Dept_Locations table
create table Dept_Locations (
    Dloc varchar(50),
    Dnumber int,
    primary key (Dnumber, Dloc),
    foreign key (Dnumber) references Departments(Dnum),
);

-- Projects table
create table Projects (
    Pnumber int primary key,
    Pname varchar(50) not null,
    Plocation varchar(50),
    Dnum int,
    foreign key (Dnum) references Departments(Dnum)
);

-- Works_On table
create table Works_On (
    ESSN int,
    Pno int,
    [Hours] decimal(5, 2),
    primary key (ESSN, Pno),
    foreign key (ESSN) references Employees(SSN),
    foreign key (Pno) references Projects(Pnumber)
);

-- Dependents table
create table Dependents (
    ESSN int,
    Dependent_name varchar(50),
    Sex char(1),
    BDate date,
    primary key (ESSN, Dependent_name),
    foreign key (ESSN) references Employees(SSN)
);

-- insert into Departments
insert into Departments (Dnum, Dname, MGRSSN, MGRStartdate) 
values
    (10, 'IT', 123, '2020-01-15'),
    (20, 'Sales', 456, '2019-06-01'),
    (30, 'Research', 789, '2021-03-10');

-- insert into Employees
insert into Employees (SSN, Fname, Lname, Sex, Salary, Superssn, Dno) 
values
    (123, 'Nourhan', 'Khalifa', 'F', 15000, NULL, 10),
    (456, 'Sara', 'Mohamed', 'F', 12000, 123, 20),
    (789, 'Khaled', 'Hassan', 'M', 13000, 123, 30);

-- insert into Dept_Locations
insert into Dept_Locations (Dloc, Dnumber) 
values 
    ('New York', 1),
    ('Los Angeles', 2),
    ('Chicago', 3);

-- insert into Projects
insert into Projects (Pnumber, Pname, Plocation, Dnum) 
values
    (1, 'X', 'Cairo', 30),
    (2, 'Y', 'Alexandria', 10),
    (3, 'Z', 'Giza', 20);

-- insert into Works_On
insert into Works_On (ESSN, Pno, [Hours]) 
values
    (123, 1, 32.5),
    (789, 2, 7.5),
    (456, 3, 40.0);

-- insert into Dependents
insert into Dependents (ESSN, Dependent_name, Sex, BDate) 
values
    (123, 'Samy Kareem', 'M', '2015-05-10'),
    (456, 'Yasmin mahmoud', 'F', '2016-12-03'),
    (789, 'Amr Khaled', 'M', '2019-03-15');

-----------------------------------------------------------------------

-- Part 2 (using Company from Session)
use Company_SD

-- 1
select * from Employee;

-- 2
select Fname as 'First Name', 
       Lname as 'Last Name', 
       Salary, 
       Dno as 'Department Number'
from Employee;

-- 3
select Pname as 'Project Name', 
       Plocation as 'Location', 
       Dnum as 'Department Number'
from Project;

-- 4
select concat(Fname, ' ', Lname) as 'Full Name',
       (Salary * 12 * 0.10) as 'Annual Comm'
from Employee;

-- 5
select SSN as 'Employee ID',
       concat(Fname, ' ', Lname) as 'Employee Name'
from Employee
where Salary > 1000;

-- 6
select SSN as 'Employee ID',
       concat(Fname, ' ', Lname) as 'Employee Name'
from Employee
where (Salary * 12) > 10000;

-- 7
select concat(Fname, ' ', Lname) as 'Employee Name',
       Salary
from Employee
where Sex = 'F';

-- 8
select Dnum as 'Department ID',
       Dname as 'Department Name'
from Departments
where MGRSSN = 968574;

-- 9
select Pnumber as 'Project ID',
       Pname as 'Project Name',
       Plocation as 'Location'
from Project
where Dnum = 10;