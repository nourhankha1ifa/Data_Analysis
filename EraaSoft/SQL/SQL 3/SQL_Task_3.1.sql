-- 1
create database SchoolDB

-- 2
use SchoolDB

-- 3
create table Students
(
StudentID int Primary Key,
FirstName varchar(50),
LastName varchar(50),
Age int,
Email varchar(100)
)

-- 4
create table Courses
(
CourseID int Primary Key,
CourseName varchar(100),
Credits int 
)

-- 5
create table Enrollments
(
EnrollmentID int Primary Key,
StudentID INT,
CourseID INT,
Foreign Key (StudentID) references Students(StudentID),
Foreign Key (CourseID) references Courses(CourseID),
EnrollmentDate date
)

-- 6
alter table Students
add [Address] varchar(255)

-- 7
insert into Students
values
(1, 'John', 'Doe', 20, 'john.doe@example.com', '123 Main St'),
(2, 'Jane', 'Smith', 22, 'jane.smith@example.com', '456 Maple Ave'),
(3, 'Ahmed', 'Ali', 19, 'ahmed.ali@example.com', '789 Elm St'),
(4, 'Sara', 'Connor', 21, 'sara.connor@example.com', '321 Oak St')

-- 8
insert into Courses
values
(101, 'Mathematics', 3),
(102, 'Physics', 4),
(103, 'Chemistry', 3),
(104, 'Biology', 4)

-- 9
insert into Enrollments
values
(1, 1, 101, '2024-01-15'),
(2, 2, 102, '2024-01-16'),
(3, 3, 103, '2024-01-17'),
(4, 4, 104, '2024-01-18')

-- 10
update Courses
set Credits = 5
where CourseID = 102

-- 11
delete from Enrollments
where StudentID = 1;

delete from Students
where StudentID = 1

-- 12
select * from Students
where Age > 20

-- 13
select * from Courses
order by CourseName asc

-- 14
select * from Enrollments
where EnrollmentDate > '2024-01-16'

-- 15
select * from Students
where FirstName = 'Sara'

-- 16
select * from Courses
where Credits = 3

-- 17
select * from Students
where Age between 20 and 22

-- 18
select * from Students
where FirstName IN ('Jane', 'Ahmed')

-- 19
select * from Enrollments
where EnrollmentDate between '2024-01-15' and '2024-01-17'

-- 20
alter table Courses
drop column Credits