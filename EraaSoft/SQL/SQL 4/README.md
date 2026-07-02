# SQL Learning – Task 4: Joins, Aggregation, and Subqueries

Task 3 was about single-table `SELECT` queries. This task is a big step up — working across **multiple connected tables at once** using joins, summarizing data with aggregate functions, and writing queries that use the result of another query.

---

## What I Learned

- **Joins** — combining rows from two or more tables based on a matching column:
  - `JOIN` (inner join) — only returns rows that match in both tables
  - `LEFT JOIN` — returns everything from the left table, even if there's no match on the right
  - `RIGHT JOIN` — returns everything from the right table, even if there's no match on the left
  - `FULL JOIN` — returns everything from both tables, matched where possible
  - **Self join** — joining a table to itself, useful for relationships within one table (like an employee and their own supervisor, who is also stored as an employee)
  - Joining **more than two tables together** in one query
- **Aggregate functions** — summarizing many rows into one value: `COUNT()`, `AVG()`, `MAX()`, `MIN()`
- **`GROUP BY`** — grouping rows together (e.g. by department) so an aggregate function can be calculated per group instead of for the whole table
- **`HAVING`** — filtering groups *after* they've been grouped and summarized (different from `WHERE`, which filters rows *before* grouping)
- **Subqueries** — a query nested inside another query, used two ways:
  - A **correlated subquery**, where the inner query re-runs for each row of the outer query (e.g. comparing a student's grade to the average grade of their own course)
  - A subquery used **as a table** in the `FROM` clause, to first calculate something (like the oldest age per department) before joining back to it
- **`TOP (n)`** — limiting results to a set number of rows, combined with `ORDER BY` to get "the top N"
- **`UNION`** — stacking the results of two separate `SELECT` statements into one combined list of results
- **`IS NULL`** — used after a `LEFT JOIN` to find rows on the left side that had *no* match at all (e.g. students with no courses)
- Continued practice with things from earlier tasks: `LIKE` for pattern matching, `IN (...)`, `BETWEEN`, string concatenation with column aliases

---

## SQL_Task_4_1.sql – Company Database (Joins Focus)

Working with the `Employee`, `Departments`, `Project`, `Dependent`, and `Works_for` tables:

1. Joined `Departments` to `Employee` to show each department alongside its manager's name (matching manager SSN to employee SSN).
2. Joined `Departments` to `Project` to list each department's name next to the projects it controls.
3. Joined `Dependent` to `Employee` to show each dependent's full details next to the employee they belong to.
4. Filtered projects by city using `IN ('Cairo', 'Alex')`.
5. Filtered projects whose name starts with "a" using `LIKE 'a%'`.
6. Filtered employees in department 30 earning between 1000 and 2000 using `BETWEEN`.
7. Joined **four tables together** (`Employee`, `Works_for`, `Departments`, `Project`) to find employees in department 10 working 10+ hours on a specific project, using `DISTINCT` to avoid repeated rows.
8. Used a **self join** on `Employee` to find employees supervised directly by "Kamel Mohamed" — joining the employee table to itself once as the employee and once as their supervisor.
9. Joined `Employee` to `Project` and sorted the results by project name.
10. Joined **three tables** (`Project`, `Departments`, `Employee`) to get, for each Cairo project, its controlling department and that department manager's last name, address, and birthdate.
11. Used a join to display full details of every manager (matching managers back to the employee table).
12. Used a `LEFT JOIN` from `Employee` to `Dependent`, so employees appear in the results even if they have no dependents at all.
13–14. Inserted two new employee records — one with full details, one leaving salary and supervisor blank on purpose.
15. Updated salary by increasing it 20% for two specific employees, then selected the result back to check it.

---

## SQL_Task_4_2.sql – Students Database (Joins, Aggregation, Subqueries)

Working with `Student`, `Department`, `Course`, `Stud_Course`, and `Instructor` tables:

1. Joined `Student` to `Department` to show each student's first name with their department name.
2. Used a `LEFT JOIN` so every student appears, even those with no department assigned.
3. Used a `RIGHT JOIN` so every department appears, even those with no students.
4. Used a `FULL JOIN` to show every student and every department together, matched where possible.
5. Filtered students whose address contains "alex" using `LIKE '%alex%'`, sorted by age.
6. Joined three tables (`Stud_Course`, `Course`, `Student`) to show each student, their course, and their grade.
7. Used `COUNT(*)` with `GROUP BY` to count students per department.
8. Adjusted grades by +10 for students from Cairo, using a calculated column combined with a join and a filter.
9. Joined `Instructor` to `Department` to list each instructor with their department name.
10. Used a **self join** on `Student` to pair each student with their supervisor (another student).
11. Used `TOP (3)` with `GROUP BY` and `ORDER BY ... DESC` to find the 3 departments with the most students.
12. Used a `LEFT JOIN` between `Instructor` and `Ins_Course`, with `COUNT()`, so instructors teaching zero courses still appear with a count of 0.
13. Used a `LEFT JOIN` plus `WHERE ... IS NULL` to find students who haven't enrolled in any course.
14. Used the same pattern in reverse to find courses with no enrolled students.
15. Used `MAX()` and `MIN()` with `GROUP BY` to find the highest and lowest grade in each course.
16. Used `AVG()` with `GROUP BY` to find the average grade per course.
17. Used a **correlated subquery** to find students whose grade is above the average grade *of their specific course* — the subquery re-calculates the average separately for each row.
18. Used a subquery **as a table** (calculating the oldest age per department first), then joined back to `Student` to get the full details of each department's oldest student.
19. Used `GROUP BY` with `HAVING COUNT(*) > 1` inside a subquery to find first names shared by more than one student.
20. Used `UNION` to combine student names and instructor names into a single list under one column.

---

## Files

| File | What it is |
|---|---|
| `SQL_Task_4_1__company_db_.pdf` | The 15 Company database join questions this task answers |
| `SQL_Task_4_2__Students_db_.pdf` | The 20 Students database join/aggregation questions this task answers |
| `SQL_Task_4_1.sql` | My answers to the Company database questions |
| `SQL_Task_4_2.sql` | My answers to the Students database questions |

---

## What I Learned Overall

This task was about querying data the way it actually lives — spread across multiple related tables, not just one:

- Choosing the right join type depending on whether I need only matching rows (`JOIN`), or need to keep unmatched rows from one or both sides (`LEFT` / `RIGHT` / `FULL JOIN`).
- Using a self join to handle relationships where a table refers to itself, like an employee's supervisor or a student's supervisor.
- Summarizing data properly with `GROUP BY` and aggregate functions, and knowing when to filter with `WHERE` versus `HAVING`.
- Writing subqueries, including the trickier correlated kind, where the inner query depends on the outer query's current row.
- Combining everything — joins, aggregation, and subqueries — in a single query when a question needed more than one technique at once (like question 7 in the company script, joining four tables together).

This task pulled together everything from Tasks 1–3: the tables I designed and mapped are the same ones I'm now joining, summarizing, and querying in more advanced ways.
