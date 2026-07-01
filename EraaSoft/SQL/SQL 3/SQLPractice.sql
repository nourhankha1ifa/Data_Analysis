create database SQL_3

use SQL_3

create table Students
(
Std_id int primary key,
student_name VARCHAR(50) NOT NULL,
department VARCHAR(30)
)

Create table Courses
(
course_id INT Primary Key,
course_name VARCHAR(50) NOT NULL,
credits INT
)

-- adding col
alter table Students 
add birth_year INT

-- modifying col
Alter table Students
alter column department VARCHAR(50)

Drop table Courses

insert into Students(Std_id,student_name,department)
values(1, 'Ahmed Ali', 'Computer Science'),
(2, 'Sarah Mohamed', 'Business'),
(3, 'Omar Tarek', 'Engineering')

update Students set department = 'Mechanical Engineering'
where Std_id = 3

Delete from Students 
where Std_id = 2