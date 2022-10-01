require_relative "../lib/order_repo.rb"

RSpec.describe OrderRepository do
  def reset_orders_table
    seed_sql = File.read('spec/seed_shop_manager.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end
  
  before(:each) do 
      reset_orders_table
  end

  it "shows all orders" do
    repo = OrderRepository.new
    orders = repo.all
    expect(orders[0].id).to eq '1'
    expect(orders[0].customer_name).to eq 'Joe'
    expect(orders[0].date).to eq 'sept'
  end

  it "shows all orders" do
    repo = OrderRepository.new
    orders = repo.all
    expect(orders[1].id).to eq '2'
    expect(orders[1].customer_name).to eq 'Dave'
    expect(orders[1].date).to eq 'oct'
  end

  it "creates a new order" do
      repo = OrderRepository.new
      order = Order.new
      order.customer_name = 'Jim' 
      order.date = 'aug' 

      repo.create(order)

      orders = repo.all
      expect(orders.length).to eq 3
      expect(orders[2].customer_name).to eq 'Jim' 
      expect(orders[2].date).to eq 'aug' 
  end
end
