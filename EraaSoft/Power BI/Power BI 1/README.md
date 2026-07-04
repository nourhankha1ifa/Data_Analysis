# Kickstarter Projects Analysis Dashboard

![Dashboard Preview](https://github.com/nourhankha1ifa/Data_Analysis/blob/main/EraaSoft/Power%20BI/Power%20BI%201/Kickstarter%20Snapshot.png)

<br>

This is my first Power BI project. I built it to learn and practice the basics of Power BI: bringing in data from more than one file, cleaning it, building a simple data model, writing DAX measures, and creating a one-page dashboard. It is a learning project, not a finished, production-ready dashboard.

---

## 1. Overview

The dashboard looks at Kickstarter crowdfunding projects and shows simple facts like how many projects there are, how much money was pledged, and which categories, states, and countries do best.

| | |
|---|---|
| **Report pages** | 1 page |
| **Data source** | 2 CSV files (from Kaggle: Kickstarter Projects) |
| **Tools used** | Power BI Desktop (Power Query, Data Modeling, DAX) |

---

## 2. Business Problem

Kickstarter has hundreds of thousands of crowdfunding campaigns, but the data is split across separate yearly export files with no easy way to see the bigger picture. Without pulling it together, it's hard to answer basic questions like:

- How many projects actually get funded successfully, versus fail or get cancelled?
- Which project categories attract the most projects and the most money?
- Which countries pledge the most money?
- Is funding activity growing or slowing down over time?

## 3. Goal of the Dashboard

The goal was to combine the 2016 and 2018 Kickstarter files into one clean data source, and build a page that can answer those questions quickly:

1. Show the overall scale of activity (total projects, backers, money pledged, money targeted).
2. Break performance down by **category**, **funding outcome (state)**, **country**, and **time**.
3. Let someone filter by **year** and **country** to explore the data themselves.
4. Keep everything on one page so the full picture is visible at a glance.

---

## 4. Data Source and Modeling

**Data source:** two CSV files — `ks-projects-201612.csv` (2016 snapshot) and `ks-projects-201801.csv` (2018 snapshot).

**Cleanup with Power Query:**
- Added a custom column to each file marking which year it came from, so I can still trace a row back to its source file after combining
- **Appended (combined)** the two files into one table using Power Query
- **Renamed** the combined table to a clear name, `ks-projects`, instead of leaving it as a raw filename. I kept the original `2016` and `2018` queries in the model too.

**Data Model:** 3 tables — `2016`, `2018` (the original yearly queries), and `ks-projects` (the combined table used for the visuals).

**Hierarchy:** built on `ks-projects` as `main_category → category → name`, so I can drill down from a broad category into individual projects on one chart.

### DAX Measures I created
| Measure | DAX | What it does |
|---|---|---|
| `Number of Projects` | `COUNT('ks-projects'[ID])` | Counts the total number of projects |
| `Number of Backers` | `DISTINCTCOUNT('ks-projects'[backers])` | Counts the number of backers |
| `Total Pledged` | `SUM('ks-projects'[pledged])` | Adds up the total money pledged |
| `Total Goal` | `SUM('ks-projects'[goal])` | Adds up the total funding goal |

---

## 5. Dashboard Layout

**Header:** a title text box at the top of the page.

### KPI Cards (top row)
Number of Projects, Number of Backers, Total Pledged, and Total Goal — the four headline numbers, so anyone opening the report sees the overall scale straight away.

### Charts — What They Show and Why I Picked Them

| Chart | Type | What it shows | Why I used this chart |
|---|---|---|---|
| **Number of Projects by Main Category** | Clustered column chart with drill-down | Project counts across Main Category → Category → Project Name | A column chart makes it easy to compare project counts across categories, and using the hierarchy lets me click into one category and drill all the way down to individual projects on the same chart. |
| **Number of Projects by State** | Clustered column chart | Project counts by outcome (successful, failed, cancelled, live) | The outcome states are a small, fixed set, so a simple column chart gives a fast, honest comparison of how projects actually end up — the single most important funding-outcome question. |
| **Number of Projects by Month** | Line chart | Project counts over time (by launch month) | A line chart is the clearest way to see a trend over time, since the eye can follow the shape of the line rather than compare separate bars. |
| **Top 5 Total Pledged by Country** | Clustered column chart (filtered to top 5) | Total money pledged, for the top 5 countries | With many countries in the data, showing all of them would clutter the chart. Filtering to the top 5 keeps it clean and highlights where the money is actually coming from. |

### Slicers (filters)
| Slicer | Field |
|---|---|
| Country | Country |
| Year | Deadline (Year) |

These let me filter the whole page down to a specific country or funding-deadline year.

---

## 6. Design Notes
- Chart titles are written in plain, meaningful language (e.g. "Top 5 Total Pledged by Country") so each visual is understandable without extra explanation.
- Kept the layout to one page so the full picture is visible without switching tabs.

---

## 7. Business Impact

Even as a first practice project, this kind of dashboard has real value:

- **Faster answers:** anyone can filter by year or country and instantly see how Kickstarter activity looks, without opening the raw CSV files.
- **Clear success/failure picture:** the State breakdown makes the real success rate of crowdfunding campaigns immediately visible.
- **Category and geography insight:** seeing which categories and countries generate the most projects and money helps highlight where attention is best placed.
- **Trend awareness:** the monthly line chart shows whether platform activity is growing or slowing.
- **A reusable base:** because the two yearly files were combined into one clean model, the same structure could take in a future year's export with little extra work.

---

## 8. Known Limitations
- Single page only — a finished dashboard would likely need more pages (e.g. one for money/funding, one for categories, one for time trends).
- No error handling or data quality checks beyond the basic Power Query cleanup.
- Some formatting and layout details are not fully polished, since the focus was on learning the tool, not building a final product.

---

## 9. File Reference
| File | Purpose |
|---|---|
| `Kickstarter_Projects_Analysis_Dashboard.pbit` | The Power BI template file |
| `ks-projects-201612.csv` | Raw source data (2016) |
| `ks-projects-201801.csv` | Raw source data (2018) |
