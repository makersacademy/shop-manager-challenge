require 'order_repository'

def reset_orders_table
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

RSpec.describe OrderRepository do
  before(:each) do 
    reset_orders_table
  end

  it 'returns all order' do
    repo = OrderRepository.new

    orders = repo.all
    
    expect(orders.length).to eq 2
    expect(orders[0].id).to eq '1'
    expect(orders[0].customer).to eq 'Hana Holmens'
    expect(orders[0].date).to eq '2022-07-10'
  end

  it 'creates a new order' do
    repo = OrderRepository.new

    order = Order.new
    order.customer = 'Mike Anderson'
    order.date = '2022-06-23'
    
    repo.create(order)
    
    all_orders = repo.all
    expect(all_orders.last.id).to eq '3'
    expect(all_orders.last.customer).to eq 'Mike Anderson'
    expect(all_orders.last.date).to eq '2022-06-23'
  end
end