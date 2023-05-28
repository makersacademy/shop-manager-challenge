require_relative './orders_repo'

repo = OrderRepository.new

orders = repo.all
orders.length # => 2
orders.first.id # => '1'
orders.first.customer_name # => 'Trompe le Monde'
orders.first.date_of_order # => '1'

# 2
# Get a single order

repo = OrderRepository.new
order = repo.find(1)
order.customer_name # => 'Trompe le Monde' 
order.date_of_order # => '1991'
#3 
# Get another single artist 

repo = OrderRepository.new
order = repo.find(2)
order.customer_name # => 'Surfer Rosa'
order.date_of_order #=> '1988'
