# My Power BI Learning Journey

This is a summary of what I learned across my three Power BI projects, going from a simple one-page dashboard on CSV files to a live-connected, multi-page dashboard with drill-through. Each project built directly on the one before it.

---

## The Journey at a Glance

| Project | Data Source | Focus | What it added |
|---|---|---|---|
| **1. Kickstarter Projects Analysis** | 2 CSV files | The basics | Power Query cleanup, appending files, a simple data model, first DAX measures, one-page dashboard |
| **2. AdventureWorks - Sales Dashboard** | 1 Excel file | Proper data modeling | Star schema, dimension tables, a product hierarchy with drill-down, a Measures Table, a tooltip page |
| **3. Sales Performance Dashboard** | Live SQL database | Real-world complexity | DirectQuery, a role-playing date dimension (`USERELATIONSHIP`), drill-through, Top N filtering |

---

## Project 1 – Kickstarter Projects Analysis Dashboard
![Dashboard Preview](https://github.com/nourhankha1ifa/Data_Analysis/blob/main/EraaSoft/Power%20BI/Power%20BI%201/Kickstarter%20Snapshot.png)

<br>

My first project. The goal was just to get comfortable with the core Power BI workflow: bring in data, clean it, model it, and put a few visuals on a page.

**Key ideas:** using Power Query to add a custom column, **append** two yearly CSV files into one combined table, and rename that table to something clear. Writing my first real DAX measures (`COUNT`, `DISTINCTCOUNT`, `SUM`). Building a simple hierarchy (`main_category → category → name`) so one chart could drill down instead of needing three separate charts. Everything lived on a single page with two slicers (Country, Year).

**What I learned:** the basic shape of a Power BI project — Power Query for cleanup, a small data model, measures instead of relying on default aggregations, and picking chart types based on what the data actually needed to show (a line for a trend, a filtered column chart for a "top N" comparison).

## Project 2 – AdventureWorks - Sales Dashboard
![Dashboard Preview](https://github.com/nourhankha1ifa/Data_Analysis/blob/main/EraaSoft/Power%20BI/Power%20BI%202/AdventureWorks%20Snapshot.png)

<br>

My second project moved from one flat, combined table to a **proper star schema** — separate fact and dimension tables connected by relationships, the way real Power BI models are usually built.

**Key ideas:** splitting the data into a central `Fact` table and separate dimension tables (`ProductDim`, `TerritoryDim`, `StatuesDim`, `ShipMethodDim`, `DateDim`). Keeping all my DAX measures together in their own **Measures Table** instead of mixing them into the fact table. Using `DISTINCTCOUNT` properly for the first time, since one order could have several order-line rows and a plain count would have counted it more than once. Building my first **tooltip page**, so extra detail could pop up on hover instead of cluttering the main page.

**What I learned:** why a star schema matters — it keeps the model organized and makes measures and relationships much easier to reason about than one giant flat table. This project is where Power BI started to feel like real data modeling instead of just chart-building.

## Project 3 – Sales Performance Dashboard
![Dashboard Preview](https://github.com/nourhankha1ifa/Data_Analysis/blob/main/EraaSoft/Power%20BI/Power%20BI%203/Dashboard%20Snapshot.png)

<br>

My third project was the most advanced: connecting to a real, live database instead of static files, and handling problems that only show up with more complex, realistic data.

**Key ideas:** connecting with **DirectQuery** so the report always reflects the live database instead of a saved copy. Merging three separate product tables into one clean `ProductDim` with Power Query. Solving the **role-playing dimension** problem — one date table, but three different date columns on the fact table (Order Date, Ship Date, Due Date) — by keeping one relationship active and using `USERELATIONSHIP` inside DAX measures to temporarily activate the other two. Adding a real **Top N filter** to highlight the top 10 salespeople instead of listing everyone. Building a **drill-through** page for the first time, so clicking a salesperson jumps to a dedicated details page just for them.

**What I learned:** how to handle the kind of messy, interconnected complexity that shows up in real business data — multiple date roles, live data connections, and giving people a way to go from a summary view to a detailed view without overloading a single page.

---

## How It All Connects

Looking back, the three projects form one continuous line of increasing complexity:

1. **Learn the basics** — Power Query, a simple model, first measures, one page (Project 1)
2. **Learn proper modeling** — star schema, dimension tables, a Measures Table, drill-down, tooltips (Project 2)
3. **Learn real-world complexity** — live connections, role-playing dimensions, drill-through, Top N filtering (Project 3)

Each project kept the things I'd already learned (Power Query cleanup, DAX measures, meaningful chart titles, slicers) and added exactly one or two new, harder ideas on top. By the third project, things like writing a measure or picking the right chart type felt automatic, which left room to focus on the genuinely new parts — DirectQuery and the date relationship problem.
