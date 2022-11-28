require "order_repository"

def reset_tables
  seed_sql = File.read("spec/seeds.sql")
  connection = PG.connect({ host: "127.0.0.1", dbname: "shop_manager" })
  connection.exec(seed_sql)
end

describe OrderRepository do
  before(:each) do
    reset_tables
  end

  it "returns an array with all orders" do
    repo = OrderRepository.new
    orders = repo.all
    expect(orders.length).to eq(3)
    expect(orders.first.customer).to eq("Bruce")
    expect(orders.first.date).to eq("2022-03-06")
    expect(orders.last.customer).to eq("Diana")
    expect(orders.last.date).to eq("2022-07-08")
  end

  it "creates a new order" do
    repo = OrderRepository.new
    new_order = Order.new
    new_order.customer = "Hal"
    new_order.date = "2022-07-07"
    repo.create(new_order)
    orders = repo.all
    expect(orders.length).to eq(4)
    expect(orders.last.customer).to eq("Hal")
    expect(orders.last.date).to eq("2022-07-07")
  end

  it "returns an order with items" do
    repo = OrderRepository.new
    order = repo.find_with_items(1)
    expect(order.customer).to eq("Bruce")
    expect(order.date).to eq("2022-03-06")
    expect(order.items.length).to eq(5)
    expect(order.items.first.name).to eq("Kitchen Towel")
    expect(order.items.last.name).to eq("Soap")
  end
end
