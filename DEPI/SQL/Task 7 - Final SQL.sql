-- PART 1: Create SD32-Company Database
CREATE DATABASE [SD32-Company];
GO

USE [SD32-Company];
GO

-- Table 1: Department
CREATE TABLE Department (
    DeptNo   CHAR(2)     NOT NULL,
    DeptName VARCHAR(50) NOT NULL,
    Location NCHAR(2)    NOT NULL DEFAULT 'NY'
        CHECK (Location IN ('NY', 'DS', 'KW')),
    CONSTRAINT PK_Department PRIMARY KEY (DeptNo)
);
GO

INSERT INTO Department VALUES ('d1', 'Research',   'NY');
INSERT INTO Department VALUES ('d2', 'Accounting', 'DS');
INSERT INTO Department VALUES ('d3', 'Markiting',  'KW');
GO

-- Table 2: Employee
CREATE TABLE Employee (
    EmpNo    INT           NOT NULL,
    EmpFname VARCHAR(50)   NOT NULL,
    EmpLname VARCHAR(50)   NOT NULL,
    DeptNo   CHAR(2)       NULL,
    Salary   DECIMAL(10,2) NULL CHECK (Salary < 6000),
    CONSTRAINT PK_Employee PRIMARY KEY (EmpNo),
    CONSTRAINT FK_Emp_Dept FOREIGN KEY (DeptNo) REFERENCES Department(DeptNo),
    CONSTRAINT UQ_Salary   UNIQUE (Salary)
);
GO

INSERT INTO Employee VALUES (25348, 'Mathew', 'Smith',     'd3', 2500);
INSERT INTO Employee VALUES (10102, 'Ann',    'Jones',     'd3', 3000);
INSERT INTO Employee VALUES (18316, 'John',   'Barrimore', 'd1', 2400);
INSERT INTO Employee VALUES (29346, 'James',  'James',     'd2', 2800);
INSERT INTO Employee VALUES (9031,  'Lisa',   'Bertoni',   'd2', 4000);
INSERT INTO Employee VALUES (2581,  'Elisa',  'Hansel',    'd2', 3600);
INSERT INTO Employee VALUES (28559, 'Sybl',   'Moser',     'd1', 2900);
GO

-- Table 3: Project
CREATE TABLE Project (
    ProjectNo   CHAR(2)       NOT NULL,
    ProjectName VARCHAR(100)  NOT NULL,
    Budget      DECIMAL(12,2) NULL,
    CONSTRAINT PK_Project PRIMARY KEY (ProjectNo)
);
GO

INSERT INTO Project VALUES ('p1', 'Apollo',  120000);
INSERT INTO Project VALUES ('p2', 'Gemini',   95000);
INSERT INTO Project VALUES ('p3', 'Mercury', 185600);
GO

-- Table 4: Works_on
CREATE TABLE Works_on (
    EmpNo      INT         NOT NULL,
    ProjectNo  CHAR(2)     NOT NULL,
    Job        VARCHAR(50) NULL,
    Enter_Date DATE        NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_Works_on   PRIMARY KEY (EmpNo, ProjectNo),
    CONSTRAINT FK_Works_Emp  FOREIGN KEY (EmpNo)     REFERENCES Employee(EmpNo),
    CONSTRAINT FK_Works_Proj FOREIGN KEY (ProjectNo) REFERENCES Project(ProjectNo)
);
GO

INSERT INTO Works_on VALUES (10102, 'p1', 'Analyst', '2006-10-01');
INSERT INTO Works_on VALUES (10102, 'p3', 'Manager', '2012-01-01');
INSERT INTO Works_on VALUES (25348, 'p2', 'Clerk',   '2007-02-15');
INSERT INTO Works_on VALUES (18316, 'p2', NULL,      '2007-06-01');
INSERT INTO Works_on VALUES (29346, 'p2', NULL,      '2006-12-15');
INSERT INTO Works_on VALUES (2581,  'p3', 'Analyst', '2007-10-15');
INSERT INTO Works_on VALUES (9031,  'p1', 'Manager', '2007-04-15');
INSERT INTO Works_on VALUES (28559, 'p1', NULL,      '2007-08-01');
INSERT INTO Works_on VALUES (28559, 'p2', 'Clerk',   '2012-02-01');
INSERT INTO Works_on VALUES (9031,  'p3', 'Clerk',   '2006-11-15');
INSERT INTO Works_on VALUES (29346, 'p1', 'Clerk',   '2007-01-04');
GO

---------------------------------------------------------------
-- PART 2: DEPI Database Functions
USE DEPI;
GO

-- 1
CREATE FUNCTION MonthName (@InputDate DATE)
RETURNS NVARCHAR(20)
AS
BEGIN
    RETURN DATENAME(MONTH, @InputDate);
END;
GO

-- Test:
-- SELECT dbo.MonthName('2024-07-15');

-- 2
CREATE FUNCTION V_Between (@Start INT, @End INT)
RETURNS @Result TABLE (Value INT)
AS
BEGIN
    DECLARE @i INT = @Start;
    WHILE @i <= @End
    BEGIN
        INSERT INTO @Result VALUES (@i);
        SET @i = @i + 1;
    END;
    RETURN;
END;
GO

-- Test:
-- SELECT * FROM dbo.V_Between(3, 8);

-- 3
CREATE FUNCTION St_DeptInfo (@StId INT)
RETURNS TABLE
AS
RETURN
(
    SELECT
        d.Dept_Name                                            AS DepartmentName,
        ISNULL(s.St_Fname, '') + ' ' + ISNULL(s.St_Lname, '') AS StudentFullName
    FROM Student s
    JOIN Department d ON s.Dept_Id = d.Dept_Id
    WHERE s.St_Id = @StId
);
GO

-- Test:
-- SELECT * FROM dbo.St_DeptInfo(1);

-- 4
CREATE FUNCTION StudentName (@StId INT)
RETURNS NVARCHAR(100)
AS
BEGIN
    DECLARE @Fname NVARCHAR(50);
    DECLARE @Lname NVARCHAR(50);
    DECLARE @Msg   NVARCHAR(100);

    SELECT @Fname = St_Fname, @Lname = St_Lname
    FROM Student
    WHERE St_Id = @StId;

    IF @Fname IS NULL AND @Lname IS NULL
        SET @Msg = 'First name & last name are null';
    ELSE IF @Fname IS NULL
        SET @Msg = 'first name is null';
    ELSE IF @Lname IS NULL
        SET @Msg = 'last name is null';
    ELSE
        SET @Msg = 'First name & last name are not null';

    RETURN @Msg;
END;
GO

-- Test:
-- SELECT dbo.StudentName(1);

-- 5
CREATE FUNCTION MGR_HireDate (@FormatCode INT)
RETURNS TABLE
AS
RETURN
(
    SELECT
        d.Dept_Name                                          AS DepartmentName,
        ISNULL(i.Ins_Name, 'N/A')                           AS ManagerName,
        CONVERT(NVARCHAR(30), d.Manager_hiredate, @FormatCode)     AS HiringDate
    FROM Department d
    JOIN Instructor i ON d.Dept_Manager = i.Ins_Id
);
GO

-- Test:
-- SELECT * FROM dbo.MGR_HireDate(103);

-- 6
CREATE FUNCTION fn_GetStudentNameByType (@NameType NVARCHAR(20))
RETURNS @Result TABLE (St_Id INT, NameValue NVARCHAR(100))
AS
BEGIN
    IF @NameType = 'first name'
        INSERT INTO @Result
        SELECT St_Id, ISNULL(St_Fname, 'N/A')
        FROM Student;

    ELSE IF @NameType = 'last name'
        INSERT INTO @Result
        SELECT St_Id, ISNULL(St_Lname, 'N/A')
        FROM Student;

    ELSE IF @NameType = 'full name'
        INSERT INTO @Result
        SELECT St_Id,
               ISNULL(St_Fname, '') + ' ' + ISNULL(St_Lname, '')
        FROM Student;

    RETURN;
END;
GO

-- Test:
-- SELECT * FROM dbo.fn_GetStudentNameByType('first name');
-- SELECT * FROM dbo.fn_GetStudentNameByType('last name');
-- SELECT * FROM dbo.fn_GetStudentNameByType('full name');