# Shop Manager design recipe

## 1. Extract nouns from the user stories or specification

```
# USER STORIES

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
```

```
Nouns:

items, name, unit price, stock level, orders, customer name, order items, order date
```

## 2. Infer the Table Name and Columns

Put the different nouns in this table. Replace the example with your own nouns.

| Record                | Properties          |
| --------------------- | ------------------  |
| items                 | name, price, quantity
| orders                | customer_name, date

1. Name of the first table (always plural): `items` 

    Column names: `name`, `price`, `quantity`

2. Name of the second table (always plural): `orders` 

    Column names: `customer_name`, `date`

## 3. Decide the column types.

[Here's a full documentation of PostgreSQL data types](https://www.postgresql.org/docs/current/datatype.html).

Most of the time, you'll need either `text`, `int`, `bigint`, `numeric`, or `boolean`. If you're in doubt, do some research or ask your peers.

```
Table: items
id: SERIAL
name: text
price: numeric
quantity: int

Table: orders
id: SERIAL
customer_name: text
date: date
```

## 4. Design the Join Table

```
Join table for tables: items and orders
Join table name: items_orders
Columns: item_id, order_id
```

## 6. Write the SQL.

```sql
-- file: items_orders.sql

-- Replace the table name, columm names and types.

-- Create the first table.
CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  name text,
  price numeric,
  quantity int
);

-- Create the second table.
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  customer_name text,
  date date
);

-- Create the join table.
CREATE TABLE items_orders (
  item_id int,
  order_id int,
  constraint fk_item foreign key(item_id) references items(id) on delete cascade,
  constraint fk_order foreign key(order_id) references orders(id) on delete cascade,
  PRIMARY KEY (item_id, order_id)
);

```

## 7. Create the tables.

```bash
psql -h 127.0.0.1 shop_manager < items_orders.sql
```

----

# Shop Manager Model and Repository Classes Design

## 1. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- (file: spec/seeds.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE items, orders, items_orders RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO items (id, name, price, quantity) VALUES (1, 'Bread', 2.50, 10);
INSERT INTO items (id, name, price, quantity) VALUES (2, 'Towels', 9, 5);
INSERT INTO items (id, name, price, quantity) VALUES (3, 'Soap', 3.25, 15);
INSERT INTO items (id, name, price, quantity) VALUES (4, 'Salad', 4.75, 10);
INSERT INTO items (id, name, price, quantity) VALUES (5, 'Pizza', 7.25, 7);
INSERT INTO items (id, name, price, quantity) VALUES (6, 'Gloves', 19.99, 3);
INSERT INTO items (id, name, price, quantity) VALUES (7, 'Sausages', 3.75, 11);
INSERT INTO items (id, name, price, quantity) VALUES (8, 'Cheese', 3.50, 25);
INSERT INTO items (id, name, price, quantity) VALUES (9, 'Chair', 55, 1);
INSERT INTO items (id, name, price, quantity) VALUES (10, 'Orange juice', 1.75, 2);

INSERT INTO orders (id, customer_name, date) VALUES (1, 'Rodney Howell', '3 May 2023');
INSERT INTO orders (id, customer_name, date) VALUES (2, 'Lynn Stiedemann', '10 May 2023');

INSERT INTO items_orders (item_id, order_id) VALUES (1, 1);
INSERT INTO items_orders (item_id, order_id) VALUES (7, 1);
INSERT INTO items_orders (item_id, order_id) VALUES (10, 1);
INSERT INTO items_orders (item_id, order_id) VALUES (9, 2);
INSERT INTO items_orders (item_id, order_id) VALUES (2, 2);

```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 shop_manager < spec/seeds.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# Table name: items

# Model class
# (in lib/item.rb)
class Item
end

# Repository class
# (in lib/item_repository.rb)
class ItemRepository
end

# Table name: orders

# Model class
# (in lib/order.rb)
class Order
end

# Repository class
# (in lib/order_repository.rb)
class OrderRepository
end



```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# Table name: items

# Model class
# (in lib/item.rb)
class Item
  # Replace the attributes by your own columns.
  attr_accessor :id, :name, :price, :quantity
end

# Table name: orders

# Model class
# (in lib/order.rb)
class Order
  # Replace the attributes by your own columns.
  attr_accessor :id, :customer_name, :date
end
```


## 5. Define the Repository Class interface

```ruby
# Table name: items

# Repository class
# (in lib/item_repository.rb)
class ItemRepository
  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, name, price, quantity FROM items;
  
    # Returns an array of Item objects.
  end
  # Creates a new record for the Item object passed to it
  def create(item)
    # Executes the SQL query:
    # INSERT INTO items (name, price, quantity) VALUES ($1, $2, $3);
    # DatabaseConnection.exec_params(sql, [item.name, item.price, item.quantity])
    
    # Returns nothing
  end
end

---

# Table name: orders

# Repository class
# (in lib/order_repository.rb)
class OrderRepository
  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, customer_name, date FROM orders;
  
    # Returns an array of Order objects.
  end
  # Creates a new record for the Order object passed to it
  def create(order)
    # Executes the SQL query:
    # INSERT INTO orders (customer_name, date) VALUES ($1, $2);
    # DatabaseConnection.exec_params(sql, [order.customer_name, order.date])
    # INSERT INTO items_orders (item_id, order_id) VALUES ($1, $2);
    # DatabaseConnection.exec_params(sql, [order.customer_name, order.date])
    
    # Returns nothing
  end
end



```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# 1
# Get all students

repo = StudentRepository.new

students = repo.all

students.length # =>  2

students[0].id # =>  1
students[0].name # =>  'David'
students[0].cohort_name # =>  'April 2022'

students[1].id # =>  2
students[1].name # =>  'Anna'
students[1].cohort_name # =>  'May 2022'

# 2
# Get a single student

repo = StudentRepository.new

student = repo.find(1)

student.id # =>  1
student.name # =>  'David'
student.cohort_name # =>  'April 2022'

# Add more examples for each method
```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/item_repository_spec.rb

def reset_database
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager' })
  connection.exec(seed_sql)
end

describe ItemRepository do
  before(:each) do 
    reset_database
  end

  # (your tests will go here).
end

```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._
