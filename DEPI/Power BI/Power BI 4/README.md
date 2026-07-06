# Sales Dashboard — Star Schema & Analysis
![Dashboard Preview](https://github.com/nourhankha1ifa/Data_Analysis/blob/main/DEPI/Power%20BI/Power%20BI%204/Dashboard%20Snapshot.png)
<br>

This is my fourth Power BI project. The focus this time was on properly building a **star schema from scratch in Power Query** — splitting one flat sales file into a fact table and several dimension tables — and then building a dashboard on top of that model.

---

## 1. Overview

The dashboard analyzes AdventureWorks-style sales orders: how many there are, how much money is involved, and how orders break down by status, product, territory, and date.

| | |
|---|---|
| **Report pages** | 1 |
| **Data source** | `Data Source Sales.xlsx` (one flat sheet, split into a star schema in Power Query) |
| **Tools used** | Power BI Desktop (Power Query, Data Modeling, DAX) |

---

## 2. Business Problem

The raw sales file is one big flat sheet — every order-line row repeats its status text, territory name, ship method, and product details over and over. That's fine for storing data, but bad for analyzing it: it's slow, hard to filter cleanly, and doesn't let Power BI build proper relationships. Without restructuring it, it's hard to answer basic questions like:

- How many orders and order lines are there, and how much money is involved (subtotal, tax, freight, total due)?
- How does order volume change depending on whether you look at order date, due date, or ship date?
- How do orders break down by status, and by product category/sub-category/product?
- Which territories bring in the most orders and the most money?

## 3. Goal of the Dashboard

The goal was to turn that one flat sheet into a proper star schema, then build a single dashboard page that can answer those questions:

1. Split the flat sales sheet into a **fact table** (the actual order-line measurements) and separate **dimension tables** (status, territory, ship method, product, and three separate date tables).
2. Connect them all with relationships instead of repeating text everywhere.
3. Write DAX measures for the key numbers instead of relying on default sums.
4. Build one clear, well-labeled dashboard page covering KPIs, dates, status, product hierarchy, and territory.

---

## 4. Data Source and Modeling

**Data source:** `Data Source Sales.xlsx`, a single "Sales" sheet with one row per order line.

**Building the star schema in Power Query:** I loaded the same raw sheet multiple times as **separate queries**, and trimmed each one down to just the columns it needed:

| Table | Role | Kept columns |
|---|---|---|
| `FactSales` | The center of the star — one row per order line | OrderDetailID, OrderID, quantity, unit price, line total, tax, freight, total due, plus the ID columns linking out to every dimension |
| `DimProduct` | Product details | ProductID, Product, ProductSubCategory, ProductCategory |
| `DimStatus` | Order status lookup | StatusID, Status |
| `DimTerritory` | Territory lookup | TerritoryID, Territory, TerritoryGroup |
| `DimShipMethod` | Shipping method lookup | ShipMethodID, ShipMethod |
| `DimOrderFlag` | Online vs. offline order lookup | OnlineOrderFlag, Flag |
| `DimOrderDate` | A date table for **Order Date** | Just the order date column, de-duplicated |
| `DimDueDate` | A date table for **Due Date** | Just the due date column, de-duplicated |
| `DimShipDate` | A date table for **Ship Date** | Just the ship date column, de-duplicated |

**Handling three different dates:** instead of using one shared date table and switching between relationships with `USERELATIONSHIP` (which I practiced in an earlier project), this time I built **three separate date dimension tables** — one each for Order Date, Due Date, and Ship Date — all connected to `FactSales` as normal, active relationships. This is a different, simpler way to solve the same "which date do I mean?" problem: instead of one shared table with tricky relationship-switching, each date role just gets its own table.

**Relationships:** `FactSales` connects out to every dimension table above through its matching ID column (StatusID, TerritoryID, ShipMethodID, ProductID, OnlineOrderFlag, and the three date keys).

**Product Hierarchy:** built on `DimProduct` as `ProductCategory → ProductSubCategory → Product`, so I can drill down from a category into individual products on one chart.

### DAX Measures I created
| Measure | DAX | What it does |
|---|---|---|
| `Number of Orders` | `DISTINCTCOUNT(FactSales[OrderID])` | Counts unique orders, not order lines |
| `Number of Order Details` | `COUNT(FactSales[OrderDetailID])` | Counts every individual order line |
| `SubTotal` | `SUM(FactSales[LineTotal])` | Adds up line totals before tax and freight |
| `Total Tax` | `SUM(FactSales[TaxAmt])` | Adds up tax charged |
| `Total Freight` | `SUM(FactSales[Freight])` | Adds up shipping cost |
| `Total Due` | `SUM(FactSales[TotalDue])` | Adds up the final amount owed |

Using `DISTINCTCOUNT` for Number of Orders was important again here — one order can have several order-line rows, so a plain count would count the same order more than once.

---

## 5. Dashboard Layout

**KPI card:** a single multi-row card showing all six headline numbers together — Number of Orders, Number of Order Details, SubTotal, Total Tax, Total Freight, and Total Due — so the full financial picture is visible in one glance without needing six separate cards.

### Charts — What They Show and Why I Picked Them

| Chart | Type | What it shows | Why I used this chart |
|---|---|---|---|
| **Orders by OrderDate / DueDate / ShipDate** | Line chart, 3 lines | Order counts over time, once for each date role | A line chart with three lines lets me directly compare how order, due, and ship dates track against each other over the same timeline — useful for spotting delays between when an order is placed and when it actually ships. |
| **Orders by Status** | Pie chart | Share of orders per status | The order statuses are a small, fixed set, so a pie chart works well for showing what share of orders fall into each one. |
| **Orders by Category / Sub-Category / Product** | Treemap with drill-down | Order count broken down by the product hierarchy | A treemap makes the biggest categories and products immediately visible by size, and using the Product Hierarchy means I can drill from category down to individual products on the same visual. |
| **Order Details and Total Due by Territory** | Combo chart (columns + line) | Order-line count and total money due, per territory | I used a combo chart so I could compare order *volume* (columns) against order *value* (line) for each territory in one view — a territory with a lot of order lines isn't always the one bringing in the most money. |

### Slicers
| Slicer | Field |
|---|---|
| Territory | Territory |
| Territory Group | Territory Group |
| Order Date | Order Date (Year/Month/Day) |
| Product Details | Product Category / Sub-Category |

These let the whole page be filtered down to a specific region, time period, or product group at once.

---

## 6. Design Notes
- Kept everything on one page since the dashboard covers one connected story (orders, money, and where/what/when they relate to).
- Used a single multi-row KPI card instead of six separate cards, to keep the top of the page compact.

---

## 7. Business Impact

- **A model built the right way:** splitting one flat sheet into a proper star schema means the model is smaller, faster, and much easier to build new charts on top of later, compared to working off one repeated flat table.
- **Spotting shipping delays:** comparing order, due, and ship dates on one chart makes it easy to notice if orders are shipping later than expected.
- **Product performance:** the drill-down treemap shows which categories and products actually generate the most order volume.
- **Territory comparison:** seeing order-line count next to total money due by territory highlights which regions are high-volume versus high-value.
- **A flexible report:** with slicers for territory, date, and product, the same one-page dashboard can answer very different questions just by changing filters.

---

## 8. File Reference
| File | Purpose |
|---|---|
| `Sales_Dashboard.pbix` | The Power BI report file |
| `Data_Source_Sales.xlsx` | Raw source data |
