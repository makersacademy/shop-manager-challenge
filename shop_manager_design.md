# Shop Manager Design Recipe

## 1. Extract nouns from the user stories or specification

```
# USER STORY:

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
Notes:
see all items,
create item
see all orders,
create order

Nouns:

item, name (item), unit_price (item), quantity (of items), order, customer_name (order), item_id (order), date (order)

```

## 2. Infer the Table Name and Columns


| Record        | Properties                   |
| ------------- | ---------------------------- |
| item          | name, unit_price, quantity   |
| order         | customer_name, date, item_id |

1. Name of the first table: `items`

    Column names: `name`, `unit_price`, `quantity`

2. Name of the second table: `orders`

    Column names: `customer_name`, `date`, `item_id`


## 3. Decide the column types

```
Table: items
id: SERIAL
name: text
unit_price: float
quantity: int

Table: orders
id: SERIAL
customer_name: text
date: date
item_id: int
```

## 4. Decide on The Tables Relationship

One-to-Many

## 4. Write the SQL.

```sql
-- file: shop_manager.sql

CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  name text,
  unit_price float,
  quantity int
);


CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  customer_name text,
  date date,
  item_id int,
  constraint fk_item foreign key(item_id)
    references items(id)
    on delete cascade
);

```

## 5. Create the tables.

```bash
psql -h 127.0.0.1 shop_manager < shop_manager.sql
```


## _____________________________


## 1. Design and create the Tables

See above.


## 2. Create Test SQL seeds

```sql

TRUNCATE TABLE items RESTART IDENTITY;
TRUNCATE TABLE orders RESTART IDENTITY;

INSERT INTO items (name, unit_price, quantity) VALUES ('Bag', 35.5, 23);
INSERT INTO items (name, unit_price, quantity) VALUES ('Lipstick', 15, 49);
INSERT INTO items (name, unit_price, quantity) VALUES ('Mascara', 18.4, 4);

INSERT INTO orders (customer_name, date, item_id) VALUES ('Lucas Smith', 2022-10-28, 1);
INSERT INTO orders (customer_name, date, item_id) VALUES ('Abigail Brown', 2022-11-28, 3);
INSERT INTO orders (customer_name, date, item_id) VALUES ('Sally Bright', 2022-11-16, 1);

```

```bash
psql -h 127.0.0.1 shop_manager_test < ./spec/seeds_stock.sql
```

## 3. Define the class names

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


```ruby

# Table name: items

# Model class
# (in lib/item.rb)

class Item

  attr_accessor :id, :name, :unit_price, :quantity

end

# Table name: orders

# Model class
# (in lib/order.rb)

class Order

  attr_accessor :id, :customer_name, :date, :item_id

end

```


## 5. Define the Repository Class interface

```ruby

# Table name: items

# Repository class
# (in lib/item_repository.rb)

class ItemRepository

  def all
    # Executes the SQL query:
    # SELECT id, name, unit_price, quantity FROM items;

    # Puts a list of all items
  end

  def create(item)
    # Adds an item (item) to the database.
  end

end

# Table name: orders

# Repository class
# (in lib/order_repository.rb)

class OrderRepository

  def all
    # Executes the SQL query:
    # SELECT id, customer_name, date, item_id FROM orders;

    # Puts a list of all orders
  end

  def create(order)
    # Adds an order (order) to the database.
  end

end


```

## 6. Write Test Examples

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES for ITEMS

# 1
# puts a list of all items

repo = ItemRepository.new
repo.all # =>
# "1 - Bag - £35.5 - 23"
# "2 - Lipstick - £15 - 49"
# "3 - Mascara - £18.4 - 4"


#2
# Adds an item to the database when the create method is used

repo = ItemRepository.new
item = Item.new

item.id = 4
item.name = 'Nail File'
item.unit_price = 1
item.quantity = 21

repo.create(item)
repo.all # =>
# "1 - Bag - £35.5 - 23"
# "2 - Lipstick - £15 - 49"
# "3 - Mascara - £18.4 - 4"
# "4 - Nail File - £1 - 21"

# EXAMPLES for ORDERS

# 1
# puts a list of all items

repo = OrderRepository.new
repo.all # =>
# "1 - Lucas Smith - 2022-10-28 - 1"
# "2 - Abigail Brown - 2022-11-28 - 3"
# "3 - Sally Bright - 2022-11-16 - 1"

#2
# Adds an item to the database when the create method is used

repo = OrderRepository.new
order = Order.new

order.id = 4
order.customer_name = 'Jenny Boyle'
order.date = '2022-11-05'
order.item_id = 2

repo.create(order)
repo.all # =>
# "1 - Lucas Smith - 2022-10-28 - 1"
# "2 - Abigail Brown - 2022-11-28 - 3"
# "3 - Sally Bright - 2022-11-16 - 1"
# "4 - Jenny Boyle - 2022-11-05 - 2"

```

## 7. Reload the SQL seeds before each test run


## 8. Test-drive and implement the Repository class behaviour
