require 'order_repository'
require 'order'

describe OrderRepository do

def reset_shop_tables
  seed_sql = File.read('spec/shop_manager_seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

  before(:each) do 
    reset_shop_tables
  end

  it 'gets all orders' do
    repo = OrderRepository.new
    orders = repo.all
    expect(orders.length).to eq 2
    expect(orders[0].id).to eq 1
    expect(orders[0].customer_name).to eq 'Brenda'
    expect(orders[0].item_name).to eq 'Fanta'
    expect(orders[0].order_date).to eq '2023-01-01'
    expect(orders[1].id).to eq 2
    expect(orders[1].customer_name).to eq 'Keith'
    expect(orders[1].item_name).to eq 'Coke'
    expect(orders[1].order_date).to eq '2022-12-31'
  end

  it 'gets a single orders' do
    repo = OrderRepository.new
    sing_order = repo.find(1)
    expect(sing_order[0].id).to eq 1
    expect(sing_order[0].customer_name).to eq 'Brenda'
    expect(sing_order[0].item_name).to eq 'Fanta'
    expect(sing_order[0].order_date).to eq '2023-01-01'
  end

  it 'creates a new order' do
    repo = OrderRepository.new
    new_order = Order.new
    new_order.customer_name = 'Dwight'
    new_order.item_name = 'Sprite'
    new_order.order_date = '2023-02-10'
    repo.create(new_order)
    find_new_order = repo.find(3)
    expect(find_new_order[0].customer_name).to eq 'Dwight'
    expect(find_new_order[0].item_name).to eq 'Sprite'
    expect(find_new_order[0].order_date).to eq '2023-02-10'
  end

end


