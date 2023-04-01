require "order_repository"

def reset_orders_table
  seed_sql = File.read('spec/seeds_orders.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

describe OrderRepository do
  before(:each) do 
    reset_orders_table
  end

  it "returns all orders" do
    repo = OrderRepository.new
    orders = repo.all

    expect(orders.length).to eq 3
  end

  it "returns the first order" do
    repo = OrderRepository.new
    orders = repo.all

    expect(orders.first.customer_name).to eq "Joe Bloggs"
    expect(orders.first.order_date).to eq "2023-03-30"
  end

  it "creates a new order and checks how many orders there are" do
    repo = OrderRepository.new
    order = Order.new
    order.customer_name = "Lee Mack"
    order.order_date = "2023-04-01"

    repo.create(order)
    all_orders = repo.all
    expect(all_orders.length).to eq 4
  end

  it "creates a new order and checks the last insert" do
    repo = OrderRepository.new

    order = Order.new
    order.customer_name = "Jimmy Carr"
    order.order_date = "2023-04-01"

    repo.create(order)

    all_orders = repo.all
    expect(all_orders.last.customer_name).to eq "Jimmy Carr"
    expect(all_orders.last.order_date).to eq "2023-04-01"
  end
end