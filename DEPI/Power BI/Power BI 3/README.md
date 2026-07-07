# Amazon Product Analysis Dashboard

This is my third Power BI project. It combines two different Amazon datasets — order transactions and a product catalog — into one dashboard, and practices some things I hadn't done before: a Sales-vs-Units toggle switch, a product picker page, and a tooltip page that mirrors a full page of detail.

---

## 1. Overview

The dashboard analyzes Amazon order data alongside product catalog details (price, rating, reviews, and product image), so I can see both **how well products sell** and **what the product actually looks like** in one place.

| | |
|---|---|
| **Report pages** | 4 (Overview, Products, Product View, Tool tip) |
| **Data source** | `Amazon Sale Report - YT.xlsx` (orders) + `amazon-fashion - YT.csv` (product catalog) |
| **Tools used** | Power BI Desktop (Power Query, Data Modeling, DAX) |

---

## 2. Business Problem

Order data and product data usually live in two separate places — a sales/orders export, and a separate product catalog with pricing, images, and reviews. Looked at separately, neither one tells the full story:

- The orders file shows what sold, but not what the product looks like, its rating, or how many reviews it has.
- The product catalog shows the product details, but not how it's actually selling.

Without joining them, it's hard to answer questions like:

- How many orders come in, how many units sell, and what's the total sales value — and how does that change if I want to see it in Sales ($) versus Units instead?
- Which cities and states generate the most sales?
- How does a single product perform — its price, its sales, its units sold, and its customer reviews — all in one view?

## 3. Goal of the Dashboard

The goal was to connect the two datasets and build a dashboard that can answer both the "big picture" and "single product" versions of those questions:

1. Join the orders data to the product catalog so every order line knows its product's category, price, image, and rating.
2. Build a **Sales vs. Units toggle**, so the same charts can switch between showing money and showing quantity, without needing two separate sets of charts.
3. Give an overview page for the big picture, plus a dedicated page to look up and inspect one specific product in detail.

---

## 4. Data Source and Modeling

**Data sources:**
- `Amazon` — the orders table (Order ID, Date, Status, Category, Size, ASIN, Qty, ship-city, ship-state, Amount, Total_Amount, and more)
- `amazon-fashion - YT` — the product catalog (ASIN, brand, colour, description, product name, product image URL, rating, sales price, category, seller info, and number of reviews)

**Relationships:** `Amazon` connects to `amazon-fashion - YT` through the shared `ASIN` (Amazon Standard Identification Number) — the code that uniquely identifies each product — so an order line can pull in its product's full catalog details. `Amazon` also connects to a built-in date table through its `Date` column.

**A small manual table for the toggle:** `Sale_Option` is a table I built by hand (not imported from a file) with just two rows — "Sales" and "Units" — used purely to drive a slicer that switches what the charts display.

### DAX Measures I created
| Measure | DAX (simplified) | What it does |
|---|---|---|
| `Sale_Amount` | `SUM(Amazon[Total_Amount])` | Total money from sales |
| `Sale_Units` | `SUM(Amazon[Qty])` | Total quantity sold |
| `Filter_Sale` | Checks which option is selected in `Sale_Option`, then returns `Sale_Amount` or `Sale_Units` | This is the actual toggle — one measure that returns a different number depending on which slicer option is picked |
| `All_Overall_Sale` | `CALCULATE([Filter_Sale], ALL('amazon-fashion - YT'[Category]))` | The overall total (Sales or Units, depending on the toggle), ignoring any category filter — useful for showing "total across everything" next to a filtered chart |
| `Order_Counts` | Counts sellers where the order status contains "Delivered" | Counts delivered orders specifically, not all orders regardless of status |
| `Review` | Sums up the number of reviews, showing `0` instead of blank if there's no data | A safe review count that won't show a blank card if a product has no reviews |

Using a **SELECTEDVALUE + IF pattern** for `Filter_Sale` was the key new DAX idea here — instead of building two separate charts (one for sales, one for units), one measure reads which option the user picked and returns the right number, so the same chart works for both.

> **Note:** while working on this, I also drafted a few extra measures and dynamic icon-image ideas (like a Seller Count, a Return Units measure, and icons that appear/disappear based on the toggle) which are saved in `Amazon_Measure_Script & Url_Image.docx` as notes, but they didn't make it into this final version of the dashboard.

---

## 5. Dashboard Pages, Charts, and Why I Picked Them

### Page 1 — Overview
![Dashboard Preview](https://github.com/nourhankha1ifa/Data_Analysis/blob/main/DEPI/Power%20BI/Power%20BI%203/P1_Overview.png)
<br>

**Cards:** the current toggle value (Sales or Units), Order_Counts, and All_Overall_Sale — the headline numbers, reacting live to whichever toggle option is selected.

| Chart | Type | What it shows | Why I used this chart |
|---|---|---|---|
| **Sales by City** | Clustered bar chart | Sales/Units by shipping city | A horizontal bar chart handles city names of different lengths better than vertical columns. |
| **Sales by State** | Clustered bar chart | Sales/Units by shipping state | Same reasoning — state names read more clearly as horizontal bars. |
| **Sale Units** (trend) | Area chart | Sales/Units over time | An area chart shows the trend over time while also giving a sense of overall volume through the filled area, which felt right for a "how much are we selling over time" question. |

**Slicers:** Category, Status, and the **Sale_Option toggle** (Sales vs. Units) — the toggle is what makes every chart on this page switch between money and quantity.

### Page 2 — Products
![Dashboard Preview](https://github.com/nourhankha1ifa/Data_Analysis/blob/main/DEPI/Power%20BI/Power%20BI%203/P2_Products.png)
<br>

A product-browsing page: pick a Category, then pick a specific Product from the list, ready to jump into that product's detail view.

### Page 3 — Product View
![Dashboard Preview](https://github.com/nourhankha1ifa/Data_Analysis/blob/main/DEPI/Power%20BI/Power%20BI%203/P3_Product%20view.png)
<br>

A single-product detail page, built around the product picked on the Products page.

| Element | Type | What it shows |
|---|---|---|
| Product image | Card (image) | The actual product photo, pulled from the catalog's image URL |
| Sale_Amount, Sale_Units, Total_Amount, Review | Cards | That one product's total sales, total units, total amount, and review count |
| **Units** | Area chart (by Year/Quarter/Month/Day) | How that single product's units sold have trended over time, drillable from year down to day |

I used cards with a live product image here specifically so the page feels like a proper product page, not just a table of numbers — seeing the product alongside its stats makes the data easier to connect to something real.

### Page 4 — Tool tip
![Dashboard Preview](https://github.com/nourhankha1ifa/Data_Analysis/blob/main/DEPI/Power%20BI/Power%20BI%203/Tooltip.png)
<br>

A page set up as an actual **tooltip page**, mirroring the same cards and area chart as Product View. It's designed to pop up on hover elsewhere in the report, so someone can see a product's key stats without leaving the page they're on.

---

## 6. Design Notes
- Reused the same Category slicer and page-navigation control across all 4 pages, so moving between the overview and product-level views feels consistent.
- Kept a light background (`#F8F8F8`) with an orange accent (`#FF9F10`) for KPI highlights, based on the colour notes I kept while building this.

---

## 7. Business Impact

- **One toggle instead of two dashboards:** the Sales-vs-Units switch means the same set of charts answers two different questions, instead of needing a duplicate set of "Units" charts next to the "Sales" ones.
- **Geographic insight:** the city/state charts make it easy to spot where demand is strongest.
- **Product-level accountability:** the Product View page means a single product's performance (and its actual image and reviews) can be checked directly, not just its aggregate row in a table.
- **Faster spot-checks via tooltip:** the Tool tip page means a product's stats can be glanced at without navigating away from wherever the person currently is in the report.
- **A joined, reusable model:** connecting the sales and product-catalog data through ASIN means any future chart can pull from both sides (price, rating, sales, units) without needing a manual lookup each time.

---

## 8. File Reference
| File | Purpose |
|---|---|
| `Amazon.pbit` | The Power BI template file |
| `Amazon_Sale_Report_-_YT.xlsx` | Raw order/sales data |
| `amazon-fashion_-_YT.csv` | Raw product catalog data |
| `Amazon_Measure_Script___Url_Image.docx` | My working notes — draft DAX measures, image URLs, and colour codes used while building this |
