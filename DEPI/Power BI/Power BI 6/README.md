# Hospital Dashboard — Final Project

This is my final Power BI project. It pulls together everything from my earlier lessons — Power Query transformations, a full star schema, DAX measures, and a multi-page interactive dashboard — applied to real hospital visit data.

---

## 1. Overview

The dashboard analyzes hospital visit transactions: how many visits happen, how much revenue they bring in, and how both break down by department, diagnosis, procedure, hospital, and payment method.

| | |
|---|---|
| **Report pages** | 3 (Overview, Medical Analysis, Financial Analysis) |
| **Data source** | `hospital_dataset.xlsx` — one raw sheet of hospital visit transactions |
| **Tools used** | Power BI Desktop (Power Query, Data Modeling, DAX) |

---

## 2. Business Problem

The raw hospital data is one flat sheet — every visit row repeats the doctor's name, department, diagnosis, procedure, and hospital details as plain text. That makes it hard to answer the questions a hospital would actually want answered:

- How many visits happen, how many different patients are being treated, and how much total revenue do visits bring in?
- Which departments, diagnoses, and procedures come up most often, and how does that differ by patient age group?
- Where does the money come from — which payment methods and insurance providers — and how are costs split between procedures, medicine, and room charges?
- How does all of this vary by hospital, city, region, and time?

## 3. Goal of the Dashboard

The goal was to turn the raw visit-level data into a proper data model and a 3-page dashboard that can answer those questions:

1. Split the flat sheet into a **fact table** (the actual visit-level numbers) and **8 dimension tables** (patient, doctor, department, date, procedure, diagnosis, payment, hospital), following a full star schema.
2. Build extra business logic directly in Power Query — patient age groups, procedure types, disease categories, and hospital city/region — instead of leaving those as raw values.
3. Write DAX measures for the key healthcare KPIs.
4. Split the dashboard into 3 focused pages — an executive overview, medical analysis, and financial analysis — each filterable by city, region, and date.

---

## 4. Data Source and Modeling

**Data source:** `hospital_dataset.xlsx`, one sheet of transactional hospital visits (visit ID, date, patient, doctor, department, diagnosis, procedure, hospital, payment method, insurance provider, and cost columns).

**Star schema:** `Fact` sits at the center, with visit-level costs (Procedure_Cost, Medicine_Cost, Room_Charges, Total_Bill) and ID columns linking out to 8 dimension tables:

| Table | What it holds |
|---|---|
| `Dim_Patient` | Patient ID, gender, age, and an **Age_Group** built in Power Query (Child / Teen / Young Adult / Adult / Senior, based on age) |
| `Dim_Doctor` | Doctor ID, name, specialty, and department |
| `Dim_Department` | Department name |
| `Dim_Date` | A full date table (day, week, month, quarter, year) |
| `Dim_Procedure` | Procedure name and a **Procedure_Type** grouping built in Power Query (Consultation, Lab, Imaging, Surgical, Therapy, Other) |
| `Dim_Diagnosis` | Diagnosis name and a **Disease_Category** grouping built in Power Query (Chronic, Acute, Respiratory, Infectious, Screening, Dermatology, Other) |
| `Dim_Payment` | Payment method and insurance provider |
| `Dim_Hospital` | Hospital name, plus **City** and **Region** worked out in Power Query from the hospital name |

**Business logic built into the model, not left to the report:** several of the "extra" columns above (Age_Group, Procedure_Type, Disease_Category, City, Region) are calculated once in Power Query using conditional logic, rather than being calculated repeatedly inside chart formulas. That keeps the model doing the classification work once, so every chart across all 3 pages uses the same consistent groupings.

**A technical note:** the original raw sheet (`Sheet1`) is still present in the model alongside the finished star schema, with a few of its own connections to the dimension tables. It isn't used by any of the dashboard visuals — the report runs entirely on `Fact` and the 8 `Dim_` tables — but it's worth mentioning as something to tidy up (disable load on the raw query) in a future revision.

### DAX Measures I created
| Measure | DAX | What it does |
|---|---|---|
| `Total Revenue` | `SUM('Fact'[Total_Bill])` | Adds up total billed amount across all visits |
| `Total Visits` | `COUNT('Fact'[Visit_ID])` | Counts the number of hospital visits |
| `Distinct Patients` | `DISTINCTCOUNT('Fact'[Patient_ID])` | Counts unique patients, so a patient with several visits is only counted once |
| `Average Bill Per Visit` | `DIVIDE([Total Revenue], [Total Visits], 0)` | Average amount billed per visit |
| `Medicine %` | `DIVIDE(SUM('Fact'[Medicine_Cost]), [Total Revenue], 0)` | What share of total revenue comes from medicine cost specifically |
| `Visits Per Patient` | `DIVIDE([Total Visits], [Distinct Patients], 0)` | Average number of visits per patient — a simple sign of how often patients return |

I used `DIVIDE()` instead of a plain `/` for every ratio measure, since `DIVIDE()` safely returns 0 instead of an error if there's ever a zero on the bottom of the calculation.

---

## 5. Dashboard Pages, Charts, and Why I Picked Them

### Page 1 — Overview
![Dashboard Preview](https://github.com/nourhankha1ifa/Data_Analysis/blob/main/DEPI/Power%20BI/Power%20BI%206/P1_Overview.png)
<br>

**Cards:** Total Revenue, Average Bill Per Visit, Distinct Patients, Total Visits — the headline numbers, so anyone opening the report sees the overall scale immediately.

| Chart | Type | What it shows | Why I used this chart |
|---|---|---|---|
| **Revenue by Department** | Clustered column chart | Total revenue per department | A column chart makes it easy to compare revenue across departments side by side. |
| **Visits by Month** | Line chart | Visit count trend over time | A line chart is the clearest way to see whether visit volume is rising, falling, or seasonal month to month. |
| **Visits by Hospital** | Pie chart | Share of visits per hospital | With only a few hospitals, a pie chart works well for a simple "what share of visits" question. |

**Slicers:** City, Region, Date.

### Page 2 — Medical Analysis
![Dashboard Preview](https://github.com/nourhankha1ifa/Data_Analysis/blob/main/DEPI/Power%20BI/Power%20BI%206/P2_Medical%20Analysis.png)
<br>

**Cards:** Distinct Patients, Total Visits, Visits Per Patient.

| Chart | Type | What it shows | Why I used this chart |
|---|---|---|---|
| **Top Diagnoses** | Clustered bar chart | Visit count by diagnosis | Diagnosis names can be long text, so a horizontal bar chart keeps them readable instead of squeezing them under columns. |
| **Department Workload** | Column chart | Visit count by department, broken down by patient Age_Group | I used a column chart with the age group as the breakdown so I could see not just which department is busiest, but which age groups make up that workload. |
| **Top Procedures** | Clustered bar chart | Visit count by procedure | Same reasoning as diagnoses — procedure names are long, so a horizontal bar chart reads better. |

**Slicers:** City, Region, Date.

### Page 3 — Financial Analysis
![Dashboard Preview](https://github.com/nourhankha1ifa/Data_Analysis/blob/main/DEPI/Power%20BI/Power%20BI%206/P3_Financial%20Analysis.png)
<br>

**Cards:** Total Revenue, Average Bill Per Visit, Medicine %.

| Chart | Type | What it shows | Why I used this chart |
|---|---|---|---|
| **Total Revenue by Insurance Provider** | Clustered bar chart | Revenue split by insurance provider | Insurance provider names vary in length, so a horizontal bar chart handles that better than columns. |
| **Sum of Costs by Hospital and Year** | Column chart | Room charges, medicine cost, and procedure cost, broken down by hospital and year | I used a column chart with 3 cost measures together so I could compare **what kind** of cost dominates at each hospital, not just the total — this answers the "cost breakdown" requirement directly. |
| **Total Revenue by Payment Method** | Pie chart | Revenue split by payment method (Cash / Insurance / Card) | A small, fixed set of payment methods makes a pie chart a natural fit for a share-of-total question. |

**Slicers:** City, Region, Date.

---

## 6. Design Notes
- Split the dashboard into 3 pages by topic (overview / medical / financial) rather than one crowded page, since the questions genuinely come from different angles.
- Repeated the City, Region, and Date slicers on every page, so each page can be explored on its own without switching context.
- Business logic (age groups, procedure types, disease categories, hospital region) was built once in Power Query rather than recreated per chart, so every page's groupings stay consistent.

---

## 7. Business Impact

- **Faster operational decisions:** the Overview page gives hospital management the big picture — total visits, revenue, and patient count — in seconds.
- **Clinical insight:** the Medical Analysis page highlights which diagnoses and procedures are most common, and how department workload splits across age groups — useful for staffing and resource planning.
- **Financial clarity:** the Financial Analysis page shows exactly where revenue comes from (insurance vs. cash vs. card) and how costs break down between procedures, medicine, and room charges at each hospital.
- **Consistent classifications:** because age groups, procedure types, and disease categories are calculated once in the model, every report and every future chart built on this model will use the same consistent groupings.
- **A reusable foundation:** with a full star schema and calculated groupings already in place, this model is ready to support more pages or deeper analysis later without needing to rebuild the fundamentals.

---

## 8. File Reference
| File | Purpose |
|---|---|
| `Hospital_Dashboard.pbix` | The Power BI report file |
| `hospital_dataset.xlsx` | Raw source data |
| `Final_hospital_Analysis_dashboard.pdf` | The project brief and requirements |

