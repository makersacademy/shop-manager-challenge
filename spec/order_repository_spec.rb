require_relative '../lib/order_repository.rb'

def reset_orders_table
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

describe OrderRepository do
  before(:each) do 
    reset_orders_table
  end

  it 'lists all customer orders' do
    repo = OrderRepository.new
    orders = repo.all
    expect(orders.length).to eq 3
    expect(orders[0].customer).to eq 'customer_1'
    expect(orders[0].date).to eq '2022-01-01'
    expect(orders[2].customer).to eq 'customer_3'
    expect(orders[2].date).to eq '2022-03-01'
  end

  it 'finds an order' do
    repo = OrderRepository.new
    order = repo.find(1)
    expect(order.customer).to eq 'customer_1'
    expect(order.date).to eq '2022-01-01'
  end

  it 'creates a new order' do
    repo = OrderRepository.new
    new_order = Order.new
    new_order.customer = 'customer_4'
    new_order.date = '2022-04-01'

    repo.create(new_order)
    
    orders = repo.all
    last_order = orders.last
    expect(last_order.customer).to eq 'customer_4'
    expect(last_order.date).to eq '2022-04-01'
  end
end