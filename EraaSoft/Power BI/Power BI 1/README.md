# Kickstarter Projects Analysis Dashboard

This is my first Power BI project. I built it to learn and practice the basics of Power BI: bringing in data, cleaning it, building a data model, writing simple DAX measures, and creating a dashboard. It is a learning project, not a finished, production-ready dashboard.

---

## 1. Overview

The dashboard looks at Kickstarter crowdfunding projects and shows simple facts like how many projects there are, how much money was pledged, and which categories and countries do best.

| | |
|---|---|
| **Report pages** | 1 page |
| **Data source** | 2 CSV files (from Kaggle: Kickstarter Projects) |
| **Total raw rows** | about 702,000 rows combined |
| **Tools used** | Power BI Desktop (Power Query, DAX) |

---

## 2. Why I Made This

I wanted a simple project to practice real Power BI skills: importing data, cleaning it, combining two files, building measures, and making charts. Kickstarter data was a good fit because it has real numbers (money, backers, dates, categories) that are easy to understand and easy to build simple charts around.

## 3. Goal of the Dashboard

The goal was to take two separate yearly data files and turn them into one easy-to-read page that answers simple questions like:

- How many projects are there in total, and how much money was pledged?
- How many projects succeed, fail, or get cancelled?
- Which categories have the most projects?
- Which countries pledge the most money?
- Does project activity go up or down over time?

This was mainly a way for me to practice, so the dashboard keeps things simple on purpose.

---

## 4. Data Sources

| File | Description | Rows |
|---|---|---|
| `ks-projects-201612.csv` | Kickstarter data, December 2016 | ~323,750 |
| `ks-projects-201801.csv` | Kickstarter data, January 2018 | ~378,661 |

Source: [Kaggle – Kickstarter Projects](https://www.kaggle.com/kemical/kickstarter-projects)

**Main columns in both files:**
`ID`, `name`, `category`, `main_category`, `currency`, `deadline`, `goal`, `launched`, `pledged`, `state`, `backers`, `country`, `usd pledged`, `usd_pledged_real`, `usd_goal_real`

> Note: the 2016 file had slightly messy column names (extra spaces). I cleaned this up in Power Query.

---

## 5. Data Steps (Power Query)

1. **Added a custom column** in each file to mark which year it came from (2016 or 2018). This way I can still tell where each row came from after combining the files.
2. **Appended (combined) the two files** into one table using Power Query, so I have one full table to build the dashboard from.
3. **Renamed the combined table** to a clear name (`ks-projects`) instead of leaving it as a raw file name. I kept the original 2016 and 2018 tables in the model too.

### Data Model
The model has **3 tables**:

| Table | What it's for |
|---|---|
| `2016` | The original 2016 file; also holds my main DAX measures |
| `2018` | The original 2018 file |
| `ks-projects` | The combined table (2016 + 2018), used for the charts and hierarchy |

---

## 6. Modeling

### Hierarchy
- **Project Hierarchy**: `Main Category → Category → Project Name` — lets me click into a chart and drill down from a big category down to single projects.

### Measures (DAX) I created
| Measure | What it does |
|---|---|
| `Number of Projects` | Counts the total number of projects |
| `Number of Backers` | Adds up the total number of backers |
| `Total Pledged` | Adds up the total money pledged |
| `Total Goal` | Adds up the total funding goal |

I also used a simple **Count of ID** directly on two of the charts instead of a separate measure.

### Date Hierarchies
- `launched` date → used for the monthly trend line
- `deadline` date → used for the Year filter

---

## 7. Dashboard Layout

**Header:** "Kickstarter Projects Analysis Dashboard" — a title banner at the top (blue background, white text).

### KPI Cards (top row)
| Card | Measure |
|---|---|
| Number of Projects | `Number of Projects` |
| Number of Backers | `Number of Backers` |
| Total Pledged | `Total Pledged` |
| Total Goal | `Total Goal` |

I put these four numbers at the top so anyone looking at the page gets the big picture right away, before looking at any chart.

### Charts — What They Show and Why I Picked Them

| Chart | Type | Fields | Why I used this chart |
|---|---|---|---|
| **Number of Projects by Main Category** | Clustered column chart | Category = Project Hierarchy (Main Category / Category / Name); Value = Count of Projects | A column chart makes it easy to compare project counts across categories. I added the drill-down hierarchy so I could click deeper into a category without needing extra charts. |
| **Number of Projects by State** | Clustered column chart | Category = `state` (successful, failed, canceled, live); Value = Count of Projects | The states are just a few simple options, so a column chart makes it quick to compare how many projects succeed vs fail. |
| **Number of Projects by Month** | Line chart | Category = `launched` date (Month); Value = Count of Projects | A line chart is the easiest way to see a trend over time — it shows if activity is going up or down more clearly than bars would. |
| **Top 5 Total Pledged by Country** | Clustered column chart (filtered to top 5) | Category = `country`; Value = `Total Pledged` | There are too many countries to show all of them clearly, so I filtered to the top 5. This keeps the chart clean and shows the countries with the most pledged money. |

### Slicers (filters)
| Slicer | Field | Type |
|---|---|---|
| Country | `country` | List slicer |
| Year | `deadline` date (Year) | List slicer |

I added these two filters so I could practice making the whole page interactive — picking a year or country updates all the charts and cards at once.

---

## 8. Design Notes
- Used the default Power BI accessible theme, with a blue (`#005A9E`) header banner.
- Rounded corners and a drop shadow on the title box, just to make it look a bit nicer.
- Kept chart titles in plain language (e.g. "Top 5 Total Pledged by Country") so the page is easy to read without extra explanation.

---

## 9. What I Learned / Impact of This Project

This was a learning project, so the biggest value was for me:

- Practiced combining two raw data files into one clean table.
- Practiced building a simple data model with a hierarchy and DAX measures.
- Practiced picking the right chart type for the type of question (bars for comparison, line for trend).
- Practiced adding interactive filters (slicers) to a dashboard.

As a side effect, the dashboard also gives a simple, honest picture of Kickstarter activity — how many projects succeed, which categories are most active, and which countries pledge the most. It's a good starting point that I could build on later (e.g. adding more pages or better formatting).

---

## 10. Known Limitations
- This is a single page — a finished dashboard would likely need more pages (e.g. one for money/funding, one for categories, one for time trends).
- No error handling or data quality checks beyond basic cleaning.
- Some formatting and layout details (spacing, alignment) are not fully polished, since the focus was on learning the tool, not building a final product.

---

## 11. File Reference
| File | Purpose |
|---|---|
| `Power_BI_1.pbix` | The Power BI report file |
| `ks-projects-201612.csv` | Raw source data (2016) |
| `ks-projects-201801.csv` | Raw source data (2018) |