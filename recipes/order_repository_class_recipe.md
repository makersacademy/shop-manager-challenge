# Order Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](./single_table_design_recipe_template.md).

*In this template, we'll use an example table `students`*

```
# EXAMPLE

Table: students

Columns:
id | name | cohort_name
```

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- EXAMPLE
-- (file: spec/seeds_{table_name}.sql)

-- Write your SQL seed here. 

DROP TABLE IF EXISTS items CASCADE;

CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  name text,
  price numeric,
  quantity int
);

DROP TABLE IF EXISTS orders CASCADE;
-- Create the second table.
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  customer_name text,
  date date
);


DROP TABLE IF EXISTS items_orders CASCADE;
-- Create the join table.
CREATE TABLE items_orders (
  item_id int,
  order_id int,
  constraint fk_post foreign key(item_id) references items(id) on delete cascade,
  constraint fk_tag foreign key(order_id) references orders(id) on delete cascade,
  PRIMARY KEY (item_id, order_id)
);

TRUNCATE TABLE items RESTART IDENTITY CASCADE;
TRUNCATE TABLE orders RESTART IDENTITY CASCADE;
TRUNCATE TABLE items_orders RESTART IDENTITY CASCADE;


INSERT INTO items (name, price, quantity) VALUES ('Eggs', '2.99', '10');
INSERT INTO items (name, price, quantity) VALUES ('Coffee', '5.99', '5');
INSERT INTO items (name, price, quantity) VALUES ('Bread', '3.99', '15');
INSERT INTO items (name, price, quantity) VALUES ('Orange Juice', '2.99', '10');
-- New post inserted with id 3

INSERT INTO orders (customer_name, date) VALUES ('John Key', 'Jan-08-2023');
INSERT INTO orders (customer_name, date) VALUES ('Sally Smith', 'Jan-09-2023');
INSERT INTO orders (customer_name, date) VALUES ('Eddie Man', 'Jan-09-2023');
INSERT INTO orders (customer_name, date) VALUES ('Sam Baker', 'Jan-09-2023');
-- New tag inserted with id 5

INSERT INTO items_orders (item_id, order_id) VALUES
(1, 1), 
(1, 2),
(2, 2),
(1, 3),
(3, 3),
(4, 4);

ALTER TABLE items_orders ADD FOREIGN KEY (item_id) REFERENCES items(id);
ALTER TABLE items_orders ADD FOREIGN KEY (order_id) REFERENCES orders(id);
```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 your_database_name < seeds_recipes.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# EXAMPLE
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
# EXAMPLE
# Table name: iorder

# Model class
# (in lib/order.rb)

class Order
    
    attr_accessor :id, :customer_name, :date
end

```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby

# Table name: orders

# Repository class
# (in lib/order_repository.rb)

class orderRepository
    def all
        # shows all orders
        sql = 'SELECT id, customer_name, date FROM orders;'
        result = DatabaseConnection.exec_params(sql, [])

        orders = []

        result.each do |record|
            order = Order.new
            order.id = record['id']
            order.customer_name = record['customer_name']
            order.date = record['date']

            orders << order
        end
    end

    def find(id)
    end

    def create(item)
        def create(item)
        sql = 'INSERT INTO items
                    (name, price, quantity)
                    VALUES($1, $2, $3);'
        sql_params = [item.name, item.price, item.quantity]

        DatabaseConnection.exec_params(sql, sql_params)

        return nil
    end

    def delete(item)
    # 'DELETE FROM items
    #                 WHERE id = $1;'
    end

end

```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby

  # 1
        it 'shows all items' do
            repo = ItemRepository.new

            items = repo.all
            expect(items.length).to eq 4
            expect(items.first.id).to eq '1'
            expect(items.first.name).to eq 'Eggs'
        end
  # 2
        it 'returns a single item' do
            repo = ItemRepository.new

            item = repo.find(1)
            expect(item.name).to eq 'Eggs'
            expect(item.price).to eq '2.99'
        end
  # 3
        it 'returns another item' do
            repo = ItemRepository.new

            item = repo.find(2)
            expect(item.name).to eq 'Coffee'
            expect(item.price).to eq '5.99'
        end

  # 4
        it 'creates and item' do
            repo = ItemRepository.new

            item = Item.new
            item.name = 'Bananas'
            item.price = '1.99'
            item.quantity = '10'
            repo.create(item)

            expect(repo.all.length).to eq 5
        end

  # 5
        it 'deletes an item' do
            repo = ItemRepository.new
            id_to_delete = 1
            repo.delete(id_to_delete)

            expect(repo.all.length).to eq 3 
        end


Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/recipe_repository_spec.rb

def reset_recipes_table
  seed_sql = File.read('spec/seeds_recipes.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'recipes_directory_test' })
  connection.exec(seed_sql)
end

describe RecipeRepository do
  before(:each) do 
    reset_recipes_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._

<!-- BEGIN GENERATED SECTION DO NOT EDIT -->

---

**How was this resource?**  
[😫](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=😫) [😕](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=😕) [😐](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=😐) [🙂](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=🙂) [😀](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=😀)  
Click an emoji to tell us.

<!-- END GENERATED SECTION DO NOT EDIT -->