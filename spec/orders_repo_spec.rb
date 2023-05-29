require_relative './orders_repo'

def reset_orders_table
  seed_sql = File.read('spec/seeds_orders.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'database_orders_test' })
  connection.exec(seed_sql)
end

describe OrderRepository do
  before(:each) do 
    reset_orders_table
  end

  repo = OrderRepository.new

  orders = repo.all
  orders.length # => 2
  orders.first.id # => '1'
  orders.first.customer_name # => 'Khuslen'
  orders.first.date_of_order # => '23-05-26'
  
  # 2
  # Get a single order
  
  repo = OrderRepository.new
  order = repo.find(1)
  order.id # => '1'
  order.customer_name # => 'Khuslen' 
  order.date_of_order # => '23-05-26'
  #3 
  # Get another single artist 
  
  repo = OrderRepository.new
  order = repo.find(2)
  order.id # => '2'
  order.customer_name # => 'John'
  order.date_of_order #=> '2023-05-25'
  
  #4
  # Creates a new iteorderm
  repo = OrderRepository.new
  new_order = repo.create(customer_name: 'Billy', date_of_order: '2023-5-01')
  
  new_order.id
  new_order.customer_name
  new_order.date_of_order
  
end
