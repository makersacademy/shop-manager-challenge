require_relative "../lib/order_repository"

def reset_orders_table
  seed_sql = File.read('spec/seeds_items_orders.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'orders' })
  connection.exec(seed_sql)
end

describe OrderRepository do
  before(:each) do 
    reset_orders_table
  end

  # (your tests will go here).
end

# # 1
# # Get all orders

# repo = OrderRepository.new

# orders = repo.all

# orders.length # =>  2

# orders[0].id # =>  1
# orders[0].customer_name # =>  'John Smith'
# orders[0].date # =>  '2022-06-01'
# orders[0].item_id # =>  '1'

# orders[1].id # =>  2
# orders[1].customer_name # =>  'Pauline Jones'
# orders[1].date # =>  '2022-05-01'
# orders[1].item_id # =>  '2'

# # 2
# # Get a single order

# repo = OrderRepository.new

# order = repo.find(1)

# order.id # =>  1
# order.customer_name # =>  'John Smith
# order.date # =>  '2022-06-01'
# order.item_id # =>  '2'

# # 3
# # Create an order entry

# repo = OrderRepository.new

# order = Order.new
# order.customer_name = 'Alex Appleby'
# order.date = '06/01/22'
# order.item_id = '2'

# repo.create(order)

# orders = repo.all
# last_order = items.last
# last_order.customer_name # => 'Alex Appleby'
# last_order.date # => '2022-06-01'
# last_order.item_id # => '2'

# # 4 
# # Update an order

# repo = OrderRepository.new

# order = repo.find(2)
# order.customer_name = 'John Smith'
# order.date = '01/06/22'
# order.item_id = '1'

# repo.update(order)

# updated_order = repo.find(2)

# updated_order.id # =>  1
# updated_order.customer_name # =>  'John Smith'
# updated_order.date # =>  '2022-06-01'
# updated_order.item_id # => '1'

# # 5
# # Delete an order

# repo = OrderRepository.new

# delete_order = repo.delete('1')
# orders = repo.all

# orders.length # =>  1

# orders[0].id # =>  1
# orders[0].customer_name # =>  'Pauline Jones'
# orders[0].date # =>  '2022-05-01'
# orders[0].item_id # => '2'