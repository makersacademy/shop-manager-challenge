require 'order'
require 'order_repository'
require 'item'

def reset_tables
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'items_orders_test' })
  connection.exec(seed_sql)
end

describe OrderRepository do
  before(:each) do 
    reset_tables
  end

  it "finds all order" do
    repo = OrderRepository.new

    orders = repo.all

    expect(orders.length).to eq 3

    expect(orders.first.id).to eq 1
    expect(orders.first.customer_name).to eq 'Sam'
    expect(orders.first.date).to eq '2023-03-31'
  end

  it "creates an order" do
    repo = OrderRepository.new

    order = Order.new
    order.customer_name = 'Laura'
    order.date = '2023-04-01'

    repo.create(order)

    created_order = repo.all.last
    expect(created_order.id).to eq 4
    expect(created_order.customer_name).to eq 'Laura'
    expect(created_order.date).to eq '2023-04-01'
  end

  it "finds order associated with an item" do
    repo = OrderRepository.new

    orders = repo.find_by_item(1)

    expect(orders.length).to eq 2
    expect(orders.first.id).to eq 1
    expect(orders.first.customer_name).to eq 'Sam'
    expect(orders.first.date).to eq '2023-03-31'
  end
end
