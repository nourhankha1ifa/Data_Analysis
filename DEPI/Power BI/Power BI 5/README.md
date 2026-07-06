# Adventure Works Order Analysis Dashboard
![Dashboard Preview](https://github.com/nourhankha1ifa/Data_Analysis/blob/main/DEPI/Power%20BI/Power%20BI%205/Dashboard%20Snapshot.png)
<br>

This is my fifth Power BI project, based on the AdventureWorks2025 database. It covers the full path from raw database tables to a finished dashboard: building a star schema in Power Query, connecting it with relationships, writing DAX measures, and putting together a one-page Order Analysis report.

---

## 1. Overview

The dashboard looks at AdventureWorks sales orders and shows how many there are, how much money is involved, and how orders break down by product, shipping method, and territory.

| | |
|---|---|
| **Report pages** | 1 |
| **Data source** | AdventureWorks2025 database |
| **Tools used** | Power BI Desktop (Power Query, Data Modeling, DAX) |

---

## 2. Business Problem

AdventureWorks stores order data across several separate database tables — orders, order lines, products, categories, shipping methods, and territories — with no single place that shows the overall picture. Without pulling it together, it's hard to answer basic questions like:

- How many orders and order lines are there, and how much money is involved (subtotal, tax, freight, total due)?
- How does order volume trend over time?
- Which product categories, sub-categories, and products get ordered the most?
- Which shipping methods are most used, and which territories bring in the most orders and money?

## 3. Goal of the Dashboard

The goal was to build a proper data model from the AdventureWorks tables and turn it into a single dashboard page that can answer those questions:

1. Bring in the Order, OrderDetail, Product, ProductSubcategory, ProductCategory, ShipMethod, and Territory tables and connect them properly.
2. Write DAX measures for the key numbers instead of relying on default totals.
3. Build one clear, well-labeled page covering KPIs, order trend, product breakdown, shipping method, and territory.

---

## 4. Data Source and Modeling

**Data source:** the AdventureWorks2025 database.

**Data model:** `Order` and `OrderDetail` sit at the center as the fact tables (one order can have several order-line rows), connected out to:

| Table | What it holds |
|---|---|
| `Territory` | Sales territory and region group |
| `ShipMethod` | Shipping method |
| `Product` | Individual products |
| `ProductSubcategory` | Product sub-category, linked to `Product` |
| `ProductCategory` | Product category, linked to `ProductSubcategory` |

**A chain of dimension tables:** rather than merging product, sub-category, and category into one flat table, I kept them as three separate connected tables (`Product → ProductSubcategory → ProductCategory`), each linked by its own key. This keeps the model closer to how the database itself is structured.

**Dates:** `Order` includes OrderDate, DueDate, and ShipDate, but for this dashboard I focused the actual reporting on **OrderDate** — that's the one used for the trend chart and the date slicer. DueDate and ShipDate are in the model but weren't built into a visual on this page.

**DAX Measures Table:** I kept all my measures together in a separate `DAX Measures` table rather than mixing them into `Order` or `OrderDetail`.

### DAX Measures I created
| Measure | DAX | What it does |
|---|---|---|
| `# Orders` | `COUNT('Order'[OrderID])` | Counts the number of orders |
| `# Order Details` | `COUNT(OrderDetail[OrderDetailID])` | Counts the number of individual order lines |
| `Total Amount` | `SUM('Order'[SubTotal])` | Adds up the subtotal before tax and freight |
| `Total Tax` | `SUM('Order'[TaxAmt])` | Adds up tax charged |
| `Total Frieght` | `SUM('Order'[Freight])` | Adds up shipping cost |
| `Total Due` | `SUM('Order'[TotalDue])` | Adds up the final amount owed |

---

## 5. Dashboard Layout

### KPI Cards (top row)
Six separate cards: `# Orders`, `# Order Details`, `Total Amount`, `Total Tax`, `Total Frieght`, and `Total Due` — the headline numbers, so anyone opening the report sees the overall scale straight away.

### Charts — What They Show and Why I Picked Them

| Chart | Type | What it shows | Why I used this chart |
|---|---|---|---|
| **Num of Orders by Date** | Line chart | Order count over time (by Order Date) | A line chart is the clearest way to see whether order activity is growing, shrinking, or seasonal over time. |
| **Num of Orders by Category** | Treemap | Order count broken down by Category, Sub-Category, and Product | A treemap makes the biggest categories and products immediately visible by the size of each block, which works well when comparing many products at once rather than just a handful. |
| **Num of Orders by ShipMethod** | Pie chart | Share of orders per shipping method | There's a small, fixed set of shipping methods, so a pie chart is a natural fit for a "what share of orders" question. |
| **Num of Orders and Total Amount by Territory** | Combo chart (line + stacked column) | Order count and order value together, per territory | I used a combo chart so I could compare order *count* against order *value* for each territory in one view — a territory with a lot of orders isn't always the one bringing in the most money. |

### Slicers
| Slicer | Field |
|---|---|
| OrderDate | Order Date |
| Territory | Territory |

These let the whole page be filtered down to a specific date range or territory.

---

## 6. Design Notes
- Kept everything on one page, since the dashboard tells one connected story about order activity.
- Chart titles are written in plain, meaningful language (e.g. "Num of Orders and Total Amount by Territory") so each visual is understandable without extra explanation.

---

## 7. Business Impact

- **A model that mirrors the real database:** keeping Product, Sub-Category, and Category as separate connected tables (instead of flattening them) means the model stays close to how AdventureWorks itself is structured, which makes it easier to extend later.
- **Trend visibility:** the order-count line chart makes it easy to see whether the business is growing or slowing down over time.
- **Product insight:** the treemap highlights which categories and products actually drive order volume.
- **Shipping and territory insight:** seeing shipping method share and order count vs. order value by territory both help identify operational and sales patterns at a glance.
- **A flexible report:** with date and territory slicers, the same one-page dashboard can answer different questions just by changing which filters are applied.

---

## 8. File Reference
| File | Purpose |
|---|---|
| `Order_Analysis_Dashboard.pbix` | The Power BI report file |
| **Database used** | `AdventureWorks2025.bak` |

