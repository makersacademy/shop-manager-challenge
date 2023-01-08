require_relative '../lib/order_repository'

RSpec.describe OrderRepository do
  def reset_tables
    seed_sql = File.read('spec/seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_tables
  end

  it 'provides a list of all orders' do

    repo = OrderRepository.new
    
    orders = repo.all
    expect(orders.length).to eq 5
    expect(orders[0].customer_name).to eq 'John Smith'
    expect(orders[1].date).to eq '2023-01-02'
    expect(orders[3].customer_name).to eq 'Elise Beer'
  end

  it 'creates a new order and adds to the order repository' do
    repo = OrderRepository.new
    orders = repo.all

    expect(orders.length).to eq 5
    expect(orders.last.customer_name).to eq 'James Dean'
    item = double(:item, :id => 1, :name => 'Apple', :price => '$1.00')
    new_order = Order.new
    new_order.date = '2023-01-03'
    new_order.customer_name = 'Tara Dunham'
    new_order.items << item
    repo.create(new_order)
    updated_orders = repo.all

    expect(updated_orders.length).to eq 6
    expect(updated_orders.last.customer_name).to eq 'Tara Dunham'
  end

  it 'provides order information including related items' do
    repo = OrderRepository.new
    order = repo.find_with_items(1)
    expect(order.customer_name).to eq 'John Smith'
    expect(order.items[0].name).to eq 'Apple'
  end
end
