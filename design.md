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

Key words:

items, name, price, quantity, create item

order, customer name, order-item, date placed, create order

Table names and columns:
name: items
properties: name, price, quantity

name: orders
properties: customer_name, date, item_id

Items
id: SERIAL
name: text
price: money
quantity: int

Orders
id: SERIAL
customer_name: text
date: date
FOREIGN KEY

one order links to one item
order contains foreign key

EXAMPLE OF MANY TO MANY:
<!-- join table: items and orders
name: items_orders
columns: item_id order_id -->

------------

CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  name text,
  price money,
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

EXAMPLE OF MANY TO MANY:
<!-- CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  name text,
  price money,
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
); -->

--------------------
SQL seeds:

```sql
-- (file: spec/seeds_{table_name}.sql)

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE items RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO items (name, price, quantity) VALUES ('Banana', '2.00', 14);
INSERT INTO items (name, price, quantity) VALUES ('Cheesecake', '11.00', 3);

TRUNCATE TABLE items RESTART IDENTITY; -- replace with your own table name.

INSERT INTO orders (customer_name, date, item_id) VALUES ('Brain', '2022-09-04', 1);
INSERT INTO orders (customer_name, date, item_id) VALUES ('Lily', '2022-09-07', 2);

```
------------------------------ classes -------------------------

MODEL CLASS

```Ruby
class Item
    attr_accessor :name, :price, :quantity
end

class Order
    attr_accessor :customer_name, :date, :item_id
end
```

REPOSITORY CLASS
```Ruby

class ItemRepository

  def all
    # Executes the SQL query:
    # SELECT name, price, quantity FROM items;
    # Returns an array of item objects.
  end

  def create(item)
    # INSERT INTO items (name, price, quantity) VALUES ($1, $2, $3)
  end

end

class OrderRepository

  def all
    # Executes the SQL query:
    # SELECT customer_name, date, order_id FROM items;
    # OR

    # SELECT orders.id,
    #        orders.title,
    #        items.id AS item_id,
    #        items.name
    #   FROM orders
    #     JOIN items
    #     ON items.id = orders.item_id;
        # Returns an array of item objects.
  end

  def create(order)
    # INSERT INTO items (customer_name, date) VALUES ($1, $2)
  end

end
```

TEST EXAMPLES:
```Ruby

# 1
# Get all items

repo = ItemRepository.new

items = repo.all
items.length # 2

items[0].name # Banana
items[0].price # 2.00
items[0].quantity # 14

# 2
# Add an item

repo = ItemRepository.new

item = Item.new
item.name = 'chocolate'
item.price = '4.00'
item.quantity = 6

repo.create(item) # performs INSERT
items = repo.all

items[2].name # chocolate
items[2].price # 4.00
items[2].quantity # 6

# 1
# Get all orders

repo = OrderRepository.new
orders = repo.all # returns..... arr of joined items and orders? idk yet
# DON'T KNOW YET IS ACCESSING THESE VALUES IS DIFFERENT..
# access each value and check against expected for: customer_name, date, item_id, and if can access item

# 2
# Add an item

repo = orderRepository.new

order = order.new
order.customer_name = 'Jo'
order.date = '2022-08-22'
order.item_id = 1

repo.create(order) # performs INSERT
orders = repo.all

order[2].customer_name # 'Jo'
order[2].date # '2022-08-22'
order[2].item_id # 1


EXAMPLE OUTPUT:

Welcome to the shop management program!

What do you want to do?
  1 = list all shop items
  2 = create a new item
  3 = list all orders
  4 = create a new order

1 [enter]

Here's a list of all shop items:

 #1 Super Shark Vacuum Cleaner - Unit price: 99 - Quantity: 30
 #2 Makerspresso Coffee Machine - Unit price: 69 - Quantity: 15
 (...)
