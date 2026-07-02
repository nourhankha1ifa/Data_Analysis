# SQL Learning – Task 3: Writing Real SQL Scripts

Tasks 1 and 2 were about designing databases on paper (ER diagrams, then mapping them into tables). This task is where it became real: actually writing and running SQL — creating databases, building tables, inserting data, and writing queries.

---

## What I Learned

- **DDL (Data Definition Language)** — commands that define the structure of a database:
  - `CREATE DATABASE` / `USE` to create and switch to a database
  - `CREATE TABLE` with column types (`int`, `varchar(n)`, `date`) and a `PRIMARY KEY`
  - `FOREIGN KEY ... REFERENCES` to link one table to another
  - `ALTER TABLE ... ADD` to add a new column to an existing table
  - `ALTER TABLE ... ALTER COLUMN` to change a column's data type
  - `DROP TABLE` / `ALTER TABLE ... DROP COLUMN` to remove a table or column
- **DML (Data Manipulation Language)** — commands that work with the actual data:
  - `INSERT INTO ... VALUES` to add rows, including multiple rows in one statement
  - `UPDATE ... SET ... WHERE` to change existing data
  - `DELETE FROM ... WHERE` to remove specific rows
- **Querying with `SELECT`:**
  - Filtering with `WHERE`, including comparisons (`>`, `=`), `BETWEEN ... AND ...`, and `IN (...)`
  - Sorting results with `ORDER BY ... ASC`
  - Selecting only specific columns instead of `*`
  - Creating a **calculated column** (e.g. salary × 12) and giving it a readable name with `AS`
  - Combining text columns together (first name + last name) into one result column
  - Filtering on a calculated value, not just a stored column
- **Constraints:** `NOT NULL` to make sure a column always has a value

---

## SQLPractice.sql – Warm-up Practice

A short script to practice the basic database and table commands before the graded tasks:
- Created a new database (`SQL_3`) and switched to it
- Created a `Students` table and a `Courses` table
- Practiced `ALTER TABLE` twice: once to **add** a new column (`birth_year`), and once to **change** an existing column's type (`department`)
- Practiced `DROP TABLE` to remove the `Courses` table
- Inserted 3 student records, specifying the column names explicitly in the `INSERT` statement
- Practiced `UPDATE` to change one student's department, and `DELETE` to remove one student record

This script was mainly about getting comfortable with the everyday commands (create, alter, insert, update, delete) before working with more connected, multi-table databases.

---

## SQL_Task_3_1.sql – SchoolDB (Students, Courses, Enrollments)

This script builds a small school database from scratch and answers 20 questions, working with **three connected tables**:

**Building the database (Q1–Q6):**
- Created the `SchoolDB` database and switched to it
- Created `Students` (StudentID as primary key)
- Created `Courses` (CourseID as primary key)
- Created `Enrollments` — the table that connects the other two, with **two foreign keys** (`StudentID` and `CourseID`) linking back to `Students` and `Courses`
- Added an `Address` column to `Students` after it already existed, using `ALTER TABLE`

**Adding data (Q7–Q9):**
- Inserted 4 students, 4 courses, and 4 enrollment records linking specific students to specific courses on specific dates

**Changing data (Q10–Q11):**
- Updated a course's credit value with `UPDATE`
- Deleted a student — and first deleted their related row from `Enrollments`, since a foreign key means you can't delete a student while an enrollment still points to them

**Querying data (Q12–Q19):**
- Filtered students by age (`> 20`, and `BETWEEN 20 AND 22`)
- Sorted courses alphabetically by name
- Filtered enrollments by date (after a date, and between two dates)
- Filtered students by exact name match and by a list of names (`IN (...)`)
- Filtered courses by an exact credit value

**Changing the structure again (Q20):**
- Dropped the `Credits` column from `Courses` with `ALTER TABLE ... DROP COLUMN`

This was the most complete exercise — it covered the full lifecycle of a small database: build the structure, connect tables with foreign keys, load data, update it, query it in different ways, and modify the structure again afterward.

---

## SQL_Task_3_2.sql – Company Database Queries

This script works with an existing company database (`Employee`, `Departments`, `Project` tables) and focuses on **writing SELECT queries only** — no table creation, since the database already existed:

1. Selected every column from `Employee` (`SELECT *`)
2. Selected only specific columns: first name, last name, salary, and department number
3. Selected project name, location, and department number from `Project`
4. Built a **calculated column**: combined first and last name into one `Fullname` column, and calculated a 10% annual commission as `ANNUAL COMM` — both using column aliases (`AS`) to give the results readable names
5. Filtered employees earning more than 1000 (monthly)
6. Calculated an **annual** salary (monthly × 12) as a new column, and filtered on that calculated value rather than the stored one
7. Filtered employees by sex (`= 'F'`) and returned their name and salary
8. Filtered departments by manager ID, returning the department number and name
9. Filtered projects by department number, returning project number, name, and location

This script was good practice for the difference between filtering on a **stored** column versus filtering on a **calculated** one, and for making query results more readable using aliases.

---

## Files

| File | What it is |
|---|---|
| `SQL_Task_1_1.pdf` | The 20 SchoolDB questions this task answers |
| `SQL_Task_1_2.pdf` | The 9 Company database questions this task answers |
| `SQL_Task_3_1.sql` | My answers to the SchoolDB questions |
| `SQL_Task_3_2.sql` | My answers to the Company database questions |
| `SQLPractice.sql` | Extra warm-up practice with a separate small database |

---

## What I Learned Overall

This task moved me from theory into practice — actually typing and running SQL instead of just designing on paper:

- Building a database from nothing: creating it, creating tables inside it, and connecting those tables with foreign keys.
- Managing data with `INSERT`, `UPDATE`, and `DELETE`, including understanding that a foreign key means related rows sometimes have to be deleted in the right order.
- Writing `SELECT` queries with real filtering, sorting, and calculated columns — going beyond "get everything" to "get exactly what I need."
- Changing a table's structure after it already has data in it, using `ALTER TABLE`.

This ties directly back to Tasks 1 and 2 — the tables and relationships I designed and mapped on paper are the same shapes I'm now actually building and querying in SQL.
