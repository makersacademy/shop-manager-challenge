require 'order_repository'

def reset_orders_table
  seed_sql = File.read('spec/seeds_shop_manager.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

describe OrderRepository do
  before(:each) do 
    reset_orders_table
  end

  it "Gets a list of all shop orders" do
    repository = OrderRepository.new
    orders = repository.all
    expect(orders.length).to eq 3
    expect(orders[0].id).to eq 1
    expect(orders[0].customer_name).to eq 'Sophie'
    expect(orders[0].date).to eq '2022-08-05 12:00:00'
    expect(orders[0].item_id).to eq 1
  end

  it "Creates a new shop order" do
    repository = OrderRepository.new
    order = double :order, customer_name: 'Tigi', date: '2022-08-07 16:00:00', item_id: 2
  
    repository.create(order)
    
    all_orders = repository.all
    last_order = all_orders.last
    expect(last_order.customer_name).to eq 'Tigi'
    expect(last_order.date).to eq '2022-08-07 16:00:00'
    expect(last_order.item_id).to eq 2
  end
end
