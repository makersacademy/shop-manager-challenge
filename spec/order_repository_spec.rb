require "order_repository"
require "order"
require "item_repository"

def reset_orders_table
  sql_seed = File.read("spec/seeds_orders.sql")
  connection = PG.connect({ host: "127.0.0.1", dbname: "shop_manager_test" })
  connection.exec(sql_seed)
end

RSpec.describe OrderRepository do
  before(:each) do
    reset_orders_table
  end

  it "Gets all orders" do
    order_repo = OrderRepository.new
    orders = order_repo.all

    expect(orders.length).to eq 6

    expect(orders.first.id).to eq 1
    expect(orders.first.customer_name).to eq "Customer One"
    expect(orders.first.date_placed).to eq "2022-01-01"

    expect(orders.last.id).to eq 6
    expect(orders.last.customer_name).to eq "Customer Four"
    expect(orders.last.date_placed).to eq "2022-01-08"
  end

  it "Create adds an order to the database" do
    order_repo = OrderRepository.new
    item_repo = ItemRepository.new

    new_order = Order.new
    new_order.id = 7
    new_order.customer_name = "Customer Five"
    new_order.date_placed = "2022-01-08"
    items = item_repo.all[1,2]
    order_repo.create(new_order, items)

    expect(order_repo.all).to include(have_attributes(
      id: 7,
      customer_name: "Customer Five",
      date_placed: "2022-01-08"
    ))

    items = item_repo.find_with_order(7)
    expect(items.length).to eq 2
    expect(items.first.id).to eq 2
    expect(items.last.id).to eq 3
  end

  it "Create fails when trying to add an order with an order id already being used" do
    order_repo = OrderRepository.new
    item_repo = ItemRepository.new

    new_order = Order.new
    new_order.id = 3
    new_order.customer_name = "Customer Five"
    new_order.date_placed = "2022-01-08"
    items = item_repo.all[1,2]
    expect { order_repo.create(new_order, items) }.to raise_error PG::UniqueViolation
  end

  it "Create fails when trying to add an order with items that don't exist" do
    order_repo = OrderRepository.new

    new_order = Order.new
    new_order.id = 7
    new_order.customer_name = "Customer Five"
    new_order.date_placed = "2022-01-08"

    fake_item = double(:fake_item, id: 5, name: "fake_name", unit_price: 1.00, quantity: 1)
    expect { order_repo.create(new_order, [fake_item]) }.to raise_error PG::ForeignKeyViolation
  end

  it "Create fails when trying to create an order without items" do
    order_repo = OrderRepository.new

    new_order = Order.new
    new_order.id = 7
    new_order.customer_name = "Customer Five"
    new_order.date_placed = "2022-01-08"
    error_message = "An order must have items"
    expect { order_repo.create(new_order, []) }.to raise_error error_message
  end
end
