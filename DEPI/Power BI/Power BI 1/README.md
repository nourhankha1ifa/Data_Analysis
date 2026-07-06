# Data Science Survey — Data Cleaning (Power BI)

This is my first Power BI project. It's a learning project, not a finished, production-ready dashboard — the task was specifically about cleaning data in Power Query, not building charts yet.

---

## 1. Overview

This project takes a raw survey of data professionals (roles, salaries, happiness at work, and demographics) and cleans it up inside Power BI's Power Query Editor, ready for analysis later.

| | |
|---|---|
| **Report pages** | 1 (empty — no visuals built yet) |
| **Data source** | `Data Science Survey.xlsx` |
| **Tools used** | Power BI Desktop (Power Query only) |

---

## 2. Business Problem

Survey data almost never comes out clean. This survey export had several problems that would make it hard to analyze as-is:

- Answers to some questions were stored as long sentences (e.g. a job title with extra descriptive text after it) instead of a clean, short value.
- Salary was given as a text range (like `"100k-150k"`), not a number — so you couldn't average it, sort it, or put it on a chart.
- Some happiness-rating answers were left blank when someone skipped a question.
- One respondent had an age of 92, which stood out as an unrealistic outlier for this kind of survey.
- Personal/technical columns (Email, Browser, OS, IP-adjacent info like City/Country of the response, Referrer, Time Spent) were mixed in with the actual survey answers.

Without fixing these, nothing built afterward — a chart, a measure, a filter — would be reliable.

## 3. Goal of the Task

The goal was to take the raw file and, using only Power Query (no charts yet), turn it into one clean table that's actually ready to analyze:

1. Remove columns that aren't needed for the analysis (technical/tracking columns).
2. Fix the salary field so it becomes real numbers instead of text ranges.
3. Split messy text answers down to just the useful part.
4. Handle missing values sensibly instead of leaving blanks.
5. Remove a clear outlier that would skew any age-based analysis.
6. Rename every column to something short and clear.

---

## 4. Data Source

**Source:** `Data Science Survey.xlsx`, one sheet, loaded into Power BI and promoted to use its first row as headers.

**Original columns included:** Unique ID, Email, dates/times the survey was taken, Browser, OS, City, Country, Referrer, Time Spent, and 13 survey questions (Q1–Q13) covering role, career switch, salary, industry, favorite programming language, happiness across 6 areas, difficulty breaking into data, what matters most in a next job, gender, age, country, education, and ethnicity.

---

## 5. Data Cleaning Steps (Power Query)

This is where all the actual work happened. Step by step:

1. **Promoted headers** — made the first row of the spreadsheet into real column names.
2. **Set proper data types** — text, date, time, or whole number, for every column, instead of leaving everything as generic text.
3. **Removed tracking columns** that don't matter for the analysis: Email, Date/Time Taken, Browser, OS, City, Country (of the response), Referrer, and Time Spent.
4. **Renamed every survey question** from its full sentence (like *"Q1 - Which Title Best Fits your Current Role?"*) to a short, clear name (`CurrentRole`), and did the same for all 13 questions (`CareerSwitch`, `Industry`, `ProgrammingLanguage`, `Gender`, `Age`, `Country`, `Education`, `Ethnicity`, and 6 separate `Happiness(...)` columns for salary, work/life balance, coworkers, management, upward mobility, and learning new things).
5. **Cleaned up `CurrentRole`** — some answers had extra text in brackets after the job title, so I split the column at the `(` character and kept only the first part.
6. **Fixed the salary field** — this was the trickiest part:
   - Salary was written like `"100k-150k"`, so I split it into a low and a high number at the `-`.
   - Replaced the letter `"k"` with `"000"` in both parts, and removed any stray `"+"` signs, so `"150k+"` became a real number.
   - Where the high end of the range was missing, I filled it in with `225000` as a reasonable upper estimate.
   - Converted both parts to whole numbers, then created a new `AvgSalary` column as the midpoint of the low and high values — one clean number I can actually chart or average.
   - Removed the original low/high text columns once `AvgSalary` was built, and reordered columns so `AvgSalary` sits in a sensible place.
7. **Cleaned up `Industry`, `ProgrammingLanguage`, `NewJob`, `Country`, and `Ethnicity`** the same way — each of these had extra bracketed or colon-separated text after the real answer, so I split each column and kept just the clean part.
8. **Filled in missing happiness ratings** — instead of leaving blanks where someone skipped a happiness question, I filled each one with a reasonable default (4 or 5, depending on the question) so later averages aren't thrown off by missing data.
9. **Removed an outlier** — filtered out the one response where Age was 92, since it's far outside a realistic range for this survey and would distort any age-based analysis.
10. **Fixed a blank `Education` value** — filled in `"Bachelors"` for the one row where Education was left empty.

**Final result:** one clean table, `Data Professional Survey`, with 19 well-named, properly typed columns — ready to load into the data model with Close & Apply.

---

## 6. About the Charts

This particular lesson stopped at the data-cleaning stage — the task was specifically to load, clean, and apply the data in Power Query, not to build visuals yet. So there's no dashboard page with charts in this file. The report page is currently empty, ready for the next lesson where I'll actually build cards and charts on top of this cleaned table.

---

## 7. Business Impact

Even though this project is "just" cleaning, that step matters a lot in practice:

- **Reliable numbers:** turning salary from a text range into a real `AvgSalary` number means it can now be averaged, sorted, and charted — none of that was possible with the raw text.
- **Cleaner categories:** stripping the extra bracketed text from fields like Role, Industry, and Programming Language means future charts will group people correctly instead of splitting the same answer into several slightly different text values.
- **Less noise:** removing tracking columns (Browser, OS, Referrer, etc.) means anyone building visuals later isn't distracted by fields that have nothing to do with the actual survey questions.
- **More trustworthy averages:** filling in missing happiness ratings and removing the age-92 outlier means summary statistics built later won't be quietly skewed by a few bad data points.
- **A solid foundation:** because all of this cleanup happened in Power Query rather than by hand, it will re-run automatically if the survey file is refreshed with new responses.

---

## 8. Known Limitations
- No visuals or measures yet — this file is data preparation only.
- A few cleaning choices involved judgment calls (like filling missing happiness scores with 4 or 5, and estimating 225000 for an open-ended top salary bracket) rather than a database-verified true value.
- Only the one worksheet/table was used; no relationships or star schema were needed since there's just one table.

---

## 9. File Reference
| File | Purpose |
|---|---|
| `Survey_Analysis.pbix` | The Power BI report file with the Power Query cleaning steps applied |
| `Data_Science_Survey.xlsx` | Raw source data |

