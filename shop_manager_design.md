# {{TABLE NAME}} Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

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
# EXAMPLE

Table: stock

Columns:
id | name | price | quantity

Table: orders

Columns: 
id | cname | time | date

```

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql

CREATE TABLE stocks( 
id SERIAL PRIMARY KEY,
name text,
price int,
quantity int
);

CREATE TABLE orders(
id SERIAL PRIMARY KEY,
cname text,
time text,
date text,
stock_id int,
constraint fk_stock foreign key(stock_id) references 
stocks(id)
);

INSERT INTO "public"."stocks" ("id", "name", "price", "quantity" ) VALUES 
(1, 'Item1', 1, 1),
(2, 'Item2', 2, 2),
(3, 'Item3', 3, 3);


INSERT INTO "public"."orders" ("id", "cname", "time", "date" ) VALUES 
(1, 'A', '11:00', '20.04.2022'),
(2, 'B', '12:00', '21.04.2022'),
(3, 'C', '13:00', '22.04.2022');
```

```bash
createdb shop_manager
psql -h 127.0.0.1 shop_manager < seeds.sql
```

## 3. Define the class names


```ruby
class Stock 
end 

class StockRepository
end

class Order
end

class OrderRepository
end 

```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
class Stock 
    attr_accessor :id, :name, :price, :quantity
end 

class Post 
    attr_accessor :id, :cname, :time, :date, :stock_id
end 


# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,
# here's an example:
#
# student = Student.new
# student.name = 'Jo'
# student.name
```


## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby

class StockRepository

    def all 
        sql = 'SELECT * FROM stocks;'
        result = DatabaseConnection.exec_params(sql, [])
        #Returns list of stocks
    end 

    def find(id)

    end 

    def create(stock) 
        sql = 'INSERT INTO stocks (id, name, price, quantity) VALUES ($1, $2, $3);'
        params = [stock.name, stock.price, stock.quantity]

        DatabaseConnection.exec_params(sql, params)

        return nil
    end

    def delete(id)
        sql = 'DELETE FROM stocks WHERE id = $1;'
        DatabaseConnect.exec_params(sql, [id])

        return nil
    end

    def update(id, col, val) 
        
        if col == 'name'
            sql = 'UPDATE stocks SET name = $2 WHERE id = $1;'
        elsif col == 'price'
            sql = 'UPDATE stocks SET price = $2 WHERE id = $1;'
        elsif col == 'quantity'
            sql = 'UPDATE stocks SET quantity = $2 WHERE id = $1;'
        end 
        params = [id, val]
        DatabaseConnection.exec_params(sql, params)

        return nil
    end 
end 

class OrderRepository
    def all 
        sql = 'SELECT * FROM orders;'
        result = DatabaseConnection.exec_params(sql, [])
        #Returns list of stocks
    end 

    def find(id)
    end 

    def create(order) 
        sql = 'INSERT INTO orders (id, cname, time, date, stock_id) VALUES ($1, $2, $3, $4, $5);'
        params = [order.cname, order.time, order.date, order.stock_id]

        DatabaseConnection.exec_params(sql, params)

        return nil
    end

    def delete(id)
        sql = 'DELETE FROM orders WHERE id = $1;'
        DatabaseConnect.exec_params(sql, [id])

        return nil
    end

    def update(id, col, val) 
        
        if col == 'cname'
            sql = 'UPDATE orders SET cname = $2 WHERE id = $1;'
        elsif col == 'time'
            sql = 'UPDATE orders SET time = $2 WHERE id = $1;'
        elsif col == 'date'
            sql = 'UPDATE orders SET date = $2 WHERE id = $1;'
        elsif col == 'stock_id'
            sql = 'UPDATE orders SET stock_id = $2 WHERE id = $1;'
        end 
        params = [id, val]
        DatabaseConnection.exec_params(sql, params)

        return nil
    end
end

```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# 1
# Get all stocks
repo = StockRepository.new
stocks = repo.all 
expect(stocks.length).to eq 3


# 2
# Get a single account
repo = AccountRepository.new
account = repo.find(1)

account.id # =>  1
account.email
account.username

# 3
# Create new accoun
repo = AccountRepository.new
account = Account.new
account.email = 'test@example.com'
account.username = 'test'

repo.create(account)

stocks = repo.all
expect(stocks).to include(account) # => true


# 4
# Delete account
repo = AccountRepository.new
repo.delete(id)
stocks = repo.all
expect(stocks).to include(account) # => true

# 5
# Update account email 

repo = AccountRepository.new
account = Account.new(1, 'email', 'newtest@example.com')
stocks = repo.all
expect(stocks[0].email).to eq('newtest@example.com')
```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/student_repository_spec.rb

def reset_students_table
  seed_sql = File.read('spec/seeds_students.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'students' })
  connection.exec(seed_sql)
end

describe StudentRepository do
  before(:each) do 
    reset_students_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour