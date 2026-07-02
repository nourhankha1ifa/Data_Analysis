# SQL Learning – Task 5: Retail Sales Management System (Final Project)

This is my final SQL project, bringing together everything from Tasks 1–4 — database design, table creation with keys, joins, and aggregation — into one realistic business scenario: a retail company selling products across multiple branches. All 50 practice questions are answered.

---

## The Scenario

`RetailSalesDB` models a retail business with multiple branches, built and loaded in `Database.sql`:

| Table | What it stores |
|---|---|
| `Branch` | Each store location |
| `Employee` | Staff, linked to the branch they work at |
| `Customer` | People who buy products |
| `Product` | Items for sale, with category and price |
| `Inventory` | How much stock of each product is at each branch |
| `Sale` | Each sale transaction (who bought, who sold, where, when, total) |
| `SaleDetails` | The individual products inside each sale |

This is the same table structure I designed and mapped in Tasks 1–2, scaled up for a realistic case: it uses **composite primary keys** (`Inventory` is keyed on `BranchID + ProductID` together, `SaleDetails` on `SaleID + ProductID`) and several tables with more than one foreign key.

---

## What I Learned and Applied

Building on Task 4's joins and aggregation, this project introduced several new techniques:

- **Window functions** — calculations across a set of rows without collapsing them into one row like `GROUP BY` does:
  - `RANK()` — ranks rows, giving ties the same rank and skipping the next number
  - `DENSE_RANK()` — ranks rows, giving ties the same rank but *not* skipping the next number
  - `ROW_NUMBER()` — gives every row a unique running number, useful with `PARTITION BY` to number rows separately within each group (e.g. each customer's purchases in date order)
  - Using `ROW_NUMBER()` inside a subquery, then filtering on `rn = 1` in the outer query, to pull out just the *latest* row per group (e.g. the most recent sale at each branch)
- **`CREATE VIEW`** — saving a query as a reusable, named object, so a report (like an inventory summary or a sales report) can be queried like a table instead of rewriting the same joins every time
- **Conditional aggregation with `CASE WHEN` inside `COUNT()`** — counting how many rows meet one condition versus another within the same query, without running two separate queries (used to find employees who sold *both* electronics and furniture)
- **`LOWER()`** for a case-insensitive text search
- **`COUNT(DISTINCT ...)`** to count unique values only, instead of every row
- Continued use of `LEFT JOIN` + `IS NULL` to find "missing" data (products never sold, customers who never purchased)
- `GO` as a batch separator, needed before and after creating views

---

## Query Walkthrough

**Basic filtering (Q1–4, 21):** Searching by name pattern, filtering by price and category, a case-insensitive search on product name, and counting distinct categories.

**Counts and joins across branches/employees (Q5, 6, 22, 48):** Total employees per branch (using `LEFT JOIN` so branches with none still show), total stock per product, employees by branch location, and a simple employee-to-branch listing.

**Revenue and sales totals (Q7, 9, 13, 14, 27, 29, 30, 40, 46):** Counting customers, total revenue per branch, average sale per employee, revenue per product, inventory value per branch (quantity × price), average price within a category, revenue grouped by month, overall average sale value, and total spending per customer.

**Finding "the top" or "the most" (Q10, 24, 47):** Best-selling product by quantity and top 3 branches by revenue, both using `TOP` with `ORDER BY`.

**Filtering groups with `HAVING` (Q11, 32, 33, 49):** Employees with more than 1 sale, products with total sold quantity over 2, sales containing more than one item, and branches that sold more than 5 units — filtering *after* grouping, not before.

**Finding missing data (Q19, 20, 28):** Products never sold and customers with no purchases (both via `LEFT JOIN` + `IS NULL`), and products currently at zero stock.

**Window functions (Q16, 17, 18, 26, 43):**
- Ranking products by revenue with `RANK()`
- Ranking customers by number of purchases with `DENSE_RANK()`
- Numbering each customer's purchases in date order with `ROW_NUMBER() OVER (PARTITION BY ...)`
- Pulling the latest sale per branch using `ROW_NUMBER()` inside a subquery
- A view (`BranchTopProduct`) that finds each branch's single top-selling product using `RANK() OVER (PARTITION BY BranchID ...)`

**Views (Q34, 35, 43, 44):** Four saved views — `InventorySummary`, `SalesReport`, `BranchTopProduct`, and `EmployeePerformance` — each wrapping a useful multi-table query so it can be reused without rewriting it.

**Multi-condition and per-group breakdowns (Q25, 36, 37, 38, 39, 41, 42, 45, 50):** Customers per product, revenue by employee *and* branch together, categories sorted by units sold, sales with product names attached, distinct products sold in a specific month, employees who sold from two different categories (using conditional `COUNT` with `CASE WHEN`), sales per day in April, customers who bought a specific category, and products sold by each employee.

**Specific lookups (Q8, 23, 31):** Customers who purchased in April, all sales by a named employee, and all transactions for a named customer.

---

## Files

| File | What it is |
|---|---|
| `SQL Final Assessment.txt` | The original assignment: scenario description plus the full database setup script |
| `Database.sql` | The same setup script on its own — creates `RetailSalesDB`, all 7 tables, and loads the sample data |
| `Your SQL Practice Tasks (50 Q).txt` | The list of all 50 business questions to answer |
| `SQL Final.sql` | My completed answers to all 50 questions |

---

## What I Learned Overall

This project pulled everything together into something closer to real analyst work:

- Designing and building a multi-table database that models an actual business, including composite keys and several foreign keys per table.
- Answering real business questions ("which branch made the most revenue," "who are our top customers," "which employees sell across categories") instead of just practicing syntax.
- Adding window functions to my toolkit — ranking and numbering rows without losing row-level detail the way `GROUP BY` does.
- Saving common queries as views, so a report becomes something reusable instead of a one-off query.
- Combining joins, aggregation, `HAVING`, subqueries, and window functions confidently in the same query when a question needed more than one technique at once.

This is the most complete project in the series — it's the point where the database design from Task 1, the table mapping from Task 2, and the querying skills from Tasks 3–4 all came together in one working system.
