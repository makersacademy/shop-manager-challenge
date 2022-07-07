require "order_repository"

describe OrderRepository do
  def reset_tables
    seed_sql = File.read("spec/seeds.sql")
    connection = PG.connect({ host: "127.0.0.1", dbname: "shop_manager_test" })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_tables
  end

  it "returns all orders" do
    repo = OrderRepository.new
    orders = repo.all

    expect(orders.length).to eq 3
    expect(orders.first.id).to eq 1
    expect(orders.first.customer_name).to eq "Alex"
    expect(orders.first.order_date).to eq "2022-06-28"
    expect(orders.first.item_id).to eq 1

    expect(orders.last.id).to eq 3
    expect(orders.last.customer_name).to eq "Jemima"
    expect(orders.last.order_date).to eq "2022-07-01"
    expect(orders.last.item_id).to eq 1
  end

  it "creates a new order" do
    new_order = Order.new
    new_order.customer_name = "Harry"
    new_order.order_date = "2022-02-03"
    new_order.item_id = 3

    repo = OrderRepository.new
    repo.create(new_order)
    orders = repo.all

    expect(orders.length).to eq 4
    expect(orders.last.id).to eq 4
    expect(orders.last.customer_name).to eq "Harry"
    expect(orders.last.item_id).to eq 3
  end
end
