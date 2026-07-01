use Students;

-- 1
select s.St_Fname, dep.Dept_Name from Student s
join Department dep on dep.Dept_Id = s.Dept_Id;

-- 2
select s.St_Fname, s.St_Lname, dep.Dept_Name 
from Student s
left join Department dep on dep.Dept_Id = s.Dept_Id;

-- 3
select s.St_Fname, s.St_Lname, dep.Dept_Name 
from Student s
right join Department dep on s.Dept_Id = dep.Dept_Id;

-- 4
select s.St_Fname, s.St_Lname, dep.Dept_Name 
from Student s
full join Department dep on s.Dept_Id = dep.Dept_Id;

-- 5
select St_Fname, St_Lname, St_Address, St_Age 
from Student
where St_Address like'%alex%'
order by St_Age;

-- 6
select s.St_Fname, s.St_Lname, c.Crs_Name, sc.Grade 
from Stud_Course sc
join Course c on c.Crs_Id = sc.Crs_Id
join Student s on s.St_Id = sc.St_Id;

-- 7
select count(*) as "num of students", dep.Dept_Id from Student s
join Department dep on dep.Dept_Id = s.Dept_Id
group by dep.Dept_Id;

-- 8
select sc.Grade+10 as Grades, s.St_Address 
from Stud_Course sc
join Student s on s.St_Id = sc.St_Id
where s.St_Address like '%cairo%';

-- 9
select ins.Ins_Name, dep.Dept_Name from Instructor ins 
join Department dep on dep.Dept_Id = ins.Dept_Id;

-- 10
select 
	s.St_Fname+' '+s.St_Lname as Student,
	sup.St_Fname+' '+sup.St_Lname as Supervisor
from Student s
join Student sup on sup.St_super = s.St_Id;

-- 11
select top (3)
    d.Dept_Name,
    count(s.St_Id) as "Student Num"
from Department d
join Student s on s.Dept_Id = d.Dept_Id
group by d.Dept_Id, d.Dept_Name
order by "Student Num" desc;

-- 12
SELECT 
    i.Ins_Name,
    COUNT(ic.Crs_Id) AS NumCourses
FROM Instructor i
LEFT JOIN Ins_Course ic ON i.Ins_Id = ic.Ins_Id
GROUP BY i.Ins_Id, i.Ins_Name;

-- 13
SELECT s.St_Fname, s.St_Lname FROM Student s
LEFT JOIN Stud_Course sc ON s.St_Id = sc.St_Id
WHERE sc.Crs_Id IS NULL;

-- 14
SELECT c.Crs_Name FROM Course c
LEFT JOIN Stud_Course sc ON c.Crs_Id = sc.Crs_Id
WHERE sc.St_Id IS NULL;

-- 15
select c.Crs_Name ,max(sc.Grade) as highest, min(sc.Grade) as lowest
from Stud_Course sc
join Course c on c.Crs_Id = sc.Crs_Id
group by c.Crs_Name;

-- 16
select c.Crs_Name , avg(sc.Grade) as average
from Stud_Course sc
join Course c on c.Crs_Id = sc.Crs_Id
group by c.Crs_Name;

-- 17
SELECT 
    s.St_Fname,s.St_Lname,
    c.Crs_Name,sc.Grade
FROM Stud_Course sc
JOIN Student s ON s.St_Id = sc.St_Id
JOIN Course c ON c.Crs_Id = sc.Crs_Id
WHERE sc.Grade > (
        SELECT AVG(sc2.Grade)
        FROM Stud_Course sc2
        WHERE sc2.Crs_Id = sc.Crs_Id);

-- 18
SELECT s.St_Fname, s.St_Lname, s.Dept_Id, s.St_Age
FROM Student s
JOIN (
    SELECT Dept_Id, max(St_Age) AS OldestStudent
    FROM Student
    GROUP BY Dept_Id) 
    oldest ON s.Dept_Id = oldest.Dept_Id 
    AND s.St_Age = oldest.OldestStudent
order by s.St_Age desc;

-- 19
SELECT St_Fname, St_Lname FROM Student
WHERE St_Fname IN (
    SELECT St_Fname FROM Student
    GROUP BY St_Fname
    HAVING COUNT(*) > 1)
ORDER BY St_Fname;

-- 20
SELECT St_Fname AS "Name" FROM Student
UNION
SELECT Ins_Name AS "Name" FROM Instructor;