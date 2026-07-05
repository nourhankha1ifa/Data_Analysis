# My Python Learning Journey

This is my Python learning project. It's made up of 4 tasks that I worked through one after another, starting from the basics and building up to working with a real dataset using pandas. This is not a finished application — it's a record of what I practiced and learned.

---

## Overview

| Task | Topic | What it's about |
|---|---|---|
| Task 1 | Basics | Variables, data types, arithmetic, simple input/output programs |
| Task 2 | Conditionals & Strings | If/elif/else logic, and string methods and slicing |
| Task 3 | Data Structures & Loops | Lists, tuples, sets, dictionaries, for loops, while loops |
| Task 4 | Pandas Project | Cleaning and analyzing a real HR dataset with pandas |

---

## Task 1 – Python Basics

**What I learned:**
- How to create variables and check their data type with `type()`
- The difference between `int`, `float`, and `string` data types
- How to get input from the user with `input()` and convert it to a number with `float()` / `int()`
- Basic math operations (`+`, `-`, `*`, `/`, `//`, `%`, `**`)
- Simple `if / elif / else` logic to compare two numbers

**What I practiced with:**
- Declaring variables (age, height, name) and printing their types
- Converting Fahrenheit to Celsius
- Calculating a square and a cube of a number
- Converting kilometers to miles
- Finding the larger of two numbers
- Calculating total cost from price × quantity
- Calculating an average grade from three scores
- Finding the area of a triangle and a rectangle
- Integer division and remainder (`//` and `%`)

---

## Task 2 – Conditionals and Strings

**What I learned:**
- How to build more detailed decisions with `if / elif / else`, including checking multiple conditions with `and`
- How to work with text using string methods: `.upper()`, `.count()`, `.split()`, `.index()`, `.strip()`, `.isdigit()`
- How to use **slicing** (`string[start:end]`, `string[::-1]`) to grab or reverse parts of a string
- How to check string length with `len()`

**What I practiced with:**
- Checking if a number is even/odd, positive/negative/zero
- Checking for a leap year
- Building a simple calculator that takes two numbers and an operator
- Grouping ages into Child / Teenager / Adult / Senior Citizen
- Grading a score into A–F
- Comparing two numbers (greater / less / equal)
- Converting text to uppercase, extracting a substring, reversing a string
- Checking if a string is a palindrome using slicing
- Counting a letter in a string, splitting text by commas
- Checking if a string starts with certain text, or if it's all digits
- Removing extra spaces from a string with `.strip()`

---

## Task 3 – Data Structures and Loops

**What I learned:**
- The 4 main Python data structures and how they're different:
  - **List** — ordered, can be changed (add/remove/edit items)
  - **Tuple** — ordered, cannot be changed after creation
  - **Set** — unordered, no duplicate values, has math-style operations (union, intersection, difference)
  - **Dictionary** — stores data as key–value pairs
- Common methods for each: `.append()`, `.extend()`, `.pop()`, `.remove()`, `.clear()`, `.sort()` for lists; `.count()` for tuples; `.union()`, `.intersection()`, `.difference()`, `.update()` for sets; `.keys()`, `.values()`, `.items()`, `.update()` for dictionaries
- How to build a dictionary from two separate lists using `zip()`
- How to write a **for loop** to go through a list and find a value (like the maximum, without using `max()`)
- How to write a **while loop** to repeat something until a condition is met, including an infinite loop with `break`

**What I practiced with:**
- Editing, searching, sorting, combining, and removing items from lists
- Counting, converting, merging, and slicing tuples
- Adding, combining, and comparing sets (union, intersection, difference, symmetric difference)
- Creating, reading, updating, and deleting dictionary entries
- Finding the max and second-smallest number in a list using a for loop, without built-in functions
- Counting up and down, printing even numbers, summing numbers, building a multiplication table, and calculating a factorial using while loops
- A loop that keeps asking the user for input until they type `0`

---

## Task 4 – Pandas Project: HR Dataset

This was the biggest task — applying everything from Tasks 1–3 to a real dataset (`hr_dataset.csv`) using the **pandas** library, going from raw data to a cleaned, analyzed result (`cleaned_hr_data.csv`).

**What I learned:**
- How to load a CSV into a DataFrame with `pd.read_csv()` and inspect it with `.head()`, `.tail()`, `.shape`, `.columns`, `.dtypes`
- How to find and handle missing data with `.isnull().sum()` and `.fillna()`
- How to rename columns and convert a column to a proper date type with `pd.to_datetime()`
- How to find and remove duplicate rows with `.duplicated()` and `.drop_duplicates()`
- How to create new columns based on conditions using `.loc[]`
- How to group continuous numbers into categories (binning) using `pd.cut()`
- How to do simple math across columns (e.g. Bonus = Salary × 10%)
- How to select specific columns and filter rows with conditions (`>`, `==`, `&` for AND)
- How to search inside text columns with `.str.contains()`
- How to sort data with `.sort_values()` and get the top rows with `.head()` / `.nlargest()`
- How to summarize data with `.min()`, `.max()`, `.mean()`, `.unique()`, `.nunique()`, `.value_counts()`
- How to group data and summarize it per group with `.groupby()`, including multiple statistics at once with `.agg()`
- How to pull the year and month out of a date column with `.dt.year` and `.dt.month`
- How to take a random sample of rows with `.sample()`
- How to replace text inside a column with `.replace()`
- How to save the final, cleaned DataFrame back to a CSV with `.to_csv()`

**What I did, step by step:**
1. Loaded the HR data and checked its shape, columns, and data types.
2. Found and fixed missing `Salary` values by filling them with the average salary.
3. Renamed a column and converted `HireDate` to a real date type.
4. Checked for and removed duplicate employee records.
5. Created new columns:
   - `Experience_Level` (Junior / Mid / Senior) based on years of experience
   - `Salary_Category` (Low / Medium / High) using binning
   - `Bonus` and `Total_Compensation` calculated from salary
   - `Salary_Level` (Low / Medium / High) based on salary conditions
   - `HireYear` and `HireMonth` extracted from the hire date
6. Filtered employees using different conditions (department, salary, performance score, job title).
7. Sorted and ranked employees by experience and salary.
8. Summarized the data: average/min/max salary, department counts, average salary and performance per department, employees hired per year/month.
9. Cleaned up a job title by replacing text.
10. Exported the final result to `cleaned_hr_data.csv`.

---

## Files in This Project

| File | What it is |
|---|---|
| `Task_1` | Notebook — Python basics (variables, types, math, input/output) |
| `Task_2` | Notebook — conditionals and string methods |
| `Task_3` | Notebook — lists, tuples, sets, dictionaries, loops |
| `Task_4` | Notebook — pandas project cleaning and analyzing HR data |
| `hr_dataset.csv` | Raw HR data used in Task 4 |
| `cleaned_hr_data.csv` | Final cleaned/enriched HR data produced at the end of Task 4 |

---

## What I Learned Overall

Going through these four tasks, I moved from single Python statements to actually cleaning and analyzing a real dataset:

- **Task 1–2** gave me the core building blocks: variables, data types, decisions (`if/elif/else`), and working with text.
- **Task 3** taught me how to organize and store data properly with the right structure (list vs. tuple vs. set vs. dictionary) and how to repeat actions with loops.
- **Task 4** brought it all together in a real pandas workflow — the same kind of process (load → clean → transform → analyze → export) that's used in real data analysis work.
