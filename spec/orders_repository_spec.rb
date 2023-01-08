require "database_connection"
require "orders"
require "orders_repository"
require "items"
require "items_repository"

def reset_shop_manager_test_table
  seed_sql = File.read("spec/seed_shop_manager_test.sql")
  connection = PG.connect({ host: "127.0.0.1", dbname: "shop_manager_test" })
  connection.exec(seed_sql)
end

describe OrdersRepository do
  before(:each) do
    reset_shop_manager_test_table
  end

  it "returns array of all entries" do
    repo = OrdersRepository.new
    list = repo.all
    expect(list.length).to eq 2
    expect(list[0].customer_name).to eq "Lisa"
    expect(list[0].date).to eq "12/01/2023"
    expect(list[0].items.first.name).to eq "Laptop"
    expect(list[0].items.first.price).to eq "450"
  end

  it "creates an order entry" do
    repo = OrdersRepository.new
    order = Orders.new
    order.customer_name = "Billy"
    order.date = "8/01/2023"
    item = Items.new
    item_id = item.id = 1
    repo.create(order, item_id)
  end
end
