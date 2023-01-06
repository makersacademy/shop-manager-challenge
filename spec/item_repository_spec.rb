require_relative "../lib/item_repository"

def reset_items_table
  seed_sql = File.read('spec/seeds_items_orders.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'items' })
  connection.exec(seed_sql)
end

describe ItemRepository do
  before(:each) do 
    reset_items_table
  end

  # (your tests will go here).
end

# # 1
# # Get all items

# repo = ItemRepository.new

# items = repo.all

# items.length # =>  2

# items[0].id # =>  1
# items[0].name # =>  'Super Shark Vacuum Cleaner'
# items[0].price # =>  '99'
# items[0].quantity # =>  '30'

# items[1].id # =>  2
# items[1].name # =>  'Makerspresso Coffee Machine'
# items[1].price # =>  '69'
# items[1].quantity # =>  '15'

# # 2
# # Get a single item

# repo = ItemRepository.new

# item = repo.find(1)

# item.id # =>  1
# item.name # =>  'Super Shark Vacuum Cleaner'
# item.price # =>  '99'
# item.quantity # =>  '30'

# # 3
# # Create an item entry

# repo = ItemRepository.new

# item = Item.new
# item.name = 'Bosch Washing Machine'
# item.price = '300'
# item.quantity = '20'

# repo.create(item)

# items = repo.all
# last_item = items.last
# last_item.name # => 'Bosch Washing Machine'
# last_item.price # => '300'
# last_item.quantity # => '20'

# # 4 
# # Update an item

# repo = ItemRepository.new

# item = repo.find(2)
# item.name = 'Makerspresso Coffee Machine'
# item.price = '85'
# item.quantity = '30'

# repo.update(item)

# updated_item = repo.find(2)

# updated_item.id # =>  2
# updated_item.name # =>  'Makerspresso Coffee Machine'
# updated_item.price # =>  '85'
# updated_item.quantity # => '30'

# # 5
# # Delete an item

# repo = ItemRepository.new

# delete_item = repo.delete('1')
# items = repo.all

# items.length # =>  1

# items[0].id # =>  1
# items[0].name # =>  'Makerspresso Coffee Machine'
# items[0].price # =>  '70'
# items[0].quantity # => 15