require 'orders_repository'
require 'database_connection'

def reset_orders_table
    seed_sql = File.read('spec/shop_manager.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
end
  
describe OrdersRepository do
  before(:each) do 
    reset_orders_table
  end

  it 'return all orders' do
    repo = OrdersRepository.new
    orders = repo.all
    expect(orders.length).to eq 6
    expect(orders.first.customer_name).to eq 'Ana'
    expect(orders.last.date).to eq '2022-03-10'
  end

  it 'return only one order' do 
    repo = OrdersRepository.new
    orders = repo.find(3)
    expect(orders.customer_name).to eq 'Jon'
    expect(orders.date).to eq '2022-09-09'
  end

  it 'creates a new order' do
    repo = OrdersRepository.new
    new_order = Order.new
    new_order.id = 7
    new_order.customer_name = 'Angel'
    new_order.date = '2022-10-12'
    
    repo.create(new_order)
    all_orders = repo.all
    expect(all_orders.length).to eq 7
    expect(all_orders.last.customer_name).to eq 'Angel'
    expect(all_orders.last.date).to eq '2022-10-12'
  end

  it 'deletes an order' do 
    repo = OrdersRepository.new
    id_to_delete = 7
    repo.delete(id_to_delete)
    all_orders = repo.all
    expect(all_orders.length).to eq 6
    expect(all_orders.last.id).to eq '6'
    expect(all_orders.first.id).to eq '1'
    expect(all_orders.last.date).to eq '2022-03-10'
  end
end