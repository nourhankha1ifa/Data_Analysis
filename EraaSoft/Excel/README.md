# Excel Learning – Tasks 1–5

This covers 5 Excel workbooks, going from basic formulas up to two full interactive dashboards built on a Power Pivot data model. Excel_1–3 are learning the fundamentals one skill at a time; Excel_4 and Excel_5 are complete, self-contained dashboard projects that pull everything together.

---

## Overview

| File | Focus | Type |
|---|---|---|
| `Excel_1.xlsx` | Core formulas (aggregates, text functions, logic) | Practice |
| `Excel_2.xlsx` | Power Query + Excel Tables + lookup/conditional formulas | Practice |
| `Excel_3.xlsx` | PivotTables + lookup reference tables | Practice |
| `Excel_4.xlsx` | **Full dashboard** — Power Pivot data model, advanced PivotTables, interactive dashboard | Project |
| `Excel_5.xlsx` | **Full dashboard** — separate retail dataset, own data model, interactive dashboard | Project |

---

## Excel_1.xlsx – Formulas Practice with a Sales Dataset

A 1,000-row supermarket sales dataset (`Sheet1`), with 33 questions answered using formulas in the `Tasks` sheet.

**What I learned and applied:**
- Aggregate functions: `SUM`, `AVERAGE`, `MIN`, `MAX`, `COUNT`
- Conditional aggregates: `SUMIF`, `COUNTIF`, `AVERAGEIF`
- Ranking: `LARGE` / `SMALL` combined with `UNIQUE`
- Text functions: `LEFT`, `RIGHT`, `MID`, `CONCAT`, `TEXT`
- Logic: `IF`, nested `IF`, `ISNUMBER`, `COUNTBLANK`
- Cross-sheet formulas referencing another sheet's data

---

## Excel_2.xlsx – Power Query and Table-Based Formulas

Built on a ~10,000-row Superstore-style orders dataset (`Orders`), first cleaned up with **Power Query** (the second sheet, `After power query`, works from the query output), then formatted as a proper **Excel Table** so formulas can use structured references like `Orders[Sales]` instead of plain cell ranges.

**What I learned and applied:**
- Turning raw data into a Power Query-cleaned, structured Excel Table
- Structured references (`Orders[Sales]`, `Orders[Profit]`) instead of fixed cell ranges
- Conditional aggregates on table columns: `SUMIF`, and totals filtered by Region, Category, Segment, and Discount level
- `INDEX` + `MATCH` to look up which sub-category had the highest profit
- Array formulas for date-based questions (e.g. counting orders placed in a specific year)
- Building small per-month and per-customer summary tables with `SUMIF`, feeding from the main table

---

## Excel_3.xlsx – PivotTables and Lookup Reference Tables

Same orders dataset (`Orders1`), plus three small reference tables — `Return` (which orders were returned), `Shipping Cost` (cost per unit by state), and `People` (which regional manager covers which region) — set up for lookup practice, and a first introduction to **PivotTables**.

**What I learned and applied:**
- Building a PivotTable to find total sales by month for a specific year, then sorting to find the best month
- Building a second PivotTable to find the Top 5 products by sales
- Setting up small lookup/reference tables (`Return`, `Shipping Cost`, `People`) structured for use with lookup functions like `VLOOKUP`

---

## Excel_4.xlsx – Full Dashboard: Superstore Sales

![Dashboard Preview](https://github.com/nourhankha1ifa/Data_Analysis/blob/main/EraaSoft/Excel/Snapshot%20Excel%204.png)

<br>

This is a **complete, working dashboard**, not just practice. It takes the same orders dataset from Excel_2 and Excel_3 and builds it into a proper data model with a real interactive report.

**How it's built:**
- **Power Pivot Data Model:** the `Orders1` table is connected to the `Return`, `Shipping Cost`, and `People` reference tables through relationships (not manual lookups), plus a built-in date table breaking `Order Date` into Year, Quarter, Month, and Month Index
- **Calculated columns pulled in through those relationships:** `Person` (regional manager), `Shipping Cost Per Unit`, `Shipping Cost`, and `Returned` — all pulled automatically from the connected tables instead of copy-pasted or manually looked up
- **A large `Pivot Table` sheet** with multiple PivotTables answering different business questions:
  - Total sales by year and by month
  - Top 5 and Bottom 5 products by sales
  - Number of orders by ship mode
  - Top 10 customers by total sales
  - Sales by region and by the person managing that region
  - Sales and profit by category, drilling down to sub-category and product
  - Top 3 products per state by quantity and sales, including returns
- **The `Dashboard` sheet** — the actual interactive report, built from 6 charts and 3 slicers:
  - **Charts:** Total Sales for Each Year, Top 5 Products, Number of Orders, Top 10 Customers by Total Sales, Total Sales by Region, and a donut chart showing Returned vs. Kept orders
  - **Slicers:** Region, Segment, and City — so every chart on the dashboard updates together when you filter by any of these

This file shows the full path from raw data to a finished report: clean the data (Power Query, Tasks 1–2), model the relationships (Power Pivot), summarize it (PivotTables), and present it (charts + slicers on one dashboard page).

---

## Excel_5.xlsx – Full Dashboard: Retail Sales (Branches, Classes, Segments)

![Dashboard Preview](https://github.com/nourhankha1ifa/Data_Analysis/blob/main/EraaSoft/Excel/Snapshot%20Excel%205.png)

<br>

A second, independent dashboard project on a different dataset — a retail electronics business selling phones and tablets across branches in Egypt (Marsa Matrouh, Alexandria, Zagazig, Mansoura, Ismailia, and more).

**How it's built:**
- **`Info` sheet:** a task list of 25 questions covering both plain formulas and the data model/dashboard build, used as the brief for the rest of the workbook
- **`Data-1` sheet:** a separate, formula-only dataset (Superstore-style) used to answer the first set of questions — totals, profit, quantity, ranking (2nd highest sale, 4th lowest sale, etc.), and two calculated columns:
  - `New Sales` = Quantity × a fixed new price (150)
  - `Classes` — assigns each row a class (A/B/C/D/E) based on its New Sales value against set thresholds, using nested `IF` logic
- **`Sales` sheet:** the main fact table for the dashboard (date, branch, segment, product, sub-category, class, quantity, cost, price, sales, profit)
- **Four lookup tables** — `Code` (category codes), `Classes`, `Sub categories`, `Segments`, and `Branches` — each holding a short code that matches back to the `Sales` table
- **Power Pivot Data Model:** relationships built between `Sales` and each of the four lookup tables, joined on their code columns (Class Code, Sub category code, Branch Code, Segment Code), so everything can be reported on by name instead of by code
- **`Pivot Table` sheet:** PivotTables built on top of the data model, including:
  - Average profit by branch
  - Total profit by segment and by sub-category
  - Total profit by class
  - Sum of sales and sum of quantity across the whole model
- **The `Dashboard` sheet** — 4 charts and 4 slicers (Branch, Class, Segment, Sub category), all linked together so filtering on any slicer updates every chart on the page at once

This project mirrors Excel_4's structure (data model → PivotTables → linked dashboard) but on a completely separate, self-contained dataset, which was good practice for repeating the whole workflow independently rather than following a template.

---

## Files

| File | What it is |
|---|---|
| `Excel_1.xlsx` | Formulas practice on a supermarket sales dataset |
| `Excel_2.xlsx` | Power Query + Excel Table formulas on Superstore orders |
| `Excel_3.xlsx` | First PivotTables + lookup reference tables |
| `Excel_4.xlsx` | Full dashboard — Superstore sales (Power Pivot + PivotTables + 6 charts + 3 slicers) |
| `Excel_5.xlsx` | Full dashboard — retail branches (Power Pivot + PivotTables + 4 charts + 4 slicers) |

---

## What I Learned Overall

Across these five files, the progression was from single formulas to a complete, interactive reporting tool:

- **Excel_1–2:** getting comfortable with core formulas — aggregates, conditional aggregates, text functions, and logic — first on plain ranges, then on a proper Excel Table with Power Query behind it.
- **Excel_3:** introducing PivotTables as a faster way to summarize data than writing formulas for every question, plus setting up reference tables for lookups.
- **Excel_4–5:** the real jump — connecting multiple tables together with a Power Pivot data model instead of manual lookups, building several PivotTables off that model, and turning them into a single interactive dashboard page where slicers control every chart at once.

Building two separate dashboards (Excel_4 and Excel_5) on two different datasets was the best proof that the workflow had actually sunk in — the second one didn't copy the first, it followed the same process from scratch on new data.
