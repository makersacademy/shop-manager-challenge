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

  it 'returns items in order' do
    repo = OrderRepository.new
    order = repo.find_items_in_order(3)
    expect(order.customer_name).to eq 'Ozzy'
    expect(order.items.length).to eq 4
    expect(order.items[0].name).to eq 'Socks'
    expect(order.items[1].price).to eq '$12.00'
    expect(order.items[2].quantity).to eq '90'
  end

  it 'adds new item to existing order' do
    repo = OrderRepository.new
    order = repo.add_items_to_order(3, 2)
    updated_order = repo.find_items_in_order(3)
    expect(updated_order.customer_name).to eq 'Ozzy'
    expect(updated_order.items.length).to eq 5
    expect(updated_order.items[1].name).to eq 'Trousers'
    expect(updated_order.items[1].price).to eq '$11.00'
    expect(updated_order.items[1].quantity).to eq '75'
  end
end