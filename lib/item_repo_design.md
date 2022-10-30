
## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# EXAMPLE
# Table name: students

# Model class
# (in lib/student.rb)
class Item
end

# Repository class
# (in lib/student_repository.rb)
class ItemRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# EXAMPLE
# Table name: students

# Model class
# (in lib/student.rb)

class Item

  # Replace the attributes by your own columns.
  attr_accessor :id, :item_name, :quantity, :price, :order_id
end

# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,
# here's an example:
#
# student = Student.new
# student.name = 'Jo'
# student.name
```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# EXAMPLE
# Table name: students

# Repository class
# (in lib/student_repository.rb)

class ItemRepository
  def all
      sql = 'SELECT id, item_name, quantity, price, order_id FROM items;'
      result_set = DatabaseConnection.exec_params(sql, [])
      items = []
    
      result_set.each do |record|
        item = Item.new
        item.id = record['id']
        item.item_name = record['item_name']
        item.quantity = record['quantity']
        item.price = record['price']
        item.order_id = record['order_id']

        items << item

     end 
    return items
  end
  end

  # Gets a single record by its ID
  # One argument: the id (number)
def find(id)
    sql = 'SELECT id, item_name, quantity, price, order_id FROM items WHERE order_id = $1;'
    params = [id]
    result_set = DatabaseConnection.exec_params(sql, params)

     record = result_set[0]
    
    item = Item.new
    item.id = record['id']
    item.item_name = record['item_name']
    item.quantity = record['quantity']
    item.price = record['price']
    item.order_id = record['order_id']

    return item
  end  
  
  def create(item)
      # excutes SQL query;
    sql =  'INSERT INTO items (item_name, quantity, price, order_id) VALUES($1, $2, $3, $4);'
    sql_params = [item.item_name, item.quantity, item.price, item.order_id]

    DatabaseConnection.exec_params(sql, sql_params)

    return nil
  end 

  # def update(student)
  # end

  # def delete(student)
  # end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

it 'returns a list of all items, ' do 
  repo = ItemRepository.new 
  
  item = repo.all
  expect(item.length).to eq(2)
  expect(item[1].id).to eq('2')  # => '1'
  expect(item[1].item_name).to eq ("beer")
  end 
 
  it 'returns a single item and info from order_id = "1"' do 
   repo = ItemRepository.new 
  
   item = repo.find(1)
   expect(item.item_name).to eq('pizza')
   expect(item.price).to eq('4.99')
  end 
it 'creates a new album' do 
   repo = ItemRepository.new 

   new_item = Item.new 
   new_item.item_name = 'gum'
   new_item.price = 1
   new_item.order_id = 1

    repo.create(new_item)

    all_items = repo.all

     expect(all_items.item_name).to eq 'gum'
     expect(all_items.price).to eq 1

   end
end 



end 
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

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._

<!-- BEGIN GENERATED SECTION DO NOT EDIT -->

---

**How was this resource?**  
[😫](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=😫) [😕](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=😕) [😐](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=😐) [🙂](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=🙂) [😀](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=😀)  
Click an emoji to tell us.

<!-- END GENERATED SECTION DO NOT EDIT -->