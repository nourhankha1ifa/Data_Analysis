# Python Learning Journey

This covers 7 numbered tasks plus one bigger practice project, going from basic Python all the way to NumPy, pandas, and data visualization.

---

## Overview

| File | Topic | What it's about |
|---|---|---|
| `Task_1.ipynb` | Basics | Variables, data types, input/output, math, strings |
| `Task_2.ipynb` | Conditionals & Data Types | If/elif/else logic, lists, tuples |
| `Task_3.ipynb` | Loops & Functions | For loops, writing functions |
| `Task_4.ipynb` | NumPy | Arrays, indexing, arithmetic, reshaping |
| `Task_5.ipynb` | Pandas (Ramen dataset) | Reading CSVs, selection, filtering, new columns |
| `Task_6.ipynb` | Pandas (Weather dataset) | Exploring, filtering, grouping, summary statistics |
| `Task_7.ipynb` | Data Visualization | Line, bar, and pie charts with Matplotlib |
| `Python_Workshop.ipynb` | Final project: sales data | A full data cleaning + analysis project |

---

## Task 1 – Data Types, Variables, Input/Output, Math, Strings

**What I learned:**
- Getting input with `input()` and converting it with `float()` / `int()`
- Formatting output with f-strings, including controlling decimal places (`:.2f`)
- Using the `math` module (`math.pi`) for a real calculation
- Basic arithmetic operators, and checking for division by zero before dividing
- String slicing (`[::-1]`) to reverse text
- Checking if a word appears inside a string with `not in`

**What I practiced with:** converting Fahrenheit to Celsius, finding the area of a circle, printing a greeting, calculating a birth year from an age, finding the area of a rectangle, doing all four basic operations on two numbers safely, reversing a name, and checking a string for a specific word.

---

## Task 2 – Conditional Statements and Data Types

**What I learned:**
- `if / elif / else` logic, including combining conditions with `and`
- Checking if a string is a palindrome using slicing (`text == text[::-1]`)
- Checking if a string is only letters with `.isalpha()`
- The leap year rule, written as one combined condition
- Basic list operations (`len()`) and tuple membership checks (`in`)

**What I practiced with:** classifying a number as positive/negative/zero, even/odd, checking for a palindrome, finding the largest of three numbers, checking if two numbers are equal, checking if a string is only letters, checking for a leap year, counting items in a list of student names, and searching for a number inside a tuple.

---

## Task 3 – For Loops and Functions

**What I learned:**
- Looping over a **set** and a **list** with a `for` loop
- Splitting a string with `.split()` to pull out just the part I need (the username before the `@`)
- Writing my own functions with `def`, including functions that return a value instead of just printing
- Using the modulo operator (`%`) inside a function to check for even numbers
- Handling positive and negative numbers inside a function (recreating `abs()` myself)
- Applying a formula to every item in a list and building a new list with the results

**What I practiced with:** pulling usernames out of a set of email addresses, printing the length of each name in a list, summing the squares of the even numbers in a list, writing my own absolute value function, and converting a list of Celsius temperatures to Fahrenheit.

---

## Task 4 – NumPy

**What I learned:**
- Creating a random array with `np.random.randint()`
- Indexing and slicing an array: first N elements, last N elements, and every other element (`[::2]`)
- Doing element-by-element arithmetic between two arrays (addition, subtraction, multiplication, division) without writing a loop
- Rounding array results with `np.round()`
- Reshaping a 1D array into a 2D matrix with `.reshape()`
- Selecting a whole row, a whole column, and a smaller sub-matrix out of a 2D array

**What I practiced with:** generating 20 random numbers, slicing them different ways, doing arithmetic between two random arrays, and reshaping the original array into a 4×5 matrix to pull out specific rows, columns, and a sub-matrix.

---

## Task 5 – Pandas: Ramen Ratings Dataset

**What I learned:**
- Reading a CSV into a DataFrame with `pd.read_csv()`
- The difference between `.iloc[]` (position-based selection) and `.loc[]` (label-based selection)
- Selecting a range of rows and specific columns together (`df.loc[2560:2565, ['Brand','Stars']]`)
- Filtering rows with a condition (`df[df['Country'] == 'Japan']`)
- Cleaning a column that mixes text and numbers: I found the `Stars` column had the word `"Unrated"` mixed in with numbers, so I replaced it with `"0"` using `.str.replace()` before converting the whole column to a proper number type with `.astype(float)`
- Combining two conditions in one filter with `&`
- Creating a new column based on a condition, using a custom function with `df.apply(..., axis=1)`

**What I practiced with:** loading the ramen ratings dataset, selecting rows different ways, filtering by country and by star rating, filtering by style and country together, cleaning the Stars column, and adding a `Rating_Category` column that labels each ramen "Excellent" or "Good".

---

## Task 6 – Pandas: Weather Dataset

**What I learned:**
- Exploring a new dataset with `.head()`, `.shape`, `.index`, `.columns`, `.info()`, `.nunique()`, and `.count()`
- Finding unique values in a column with `.unique()`
- Counting how many rows match a condition
- Checking for missing data with `.isnull().sum()`
- Renaming a column with `.rename()`
- Summary statistics beyond the average: `.mean()`, `.std()` (standard deviation), and `.var()` (variance)
- Filtering with `&` (and) and `|` (or), including combining three conditions together in one filter
- Grouping data with `.groupby()` and applying `.mean()` or multiple statistics at once with `.agg(['min','max'])`

**What I practiced with:** exploring the weather dataset end-to-end, finding unique wind speeds, counting exact weather conditions, finding missing values, renaming a column, calculating mean/standard deviation/variance for different columns, filtering on combined conditions (like wind speed **and** visibility, or weather **or** visibility), and grouping by weather condition to compare stats across categories.

---

## Task 7 – Data Visualization with Matplotlib

**What I learned:**
- Building a **line chart** with markers, a legend, and axis labels — good for showing a trend over time (monthly sales)
- Building a **bar chart** to compare categories side by side (revenue by product)
- Building a **pie chart** with percentage labels shown directly on the slices (`autopct='%1.1f%%'`) and a rotated starting angle
- Adding titles and axis labels to make a chart understandable on its own

**What I practiced with:** a line chart for a 6-month sales trend, a bar chart comparing revenue across 4 product categories, and a pie chart showing programming language market share.

---

## Python_Workshop.ipynb – Final Project: Sales Data Cleaning & Analysis

This is the final project, built against its own brief (`Python Final Project.txt`) using a raw sales export (`all_data.csv`) — customer orders with duplicated/confusing columns from being joined with company and supplier data. It's the most complete piece of work in the series: clean a genuinely messy dataset first, then analyze it properly.

**Data cleaning:**
- Dropped rows with missing `OrderID` values using `.dropna(subset=[...])`
- Renamed confusing duplicate-looking columns (`City.1`, `Country.1`, `Phone.1`) to clear names (`CompanyCity`, `CompanyCountry`, `CompanyPhone`)
- Converted `OrderDate` to a real date type with `pd.to_datetime()`
- Converted several ID columns to proper integers with `.astype(int)`
- Removed duplicate rows based on `OrderID` and `OrderNumber` together
- Cleaned up column names by stripping spaces and lowercasing them
- Selected down to just the columns actually needed for analysis

**Analysis, done in three levels:**
- **Univariate** (one column at a time): a histogram of order amounts with mean and median lines marked on it, and bar charts showing how orders are spread across cities and countries
- **Bivariate** (two columns together): total amount per country and per city (bar charts), total amount over time (line chart), and the top 10 customers by total spending (bar chart)
- **Multivariate** (several columns together): resampling orders by month to track both the number of countries active and total amount per month, and a scatter chart showing each country's monthly total amount, with point size representing the amount

**New tools used here that hadn't come up before:** `seaborn` (`sns.histplot`) for a distribution chart with mean/median reference lines, `plotly.express` (`px.bar`, `px.line`, `px.scatter`) for interactive charts, and pandas' `.resample('M')` to group data by month directly from a date index.

---

## Files

| File | What it is |
|---|---|
| `1_Task_Python.pdf` – `7_Task_Python.pdf` | The task briefs for each numbered task |
| `Task_1.ipynb` – `Task_7.ipynb` | My answers to each numbered task |
| `Python Final Project.txt` | The brief for the final project |
| `all_data.csv` | The raw, messy sales dataset used in the final project |
| `Python_Workshop.ipynb` | My completed final project — cleaning and analyzing the sales data |

---

## What I Learned Overall

Across these files, the progression goes from single Python statements to a full, real-world data analysis workflow:

- **Tasks 1–3** built the fundamentals: variables, conditionals, loops, and functions.
- **Task 4** introduced NumPy, and thinking in arrays instead of loops for math on many numbers at once.
- **Tasks 5–6** brought in pandas for real datasets — selecting, filtering, cleaning messy values, and grouping data to compare categories.
- **Task 7** added visualization, matching the chart type to the question (trend → line, comparison → bar, share of whole → pie).
- **The final project** pulled everything together into one real project: clean messy data first, then explore it one column at a time, then two at a time, then several at once — and picking new tools (seaborn, plotly) when they fit the chart better than Matplotlib alone.
