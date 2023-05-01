require 'orders_repository'

RSpec.describe OrdersRepository do

def reset_orders_table
  seed_sql = File.read('spec/orders_seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_db_test' })
  connection.exec(seed_sql)
end

  before(:each) do 
    reset_orders_table
  end

  it 'gets all orders from the table ' do

    repo = OrdersRepository.new

    order = repo.all
    expect(order.length).to eq (2)
    expect(order.first.order_name).to eq 'Nice Mints'
    expect(order.first.customer_name).to eq 'Karl'
    expect(order.first.order_date).to eq ('2023')
  end

  it 'finds order 1' do
    repo = OrdersRepository.new
    order = repo.find(1)
    expect(order.order_name).to eq 'Nice Mints'
    expect(order.customer_name).to eq 'Karl'
    expect(order.order_date).to eq '2023'
  end

  it "finds order 2" do
    repo = OrdersRepository.new
    order = repo.find(2)
    expect(order.order_name).to eq 'Best Beans'
    expect(order.customer_name).to eq 'Sue'
    expect(order.order_date).to eq '2023'
  end

  it 'creates a new order in the table' do

    repo = OrdersRepository.new

    new_order = Orders.new
    new_order.order_name = 'Choclits'
    new_order.customer_name = 'Jim'
    new_order.order_date = '2023'


    repo.create(new_order)

    orders = repo.all
    last_order = orders.last

    expect(last_order.order_name).to eq 'Choclits'
    expect(last_order.customer_name).to eq 'Jim'
    expect(last_order.order_date).to eq '2023'
  end

  it 'deletes an order from the table' do
    repo = OrdersRepository.new

    id_to_delete = 1

    repo.delete(id_to_delete)

    all_orders = repo.all
    expect(all_orders.length).to eq 1
    expect(all_orders.first.order_name).to eq 'Best Beans'
  end
end