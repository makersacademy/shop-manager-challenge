require_relative '../lib/order_repository'

def reset_shop_table
  seed_sql = File.read('spec/seeds_shop.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

describe OrderRepository do
  before(:each) do 
    reset_shop_table
  end

  it 'returns all orders on record' do
    repo = OrderRepository.new
    orders = repo.all
    expect(orders.length).to eq 5
    expect(orders[0].customer_name).to eq 'Sia'
    expect(orders[2].date).to eq '2022-08-27'
  end

  it 'finds order with ID 5' do
    repo = OrderRepository.new
    order = repo.find(5)
    expect(order.customer_name).to eq 'Ari'
    expect(order.date).to eq '2022-06-25'
  end

  it 'creates new order' do
    new_order = Order.new
    new_order.customer_name = 'Ferg'
    new_order.date = '2022-05-23'
    repo = OrderRepository.new
    repo.create(new_order)
    orders = repo.all
    expect(orders.length).to eq 6
    expect(orders.last.customer_name).to eq 'Ferg'
    expect(orders.last.date).to eq '2022-05-23'
  end


end