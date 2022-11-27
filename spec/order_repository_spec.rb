require 'order_repository'

RSpec.describe OrderRepository do

  def reset_orders_table
    seed_sql = File.read('spec/seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_items_orders_test' })
    connection.exec(seed_sql)
  end
  
  before(:each) do 
    reset_orders_table
  end

  it "returns a list of all the orders" do

    repo = OrderRepository.new
    orders = repo.all
    expect(orders.length).to eq 4

    expect(orders[0].id).to eq '1'
    expect(orders[0].customer_name).to eq 'Customer 1'
    expect(orders[0].order_date).to eq '2022-11-07'

  end

  it "creates a new order" do
    repo = OrderRepository.new

    order = Order.new
    order.customer_name = 'Customer 5'
    order.order_date = '2022-11-20'
    
    repo.create(order)
    
    all_orders = repo.all
    
    new_order = all_orders.last
    
    expect(new_order.id).to eq '5'
    expect(new_order.customer_name).to eq 'Customer 5'
    expect(new_order.order_date).to eq '2022-11-20'

  end

  it "find first item related to order 3" do

    repo = OrderRepository.new

    orders = repo.find_by_item(1)

    expect(orders[0]['id']).to eq '3'
    expect(orders[0]['customer_name']).to eq 'Customer 3'
    expect(orders[0]['order_date']).to eq '2022-11-08'
  end

end