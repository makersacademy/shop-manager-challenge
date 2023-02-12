require "item_repository"

def reset_items_table
  seed_sql = File.read('spec/seeds_shop.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop' })
  connection.exec(seed_sql)
end

describe ItemRepository do
  before(:each) do 
    reset_items_table
  end

  # (your tests will go here).
end

# # EXAMPLES

# # 1
# # Get all items
# repo = ItemRepository.new
# items = repo.all

# items.length # =>  2
# items[0].id # =>  1
# items[0].name # =>  'Bread'
# items[0].unit_price # =>  '1.00'
# items[0].quantity # =>  '20'

# items[1].id # =>  2
# items[1].name # =>  'Ham'
# items[1].unit_price # =>  '3.00'
# items[1].quantity # =>  '30'


# # 2
# # Get a single item
# repo = ItemRepository.new
# items = repo.find(1)

# items.id # =>  1
# items.name # =>  'Bread'
# items.unit_price # =>  '1.00'
# items.quantity # =>  '20'


# # 3 
# # Create a new item
# repo = ItemRepository.new
# item = Item.new
# item.id # =>  3
# item.name # =>  'Jam'
# item.unit_price # =>  '1.50'
# item.quantity # =>  '25'

# repo.create(item)

# item.length # =>  3
# repo.all.last.name # => 'Jam'


# # 4
# # Delete an item
# repo = ItemRepository.new
# item = repo.find(1)
# repo.delete(item.id)

# repo.all # => 1
# repo.all.first.id # => 2


# # 5
# # Update an item 
# repo = ItemRepository.new
# item = repo.find(1)

# item.name = # => 'Bagle'
# items.unit_price # =>  '1.50'
# items.quantity # =>  '25'

# repo.update(item)

# updated_item = repo.find(1)
# updated_item.name # => 'Bagle'
# updated_item.unit_price # => '1.50'
# updated_item.quantity # => '25'