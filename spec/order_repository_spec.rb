require 'order_repository'

def reset_orders_table
  seed_sql = File.read('spec/seed.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

RSpec.describe OrderRepository do
  before(:each) do
    reset_orders_table
  end
  it "gets all orders" do
    repo = OrderRepository.new
    orders = repo.all
    expect(orders[0].id).to eq 1
    expect(orders[0].customer_name).to eq "Sally Smith"
    expect(orders[0].order_date).to eq "2022-07-04"
    expect(orders[0].item_id).to eq  1

    expect(orders[1].id).to eq  2
    expect(orders[1].customer_name).to eq  "Kevin Mack"
    expect(orders[1].order_date).to eq  "2022-07-02"
    expect(orders[1].item_id).to eq  2
  end
  it "creates a new order record" do
    repo = OrderRepository.new
    order = Order.new

    order.customer_name = "Chris Pine"
    order.order_date = "June 21, 2022"
    order.item_id = 2
    repo.create(order)

    orders = repo.all

    expect(orders[0].id).to eq 1
    expect(orders[0].customer_name).to eq "Sally Smith"
    expect(orders[0].order_date).to eq "2022-07-04"
    expect(orders[0].item_id).to eq  1

    expect(orders[1].id).to eq  2
    expect(orders[1].customer_name).to eq  "Kevin Mack"
    expect(orders[1].order_date).to eq  "2022-07-02"
    expect(orders[1].item_id).to eq  2

    expect(orders[2].id).to eq  3
    expect(orders[2].customer_name).to eq  "Chris Pine"
    expect(orders[2].order_date).to eq  "2022-06-21"
    expect(orders[2].item_id).to eq  2
  end
end