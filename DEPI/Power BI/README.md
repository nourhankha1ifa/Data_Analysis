# My Power BI Learning Journey

This is a summary of what I learned across six Power BI projects, going from basic data cleaning all the way to a full multi-page, multi-table healthcare dashboard. Each project built on the skills from the one before it.

---

## The Journey at a Glance

| # | Project | Data Source | Focus |
|---|---|---|---|
| 1 | Data Science Survey — Data Cleaning | Data Science Survey.xlsx | Power Query cleaning only, no charts yet |
| 2 | Data Science Voter Analysis Dashboard | Same cleaned survey data | First real dashboard: KPIs, charts, slicers, 3 pages |
| 3 | Amazon Product Analysis Dashboard | Amazon orders + product catalog | Joining two datasets, a Sales/Units toggle, tooltip page |
| 4 | Sales Dashboard — Star Schema & Analysis | Flat sales sheet | Building a full star schema from scratch in Power Query |
| 5 | Adventure Works Order Analysis Dashboard | AdventureWorks2025 database | Modeling straight from a real database, snowflaked dimensions |
| 6 | Hospital Dashboard (Final Project) | Hospital visit dataset | Full star schema + business logic in Power Query + 3-page dashboard |

---

## Project 1 – Data Science Survey: Data Cleaning

This one didn't have any charts at all — on purpose. The task was specifically to load a messy survey export into Power Query and clean it, nothing else.

**Key ideas:** promoting headers, setting proper data types, removing tracking columns that don't matter (Browser, OS, Referrer), renaming long question text into short clear column names, splitting messy text answers down to the useful part, turning a text salary range like `"100k-150k"` into a real number by splitting, replacing `"k"` with `"000"`, filling in a missing upper bound, and averaging the two ends. I also filled in missing happiness ratings sensibly and removed a clear outlier (an age of 92) before calling the data "ready."

**What I learned:** that cleaning is its own skill, separate from building charts — and that a chart or measure is only as trustworthy as the cleaning that happened before it.

## Project 2 – Data Science Voter Analysis Dashboard

This project picked up exactly where Project 1 left off — same cleaned data, but now actually turned into a dashboard.

**Key ideas:** writing my first proper set of DAX measures (Voters, Avg/Min/Max Salary, Avg/Min/Max Age), splitting the dashboard into 3 focused pages (Overview, Career, Satisfaction) instead of one crowded page, and picking chart types on purpose — horizontal bar charts for long text labels (job titles, ethnicities), donut/pie charts for simple share-of-whole questions (gender, career switch), and a treemap for a ranked-and-sized comparison (career factors).

**What I learned:** how to turn a cleaned table into an actual set of business answers, and that splitting a big dataset across a few focused pages (with slicers on each) makes it far more usable than one giant page.

## Project 3 – Amazon Product Analysis Dashboard

This project introduced working with **two separate datasets** joined together, plus some new DAX and navigation techniques.

**Key ideas:** joining an orders table to a separate product catalog through a shared ID (ASIN), building a small manual table (`Sale_Option`) just to power a slicer, and writing a **SELECTEDVALUE + IF** measure (`Filter_Sale`) so the same charts can toggle between showing Sales ($) and Units depending on what the user picks — instead of building two parallel sets of charts. I also built a dedicated single-product detail page (with a live product image) and a real tooltip page for the first time.

**What I learned:** how to combine multiple data sources properly, and that a single well-designed toggle measure can do the work of several duplicate charts.

## Project 4 – Sales Dashboard: Star Schema & Analysis

This project was about building a **star schema entirely by hand** in Power Query, starting from one flat sales sheet.

**Key ideas:** loading the same raw sheet multiple times as separate queries, trimming each one down into a fact table and several dimension tables, and connecting them all with relationships instead of repeating text everywhere. I also solved the "three different dates" problem differently than before — instead of one shared date table with `USERELATIONSHIP`, I built **three separate date tables** (Order/Due/Ship), each with its own normal, active relationship.

**What I learned:** that there's more than one valid way to model the same problem, and that splitting a flat file into a proper star schema makes the model smaller, faster, and easier to build on.

## Project 5 – Adventure Works Order Analysis Dashboard

This project moved from a flat Excel file to modeling **straight from a real SQL database** (AdventureWorks2025).

**Key ideas:** connecting to the database tables directly, and this time keeping Product, Sub-Category, and Category as three separate connected tables (a snowflake) instead of flattening them into one — closer to how the database itself is actually structured. I also made a deliberate choice to only build the OrderDate into the report, leaving DueDate and ShipDate in the model but unused, rather than forcing every date into a visual.

**What I learned:** modeling directly off a real database instead of a spreadsheet, and that a dimension chain (snowflake) is sometimes a better fit than flattening everything into one table.

## Project 6 – Hospital Dashboard (Final Project)

My final project pulled together everything from the previous five: Power Query cleaning, a full star schema, real DAX measures, and a multi-page dashboard — applied to real hospital visit data.

**Key ideas:** an 8-dimension star schema (patient, doctor, department, date, procedure, diagnosis, payment, hospital), with **business logic built once in Power Query** rather than repeated in every chart — age groups, procedure types, disease categories, and hospital region were all calculated as part of the model, not the report. I used `DIVIDE()` instead of plain division for every ratio measure to avoid divide-by-zero errors, and split the dashboard into 3 pages (Overview, Medical Analysis, Financial Analysis), each independently filterable.

**What I learned:** how to bring cleaning, modeling, DAX, and multi-page report design together into one finished, real-world dashboard — and that classification logic belongs in the model, not scattered across charts.

---

## How It All Connects

Looking back, the six projects form one continuous line:

1. **Learn to clean first** — Power Query only, no charts (Project 1)
2. **Learn to build a dashboard** — measures, charts, multiple pages (Project 2)
3. **Learn to combine sources and add interactivity** — joins, toggles, tooltips (Project 3)
4. **Learn to model properly** — building a star schema by hand (Project 4)
5. **Learn to model from a real database** — snowflaked dimensions (Project 5)
6. **Put it all together** — cleaning + modeling + DAX + multi-page design, on a real-world dataset (Project 6)

Each project kept what I'd already learned and added one or two genuinely new ideas on top, so by the final project, things like writing a measure or picking the right chart type were automatic — which left room to focus on the harder parts: getting the model structure right and keeping the business logic consistent across every page.

