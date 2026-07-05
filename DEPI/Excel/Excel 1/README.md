# Excel Sales Performance Dashboard

![Dashboard Preview](https://github.com/nourhankha1ifa/Data_Analysis/blob/main/DEPI/Excel/Excel%201/Sales%20Performace%20Dashboard.png)
<br>

A full Excel dashboard analyzing sales, profit, discounts, and production cost for a retail/fashion product range, broken down by category, month, and year.

---

## 1. Overview

This project takes a raw sales dataset (3,678 orders) and turns it into a one-page interactive dashboard filterable by category, year, and month.

| | |
|---|---|
| **Workbook** | `Sales_Performance.xlsx` |
| **Task brief** | `1_Excel_Sales_Performance_Dashboard.pdf` |
| **Sheets** | Data, Analysis, Dashboard |
| **Tools used** | Excel (PivotTables, PivotCharts, Slicers) |

---

## 2. What the Task Asked For

The brief asked for a dashboard covering:
1. Total number of orders
2. Total sales
3. Total production cost
4. Total discounts
5. Total profit
6. Profit and discount trends by month and year
7. Production cost by year
8. Profit per category
9. Production cost per category

Plus slicers for Category, Year, and Month.

---

## 3. The Data

**`Data`** — one row per order: Consumer ID, Order ID, Month, Year, Price, Discount, Sales, Category, Sub-Category, Production Cost, and Profit.

**`Analysis`** — the PivotTables behind the dashboard: order count, sum of sales, sum of production cost, sum of discount, sum of profit (the 5 KPIs), plus production cost/profit by category, profit and discount by month, and production cost/profit by year.

**`Dashboard`** — the final visual page.

---

## 4. Dashboard Charts — What They Show and Why

| Chart | Type | What it answers |
|---|---|---|
| **Total Orders / Sales / Production Cost / Discount / Profit** | KPI values | The five headline numbers, so the overall scale of the business is visible immediately. |
| **Profit and Discount by Month** | Line chart | A line chart is the clearest way to see how profit and discount trends move together (or apart) across the year — useful for spotting whether heavy discounting in a month actually hurt profit. |
| **Production Cost by Year** | Bar chart | With only two years in the data, a simple bar chart makes the year-over-year comparison immediate. |
| **Profit per Category** | Pie chart | Shows each category's share of total profit — a proportion question, which a pie chart answers more naturally than a bar chart would. |
| **Production Cost per Category** | Bar chart | Compares production cost across categories (Apparel, Bags, Accessories, etc.) — a bar chart makes it easy to rank which categories cost the most to produce. |

### Slicers
The dashboard includes slicers for **Category**, **Year**, and **Month**, so every chart and KPI updates together when filtering by any of these.

---

## 5. Functions Used

This workbook keeps formulas simple and lets PivotTables do most of the summarizing:

| Formula | Where | What it does |
|---|---|---|
| `=G2-J2` (Sales − ProductionCost) | `Data` sheet, `Profit` column | A basic subtraction, calculated once per order row, to get the profit for that order |

All the totals, trends, and category/year breakdowns shown on the dashboard come from **PivotTables** built on top of this column (using Sum, not a written formula) rather than separate worksheet formulas.

---

## 6. What This Project Was Good Practice For

- Building multiple PivotTables off one dataset, each answering a different business question (totals, trends, category breakdowns).
- Choosing chart types based on what the question actually needs — a trend over time gets a line chart, a share-of-total question gets a pie chart, a side-by-side comparison gets a bar chart.
- Connecting several PivotCharts to a shared set of slicers so the whole dashboard filters together instead of each chart working independently.
- Laying out KPIs, trend charts, and category breakdowns together on one page in a clear, readable way.

---

## 7. Files

| File | What it is |
|---|---|
| `1_Excel_Sales_Performance_Dashboard.pdf` | The task brief and business requirements |
| `Sales_Performance.xlsx` | The finished dashboard workbook |
