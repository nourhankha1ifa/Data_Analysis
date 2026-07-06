# Data Science Survey — Voter Analysis Dashboard

This is my second Power BI project, and it builds directly on my first one. In the first lesson I only cleaned the survey data in Power Query; in this one I actually built the dashboard on top of that cleaned data — KPIs, charts, and slicers across 3 pages.

---

## 1. Overview

The dashboard analyzes a survey of data professionals — who they are, what they earn, and how happy they are in their current job.

| | |
|---|---|
| **Report pages** | 3 (Overview, Career, Satisfaction) |
| **Data source** | `Data Science Survey.xlsx`, cleaned in Power Query (same cleanup as my first project) |
| **Tools used** | Power BI Desktop (Power Query, Data Modeling, DAX) |

---

## 2. Business Problem

A raw survey full of individual responses doesn't tell you much on its own — hundreds of rows of job titles, salaries, and satisfaction scores are hard to make sense of one row at a time. Without pulling it together, it's hard to answer basic questions like:

- Who took this survey — which countries, genders, education levels, and ethnic backgrounds are represented?
- What do data professionals actually earn, and how much does it vary?
- What career paths and programming languages are most common, and how hard was it for people to break into the field?
- How satisfied are people with different parts of their job — salary, coworkers, management, work/life balance?

## 3. Goal of the Dashboard

The goal was to turn the cleaned survey table into a dashboard that can answer those questions at a glance, split across 3 focused pages:

1. **Overview** — who responded, and the headline salary/age numbers.
2. **Career** — job-related patterns: industry, programming language, and career journey.
3. **Satisfaction** — how happy people are across 6 different aspects of their job.

And to make all of it explorable with filters, instead of being a fixed, static report.

---

## 4. Data Source and Modeling

**Data source:** the same cleaned `Data Professional Survey` table from my first project — one table, no relationships needed, since everything lives in one flat, cleaned dataset.

**Measures Table:** I kept all my DAX measures together in their own table instead of mixing them into the data table.

### DAX Measures I created
| Measure | DAX | What it does |
|---|---|---|
| `Voters` | `COUNT('Data Professional Survey'[Unique ID])` | Counts the total number of survey respondents |
| `Avg Salary` | `AVERAGE('Data Professional Survey'[AvgSalary])` | Average salary across all respondents |
| `Min Salary` | `MIN('Data Professional Survey'[AvgSalary])` | Lowest salary in the data |
| `Max Salary` | `MAX('Data Professional Survey'[AvgSalary])` | Highest salary in the data |
| `Avg Age` | `AVERAGE('Data Professional Survey'[Age])` | Average age of respondents |
| `Min Age` | `MIN('Data Professional Survey'[Age])` | Youngest respondent's age |
| `Max Age` | `MAX('Data Professional Survey'[Age])` | Oldest respondent's age |

---

## 5. Dashboard Pages, Charts, and Why I Picked Them

### Page 1 — Overview
![Dashboard Preview](https://github.com/nourhankha1ifa/Data_Analysis/blob/main/DEPI/Power%20BI/Power%20BI%202/P1_Overview.png)
<br>

KPI cards for Voters, Avg/Min/Max Salary, and Avg/Min/Max Age sit at the top, so anyone opening the report immediately sees the scale of the survey and the salary/age range.

| Chart | Type | What it shows | Why I used this chart |
|---|---|---|---|
| **Voters per Country** | Clustered column chart | Respondent count by country | A column chart makes it easy to compare respondent counts across countries at a glance. |
| **Voters per Gender** | Donut chart | Gender split | A donut chart works well for a simple share-of-whole question like gender split. |
| **Voters per Education** | Clustered column chart | Respondent count by education level | Education levels are a small, ordered set, so a column chart gives a clean side-by-side comparison. |
| **Voters per Job Title** | Clustered bar chart | Respondent count by current role | I used a **horizontal bar** chart here instead of vertical columns because job titles are long text labels — horizontal bars keep them readable instead of squeezing or rotating the text. |
| **Voters per Career Switch** | Pie chart | Whether someone switched into a data career | A pie chart suits this because it's a simple yes/no-style split, and the question is really about proportion. |
| **Voters per Ethnicity** | Clustered bar chart | Respondent count by ethnicity | Same reasoning as job title — ethnicity labels can be long, so a horizontal bar chart keeps them easy to read. |

**Slicers:** Country, Gender, Education, and Age — so the whole Overview page can be filtered down to a specific group.

### Page 2 — Career
![Dashboard Preview](https://github.com/nourhankha1ifa/Data_Analysis/blob/main/DEPI/Power%20BI/Power%20BI%202/P2_Career.png)
<br>

The same KPI cards repeat here (Voters, Avg/Min/Max Salary, Avg/Min/Max Age), so this page can stand on its own without needing to flip back to Overview.

| Chart | Type | What it shows | Why I used this chart |
|---|---|---|---|
| **Voters per Industry** | Clustered bar chart | Respondent count by industry | Industry names vary a lot in length, so a horizontal bar chart handles that better than columns. |
| **Voters per Programming Language** | Clustered column chart | Favorite programming language | Language names are short, so a column chart works fine and is an easy, familiar comparison. |
| **Voters by Difficulty Breaking Into Data** | Column chart | How hard people found it to break into the field | A column chart makes the spread across difficulty levels (easy → very hard) easy to read in order. |
| **Voters per Most Important Career Factor** | Treemap | What people would prioritize in a new job | A treemap is useful here because it shows both the ranking *and* the relative size of each factor in one glance — bigger blocks are the more popular answers. |

**Slicers:** Current Job (role), Industry, and Programming Language — letting this page focus in on specific career segments.

### Page 3 — Satisfaction
![Dashboard Preview](https://github.com/nourhankha1ifa/Data_Analysis/blob/main/DEPI/Power%20BI/Power%20BI%202/P3_Satisfaction.png)
<br>

This page has its own KPI cards: Voters, plus a summed total for each of the 6 happiness dimensions.

| Chart | Type | What it shows | Why I used this chart |
|---|---|---|---|
| **Happiness (Salary / Work-Life Balance / Coworkers / Management / Upward Mobility / Learning New Things)** — 6 charts | Clustered column chart | How respondents rated their satisfaction with each specific aspect of their job | I used the same chart type across all 6 so they're directly comparable side by side — each shows how many people gave each rating (1–5) for that one factor, and keeping the format identical makes it easy to spot which areas people are least happy with. |

**Slicers:** Country, Gender, Education, Age, Current Role, and Industry — the most filterable page, so satisfaction can be explored from any angle (e.g. "how happy are women in the UK with management?").

---

## 6. Design Notes
- Split the dashboard into 3 focused pages (Overview / Career / Satisfaction) instead of cramming everything onto one page, since the survey covers genuinely different topics.
- Repeated the core KPI cards on each page so every page can be read on its own.
- Used consistent chart types across similar comparisons (e.g. all 6 happiness charts use the same column chart format) so results are easy to compare.

---

## 7. Business Impact

- **Fast audience understanding:** the Overview page answers "who took this survey" in seconds — country, gender, education, ethnicity — without reading through raw rows.
- **Salary benchmarking:** the Avg/Min/Max Salary cards, filterable by country, role, or industry, give an instant sense of what data professionals earn in different segments.
- **Career path insight:** the Career page highlights which industries, languages, and entry-difficulty levels are most common, useful for anyone studying how people actually break into data careers.
- **Pinpointing dissatisfaction:** having all 6 happiness dimensions side by side on one page makes it easy to spot which single aspect of the job (salary vs. management vs. work/life balance) is the weakest link.
- **Reusable, filterable report:** because everything is slicer-driven, the same dashboard can answer very different questions just by changing which filters are applied, instead of needing a new report for every question.

---

## 8. File Reference
| File | Purpose |
|---|---|
| `Data_Science_Voter_Analysis.pbix` | The Power BI report file |
| `Data_Science_Survey.xlsx` | Raw source data |

