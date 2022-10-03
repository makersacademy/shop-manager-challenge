Two Tables Design Recipe Template
Copy this recipe template to design and create two related database tables from a specification.

1. Extract nouns from the user stories or specification
# EXAMPLE USER STORY:
# (analyse only the relevant part - here the final line).

As a shop manager
So I can know which items I have in stock
I want to keep a list of my shop items with their name and unit price.

As a shop manager
So I can know which items I have in stock
I want to know which quantity (a number) I have for each item.

As a shop manager
So I can manage items
I want to be able to create a new item.

As a shop manager
So I can know which orders were made
I want to keep a list of orders with their customer name.

As a shop manager
So I can know which orders were made
I want to assign each order to their corresponding item.

As a shop manager
So I can know which orders were made
I want to know on which date an order was placed. 

As a shop manager
So I can manage orders
I want to be able to create a new order.
Nouns: item(text), item price(int), quantity (int), create new item, list of orders with customer name, assign order to item, order date

album, title, release year, artist, name
2. Infer the Table Name and Columns
Put the different nouns in this table. Replace the example with your own nouns.


Record	Properties
item	price, quantity

Name of the first table (always plural): items

Column names: title, release_year

Name of the second table (always plural): orders

Column names: order, customer name, assign order to item, order date

3. Decide the column types.
Here's a full documentation of PostgreSQL data types.

Most of the time, you'll need either text, int, bigint, numeric, or boolean. If you're in doubt, do some research or ask your peers.

Remember to always have the primary key id as a first column. Its type will always be SERIAL.

# EXAMPLE:

Table: items
id: SERIAL 
item: text
price(£): int
quantity: int

Table: orders
id: SERIAL PRIMARY KEY
order: text
customer_name: text
order_date: date

4. Decide on The Tables Relationship
Most of the time, you'll be using a one-to-many relationship, and will need a foreign key on one of the two tables.

To decide on which one, answer these two questions:

Can one [TABLE ONE] have many [TABLE TWO]? (Yes/No)
Can one [TABLE TWO] have many [TABLE ONE]? (Yes/No)
You'll then be able to say that:

[A] has many [B]
And on the other side, [B] belongs to [A]
In that case, the foreign key is in the table [B]
Replace the relevant bits in this example with your own:

# EXAMPLE

1. Can one artist have many albums? YES
2. Can one album have many artists? NO

-> Therefore,
-> An artist HAS MANY albums
-> An album BELONGS TO an artist

-> Therefore, the foreign key is on the albums table.
If you can answer YES to the two questions, you'll probably have to implement a Many-to-Many relationship, which is more complex and needs a third table (called a join table).

4. Write the SQL.
-- EXAMPLE
-- file: albums_table.sql

-- Replace the table name, columm names and types.

-- Create the table without the foreign key first.
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  order int,
  customer_name text,
  order_date date);

-- Then the table with the foreign key first.
CREATE TABLE items (
  id SERIAL,
  item text,
  price(£) int,
  quantity int);

-- The foreign key name is always {other_table_singular}_id
  order_id int,
  constraint fk_order foreign key(order_id)
    references order(id)
    on delete cascade
);
5. Create the tables.
psql -h 127.0.0.1 database_name < albums_table.sql