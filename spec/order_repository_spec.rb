require 'order_repository'
require 'order'
require 'pg'
require 'database_connection'

RSpec.describe OrderRepository do
  DatabaseConnection.connect('shop_manager_test')
  def reset_orders_table
    seed_sql = File.read('spec/seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_orders_table
  end

  it "returns the list of orders" do
    repo = OrderRepository.new

    orders = repo.all

    expect(orders.length).to eq 3
    expect(orders.first.id.to_i).to eq 1
    expect(orders.first.customer_name).to eq 'customer_1'
  end

  it "returns a single order" do
    repo = OrderRepository.new
  
    order = repo.find(1)
  
    expect(order.id.to_i).to eq 1
    expect(order.customer_name).to eq 'customer_1'
    expect(order.date).to eq '2023-01-10 14:10:05'
    expect(order.item_id.to_i).to eq 1
  end

  it "creates a new order" do
    repo = OrderRepository.new
  
    new_order = Order.new
    new_order.id = 4
    new_order.customer_name = 'customer_4'
    new_order.date = Time.now.strftime("%Y-%m-%d %H:%M:%S")
    new_order.item_id = 1
  
    repo.create(new_order)
  
    orders = repo.all
  
    expect(orders.last.id.to_i).to eq 4
    expect(orders.last.customer_name).to eq 'customer_4'
    expect(orders.last.date).to eq new_order.date
    expect(orders.last.item_id.to_i).to eq 1
  end
end