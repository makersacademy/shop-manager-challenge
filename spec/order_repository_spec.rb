require 'order_repository'

def reset_tables
  seed_sql = File.read('spec/seeds_items_orders.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end
describe OrderRepository do
  before(:each) do 
    reset_tables
  end
  it "returns all items in table" do
    repo = OrderRepository.new
    orders = repo.all
    expect(orders.length).to eq 3
    expect(orders[0].customer_name).to eq 'Edward'
    expect(orders[0].order_date).to eq "2023-03-01"
    expect(orders[1].id).to eq '2'
    expect(orders[2].customer_name).to eq "Pablo"
    expect(orders[2].order_date).to eq "2023-04-01"
  end

  it "creates a new order in the table" do 
    repo = OrderRepository.new
    order = Order.new
    order.customer_name = "Isaac"
    order.order_date = "2023-03-04"
    repo.create(order)
    all_orders = repo.all
    expect(all_orders).to include(
      have_attributes(
        customer_name: "Isaac",
        order_date: "2023-03-04"
      )
    )
  end
end


