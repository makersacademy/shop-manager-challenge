require_relative "../lib/order_repository"

RSpec.describe OrderRepository do
  def reset_shop_table
    seed_sql = File.read("spec/seeds_shop.sql")
    connection = PG.connect({ host: "127.0.0.1", dbname: "shop_manager_test" })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_shop_table
  end
  it "returns all orders" do
    repo = OrderRepository.new
    all_orders = repo.all
    expect(all_orders.length).to eq(4)
    expect(all_orders.first.customer_name).to eq "Aimee"
  end
  it "returns a specific order from ID 1(Aimee)" do
    repo = OrderRepository.new
    order = repo.find_by_order(1)
    expect(order.items.first.item_name).to eq ("Galaxy Tab A8")
  end

  it "creates a new order" do
    repo = OrderRepository.new
    new_order = Order.new
    new_order.customer_name = "Lucy"
    new_order.order_date = "2022-02-11"
    new_order.id = "5"

    repo.create(new_order)

    list_orders = repo.all

    expect(list_orders).to include(
      have_attributes(
        customer_name: "Lucy",
        order_date: "2022-02-11",
        id: "5",
      )
    )
  end

  it "creates a new order linked to an item" do 
    order = Order.new
    order.customer_name = 'Zoltan'
    order.order_date = '2022-05-02'
    item_id = 2
    repo = OrderRepository.new
    repo.create(order)
    order_id = repo.all.last.id
    repo.link_order_to_item(order_id, item_id)
    items = repo.find_by_order(order_id).items
    expect(items.first.id).to eq "2"
  end

end
