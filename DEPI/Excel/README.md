# Excel Learning Journey

This is a summary of what I learned across three Excel dashboard projects: Excel Sales Performance, Customer Feedback Analysis, and Sales Distribution. Each one practiced a different mix of PivotTables, formulas, and chart choices.

---

## The Journey at a Glance

| Project | Data | Main Focus | Depth |
|---|---|---|---|
| **Excel Sales Performance** | Order-level sales data | PivotTables + PivotCharts for KPIs and trends | Full dashboard |
| **Customer Feedback Analysis** | Hotel guest survey | Power Query reshaping + NPS analysis | Full dashboard |
| **Sales Distribution** | Sales vs. target, customers, products | Dynamic formulas (XLOOKUP, UNIQUE, SUMIFS, LARGE) | Practice/basics |

---

## Project 1 – Excel Sales Performance Dashboard
![Dashboard Preview](https://github.com/nourhankha1ifa/Data_Analysis/blob/main/DEPI/Excel/Excel%201/Sales%20Performace%20Dashboard.png)
<br>

This project was mostly about **PivotTables doing the heavy lifting**. Starting from one flat table of orders, I built separate PivotTables for the 5 headline KPIs (orders, sales, production cost, discount, profit), then more for trends by month/year and breakdowns by category.

**Key ideas:** letting PivotTables calculate totals instead of writing formulas for everything, and matching the chart type to the question — a line chart for the profit/discount trend over time, a bar chart for comparing categories, a pie chart for a share-of-total question (profit per category). The only worksheet formula in the whole project was a simple subtraction (`Sales − ProductionCost` = Profit); everything past that point was PivotTable-driven.

**Functions and formulas used:**
| Formula | What it does |
|---|---|
| `=G2-J2` (Sales − ProductionCost) | Calculates Profit for each order row |
| PivotTable **Sum** and **Count** | Every KPI, trend, and category breakdown on the dashboard — no other formulas written |

**What I learned:** how far PivotTables alone can take a dashboard, and that picking the right chart type matters as much as getting the numbers right.

## Project 2 – Sales Distribution (Practice)
![Dashboard Preview](https://github.com/nourhankha1ifa/Data_Analysis/blob/main/DEPI/Excel/Excel%202/Sales%20Distribution.png)
<br>

This one was less about the final dashboard and more about practicing **dynamic, live-updating formulas** instead of relying on PivotTables.

**Key ideas:** `UNIQUE()` to pull distinct lists (weeks, months, customers, products) straight from the raw data instead of typing them by hand. `XLOOKUP()` to match values without depending on column position. `SUMIFS()` to total sales per customer or product. `LARGE()` to pull out the 1st, 2nd, 3rd highest values for Top 3/Top 10 lists. `IF()` combined with `NA()` to split actual sales into "Below" or "Above" target, so a chart could show the difference without plotting a fake zero.

**Functions and formulas used:**
| Function | Example | What it does |
|---|---|---|
| `UNIQUE()` | `=UNIQUE(InputData[WEEK])` | Pulls a distinct list of weeks/months/customers/products from the raw data |
| `XLOOKUP()` | `=XLOOKUP(B4,InputData[WEEK],InputData[SALES])` | Looks up sales for a given week or month by matching value, not column position |
| `ANCHORARRAY()` | `=XLOOKUP(J8,$M$4:$M$43,ANCHORARRAY($L$4))` | References the full spilled list from a `UNIQUE()` formula so a name lines up with its value |
| `SUMIFS()` | `=SUMIFS(InputData[SALES],InputData[CUSTOMER NAME],Functions!L4)` | Totals sales for one specific customer or product |
| `LARGE()` | `=LARGE($M$4:$M$43,1)` | Pulls the 1st/2nd/3rd highest sales value, for Top 3 and Top 10 lists |
| `IF()` + `NA()` | `=IF([Total Sales]<[Target],[Total Sales],NA())` | Splits sales into "Below"/"Above" target, leaving a blank instead of a false zero |
| `SUM()` | `=SUM(InputData[SALES])` | The overall Total Sales figure |

**What I learned:** a different way to build a dashboard — one where the numbers update live from formulas instead of needing a PivotTable refresh — and got much more comfortable with lookup and array-style functions than in the first two projects.

## Project 3 – Customer Feedback Analysis Dashboard
![Dashboard Preview](https://github.com/nourhankha1ifa/Data_Analysis/blob/main/DEPI/Excel/Excel%203/Customer%20Feedack.png)
<br>

This project pushed me into **Power Query** properly for the first time, because the raw survey data wasn't usable as-is — it had one wide row per guest with 8 separate rating columns.

**Key ideas:** using Power Query's **Unpivot** step to turn those 8 wide columns into a long table (one row per guest per question), then **merging** that against a small lookup table to convert text ratings ("Poor", "Excellent") into numeric scores and group them into categories (Staff, Room, Facility). I also built a conditional column to turn a raw recommendation score into NPS categories (Promoters/Passives/Detractors), and split a date column into Year/Quarter/Month. On the chart side, I practiced choosing between a pie chart, a doughnut chart, and a radar chart depending on whether the question was about a simple split or a multi-category comparison.

**Functions and formulas used:**
| Step/Tool | What it does |
|---|---|
| Power Query **Unpivot columns** | Turns 8 wide rating columns into one long Feedback table |
| Power Query **Merge queries** | Looks up each rating word against the Ref table to get its numeric score and category |
| Power Query **Conditional column** | Builds the NPS_Categories label (Promoters/Passives/Detractors) from the recommendation score |
| Power Query **date split** | Breaks Checkout Date into Year, Quarter, Month Index, Month |
| PivotTable **Average** and **Count** | Every chart and KPI on the dashboard — no worksheet formulas (`=IF`, `=SUM`, etc.) were used |

**What I learned:** that real survey data almost never arrives in a shape you can build a PivotTable on directly — Power Query is what gets it there, and that step matters more than any formula or chart choice that comes after it.

---

## How It All Connects

Each of these three projects leaned on a different Excel skill as its main focus:

1. **Excel Sales Performance** — PivotTables and PivotCharts as the primary tool
2. **Customer Feedback** — Power Query as the primary tool, to reshape messy source data before anything else could work
3. **Sales Distribution** — worksheet formulas (lookups, dynamic arrays, conditional logic) as the primary tool, instead of PivotTables

Together, they cover the three main ways to get from raw data to an answer in Excel: **PivotTables**, **Power Query**, and **formulas** — and when to reach for each one depends on the shape the data starts in and how "live" the result needs to be.
