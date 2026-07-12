# Data Analysis

A collection of data analysis projects and practice tasks completed during my two data analytics internships — **Digital Egypt Pioneers Initiative (DEPI)** and **EraaSoft** — covering Power BI, Excel, SQL, and Python.

<p align="center">
<img src="https://img.shields.io/badge/Excel-217346?style=flat&logo=microsoft-excel&logoColor=white">
<img src="https://img.shields.io/badge/SQL%20Server-CC2927?style=flat&logo=microsoftsqlserver&logoColor=white">
<img src="https://img.shields.io/badge/Power%20BI-F2C811?style=flat&logo=powerbi&logoColor=black">
<img src="https://img.shields.io/badge/Python-3776AB?style=flat&logo=python&logoColor=white">
</p>

---

## Repository Structure

```
Data_Analysis/
├── DEPI/
│   ├── Power BI/
│   │   ├── Power BI 1/   → Data Cleaning: Data Science Survey
│   │   ├── Power BI 2/   → Data Science Survey: Voter Analysis Dashboard
│   │   ├── Power BI 3/   → Amazon Product Analysis Dashboard
│   │   ├── Power BI 4/   → Sales Dashboard (Star Schema)
│   │   ├── Power BI 5/   → Adventure Works Order Analysis Dashboard
│   │   └── Power BI 6/   → Hospital Dashboard (Final Project)
│   ├── Excel/
│   │   ├── Excel 1/      → Excel Sales Performance Dashboard
│   │   ├── Excel 2/      → Sales Distribution Dashboard (Practice)
│   │   └── Excel 3/      → Customer Feedback Analysis Dashboard
│   ├── SQL/              → SD32-Company Database & Custom SQL Functions
│   └── Python/           → Sales Data Cleaning & Analysis
│
└── EraaSoft/
    ├── Power BI/
    │   ├── Power BI 1/   → Kickstarter Projects Analysis Dashboard
    │   ├── Power BI 2/   → AdventureWorks - Sales Dashboard
    │   └── Power BI 3/   → Sales Performance Dashboard (DirectQuery)
    ├── Excel/            → Superstore & Retail Branch Dashboards
    ├── SQL/               → Retail Sales Management System
    └── Python/            → HR Dataset Analysis
```

---

## DEPI Internship

Projects and tasks completed during the **Digital Egypt Pioneers Initiative (DEPI)** Data Analysis Track.

### Power BI

| Project | Description |
|---|---|
| [Power BI 1 — Data Cleaning](DEPI/Power%20BI/Power%20BI%201) | Cleaning a raw Data Science Survey entirely in Power Query — fixing salary ranges, splitting messy text answers, and handling missing values, before any charts. |
| [Power BI 2 — Voter Analysis Dashboard](DEPI/Power%20BI/Power%20BI%202) | A 3-page dashboard (Overview, Career, Satisfaction) analyzing the cleaned survey data — demographics, salary, and job satisfaction. |
| [Power BI 3 — Amazon Product Analysis](DEPI/Power%20BI/Power%20BI%203) | A 4-page dashboard joining Amazon orders with a product catalog, with a dynamic Sales-vs-Units toggle and a live product image view. |
| [Power BI 4 — Sales Dashboard (Star Schema)](DEPI/Power%20BI/Power%20BI%204) | Built a full star schema from a flat sales sheet in Power Query, then a one-page dashboard covering orders, status, product hierarchy, and territory. |
| [Power BI 5 — Adventure Works Order Analysis](DEPI/Power%20BI/Power%20BI%205) | Modeled straight from the AdventureWorks2025 database, with a snowflaked product dimension and an order-trend dashboard. |
| [Power BI 6 — Hospital Dashboard (Final Project)](DEPI/Power%20BI/Power%20BI%206) | A 3-page hospital analytics dashboard on an 8-dimension star schema, with business logic (age groups, disease categories) built into Power Query. |

### Excel

| Project | Description |
|---|---|
| [Excel 1 — Sales Performance Dashboard](DEPI/Excel/Excel%201) | A one-page Excel dashboard analyzing sales, profit, discounts, and production cost by category, month, and year. |
| [Excel 2 — Sales Distribution Dashboard (Practice)](DEPI/Excel/Excel%202) | Practicing dynamic Excel formulas (UNIQUE, XLOOKUP, SUMIFS, LARGE) to compare sales against target and rank top customers/products. |
| [Excel 3 — Customer Feedback Analysis Dashboard](DEPI/Excel/Excel%203) | An Excel dashboard analyzing hotel guest satisfaction and NPS, built with Power Query and PivotTables. |

### SQL

| Project | Description |
|---|---|
| [SD32-Company Database & Custom SQL Functions](DEPI/SQL) | A constraint-rich SQL Server database built from scratch (checks, defaults, unique keys), plus custom scalar and table-valued functions for reusable logic. |

### Python

| Project | Description |
|---|---|
| [Sales Data Cleaning & Analysis](DEPI/Python) | Cleaning a messy real-world sales export and analyzing it at the univariate, bivariate, and multivariate level with pandas, Matplotlib, Seaborn, and Plotly. |

---

## EraaSoft Internship

Projects and tasks completed during the **EraaSoft** Data Analysis internship.

### Power BI

| Project | Description |
|---|---|
| [Power BI 1 — Kickstarter Projects Analysis Dashboard](EraaSoft/Power%20BI/Power%20BI%201) | My first Power BI project — combining two years of Kickstarter crowdfunding data into one clean model and dashboard. |
| [Power BI 2 — AdventureWorks Sales Dashboard](EraaSoft/Power%20BI/Power%20BI%202) | Built a proper star schema data model from a flat sales file, with DAX measures and a product drill-down. |
| [Power BI 3 — Sales Performance Dashboard](EraaSoft/Power%20BI/Power%20BI%203) | A DirectQuery-connected dashboard with a role-playing date dimension (USERELATIONSHIP), Top N filtering, and drill-through to a salesperson details page. |

### Excel

| Project | Description |
|---|---|
| [Excel BI Dashboards](EraaSoft/Excel) | Two independent Excel dashboards on their own Power Pivot data models — a Superstore sales dashboard and a multi-branch retail sales dashboard. |

### SQL

| Project | Description |
|---|---|
| [Retail Sales Management System](EraaSoft/SQL) | Designed ER diagrams and relational schemas for 4 case studies, then built a 7-table retail database from scratch and answered 50 real business questions using joins, subqueries, window functions, and views. |

### Python

| Project | Description |
|---|---|
| [HR Dataset Analysis](EraaSoft/Python) | Cleaning and analyzing an HR dataset with pandas — handling missing values, binning salaries, and grouping by department. |

---

## Tools & Skills Covered

- **Excel:** PivotTables, PivotCharts, Power Pivot, Power Query, Dynamic Formulas (XLOOKUP, UNIQUE, SUMIFS)
- **SQL:** Database Design (ER Diagrams), T-SQL, Joins, Subqueries, Window Functions, Views, User-Defined Functions
- **Power BI:** Power Query, Data Modeling (Star Schema), DAX, DirectQuery, Drill-Through, Tooltip Pages
- **Python:** Pandas, NumPy, Matplotlib, Seaborn, Plotly, Data Cleaning & EDA

---

<p align="center">Connect with me on <a href="https://www.linkedin.com/in/nourhankha1ifa/">LinkedIn</a> | <a href="https://nourhankha1ifa.github.io/N_Portfolio/">Portfolio</a></p>
