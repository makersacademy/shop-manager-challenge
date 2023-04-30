require 'order_repository'

def reset_orders_table
  seed_sql = File.read('spec/seeds_orders.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

describe OrderRepository do
  before(:each) do 
    reset_orders_table
  end

  it "Returns all orders" do
    repo = OrderRepository.new

    orders = repo.all

    expect(orders.length).to eq 2

    expect(orders[0].id).to eq '1'
    expect(orders[0].customer_name).to eq 'David'
    expect(orders[0].date).to eq '2023-03-22'
    expect(orders[0].item_id).to eq '1'

    expect(orders[1].id).to eq '2'
    expect(orders[1].customer_name).to eq 'Anna'
    expect(orders[1].date).to eq '2023-04-25'
    expect(orders[1].item_id).to eq '2'

  end

  it "Finds an order by id" do
    repo = OrderRepository.new

    order = repo.find(1)

    expect(order.id).to eq '1'
    expect(order.customer_name).to eq 'David'
    expect(order.date).to eq '2023-03-22'
    expect(order.item_id).to eq '1'
  end

  it "Creates an order" do
    new_order = Order.new
    new_order.customer_name = 'Patrick'
    new_order.date = '2023-04-28'
    new_order.item_id = '2'

    repo = OrderRepository.new
    repo.create(new_order)

    orders = repo.all
    expect(orders[-1].customer_name).to eq 'Patrick'
    expect(orders[-1].date).to eq '2023-04-28'
    expect(orders[-1].item_id).to eq '2'
  end
end
