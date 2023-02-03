require_relative '../lib/order_repository'

def reset_orders_table
  seed_sql = File.read('spec/seeds_shop.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

describe OrderRepository do
  before(:each) do 
    reset_orders_table
  end

  # (your tests will go here).

  it 'returns a list of all orders' do
    repo = OrderRepository.new
    order = repo.all
    expect(order.length).to eq 2
    expect(order.first.id).to eq '1'
    expect(order.first.customer_name).to eq 'Dave'
  end

  it 'returns a single order object that matches the given id' do
    repo = OrderRepository.new
    order = repo.find(1)
    expect(order.customer_name).to eq "Dave"
  end

  it 'can create a new order' do
    repo = OrderRepository.new
    order = Order.new
    order.customer_name = 'Geoff'
    order.date = '2023-01-01'
    order.item_id = '2'
    repo.create(order)
    expect(repo.all.last.customer_name).to eq order.customer_name
  end

  it 'can delete an order that matches the given id' do
    repo = OrderRepository.new
    order = repo.find(1)
    repo.delete(order.id)
    expect(repo.all.length).to eq  1
    expect(repo.all.first.id).to eq '2'
  end

  it 'can update the details of an order' do
    repo = OrderRepository.new
    order = repo.find(1)
    order.date = '2023-01-01'
    repo.update(order)
    updated_order = repo.find(1)
    expect(updated_order.date).to eq '2023-01-01'
  end

end