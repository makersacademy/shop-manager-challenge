require "order_repository"

def reset_orders_table
  seed_sql = File.read('spec/seeds_shop.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop' })
  connection.exec(seed_sql)
end

describe OrderRepository do
  before(:each) do 
    reset_orders_table
  end

  # (your tests will go here).
end

# EXAMPLES

# # 1
# # Get all orders
# repo = OrderRepository.new
# orders = repo.all

# orders.length # =>  2
# orders[0].id # =>  1
# orders[0].customer_name # =>  'Amber'
# orders[0].order_date # =>  '2023-02-13'
# orders[0].item_id # =>  '1'

# orders[1].id # =>  1
# orders[1].customer_name # =>  'Jamie'
# orders[1].order_date # =>  '2023-02-12'
# orders[1].item_id # =>  '2'

# # 2
# # Get a single order
# repo = OrderRepository.new
# order = repo.find(1)

# order.id # =>  1
# order.customer_name # =>  'Amber'
# order.order_date # =>  '2023-02-13'
# order.item_id # =>  '1'

# # 3 
# # Create a new order
# repo = OrderRepository.new
# order = Order.new
# order.id # => 3
# order.customer_name # => 'Mark'
# order.order_date # => '2023-02-11'
# order.item_id # => '3'

# repo.create(order)

# order.length # => 3
# repo.all.last.customer_name # => 'Mark'

# # 4
# # Delete an order
# repo = OrderRepository.new
# order = repo.find(1)
# repo.delete(order.id)

# repo.all # => 1
# repo.all.first.id # => 2

# # 5
# # Update an order 
# repo = OrderRepository.new
# order = repo.find(1)

# order.customer_name # => 'Amber Ale'
# order.order_date # => '2023-02-13'
# order.item_id # => '2'

# repo.update(order)

# updated_order = repo.find(1)
# updated_order.customer_name # => 'Amber Ale'
# updated_order.order_date # => '2023-02-13'
# updated_order.item_id # => '2'
