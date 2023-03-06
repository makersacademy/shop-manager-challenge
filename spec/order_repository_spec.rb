require 'order_repository'

RSpec.describe OrderRepository do
  def reset_orders_table
    seed_sql = File.read('spec/seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end

  before(:each) do 
    reset_orders_table
  end

  # 1
  it 'returns all orders' do
    repo = OrderRepository.new
    orders = repo.all

    expect(orders.length).to eq 2

    expect(orders[0].id).to eq 1
    expect(orders[0].customer_name).to eq 'David'
    expect(orders[0].order_date).to eq "2022-08-10"
    expect(orders[0].item_id).to eq 1

    expect(orders[1].id).to eq 2
    expect(orders[1].customer_name).to eq 'Anna'
    expect(orders[1].order_date).to eq "2022-09-12"
    expect(orders[1].item_id).to eq 2
  end

# 2
  it 'returns a single student' do
    repo = OrderRepository.new

    order = repo.find(2)

    expect(order.id).to eq 2
    expect(order.customer_name).to eq 'Anna'
    expect(order.order_date).to eq "2022-09-12"
    expect(order.item_id).to eq 2
  end
# 3
  it 'creates a new order' do
    repo = OrderRepository.new
    order = Order.new
    order.customer_name = "Hilda"
    order.order_date = "6/3/23"
    order.item_id = 1

    repo.create(order)
    orders = repo.all
    last_order = orders.last
    expect(last_order.customer_name).to eq "Hilda"
    expect(last_order.order_date).to eq "2023-06-03"
    expect(last_order.item_id).to eq 1
  end
end
