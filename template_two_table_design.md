# Two Tables Design Recipe Template

_Copy this recipe template to design and create two related database tables from a specification._

## 1. Extract nouns from the user stories or specification

```
# EXAMPLE USER STORY:
# (analyse only the relevant part - here the final line).


```

```
Nouns:

album, title, release year, artist, name
```

## 2. Infer the Table Name and Columns

Put the different nouns in this table. Replace the example with your own nouns.

| Record                | Properties          |
| --------------------- | ------------------  |
|                       | 
|                       | 

1. Name of the first table (always plural): `xs` 

    Column names: `y`, `z`

2. Name of the second table (always plural): `as` 

    Column names: `b`

## 3. Decide the column types.

[Here's a full documentation of PostgreSQL data types](https://www.postgresql.org/docs/current/datatype.html).

Most of the time, you'll need either `text`, `int`, `bigint`, `numeric`, or `boolean`. If you're in doubt, do some research or ask your peers.

Remember to **always** have the primary key `id` as a first column. Its type will always be `SERIAL`.

```
# EXAMPLE:

Table:
id: SERIAL


Table: 
id: SERIAL

```

## 4. Decide on The Tables Relationship

Most of the time, you'll be using a **one-to-many** relationship, and will need a **foreign key** on one of the two tables.

To decide on which one, answer these two questions:

1. Can one [TABLE ONE] have many [TABLE TWO]? (Yes/No)
2. Can one [TABLE TWO] have many [TABLE ONE]? (Yes/No)

You'll then be able to say that:

1. **[A] has many [B]**
2. And on the other side, **[B] belongs to [A]**
3. In that case, the foreign key is in the table [B]

Replace the relevant bits in this example with your own:

```
# EXAMPLE

1. Can one A have many Bs? YES
2. Can one B have many As? NO

-> Therefore,
-> An A HAS MANY Bs
-> An B BELONGS TO an A

-> Therefore, the foreign key is on the Bs table.
```

*If you can answer YES to the two questions, you'll probably have to implement a Many-to-Many relationship, which is more complex and needs a third table (called a join table).*

## 4. Write the SQL.

```sql
-- EXAMPLE
-- file: _table.sql

-- Replace the table name, columm names and types.

-- Create the table without the foreign key first.
CREATE TABLE As (
  id SERIAL PRIMARY KEY,
  name text,
  
);

-- Then the table with the foreign key.
CREATE TABLE Bs (
  id SERIAL PRIMARY KEY,
  name text, 

-- The foreign key name is always {other_table_singular}_id
  _id int,
  constraint fk_foreign key(_id)
    references s(id)
    on delete cascade
);

```

## 5. Create the tables.

```bash
psql -h 127.0.0.1 database_name < _table.sql
```