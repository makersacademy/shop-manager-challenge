require 'database_connection'
require 'order'
require 'order_repository'

def reset_orders_table
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'orders' })
  connection.exec(seed_sql)
end

describe OrderRepository do
  before(:each) do 
    reset_orders_table
  end

  # (your tests will go here).

    # 1
    # Get all orders
  xit "Get all orders" do   
    repo = OrderRepository.new

    orders = repo.all

    orders.length # =>  2

    orders[0].id # =>  1
    orders[0].customer_name # =>  'David'
    orders[0].order_date # =>  '2022-06-22 19:10:25-07'

    orders[1].id # =>  2
    orders[1].customer_name # =>  'Anna'
    orders[1].order_date # => '2022-07-22 19:10:25-07'
  end 

    #2
    # Create a new order
  xit "Create a new order" do
    repo = OrderRepository.new

    order = Order.new
    order.customer_name = "Harry"
    order.order_date = '2022-08-22 19:10:25-07'

    repo.create(order)

    orders = repo.all

    last_order = orders.last
    order.customer_name # => "Harry"
    order.order_date # => '2022-08-22 19:10:25-07'
  end
end