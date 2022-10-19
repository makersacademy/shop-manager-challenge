# Items Model and Repository Classes Design Recipe

## 1. The Table

```
Table: items

Columns:
id | item | unit_price | quantity
```

## 2. SQL seeds

```sql
TRUNCATE TABLE items RESTART IDENTITY CASCADE; -- 

INSERT INTO items (item, unit_price, quantity) VALUES ('item_1', 2.99, 2);
INSERT INTO items (item, unit_price, quantity) VALUES ('item_2', 3.99, 5);
INSERT INTO items (item, unit_price, quantity) VALUES ('item_3', 5.49, 3);
```

## 3. Class names

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
```

## 4. Model class

```ruby
# Table name: items

# Model class
# (in lib/item.rb)

class Item
  attr_accessor :id, :item, :unit_price, :quantity
end
```

## 5. Repository Class interface


```ruby
# Table name: items

# Repository class
# (in lib/item_repository.rb)

class ItemRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT * FROM items;

    # Returns an array of Item objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT * FROM items WHERE id = $1;

    # Returns a single Item object.
  end

  # Add a new record to the table
  def create(item)
    # Executes the SQL query:
    # INSERT INTO items (item, unit_price, quantity)
    # VALUES ($1, $2, $3);
    
    # Returns nil
  end

end
```

## 6. Test Examples


These examples will later be encoded as RSpec tests.

```ruby
# 1
# Get all items

repo = ItemRepository.new

items = repo.all

items.length # =>  3

items.first.id # =>  1
items.first.item # =>  'item_1'
items.first.unit_price # =>  2.99
items.first.quantity # =>  2

items.last.id # =>  3
items.last.item # =>  'item_3'
items.last.unit_price # =>  5.49
items.last.quantity # =>  3

# 2
# Get a single student

repo = ItemRepository.new

item = repo.find(2)

items.id # =>  2
items.item # =>  'item_2'
items.unit_price # =>  3.99
items.quantity # =>  5

# 3
# Create a new item

item_to_create = Item.new
item_to_create.item = 'item_4'
item_to_create.unit_price = 6.99
item_to_create.quantity = 10

repo = ItemRepository.new
number_of_items = repo.all.length

repo.create(item_to_create)

repo.all.length # =>  number_of_items + 1
repo.all # => It will include the new item
```