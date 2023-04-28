# Design Recipe for Shop Manager Challenge

## 1. Extract nouns from the user stories or specification

```plain
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

```plain
Nouns/key elements:

list of shop items - name, unit price, quantity
list of orders - customer name, item_id, date placed

items - list all, create new item
orders - list all, create new item
Assign order to corresponding item - item_id will be fk
```

## 2. Infer the Table Name and Columns

| Record    | Properties                          |
| --------- | ----------------------------------- |
| shop_item | name, unit_price, quantity          |
| order     | customer_name, item_id, date_placed |

1. Name of the first table (always plural): `shop_items`

   Column names: `name`, `unit_price`, `quantity`

2. Name of the second table (always plural): `orders`

   Column names: `customer_name`, `shop_item_id`, `date_placed`

## 3. Decide the column types

```plain
Table: shop_items
id: SERIAL
name: text
unit_price: money
quantity: int

Table: orders
id: SERIAL
customer_name: text
date_placed: timestamp
shop_item_id: int
```

## 4. Decide on The Tables Relationship

```plain
1. Can one shop item have many orders? YES
2. Can one order have many shop items? NO

**NOTE**
One order could have many shop items. I have taken from the user story
'I want to assign each order to their corresponding item' and the menu
options that this is singular for the purposes of this challenge.

-> Therefore,
-> A shop item HAS MANY orders
-> An order BELONGS TO a shop item

-> Therefore, the foreign key is on the orders table.
```

## 5. Write the SQL

```sql
-- file: shop_manager_tables.sql

-- Create the table without the foreign key first.
CREATE TABLE shop_items (
  id SERIAL PRIMARY KEY,
  name text,
  unit_price money,
  quantity int
);

-- Then the table with the foreign key first.
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  customer_name text,
  date_placed timestamp,
-- The foreign key name is always {other_table_singular}_id
  shop_item_id int,
  constraint fk_shop_item foreign key(shop_item_id)
    references shop_items(id)
    on delete cascade
);
```

## 6. Create the databases and tables

```bash
createdb shop_manager
createdb shop_manager_test
psql -h 127.0.0.1 shop_manager < shop_manager_tables.sql
psql -h 127.0.0.1 shop_manager_test < shop_manager_tables.sql
```

## 7. Create Test SQL seeds

```sql
-- (file: spec/seeds_shop_manager_test.sql)

-- **NOTE** I am creating the test seeds in one file so I can truncate both
-- tables and resolve the error where it cannot truncate a table referenced
-- in a foreign key constraint.

TRUNCATE TABLE shop_items, orders RESTART IDENTITY;

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO shop_items (name, unit_price, quantity) VALUES ('Super Shark Vacuum Cleaner', 99.99, 30);
INSERT INTO shop_items (name, unit_price, quantity) VALUES ('Makerspresso', 69.00, 15);

-- timestamp format - YYYY-MM-DD HH:MI:SS
INSERT INTO orders (customer_name, date_placed, shop_item_id) VALUES ('Sarah', '2023-04-06 12:57:03', 1)
INSERT INTO orders (customer_name, date_placed, shop_item_id) VALUES ('Fred', '2023-03-12 15:12:42', 2)
```

## 8. Define and implement the Model classes

```ruby
# Table name: shop_items

# Model class
# (in lib/shop_item.rb)
class ShopItem
  attr_accessor :id, :name, :unit_price, :quantity
end

# Table name: orders

# Model class
# (in lib/order.rb)
class Order
  attr_accessor :id, :customer_name, :date_placed, :shop_item_id
end
```

## 9. Define the Repository Class interface

```ruby
# Table name: shop_items
# Repository class
# (in lib/shop_item_repository.rb)
class ShopItemRepository

  # Selecting all shop_items records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, name, unit_price, quantity FROM shop_items;

    # Returns an array of ShopItem objects
  end

  # Create a new item
  # Takes a ShopItem object as an argument
  def create(shop_item)
    # Executes the SQL query:
    # INSERT INTO shop_items (name, unit_price, quantity)
    # VALUES ($1, $2, $3);

    # Returns nil, inserts shop_item into db
  end
end

# Repository class
# (in lib/shop_item_repository.rb)
class OrderRepository

  # Selecting all order records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, customer_name, date_placed, shop_item_id FROM orders;

    # Returns an array of Order objects
  end

  # Create a new item
  # Takes an Order object as an argument
  def create(order)
    # Executes the SQL query:
    # INSERT INTO orders (customer_name, date_placed, shop_item_id)
    # VALUES ('Bob', '30-04-2023 18:32:02', 2);

    # Returns nil, inserts order into db
  end
end
```

## 10. Write Test Examples

```ruby
# As a shop manager
# So I can know which items I have in stock
# I want to keep a list of my shop items with their name and unit price.

# As a shop manager
# So I can know which items I have in stock
# I want to know which quantity (a number) I have for each item.

# 1
# Get all shop items
repo = ShopItemRepository.new

shop_items = repo.all

expect(shop_items.length).to eq 2
expect(shop_items.first.name).to eq 'Super Shark Vacuum Cleaner'
expect(shop_items.first.unit_price).to eq '$99.99'
expect(shop_items.first.quantity).to eq '30'

# As a shop manager
# So I can manage items
# I want to be able to create a new item.

# 2
# Create a new shop item
repo = ShopItemRepository.new
shop_item = ShopItem.new
shop_item.name = 'Dyson Airwrap'
shop_item.unit_price = 300
shop_item.quantity = 5
repo.create(shop_item)

expect(repo.all.length).to eq 3
expect(repo.all.last.id).to eq '3'
expect(repo.all.last.name).to eq 'Dyson Airwrap'
expect(repo.all.last.unit_price).to eq '$300.00'
expect(repo.all.last.quantity).to eq '5'

# As a shop manager
# So I can know which orders were made
# I want to keep a list of orders with their customer name.

# 3
# Get all orders
repo = OrderRepository.new

orders = repo.all

expect(orders.length).to eq 2
expect(orders.first.customer_name).to eq 'Sarah'
expect(orders.first.date_placed).to eq '2023-04-06 12:57:03'
expect(orders.first.shop_item_id).to eq '1'

```
