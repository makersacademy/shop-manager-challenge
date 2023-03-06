require 'order_repository'

def reset_orders_table
  seed_sql = File.read('spec/seeds_items_orders.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

RSpec.describe OrderRepository do

  before(:each) do 
    reset_orders_table
  end

  it "returns a list of all orders" do
    repo = OrderRepository.new

    orders = repo.all

    expect(orders.length).to eq 3

    expect(orders[0].customer_name).to eq 'Customer1'
    expect(orders[0].order_date).to eq '2023-01-01'
    expect(orders[0].item_id).to eq 1

    expect(orders[1].customer_name).to eq 'Customer2'
    expect(orders[1].order_date).to eq '2023-01-10'
    expect(orders[1].item_id).to eq 2

    expect(orders[2].customer_name).to eq 'Customer3'
    expect(orders[2].order_date).to eq '2023-01-20'
    expect(orders[2].item_id).to eq 3
  end

  it "creates a new order" do
    repo = OrderRepository.new

    order = Order.new
    order.customer_name = 'Customer4'
    order.order_date = '2023-01-25'
    order.item_id = 3

    repo.create(order)

    orders = repo.all 

    expect(orders).to include(
      have_attributes(
        customer_name: order.customer_name,
        order_date: order.order_date,
        item_id: order.item_id
      )
    )
  end

end
