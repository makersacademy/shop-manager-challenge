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

  it 'gets all orders' do
    repo = OrderRepository.new
    orders = repo.all

    expect(orders.length).to eq 2

    expect(orders[0].id).to eq 1
    expect(orders[0].customer_name).to eq 'Caroline'
    expect(orders[0].date).to eq '2023-04-27'
    expect(orders[0].item_id).to eq 1

    expect(orders[1].id).to eq 2
    expect(orders[1].customer_name).to eq 'Phil'
    expect(orders[1].date).to eq '2023-04-28'
    expect(orders[1].item_id).to eq 2

  end

  it 'returns a single order' do
    repo = OrderRepository.new

    order = repo.find(1)

    expect(order.id).to eq  1
    expect(order.customer_name).to eq  'Caroline'
    expect(order.date).to eq  '2023-04-27'
    expect(order.item_id).to eq 1
  end

  it 'creates a new order' do
    order = Order.new
    order.customer_name = 'Pip'
    order.date = '28-Apr-2023'
    order.item_id = 1

    repo = OrderRepository.new

    repo.create(order)

    last_order = repo.all.last

    expect(last_order.id).to eq  3
    expect(last_order.customer_name).to eq  'Pip'
    expect(last_order.date).to eq  '2023-04-28'
    expect(last_order.item_id).to eq 1
  end
end