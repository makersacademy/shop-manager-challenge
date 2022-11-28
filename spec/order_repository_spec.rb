require 'database_connection'
require 'order'
require 'order_repository'

def reset_orders_table
  seed_sql = File.read('spec/seeds.sql')
  if ENV["PG_password"] 
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test', password: ENV["PG_password"] })
  else
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  end
  connection.exec(seed_sql)
end

describe OrderRepository do
  before(:each) do 
    reset_orders_table
  end

  # (your tests will go here).

    # 1
    # Get all orders
  it "Get all orders" do   
    repo = OrderRepository.new

    orders = repo.all

    orders.length # =>  2

    expect(orders[0].id).to eq '1'
    expect(orders[0].customer_name).to eq 'David'
    expect(orders[0].order_date).to eq '2022-06-22 19:10:25'

    expect(orders[1].id).to eq '2'
    expect(orders[1].customer_name).to eq 'Anna'
    expect(orders[1].order_date).to eq '2022-07-22 19:10:25'
  end 

    # 2
    # Create a new order
  it "Create a new order" do
    repo = OrderRepository.new

    order = Order.new
    order.customer_name = 'Harry'
    order.order_date = '2022-08-22 19:10:25'

    repo.create(order)

    orders = repo.all

    last_order = orders.last
    expect(last_order.customer_name).to eq 'Harry'
    expect(last_order.order_date).to eq '2022-08-22 19:10:25'
  end
end
