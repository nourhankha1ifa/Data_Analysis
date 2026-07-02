# SQL / Database Learning – Task 2: Mapping ER Diagrams to Relational Tables

Task 1 was about designing ER diagrams for 3 case studies. This task takes those diagrams and turns them into actual **relational tables** — with primary keys and foreign keys — which is the exact step that comes right before writing `CREATE TABLE` statements in SQL.

---

## What I Learned

- **Each entity becomes a table**, and its key (underlined in the diagram) becomes the table's **primary key**.
- **A 1:M relationship becomes a foreign key** placed on the "many" side of the relationship, pointing back to the primary key on the "one" side. In my diagrams this is shown with a dashed underline.
- **A M:M relationship becomes its own junction (bridge) table**, made up of the primary keys from both entities combined together as the new table's key. This is needed because a normal column can't hold "many" values on its own — SQL tables are built to store one value per column, so the relationship itself needs a table.
- **A multi-valued attribute becomes its own table** too, for the same reason — one column can't hold more than one value, so each value gets its own row instead, linked back by a foreign key.
- **A relationship that carries its own data** (like a percentage owned, or a date and time) also becomes its own table — storing the related foreign keys *plus* that extra piece of data together, since the data only makes sense in the context of that specific relationship, not on either entity alone.
- **A relationship connecting more than two entities** (a ternary relationship) becomes one table holding a foreign key back to each entity involved, plus any extra attributes describing that relationship.

---

## Problem 1 – Musicana (Music Label)
![Dashboard Preview](https://github.com/nourhankha1ifa/Data_Analysis/blob/main/EraaSoft/SQL/SQL%202/Problem%201.png)
<br>

Starting from the Musician / Instrument / Album / Song entities and their relationships, I mapped them into 6 tables:

| Table | Columns | Notes |
|---|---|---|
| `Musician` | `ID_M` (PK), Name, Phone, St, City | Simple entity table |
| `Album` | `ID_A` (PK), cr-date, title, `ID_M` (FK → Musician) | The producer relationship (1:M) became a foreign key here, since each album has exactly one producing musician |
| `Song` | Title (PK), author, `ID_A` (FK → Album) | The "appears on" relationship (1:M) became a foreign key here, since each song belongs to exactly one album |
| `Instrument` | Name (PK), Key | Simple entity table |
| `Play_instrument` | Name (FK → Instrument), `ID_M` (FK → Musician) | Junction table for the M:M "plays" relationship between musicians and instruments |
| `Play_song` | Title (FK → Song), `ID_M` (FK → Musician) | Junction table for the M:M "performed" relationship between musicians and songs |

The two junction tables (`Play_instrument`, `Play_song`) were the main new idea in this problem — since a musician can play many instruments and an instrument can be played by many musicians, that relationship can't live as a single foreign key on either table; it needs its own table combining both keys.

---

## Problem 2 – Real Estate Firm
![Dashboard Preview](https://github.com/nourhankha1ifa/Data_Analysis/blob/main/EraaSoft/SQL/SQL%202/Problem%202.png)
<br>

Starting from the Property / Owner / Employee / Sales Office entities, I mapped them into 5 tables:

| Table | Columns | Notes |
|---|---|---|
| `Property` | `ID_P` (PK), Zip, Addr, State, City, Num (FK → Sales_office) | Each property is listed with exactly one sales office (1:M), so the office number became a foreign key here |
| `Owner` | `ID_O` (PK), Name | Simple entity table |
| `Employee` | `ID_E` (PK), Name, Num (FK → Sales_office) | Each employee is assigned to exactly one sales office (1:M), so the office number became a foreign key here |
| `Sales_office` | Num (PK), Loc, `ID_E` (FK → Employee) | The manager relationship (1:1) became a foreign key here instead, since each office has exactly one manager |
| `Property_owned` | `ID_P` (FK → Property), `ID_O` (FK → Owner), Percent_own | Junction table for the M:M ownership relationship, carrying the extra `Percent_own` attribute that only makes sense for a specific owner-property pair |

This problem was good practice for noticing that **two relationships between the same two tables can turn into different things** — `Assigned` (1:M) became a foreign key on `Employee`, while `Manage` (1:1) became a foreign key on `Sales_office` instead, pointing the opposite direction.

---

## Problem 3 – General Hospital
![Dashboard Preview](https://github.com/nourhankha1ifa/Data_Analysis/blob/main/EraaSoft/SQL/SQL%202/Problem%203.jpg)
<br>

Starting from the Patient / Ward / Nurse / Consultant / Drug entities, I mapped them into 8 tables:

| Table | Columns | Notes |
|---|---|---|
| `Patient` | IDP (PK), Name, DOB, IDC (FK → Consultant), IDW (FK → Ward) | Each patient has one leading consultant and is hosted by one ward (both 1:M), so both became foreign keys here |
| `Ward` | IDW (PK), Name, IDN (FK → Nurse) | Each ward is supervised by exactly one nurse (1:1), so the nurse became a foreign key here |
| `Nurse` | IDN (PK), Name | Simple entity table |
| `Consultant` | IDC (PK), Name | Simple entity table |
| `Drug` | Code (PK), RecD | Simple entity table (RecD = recommended dosage) |
| `Drug_Brand` | Code (FK → Drug), Brand | Separate table for the multi-valued `brand` attribute, since a drug can have more than one brand name |
| `Examine` | IDC (FK → Consultant), IDP (FK → Patient) | Junction table for the M:M "examines" relationship (separate from the 1:M "leading consultant" relationship already on `Patient`) |
| `Dosage` | IDP (FK → Patient), IDN (FK → Nurse), Code (FK → Drug), Date, Time, Dosage | One table tying Patient, Nurse, and Drug together to record every time a drug was given, along with the date, time, and dosage amount |

This was the most involved mapping of the three, because it needed:
- Two *different* relationships between the same pair of entities (`Consultant` and `Patient`) mapped in two different ways — one as a foreign key (`Lead`), one as a junction table (`Examine`).
- A multi-valued attribute (`brand`) split out into its own table.
- A relationship connecting **three** entities at once (Nurse gives Patient a Drug), mapped into a single table with three foreign keys plus the extra details about that specific event.

---

## Files

| File | What it is |
|---|---|
| `Mapping_Task.pdf` | The mapped tables for all 3 problems, typed up |
| `Problem_1.png` | Musicana table mapping |
| `Problem_2.png` | Real estate table mapping |
| `Problem_3.jpg` | Hospital table mapping (handwritten) |

---

## What I Learned Overall

This task was the bridge between "designing a database on paper" and "actually building it in SQL":

- Turning an ER diagram into a real, buildable set of tables, instead of just a conceptual picture.
- Recognizing which relationships need a foreign key versus which ones need a whole new junction table.
- Handling special cases properly: multi-valued attributes, relationships with their own data, and relationships involving more than two entities.
- Getting comfortable with primary keys and foreign keys as the actual mechanism that connects tables — which is exactly what I'll be using once I start writing `CREATE TABLE`, `PRIMARY KEY`, and `FOREIGN KEY` statements in SQL.
