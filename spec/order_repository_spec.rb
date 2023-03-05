require "order_repository"

RSpec.describe OrderRepository do
  def reset_orders_table
    seed_sql = File.read("spec/seeds_orders.sql")
    connection = PG.connect({ host: "127.0.0.1", dbname: "shop_manager_test" })
    connection.exec(seed_sql)
  end

  before(:each) { reset_orders_table }

  it "returns all the orders" do
    repo = OrderRepository.new
    orders = repo.all
    expect(orders.length).to eq (2)
    expect(orders[0].id).to eq "1"
    expect(orders[0].customer_name).to eq "Sarah"
    expect(orders[0].order_date).to eq "2023-03-03"
    expect(orders[1].id).to eq "2"
    expect(orders[1].customer_name).to eq "Emma"
    expect(orders[1].order_date).to eq "2023-02-03"
  end

  it "gets a single order" do
    repo = OrderRepository.new
    order = repo.find(1)
    expect(order.id).to eq "1"
    expect(order.customer_name).to eq "Sarah"
    expect(order.order_date).to eq "2023-03-03"
  end

  it "creates an order" do
    repo = OrderRepository.new
    order = Order.new
    order.customer_name = "Daniel"
    order.order_date = "2023-02-28"
    expect(repo.all.length).to eq (2)
    repo.create(order)
    expect(repo.all.length).to eq (3)
  end
end
