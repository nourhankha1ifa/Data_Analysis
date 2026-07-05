# Customer Feedback Analysis Dashboard

![Dashboard Preview](https://github.com/nourhankha1ifa/Data_Analysis/blob/main/DEPI/Excel/Excel%203/Customer%20Feedack.png)
<br>

A full Excel dashboard analyzing hotel guest feedback — gender, source of booking, purpose of visit, satisfaction ratings, and how likely guests are to recommend the hotel (NPS).

---

## 1. Overview

This project takes a raw hotel guest survey (1,948 responses) and turns it into a one-page interactive dashboard that can be filtered by gender, checkout year, and booking source.

| | |
|---|---|
| **Workbook** | `Customer-Feedback.xlsx` |
| **Task brief** | `2_Customer_Feedback_Analysis.pdf` |
| **Sheets** | Input Data, Feedback, Guest, Ref, Analysis, Dashboard |
| **Tools used** | Excel (Power Query, PivotTables, PivotCharts, Slicers) |

---

## 2. What the Task Asked For

The brief asked for a dashboard covering 7 things:
1. Average of overall experience
2. Count of voters per gender
3. Count of voters per NPS category
4. Average rating score per feedback item and feedback category
5. Count of voters per source
6. Count of voters per purpose
7. Count of voters per checkout date and source

Plus slicers for Gender, Checkout Date (Year), and Purpose.

---

## 3. The Data and How It Was Prepared

**`Input Data`** — the raw survey export: one row per guest, with wide columns for each rating question (Staff attitude, Check-in Process, Room service, Room cleanliness, Food quality, Variety of food, Broadband & TV, Gym), plus gender, date of birth, checkout date, purpose of visit, and how they found the hotel.

**`Feedback`** — a reshaped (unpivoted) version of the wide rating columns, turning them into one row per guest *per question* (15,584 rows), with a `Rating Score` (1–5) and a `Category` grouping each question into Staff, Room, or Facility. This was built with Power Query so the ratings could actually be summarized and averaged, since they started out as text ("Poor", "Good", "Excellent") spread across many columns.

**`Ref`** — a small lookup table mapping each rating word (Poor, Average, Good, Very good, Excellent) to a numeric score (1–5), and mapping each feedback question to its category (Staff, Room, Facility). This is what the `Feedback` sheet's scores and categories come from.

**`Guest`** — one row per guest, cleaned up with: an `overall_experience` score, an `NPS` score, and an `NPS_Categories` label (Promoters / Passives / Detractors) calculated from how likely they are to recommend the hotel, plus a full date breakdown of the checkout date (Year, Quarter, Month Index, Month).

**`Analysis`** — the PivotTables behind the dashboard, one for each of the 7 business requirements.

**`Dashboard`** — the final visual page.

---

## 4. Dashboard Charts — What They Show and Why

| Chart | Type | What it answers |
|---|---|---|
| **Average of overall experience** | KPI card/value | The single headline number — how satisfied guests are overall, on average. |
| **Voters per Gender** | Doughnut chart | A simple, clean way to show the male/female split of respondents as a share of the whole. |
| **Voters per NPS Category** | Pie chart | Shows the share of Promoters, Passives, and Detractors — the classic way NPS results are visualized, since it's fundamentally about proportions. |
| **Feedback Rating by Category** | Radar chart | A radar chart works well here because it compares several rating categories (Staff, Room, Facility, and the individual questions within them) at once, making it easy to spot which area is weakest at a glance. |
| **Voters per Source** | Bar chart | Compares booking sources (hotel booking sites, word of mouth, search engine, etc.) — a bar chart makes it easy to see which channel brings in the most guests. |
| **Voters per Purpose** | Bar chart | Compares visit purpose (Business, Vacation, Function, Other) the same way. |
| **Voters per Checkout Date and Source** | (combined with the above via slicers) | Rather than a separate chart, checkout date and source are explored together using the Year slicer alongside the Source chart. |

### Slicers
The dashboard includes slicers for **Checkout Date (Year)**, **Gender**, and **Source** — so every chart updates together when filtering by any of these. (The brief also asked for a Purpose slicer; in the finished workbook, Purpose is shown as its own chart instead, with Source used as the third slicer.)

---

## 5. What This Project Was Good Practice For

- Reshaping wide survey data into a long, analysis-ready format with Power Query (unpivoting the rating columns).
- Building a lookup table to convert text ratings into numeric scores.
- Calculating NPS categories from a raw recommendation score.
- Picking the right chart for each kind of question — proportions (pie/doughnut) versus comparisons (bar) versus a multi-category comparison (radar).
- Connecting several PivotTables to a shared set of slicers so the whole dashboard filters together.

---

## 5. Functions Used

This workbook doesn't rely on written worksheet formulas (like `=SUM()` or `=IF()`) for its data prep — the raw survey data was reshaped and cleaned using **Power Query steps** instead, which is why `Guest` and `Feedback` contain plain values rather than formulas:

| Power Query step | What it does |
|---|---|
| **Unpivot columns** | Turned the 8 wide rating columns in `Input Data` (Staff attitude, Room service, etc.) into the long `Feedback` table, one row per guest per question |
| **Merge queries** | Matched each unpivoted rating word (Poor, Good, Excellent...) against the `Ref` lookup table to bring in its numeric `Rating Score` and its `Category` (Staff/Room/Facility) |
| **Conditional column** | Built the `NPS_Categories` label (Promoters / Passives / Detractors) on the `Guest` sheet, based on the recommendation score |
| **Date column split** | Broke `Checkout Date` into Year, Quarter, Month Index, and Month on the `Guest` sheet |

On the `Dashboard` and `Analysis` sheets, the summaries themselves (averages, counts) come from **PivotTables**, using Average and Count rather than written formulas.

---

## 6. Files

| File | What it is |
|---|---|
| `2_Customer_Feedback_Analysis.pdf` | The task brief and business requirements |
| `Customer-Feedback.xlsx` | The finished dashboard workbook |
