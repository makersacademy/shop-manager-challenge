# Shop manager Model and Repository Classes Design Recipe

## 1. Design and create the Table

Table: items

Columns:
id | name | price | quantity 

Table: orders

Columns:
id | customer_name | date

Table: orders_items

Columns: 
orders_id | items_d

## 2. Create Test SQL seeds

```sql
--(file: spec/seeds_itmes.sql)
-- The table is emptied between each test run and resets the primary key
TRUNCATE orders, items, orders_items RESTART IDENTITY;

INSERT INTO  items (name, price, quantity) VALUES('Iphone 11', 1000, 10);
INSERT INTO  items (name, price, quantity) VALUES('Iphone 10', 900, 5);
INSERT INTO  items (name, price, quantity) VALUES('Iphone 8', 500, 1);

INSERT INTO  orders (customer_name, date) VALUES('Mike', '2022-10-01');
INSERT INTO  orders (customer_name, date) VALUES('John', '2022-10-25');
INSERT INTO  orders (customer_name, date) VALUES('Sam', '2022-10-27');

INSERT INTO orders_items (order_id, item_id) VALUES(1, 1);
INSERT INTO orders_items (order_id, item_id) VALUES(3, 1);
INSERT INTO orders_items (order_id, item_id) VALUES(2, 2);
INSERT INTO orders_items (order_id, item_id) VALUES(2, 3);
```
Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 items_orders_test < ./spec/seeds_items.sql
```

## 3. Implement the Model class

```ruby
class Item
  attr_accessor :id, :name, :price, :quantity
end

class Order
  attr_accessor :id, :name, :customer_name, :date
end

```
## 4. Define the Repository class

```ruby
# Table name: items
class ItemRepository
  # select all shop items
  def all_item
    # Executes the SQL query: SELECT id, name, price, quantity FROM items
    # returns an array of Item objects
  end
  
  # Insert a new item record
  # Take an Item object in argument
  def create(item)
    # Executes the SQL query: INSERT INTO items (name, price, quantity) VALUES ($1, $2, $3);
    # return nothing
  end
end 

# Table name: orders
class OrderRepository
  # Select all shop orders
  def all_order
    # Executes the SQL query: SELECT orders.id, 
            #       orders.customer_name, 
            #       orders.date, 
            #       items.name
            # FROM orders
            #     JOIN orders_items ON orders_items.order_id = orders.id
            #     JOIN items ON orders_items.item_id = items.id
            # ORDER BY orders.id;

    # returns an array of Order object with item name
  end
  
  # Insert a new order record
  # Take an Order object in argument
  def create(order)
    # Executes the SQL query: INSERT INTO orders (customer_name) VALUES ($1);
    # return nothing
  end
end

```
## 5. Write Test Examples

```ruby

```

Encode this example as a test.

## 6. Reload the SQL seeds before each test run
```ruby
# EXAMPLE

# file: spec/item_repository_spec.rb

describe ItemRepository do
  def reset_items_table
    seed_sql = File.read('spec/seeds_items.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_test' })
    connection.exec(seed_sql)
  end

  before(:each) do 
    reset_items_table
  end

  # (your tests will go here).
end
```

## 7. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._