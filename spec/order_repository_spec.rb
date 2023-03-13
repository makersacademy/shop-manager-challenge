# require "order"
require "order_repository"
require "pg"

def reset_orders_table
  seed_sql = File.read('spec/seeds_orders.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

describe OrderRepository do
  before(:each) do 
    reset_orders_table
  end

  it "gets all orders" do
    repo = OrderRepository.new
    orders = repo.all

    expect(orders.length).to eq(6)
    expect(orders.first.customer_name).to eq('Mary Jones')
    expect(orders.first.date).to eq('2023-03-11')
    expect(orders.first.item_id).to eq(1)

  end

  it "gets a single order" do
    repo = OrderRepository.new
    order = repo.find(2)

    expect(order.customer_name).to eq('Anna Smith')
    expect(order.date).to eq('2023-03-12')
    expect(order.item_id).to eq(2)
  end

  it "creates an order" do
    repo = OrderRepository.new

    order = Order.new
    order.customer_name = 'Sofia Brown'
    order.date = '2023-03-08'
    order.item_id = 4

    repo.create(order)

    orders = repo.all
    expect(orders.length).to eq 7
    expect(orders.last.customer_name).to eq('Sofia Brown')
  end
end
