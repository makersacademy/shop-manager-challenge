require_relative "../lib/order"
require_relative "../lib/order_repository"

RSpec.describe OrderRepository do
  def reset_orders_table
    seed_sql = File.read('spec/shop_manager_seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end
  
  before(:each) do 
    reset_orders_table
  end

  it "shows all orders" do
    repo = OrderRepository.new
    orders = repo.all
    expect(orders[0].customer_name).to eq 'Joe Osborne'
    expect(orders[0].date).to eq '2022-09-23 13:10:11'
  end

  it "shows all orders" do
    repo = OrderRepository.new
    orders = repo.all
    expect(orders[1].customer_name).to eq 'Dave Thomson'
    expect(orders[1].date).to eq '2022-09-29 10:10:11'
  end

  it "creates a new order" do
    repo = OrderRepository.new
    order = Order.new
    order.customer_name = 'Safiya Lambie-Knight' 
    order.date = '2022-09-30 16:04:04' 

    repo.create(order)

    orders = repo.all
    expect(orders.length).to eq 4
    expect(orders[3].customer_name).to eq 'Safiya Lambie-Knight' 
    expect(orders[3].date).to eq '2022-09-30 16:04:04' 
  end
end
