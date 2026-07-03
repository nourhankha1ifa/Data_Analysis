# Sales Performance Dashboard (AdventureWorks)
![Dashboard Preview](https://github.com/nourhankha1ifa/Data_Analysis/blob/main/EraaSoft/Power%20BI/Power%20BI%203/Dashboard%20Snapshot.png)

<br>

This is my third Power BI project. I used it to practice more advanced things than my first two projects: connecting live to a database with DirectQuery, handling a date column that plays more than one role (order date, ship date, due date), drill-through to a details page, and a Top N filter.

---

## 1. Overview

The dashboard connects to the AdventureWorks sales database and shows how the business is performing — orders, money, products, territories, and salespeople.

| | |
|---|---|
| **Report pages** | 3 (1 main page, 1 salesperson details page, 1 tooltip page) |
| **Data source** | AdventureWorks sample database (SQL Server), connected live with **DirectQuery** |
| **Tools used** | Power BI Desktop (Power Query, Data Modeling, DAX) |

---

## 2. Why I Made This

For this project I wanted to move past working with one flat file and practice connecting straight to a real database instead, using several related tables at once. AdventureWorks was a good fit again because it has a proper set of sales tables (orders, order details, salespeople, territories, products) that are perfect for practicing a full star schema, DirectQuery, and more advanced report features like drill-through.

## 3. Goal of the Dashboard

The goal was to pull data from several database tables and turn it into pages that can answer questions like:

- How many orders are there, and how much money is due, taxed, and shipped?
- How do orders compare when looked at by order date, ship date, or due date?
- How do orders break down by status, shipping method, and online vs. offline?
- Which product categories, subcategories, and products are ordered the most?
- Which territories bring in the most orders and money?
- Who are the top 10 salespeople, and what does each one's performance look like in detail?

---

## 4. Data Source and Modeling

**Data source:** the AdventureWorks sample database, connected live using **DirectQuery** instead of importing the data. This means the dashboard queries the database directly every time it refreshes, rather than storing a copy of the data inside the Power BI file.

**Tables used:**
- `Sales.SalesOrderHeader` and `Sales.SalesOrderDetail` — combined into one `Fact Sales` table
- `Sales.vSalesPerson` (a database view) — salesperson details, brought in as `VSalesPerson`
- `Sales.SalesTerritory` — territory information
- `Purchasing.ShipMethod` — shipping method information
- `Production.Product`, `Production.ProductSubcategory`, `Production.ProductCategory` — merged into one `ProductDim` table with Power Query, so product, subcategory, and category all live together instead of in three separate tables

**Cleanup with Power Query:**
- Renamed tables and columns to clearer names
- Removed columns I wasn't going to use
- Added the order **Status** as text (based on the database's status function) instead of just a status number
- Built the Total Due, Tax, and Freight figures

**Star schema:** `Fact Sales` sits in the middle, connected out to `ProductDim`, `TerritoryDim`, `ShipMethodDim`, `VSalesPerson`, and a `DatesDim` date table.

**Product Hierarchy:** built on `ProductDim` as `Category → Subcategory → Product`, so I can drill down from a category into individual products on one chart.

**Handling three different dates (role-playing dimension):** `Fact Sales` actually has three date columns — Order Date, Ship Date, and Due Date — but a table can only be "actively" connected to the date table through one of them at a time. I kept **Order Date** as the active connection, and used DAX's `USERELATIONSHIP` function to build two extra measures that temporarily switch the connection to Ship Date or Due Date just for that one calculation. That's what lets one chart compare orders by all three dates side by side.

### DAX Measures I created
| Measure | What it does |
|---|---|
| `Number of Orders` | Counts unique orders using `DISTINCTCOUNT`, so multi-line orders aren't counted twice |
| `Total SubTotal` | Adds up the line totals before tax and freight |
| `Total Tax` | Adds up the tax charged |
| `Total Freight` | Adds up the shipping/freight cost |
| `Total Due` | Adds up the final amount owed |
| `Number of Qty` | Adds up the quantity ordered |
| `M_OrderDate` | Counts orders using the normal, active Order Date connection |
| `M_ShipDate` | Counts orders by Ship Date, using `USERELATIONSHIP` to switch to that date column just for this measure |
| `M_DueDate` | Counts orders by Due Date, the same way as above |

I kept all of these in a separate **Measures Table** instead of mixing them into `Fact Sales`, to keep the model easy to navigate.

---

## 5. Dashboard Layout

### KPI Cards (top row, main page)
Number of Orders, Total SubTotal, Total Tax, Total Freight, and Total Due — the headline numbers, so anyone opening the report sees the overall scale straight away.

### Charts — What They Show and Why I Picked Them

| Chart | Type | What it shows | Why I used this chart |
|---|---|---|---|
| **Number of Orders by OrderDate vs. ShipDate vs. DueDate** | Line chart | Order counts over time, once for each of the three date measures | A line chart with three lines lets me compare how order, ship, and due dates line up (or lag behind each other) over the same timeline — something a table of numbers wouldn't show as clearly. |
| **Number of Orders by Ship Method** | Pie chart | Share of orders per shipping method | A pie chart works well here because there's a small number of shipping methods, and the question is really "what share of orders" rather than exact counts. |
| **Number of Orders by Online/Offline** | Donut chart | Orders placed online vs. offline | Same idea as the pie chart — a simple two-way split is easy to read as a share of the whole. |
| **Order Qty by Category / Subcategory / Product** | Treemap with drill-down | Quantity ordered, broken down by the product hierarchy | A treemap makes it easy to spot the biggest categories and products at a glance, since size = quantity. Using the Product Hierarchy lets me click into a category and drill down to individual products on the same visual. |
| **Number of Orders and Total Due by Territory** | Combo chart (columns + line) | Order count and order value together, per territory | I used a combo chart so I could compare order *count* (columns) against order *value* (line) for each territory in one view — a territory with a lot of orders isn't always the one bringing in the most money. |
| **Top 10 Sales Persons by Number of Orders** | Clustered bar chart | The 10 salespeople with the most orders | I used a Top N filter here instead of showing everyone, since the point of this chart is to highlight the top performers, not list the whole sales team. |

### Slicers (filters)
Date, Territory, and Online/Offline flag — so the whole main page can be filtered down to a specific time period, region, or order type.

### Drill-Through: Sales Person Details Page
![Dashboard Preview](https://github.com/nourhankha1ifa/Data_Analysis/blob/main/EraaSoft/Power%20BI/Power%20BI%203/Drill%20Through%20Snapshot.png)

<br>

Right-clicking a salesperson on the main page's Top 10 chart jumps to a dedicated **Sales Person Details** page, filtered to just that person. It shows their own KPI cards (orders and total due), their orders by territory, their orders by product category, and their trend over time — plus a back button to return to the main page. I used drill-through here so the main page can stay focused on the big picture, while still letting someone dig into one salesperson's numbers without cluttering the main view.

### Tooltip Page
A small page (`TT`) set up as a tooltip, showing order count, total due, and quantity broken down by status. It pops up on hover instead of taking up space on the main page — the same idea I practiced in my second project, just applied to status detail this time.

---

## 6. Design Notes
- Consistent theme color used for the page background across all pages.
- Chart titles are written in plain, meaningful language (e.g. "Number of Orders and Total Due by Territory") so each visual is understandable without extra explanation.

---

## 7. Business Impact

Even as a learning project, this kind of dashboard has real value in a business setting:

- **Live, always-current data:** because it uses DirectQuery instead of an imported copy, the numbers reflect the database as it is right now, not a snapshot from whenever the file was last refreshed.
- **Spotting timing problems:** comparing order date, ship date, and due date on one chart makes it easy to notice if shipping is falling behind orders.
- **Product and territory insight:** the treemap and the territory combo chart both help identify where the business is strongest, and where order volume and order value don't line up.
- **Recognizing top performers:** the Top 10 salespeople chart, with drill-through to full details, gives a fast way to identify and then dig into the team's best performers.
- **A reusable, well-structured model:** merging the product tables, building a proper star schema, and handling the three date roles properly means this model can support many more reports later without rebuilding the foundation.

---

## 8. File Reference
| File | Purpose |
|---|---|
| `Sales_Performance_Dashboard.pbit` | The Power BI template file |
