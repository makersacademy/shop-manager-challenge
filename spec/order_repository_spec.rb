require 'order_repository'


def reset_orders_table
  seed_sql = File.read('spec/seeds_shop.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_test' })
  connection.exec(seed_sql)
end

describe OrderRepository do
  before(:each) do
    reset_orders_table
  end

  # (your tests will go here).

  it 'returns all orders' do
    repo = OrderRepository.new
    orders = repo.all
    expect(orders.length).to eq(3)

    expect(orders[0].id).to eq(1) # =>  1
    expect(orders[0].customer_name).to eq('customer1') # =>  'customer1'
    expect(orders[0].date_ordered).to eq('1/1/11') # =>  '1/1/11'
    expect(orders[0].item_id).to eq(1) # =>  '1'
  end

  it 'creates new order' do
    repo = OrderRepository.new
    new_order = Order.new
    new_order.id = 4
    new_order.customer_name = 'customer4'
    new_order.date_ordered = '4/4/44'
    new_order.item_id = 1

    expect(new_order.id).to eq(4)
    expect(new_order.customer_name).to eq('customer4')
    expect(new_order.date_ordered).to eq('4/4/44')
    expect(new_order.item_id).to eq(1)
  end

end
