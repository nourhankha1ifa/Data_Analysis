# Sales Distribution – Practice Data

![Dashboard Preview](https://github.com/nourhankha1ifa/Data_Analysis/blob/main/DEPI/Excel/Excel%202/Sales%20Distribution.png)
<br>

This one is more of a learning/practice exercise than a finished, polished dashboard — working through the same task brief (`3_Sales_Distribution_Dashboard.pdf`) but treated here as basics practice rather than a full project writeup.

---

## 1. Overview

| | |
|---|---|
| **Workbook** | `Data_Source__Sales_.xlsx` |
| **Task brief** | `3_Sales_Distribution_Dashboard.pdf` |
| **Sheets** | Input Data, Target, Customer, Functions, Analysis, Dashboard |
| **Tools used** | Excel (PivotTables, PivotCharts, Slicers) |

## 2. What the Task Asked For

The brief asked for a sales distribution dashboard covering:
- Total Sales
- Total sales vs. Target per month
- Total sales per week
- Top 3 customers for sales
- Top 10 products for sales
- Total sales per region
- Total sales per country
- Filtering by Month and Region

## 3. The Data

**`Input Data`** — raw order-level data: Date, Customer Name, Product, Unit Price, Quantity, Sales, Month, Week.

**`Target`** — a monthly sales target table, with each month's actual total sales compared against its target, and helper columns splitting the result into "Below" or "Above" target.

**`Customer`** — one row per customer, with Country, Region, and total Sales — used for the top customers and region/country breakdowns.

**`Functions`** and **`Analysis`** — working area with the PivotTables and formulas behind the practice charts.

**`Dashboard`** — a practice layout with a few charts pulled together: a combined line/bar chart for sales vs. target by month, an area chart for sales by week, a bar chart for top products, and a doughnut chart for the regional split, with slicers for Month and Region.

---

## 4. Functions Used

The `Functions` sheet is where most of the real formula practice happened — this workbook uses more advanced, dynamic formulas than the other two projects:

| Function | Example | What it does |
|---|---|---|
| `UNIQUE()` | `=UNIQUE(InputData[WEEK])` | Pulls a distinct list of weeks, months, customers, and products straight out of the raw data, so I didn't have to type each one manually |
| `XLOOKUP()` | `=XLOOKUP(B4,InputData[WEEK],InputData[SALES])` | Looks up total sales for a given week/month, matching by value instead of a fixed column position (an upgrade over VLOOKUP) |
| `ANCHORARRAY()` | `=XLOOKUP(J8,$M$4:$M$43,ANCHORARRAY($L$4))` | Lets a formula refer to the *whole* spilled result of the `UNIQUE()` list above it, so the top customer/product name matches up correctly with its sales value |
| `SUMIFS()` | `=SUMIFS(InputData[SALES],InputData[CUSTOMER NAME],Functions!L4)` | Adds up sales for one specific customer or product at a time |
| `LARGE()` | `=LARGE($M$4:$M$43,1)` | Pulls out the 1st, 2nd, 3rd (and so on) highest sales value, used to build the Top 3 customers and Top 10 products lists |
| `IF()` | `=IF([Total Sales]<[Target ($)],[Total Sales],NA())` | Splits each month's sales into "Below" or "Above" target, used to color the actual-vs-target chart differently depending on whether the target was hit |
| `NA()` | (used inside the `IF()` above) | Deliberately leaves a blank/error value instead of 0, so the chart doesn't plot a fake data point for the month that didn't apply |
| `SUM()` | `=SUM(InputData[SALES])` | The overall Total Sales figure |

This was the most formula-heavy of the three projects — the other two lean mostly on PivotTables, while this one builds its summaries with live formulas that automatically update as the raw data changes.

---

## 5. What This Was Good Practice For

- Comparing an actual value against a target using helper columns (Below/Above), instead of just plotting the actual number alone.
- Practicing a few chart types I hadn't combined before — a combo chart (line + bar) for actual-vs-target, and an area chart for a week-by-week trend.
- Structuring separate lookup-style tables (`Target`, `Customer`) alongside the main transaction data, similar to the Sales Performance project, but with a slightly different shape (target values, and country/region groupings).

This one didn't get the full layout polish or complete set of charts from the brief (e.g. a dedicated "top 3 customers" and "sales per country" chart weren't finished) — it was mainly about practicing the underlying PivotTable and chart mechanics before attempting a cleaner, fully laid-out version.

---

## 6. Files

| File | What it is |
|---|---|
| `3_Sales_Distribution_Dashboard.pdf` | The task brief and business requirements |
| `Data_Source__Sales_.xlsx` | The practice workbook |
