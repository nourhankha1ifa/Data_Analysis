# My SQL Learning Journey

This is a summary of everything I learned across 5 tasks, going from "what is a database" all the way to building and querying a full retail sales system. Each task built directly on the one before it.

---

## The Journey at a Glance

| Task | Focus | What it added |
|---|---|---|
| **Task 1** | Designing databases with ER diagrams | Entities, attributes, keys, relationships, cardinality |
| **Task 2** | Mapping ER diagrams into relational tables | Turning diagrams into real tables with primary/foreign keys |
| **Task 3** | Writing real SQL | Creating databases and tables, inserting/updating/deleting data, basic `SELECT` queries |
| **Task 4** | Joins, aggregation, subqueries | Querying across multiple connected tables at once |
| **Task 5** | Final project: Retail Sales Management System | Window functions, views, and a full realistic business database |

---

## Task 1 – Designing with ER Diagrams

Before touching any SQL, I learned how to **plan** a database on paper. I worked through 3 case studies (a music label, a real estate firm, and a hospital) and drew an ER diagram for each one.

**Key ideas:** entities become tables, attributes become columns, a key (underlined) becomes a primary key, and relationships between entities have a cardinality — 1:1, 1:M, or M:M. I also practiced composite attributes (like an address split into street and city), multi-valued attributes (like a drug with several brand names), and putting data on a relationship itself when it didn't belong to either entity (like the percentage a person owns of a property).

## Task 2 – Mapping ER Diagrams into Tables

Next, I took those same 3 diagrams and turned them into actual tables with primary and foreign keys — the exact step that comes right before writing `CREATE TABLE`.

**Key ideas:** a 1:M relationship becomes a foreign key on the "many" side. A M:M relationship needs its own junction table combining both keys, since one column can't hold many values. Multi-valued attributes get their own table too, for the same reason. And a relationship connecting three entities at once (like a nurse giving a patient a drug) becomes one table with a foreign key back to each entity involved.

## Task 3 – Writing Real SQL

This is where it became real. I created databases and tables from scratch, added data, and started writing queries.

**Key ideas:** `CREATE DATABASE`, `CREATE TABLE` with `PRIMARY KEY` and `FOREIGN KEY`, `ALTER TABLE` to change a table after it exists, `INSERT`/`UPDATE`/`DELETE` to manage data, and `SELECT` queries using `WHERE`, `ORDER BY`, `BETWEEN`, and `IN (...)`. I also learned to build calculated columns (like an annual salary from a monthly one) and give them readable names with `AS`.

## Task 4 – Joins, Aggregation, and Subqueries

Real data lives across multiple tables, so this task was about querying them together instead of one at a time.

**Key ideas:** `JOIN`, `LEFT JOIN`, `RIGHT JOIN`, and `FULL JOIN` for combining tables in different ways, plus **self joins** for relationships within one table (like an employee's supervisor, who is also an employee). I learned to summarize data with `COUNT()`, `AVG()`, `MAX()`, `MIN()` and `GROUP BY`, filter groups with `HAVING`, and write subqueries — including correlated subqueries that re-run for each row of the outer query.

## Task 5 – Final Project: Retail Sales Management System

Everything came together here. I built a full 7-table retail database (branches, employees, customers, products, inventory, sales, and sale details) and answered 50 real business questions.

**Key ideas:** composite primary keys, window functions (`RANK()`, `DENSE_RANK()`, `ROW_NUMBER()`) for ranking and numbering rows without collapsing them the way `GROUP BY` does, `CREATE VIEW` to save a query as something reusable, and conditional aggregation with `CASE WHEN` inside `COUNT()`. This task was less about learning new syntax for its own sake and more about answering actual business questions — best-selling products, top branches by revenue, employees who sell across categories, and customers who never bought anything.

---

## How It All Connects

Looking back, the five tasks form one continuous line:

1. **Design** the database on paper (Task 1)
2. **Translate** that design into real tables with keys (Task 2)
3. **Build** it in SQL and manage the data inside it (Task 3)
4. **Query** across multiple tables to answer real questions (Task 4)
5. **Apply** all of it to a full, realistic business system (Task 5)

Starting from ER diagrams instead of jumping straight into SQL made a real difference — by the time I got to writing `CREATE TABLE` statements, I already understood *why* each foreign key and junction table existed, instead of just copying syntax. And by the final project, joins, aggregation, and window functions all felt like normal tools rather than separate topics.
