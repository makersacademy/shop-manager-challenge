def reset_items_table
  seed_sql = File.read('spec/seeds_items.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'database_items_test' })
  connection.exec(seed_sql)
end

describe OrderRepository do
  before(:each) do 
    reset_items_table
  end

  # (your tests will go here).
end

repo = ItemRepository.new

items = repo.all
items.length # => 2
items.first.id # => '1'
items.first.name # => 'Orange'
items.first.unit_price # => '0.85'
items.quantity # => '5'
items.order_id # => '1'

# 2
# Get a single order

repo = ItemRepository.new
item = repo.find(1)
item.id # => '2'
item.name # => 'Apple' 
item.unit_price # => '2'
item.quantity # => => '3'
item.order_id # => '1'
#3 
# Get another single artist 

repo = ItemRepository.new
item = repo.find(0)
item.id # => '1'
item.name # => 'Orange'
item.unit_price #=> '0.85'
item.quantity #=> '5'
item.order_id #=> '1'

#4
# Creates a new item
repo = ItemRepository.new
new_item = repo.create(name: 'Biscuit', unit_price: '3.50', quantity: '5', order_id: '2')

new_item.id
new_item.name
new_item.unit_prce
new_item.quantity
new_item.order_id
