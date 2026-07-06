# SQL Learning Journey

This covers a full stretch of my SQL learning: designing databases on paper (ER diagrams), turning those diagrams into real tables, and then writing actual SQL — from simple queries all the way to joins, aggregation, subqueries, variables, control-of-flow, and user-defined functions.

**Databases used:** `DEPI_Company`, `Company` (as `Company_SD` once restored), and `DEPI`.

---

## 1. Designing with ER Diagrams (`ERD_1.pdf`, `ERD_2.pdf`)

Before writing any SQL, I practiced **designing** databases on paper for 4 case studies. `ERD_2.pdf` has my actual hand-drawn diagrams for these.

**Key ideas practiced:** entities become tables, attributes become columns, a key (underlined) becomes a primary key, and relationships between entities have a cardinality — 1:1, 1:M, or M:M. I also practiced composite attributes (an address split into street and city), multi-valued attributes (a drug with several brand names), and putting data on a relationship itself when it didn't belong to either entity (like the percentage someone owns of a property).

### Problem 1 – Musicana (Music Label)
![Dashboard Preview](https://github.com/nourhankha1ifa/Data_Analysis/blob/main/DEPI/SQL/ERD/ERD-Problem%201.drawio.png)
<br>

Entities: Musician, Instrument, Album, Song.
- Musician **M:M** Instrument (`Play`)
- Musician **M:M** Song (`Performed`)
- Album **1:M** Song (`Appears at`) — this time the rule was stricter: **no song may appear on more than one album**
- Musician **1:M** Album (`Produces`)

### Problem 2 – Real Estate Firm
![Dashboard Preview](https://github.com/nourhankha1ifa/Data_Analysis/blob/main/DEPI/SQL/ERD/ERD-Problem%202.drawio.png)
<br>

Entities: Sales Office, Employee, Property, Owner.
- Sales Office **1:M** Employee (`Work`) — each employee assigned to exactly one office
- Sales Office **1:1** Employee (`Manage`) — one manager per office
- Sales Office **1:M** Property (`List`)
- Owner **M:M** Property (`Has`), with `Percent-owned` stored **on the relationship**, since it only makes sense for a specific owner-property pair

### Problem 3 – General Hospital
![Dashboard Preview](https://github.com/nourhankha1ifa/Data_Analysis/blob/main/DEPI/SQL/ERD/ERD-Problem%203.drawio.png)
<br>

Entities: Ward, Patient, Nurse, Consultant, Drug.
- Ward **1:M** Patient (`Hosts`)
- Consultant **1:M** Patient (`Assigned to`) vs. **M:M** Patient (`Examines`) — two different relationships between the same two entities
- Ward **1:1** Nurse (`Supervises`) vs. Ward **1:M** Nurse (`Serve in`)
- `Gives` ties Nurse, Patient, and Drug together (a 3-way relationship), recording dosage/date/time

### Problem 4 – Airline Company
![Dashboard Preview](https://github.com/nourhankha1ifa/Data_Analysis/blob/main/DEPI/SQL/ERD/ERD-Problem%204.drawio.png)
<br>

Entities: Airline, Employee, Aircraft, Route, Crew, Transaction.
- Airline **1:M** Employee (`Works in`)
- Airline **1:M** Aircraft (`Owns`)
- Aircraft **M:M** Route (`Assigned`), with flight-specific details (passenger count, price, departure/arrival time) stored **on the relationship**, since those details only apply to one aircraft flying one specific route
- Aircraft **1:1** Crew (`Has`) — each aircraft has its own crew (major pilot, assistant pilot, two hostesses), and the crew is **not** stored as employees — it's its own separate entity
- Airline **1:M** Transaction (`Records`) — buy/sell transactions like ticket sales or maintenance payments

This was the most involved of the four ER diagrams, because it needed multi-valued attributes (an airline can have several phone numbers), a composite attribute (birthday split into day/month/year), and a relationship carrying its own data (the aircraft-route assignment).

---

## 2. Mapping ER Diagrams into Relational Tables (`Task_2_Mapping.pdf`)

Next, I took all 4 diagrams and turned them into real tables with primary and foreign keys — the exact step before writing `CREATE TABLE`.

**Key ideas:** a 1:M relationship becomes a foreign key on the "many" side. A M:M relationship needs its own junction table combining both keys. Multi-valued attributes get their own table too. A relationship connecting three entities at once becomes one table with a foreign key to each entity involved, plus the extra details.

| Problem | Tables I mapped it into |
|---|---|
| **Musicana** | `Musician`, `Instrument`, `Music_Inst` (junction), `Music_Song` (junction), `Album`, `Song` |
| **Real Estate** | `Sales_Office`, `Employee`, `Property`, `Owner`, `Prop_Owner` (junction, with `Percent_owned`) |
| **Hospital** | `Ward`, `Patient`, `Consultant`, `Patient_Consult` (junction), `Nurse`, `Drug`, `Drug_Brand`, `Pat_Drug_Nurse` (the 3-way relationship table) |
| **Airline** | `Airline`, `Airline_Phone` (multi-valued attribute table), `Employee`, `Emp_Qual` (multi-valued attribute table), `Aircraft`, `Route`, `Aircraft_Route` (junction with flight details), `Crew`, `Transaction` |

The Airline mapping was good practice for handling **two** multi-valued attributes in the same problem (`Airline_Phone` for phone numbers, `Emp_Qual` for employee qualifications) — each one needed its own small table instead of trying to cram multiple values into one column.

---

## 3. Task 3 — Building `DEPI_Company` and First Queries (`1_SQL_TASK.pdf`)

**Part 1 — building a database from the schema:** I created a new database, `DEPI_Company`, and built it from a given schema diagram: `Departments`, `Employees`, `Dept_Locations`, `Projects`, `Works_On`, and `Dependents`. This meant writing `CREATE TABLE` statements with the right primary keys (including **composite** primary keys like `Works_On (ESSN, Pno)`), foreign keys linking everything together, and a **self-referencing foreign key** (`Superssn` on `Employees` points back to `Employees.SSN`, since a supervisor is also an employee). I then inserted at least 2 rows into every table.

**Part 2 — first queries, on the existing `Company_SD` database:** simple `SELECT` statements with column aliases (`AS`) to make results readable, `CONCAT()` to join first and last names into one column, a calculated column (annual commission = salary × 12 × 10%), and filtering with `WHERE` on salary (monthly and annual) and gender.

---

## 4. Task 4 — Joins on the Company Database (`2_SQL_TASK.pdf`)

This task moved from one table at a time to **combining multiple tables**:

- `INNER JOIN` to match departments to their managers, departments to their projects, and dependents to the employee they belong to
- Filtering with `LIKE` (project names starting with "a"), `IN (...)` (projects in Cairo or Alex), and `BETWEEN` (salary range)
- Joining **three tables** together to find employees in a department working enough hours on a named project
- A **self join** on `Employee` to find who is directly supervised by a named manager (joining the employee table to itself once as the employee, once as the supervisor)
- Sorting joined results with `ORDER BY`
- A **4-table join** (Project → Department → Employee) to get a project's controlling department and that department's manager details
- `DISTINCT` to remove duplicate rows after a join
- A `LEFT JOIN` from `Employee` to `Dependent`, so employees with **no** dependents still appear in the results
- `UNION` to combine two separate queries (female dependents of female employees, and male dependents of male employees) into one result list

---

## 5. Task 5 — Aggregation, Subqueries, and Ranking (`3_SQL_TASK.pdf`)

Two databases were used here: `Company_SD` for aggregation and subqueries, and `DEPI` for ranking functions.

**On `Company_SD`:**
- `SUM()` with `GROUP BY` to get total hours per project
- A **subquery inside a subquery** to find the department of the employee with the smallest ID
- `MAX()`, `MIN()`, `AVG()` together with `GROUP BY` to summarize salary per department
- `NOT IN` with a subquery to find managers who have no dependents
- `HAVING` to filter departments whose *average* salary is below the company-wide average
- A subquery with `TOP 2 ... ORDER BY ... DESC` to get the two highest salaries
- A join using **old-style comma syntax** (`FROM Employee E, Dependent D WHERE ...`) combined with `LIKE` and string concatenation, to find a dependent whose name appears inside their employee's first name
- `UPDATE` combined with a subquery, to give a 30% raise to everyone working on a specific project
- `EXISTS` to check whether an employee has at least one dependent, without needing to count them

**On `DEPI`:**
- `DENSE_RANK() OVER (PARTITION BY ... ORDER BY ...)` to get the **top 2 salaries per department** for instructors — ranking within each department separately instead of across the whole table
- `ROW_NUMBER() OVER (PARTITION BY ... ORDER BY NEWID())` to pick **one random student per department** — using `NEWID()` to shuffle the order randomly before numbering

---

## 6. Task 6 — Variables and Control-of-Flow (`4_SQL_TASK.pdf`)

This task was about writing SQL that behaves more like a small program, using variables and logic instead of a single flat query:

- `DECLARE` and `SET` to create a **local variable** (`@MinSalary`), then use it inside a `WHERE` clause
- A second local variable (`@DeptNo`) used with `COUNT()` and `AVG()` together to summarize one specific department
- `@@ROWCOUNT`, a **global/system variable**, to check how many rows the last query actually returned
- `CASE WHEN ... THEN ... ELSE ... END` to build a `SalaryLevel` column (High/Mid/Low) based on salary ranges
- A second `CASE` to handle a `NULL` value directly — turning a missing department number into a readable "No Department" label
- `IIF()` as a shorter, inline alternative to `CASE`, for a simple Yes/No supervisor check
- `IF EXISTS (...) BEGIN ... END ELSE BEGIN ... END` — real control-of-flow, running one block of SQL or another depending on whether a condition is true
- A `WHILE` loop that repeatedly raises salaries below a target by a fixed amount, until every salary in the loop's condition is met — my first time combining a loop with an `UPDATE` statement

---

## 7. Task 7 — Final SQL Server Lab: Building `SD32-Company` + DEPI Functions (`5_SQL_TASK.pdf`)

This was the biggest task, in two parts.

### Part 1 — `SD32-Company` database
Built a new database from scratch with real constraints, going beyond a basic `CREATE TABLE`:
- `Department` — a primary key, and a **`CHECK` constraint** restricting `Location` to only `'NY'`, `'DS'`, or `'KW'`, with a **`DEFAULT`** of `'NY'`
- `Employee` — a primary key, a foreign key back to `Department`, a **`UNIQUE` constraint** on `Salary` (no two employees can earn exactly the same amount), a `CHECK` constraint keeping salary under 6000, and `NOT NULL` on the name columns
- `Project` — a primary key, with the project name required (`NOT NULL`) but the budget optional
- `Works_on` — a **composite primary key** (`EmpNo`, `ProjectNo`), two foreign keys, and an `Enter_Date` column that **defaults to the current date** (`GETDATE()`) if no date is given
- Named constraints throughout (`CONSTRAINT PK_Department`, `CONSTRAINT FK_Emp_Dept`, etc.) instead of unnamed ones, which makes the database easier to read and to fix later if something goes wrong
- `GO` used to separate batches, since some of these statements need to run in their own batch

### Part 2 — DEPI database: user-defined functions
This introduced writing my own reusable SQL functions instead of just queries:
- A **scalar function** (`MonthName`) that takes a date and returns just the month name, using `DATENAME()`
- A **multi-statement table-valued function** (`V_Between`) that takes two numbers and returns every whole number between them, built with a `WHILE` loop that inserts one row at a time into a table variable
- An **inline table-valued function** (`St_DeptInfo`) that takes a student ID and returns their department name and full name in one step, using `ISNULL()` to handle a missing first or last name gracefully
- Another **scalar function** (`StudentName`) that returns a different **message** depending on which name fields are missing, using nested `IF ... ELSE IF ... ELSE`
- A function (`MGR_HireDate`) that takes a **format code** as a parameter and uses `CONVERT()` to display a manager's hire date in that specific format
- A **multi-statement table-valued function** (`fn_GetStudentNameByType`) that takes a string like `'first name'`, `'last name'`, or `'full name'` and returns the matching column — practicing `IF`/`ELSE IF` logic *inside* a function, and using `ISNULL()` throughout to avoid blank results

---

## 8. Databases Used

| Database | What it's for |
|---|---|
| `DEPI_Company` | Built from scratch in Task 3, Part 1, from the given schema diagram |
| `Company` (used as `Company_SD` once restored) | The main database for most of the query practice — Tasks 3 (Part 2), 4, 5, and 6 |
| `DEPI` | Used for ranking functions (Task 5) and for all the user-defined functions (Task 7) |

---

## 9. Files

| File | What it is |
|---|---|
| `ERD_1.pdf` | The 4 ER diagram case studies (written requirements) |
| `ERD_2.pdf` | The same 4 case studies, with my hand-drawn ER diagrams included |
| `Task_2_Mapping.pdf` | My relational table mapping for all 4 ER diagrams |
| `1_SQL_TASK.pdf` | Task 3's brief: build `DEPI_Company` + first `Company_SD` queries |
| `2_SQL_TASK.pdf` | Task 4's brief: joins on `Company_SD` |
| `3_SQL_TASK.pdf` | Task 5's brief: aggregation, subqueries, and ranking functions |
| `4_SQL_TASK.pdf` | Task 6's brief: variables and control-of-flow |
| `5_SQL_TASK.pdf` | Task 7's brief: the `SD32-Company` lab + DEPI functions |
| `Extra_Database_Problems.pdf` | A short list of extra self-study resources (courses and a HackerRank link) |
| `Problem_1.bak` – `Problem_4.bak` | Database backup files for the 4 ER diagram problems |
| `Task 3 - Company DB.sql` | My answers for Task 3 |
| `Task 4 - Company DB.sql` | My answers for Task 4 |
| `Task 5 - Company DB & DEPI DB.sql` | My answers for Task 5 |
| `Task 6 - Company DB.sql` | My answers for Task 6 |
| `Task 7 - Final SQL.sql` | My answers for Task 7 |

---

## 10. What I Learned Overall

Looking back across this whole stretch, it's one continuous line from paper design to a working SQL Server database:

- **Design first:** thinking through entities, attributes, keys, and cardinality before writing any SQL, across 4 different real-world scenarios.
- **Map the design into tables:** knowing when a relationship needs a foreign key versus a whole new junction table, and how to handle multi-valued attributes and 3-way relationships properly.
- **Build it for real:** creating databases and tables with the right constraints (primary keys, foreign keys, `CHECK`, `UNIQUE`, `DEFAULT`, `NOT NULL`) instead of just plain columns.
- **Query it properly:** starting from simple `SELECT`s, moving into joins (inner, self, multi-table), then aggregation and subqueries, and finally ranking functions like `DENSE_RANK()` and `ROW_NUMBER()`.
- **Add real logic:** using variables, `CASE`/`IIF`, `IF...ELSE`, and `WHILE` loops to make SQL behave more like a small program.
- **Package logic into functions:** writing my own scalar and table-valued functions so common logic (like formatting a date, or building a full name safely) can be reused instead of rewritten every time.

By Task 7, things that felt brand new in Task 3 — a foreign key, a `WHERE` clause — were second nature, which left room to focus on genuinely new ideas like constraints, control-of-flow, and writing my own functions.
