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
end