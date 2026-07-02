# SQL / Database Learning – Task 1: Entity-Relationship (ER) Diagrams

Before writing SQL, this task was about learning how to **design** a database first. I worked through 3 case studies and drew an ER diagram for each — the planning step that comes before any `CREATE TABLE` statement.

---

## What I Learned

- **Entities** — the "things" a database tracks (e.g. Musician, Property), which become tables.
- **Attributes** — the data each entity holds (e.g. Name, Phone), which become columns.
  - **Composite** — one attribute split into parts (e.g. Address → Street, City).
  - **Multi-valued** — an attribute that can hold more than one value (e.g. a drug with several brand names).
- **Keys** — the attribute that uniquely identifies each row (underlined), same idea as a `PRIMARY KEY`.
- **Relationships** — how two entities connect (drawn as a diamond).
- **Cardinality (1:1, 1:M, M:M)** — how many of one entity relate to how many of another.
- **Participation constraints** — double line = every record must join the relationship; single line = optional.

---

## Problem 1 – Musicana (Music Label)

![Dashboard Preview](https://github.com/nourhankha1ifa/Data_Analysis/blob/main/EraaSoft/SQL/SQL%201/Proplem%201.png)
<br>

Entities: Musician, Instrument, Album, Song.
- Musician **M:M** Instrument (`Play`)
- Musician **M:M** Song (`Performed`)
- Album **1:M** Song (`has`)
- Musician **1:M** Album (`Produces`)

Practiced modeling **many-to-many relationships**.

## Problem 2 – Real Estate Firm

![Dashboard Preview](https://github.com/nourhankha1ifa/Data_Analysis/blob/main/EraaSoft/SQL/SQL%201/Proplem%202.png)
<br>

Entities: Sales Office, Employee, Property, Owner.
- Sales Office **1:M** Employee (`Assigned`) vs. **1:1** Employee (`Manage`)
- Sales Office **1:M** Property (`Listed`)
- Owner **1:M** Property (`Own`), with `Percent Owned` stored **on the relationship**, not on either entity

Practiced telling apart two similar relationships with different cardinality, and putting an attribute on a relationship.

## Problem 3 – General Hospital

![Dashboard Preview](https://github.com/nourhankha1ifa/Data_Analysis/blob/main/EraaSoft/SQL/SQL%201/Proplem%203.png)
<br>

Entities: Ward, Patient, Nurse, Consultant, Drug.
- Ward **1:M** Patient (`host`)
- Consultant **1:M** Patient (`Lead`) vs. **M:M** Patient (`Examine`)
- Ward **1:1** Nurse (`supervise`) vs. **1:M** Nurse (`serve`)
- `Give` ties Nurse, Patient, and Drug together, recording dosage/date/time

Practiced handling **two different relationships between the same two entities**.

---

## Files

| File | What it is |
|---|---|
| `ERD_Task_1.pdf` | The three problem descriptions |
| `Proplem_1.png` / `2` / `3` | My ER diagrams for each problem |
