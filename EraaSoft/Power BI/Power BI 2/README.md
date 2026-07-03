# AdventureWorks - Sales Dashboard
![Dashboard Preview](https://github.com/nourhankha1ifa/Data_Analysis/blob/main/EraaSoft/Power%20BI/Power%20BI%202/AdventureWorks%20Snapshot.png)

<br>

This is my second Power BI project. I built it to practice a bit more than the first one: building a proper star schema data model, writing DAX measures, using a product hierarchy with drill-down, and adding a tooltip page. It is still a learning project, not a finished, production-ready dashboard.

---

## 1. Overview

The dashboard looks at AdventureWorks sales orders and shows simple facts like how many orders there are, how much money was due, and how orders break down by status, product, and territory.

| | |
|---|---|
| **Report pages** | 2 (1 main page + 1 tooltip page) |
| **Data source** | `Sales.xlsx` |
| **Tools used** | Power BI Desktop (Power Query, Data Modeling, DAX) |

---

## 2. Why I Made This

After my first project, I wanted to practice building a proper data model instead of just working from one big flat table. AdventureWorks sales data was a good fit because it has clear separate pieces of information (orders, products, territories, statuses, dates) that are perfect for practicing a star schema, and it gave me a reason to write real DAX measures instead of just using default sums.

## 3. Goal of the Dashboard

The goal was to take the raw `Sales.xlsx` file and turn it into a model and a page that can answer simple questions like:

- How many orders and order details are there, and how much money is due, taxed, and shipped?
- How do orders break down by their status (shipped, cancelled, etc.)?
- Which product categories, sub-categories, and products get ordered the most?
- Which territories bring in the most orders and the most money?
- How does the number of orders change over time?

This is still a practice project, so I kept it to one main dashboard page plus one tooltip page, rather than building out a full multi-page report.

---

## 4. Data Source and Modeling

**Data source:** a single Excel file, `Sales.xlsx`.

**Star schema:** I split the raw sales data into one central `Fact` table (the individual order line details: quantity, unit price, line total, tax, freight, total due) surrounded by dimension tables:

| Table | What it holds |
|---|---|
| `Fact` | Order details — quantity, price, totals, tax, freight, and IDs linking to the dimensions |
| `DateDim` | Order date, due date, and ship date |
| `ProductDim` | Product, sub-category, and category |
| `TerritoryDim` | Territory and territory group |
| `StatuesDim` | Order status |
| `ShipMethodDim` | Shipping method |

**Product Hierarchy:** built on `ProductDim` as `Category → SubCategory → Product`, so I can drill down from a big category into individual products on one chart.

**Measures Table:** I made a separate table just to hold my DAX measures, instead of mixing them into the Fact table. This keeps the model tidy and makes the measures easy to find.

### DAX Measures I created
| Measure | DAX | What it does |
|---|---|---|
| `Number of Orders` | `DISTINCTCOUNT('Fact'[OrderID])` | Counts unique orders (not order lines) |
| `Number of Order Details` | `COUNT('Fact'[OrderDetailID])` | Counts every individual order line |
| `Total SubTotal` | `SUM('Fact'[LineTotal])` | Adds up the line totals before tax and freight |
| `Total Tax` | `SUM('Fact'[TaxAmt])` | Adds up the tax charged |
| `Total Freight` | `SUM('Fact'[Freight])` | Adds up the shipping/freight cost |
| `Total Due` | `SUM('Fact'[TotalDue])` | Adds up the final amount owed on each order |

Using `DISTINCTCOUNT` for Number of Orders instead of a plain count was important — one order can have several order detail lines, so counting rows would have counted the same order more than once.

---

## 5. Dashboard Layout

**Header:** "AdventureWorks - Sales Dashboard" — a title text box at the top of the page.

### KPI Cards (top row)
| Card | Measure |
|---|---|
| Number of Orders | `Number of Orders` |
| Number of Order Details | `Number of Order Details` |
| Total SubTotal | `Total SubTotal` |
| Total Tax | `Total Tax` |
| Total Freight | `Total Freight` |
| Total Due | `Total Due` |

I put all six numbers at the top so anyone looking at the page gets the full financial picture right away.

### Charts — What They Show and Why I Picked Them

| Chart | Type | Fields | Why I used this chart |
|---|---|---|---|
| **Orders by Status** | Bar chart | Status, Number of Orders | A bar chart makes it easy to compare order counts across a small set of statuses (shipped, cancelled, in process, etc.) at a glance. |
| **Orders by Territory Group** | Donut chart | Territory Group, Number of Orders | A donut chart is good for showing how orders are split as a share of the whole across a small number of territory groups. |
| **Order Qty by Category / Sub-Category / Product** | Column chart with drill-down | Product Hierarchy, Order Qty | I used the Product Hierarchy here so I could click into a category and drill all the way down to individual products on the same chart, instead of building three separate charts. |
| **Orders over Time** | Line chart | Number of Orders, Order Date (Year/Quarter/Month/Day) | A line chart is the clearest way to see a trend over time, and using the date hierarchy lets me zoom from year level down to day level on the same chart. |
| **Orders vs. Total Due by Territory** | Clustered column chart | Territory, Total Due, Number of Orders | I put two measures side by side here so I could compare order *count* against order *value* per territory — a territory with many orders isn't always the one bringing in the most money. |

### Slicers (filters)
| Slicer | Field |
|---|---|
| Year | Order Date (Year) |
| Month | Order Date (Month) |

These let me filter the whole page down to a specific year or month.

### Tooltip Page
I built a small second page (`tt - Territory`) that isn't seen directly — it's set as a **tooltip page**, so it pops up with extra detail (Number of Orders) when hovering over a visual, instead of taking up space on the main page. This was new to me in this project and a good way to add more detail without cluttering the dashboard.

---

## 6. Design Notes
- Light grey page background (`#F3F2F1`) to keep the focus on the charts and cards.
- Kept the visuals with default titles for now rather than customizing every one, since the focus of this project was the data model and measures, not visual polish.

---

## 7. What I Learned / Impact of This Project

This was mainly a learning project, so the biggest value was for me:

- Practiced building a proper star schema instead of working off one flat table.
- Practiced writing real DAX measures, including `DISTINCTCOUNT` to avoid double-counting orders.
- Practiced building a hierarchy (Product) for drill-down charts.
- Learned how to build and use a tooltip page for the first time.

As a side effect, the dashboard also gives a clear, honest picture of AdventureWorks sales activity — order volume, financials, and how sales are spread across products and territories. It's a solid base I could expand into a bigger, multi-page report later.

---

## 8. Business Impact

Even as a practice project, this kind of setup has real value in a business context:

- **Faster answers:** anyone can filter by year or month and instantly see order volume and total money due, without digging through the raw Excel file.
- **Clearer product performance:** the drill-down chart shows which categories and products are actually being ordered, which helps with stocking and planning decisions.
- **Territory comparison:** seeing order count next to order value by territory highlights which regions are high-volume versus high-value, which is useful for sales strategy.
- **A reusable model:** because the data is now structured as a star schema with real measures, it's much easier to extend later (new visuals, new pages) than if everything were built directly on one flat table.

---

## 9. File Reference
| File | Purpose |
|---|---|
| `AdventureWorks_-_Sales_Dashboard.pbit` | The Power BI template file |
| `Sales.xlsx` | Raw source data |

