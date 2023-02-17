require_relative "../lib/order_repository"

def reset_orders_table
  seed_sql = File.read('spec/seeds_shop.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_test' })
  connection.exec(seed_sql)
end

describe OrderRepository do
  before(:each) do 
    reset_orders_table
  end

  it "#all returns all orders" do
    repo = OrderRepository.new
    orders = repo.all

    expect(orders.length).to eq 2
    expect(orders[0].id).to eq 1
    expect(orders[0].customer_name).to eq 'Amber'
    expect(orders[0].order_date).to eq '2023-02-13'
    expect(orders[0].item_id).to eq '1'

    expect(orders[1].id).to eq 2
    expect(orders[1].customer_name).to eq 'Jamie'
    expect(orders[1].order_date).to eq '2023-02-12'
    expect(orders[1].item_id).to eq '2'
  end

  it "#get returns a single order" do
    repo = OrderRepository.new
    order = repo.find(1)

    expect(order.id).to eq 1
    expect(order.customer_name).to eq 'Amber'
    expect(order.order_date).to eq '2023-02-13'
    expect(order.item_id).to eq '1'
  end


  it "creates a new order" do
    repo = OrderRepository.new
    order = Order.new
    order.id = 3
    order.customer_name = 'Mark'
    order.order_date = '2023-02-11'

    repo.create(order)

    expect(repo.all.length).to eq 3
    expect(repo.all.last.customer_name).to eq 'Mark'
  end

  it "deletes an order" do
    repo = OrderRepository.new
    order = repo.find(1)
    repo.delete(order.id)

    expect(repo.all.length).to eq 1
    expect(repo.all.first.id).to eq 2
  end

  it "updates an order" do
    repo = OrderRepository.new
    order = repo.find(1)

    order.customer_name = 'Amber Ale'
    order.order_date = '2023-02-13'
    order.item_id = '2'

    repo.update(order)

    updated_order = repo.find(1)

    expect(updated_order.customer_name).to eq 'Amber Ale'
    expect(updated_order.order_date).to eq '2023-02-13'
    expect(updated_order.item_id).to eq '2'
  end
end
