require 'order_repository'
require 'item_repository'

def reset_shop_tables
  seed_sql = File.read('spec/seeds_shop_tables.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

RSpec.describe OrderRepository do
  before(:each) do
    reset_shop_tables
  end

  it 'gets a list of all order objects' do
    repo = OrderRepository.new
    orders = repo.all

    expect(orders.length).to eq 3
    expect(orders[0].id).to eq 1
    expect(orders[0].customer_name).to eq 'Louis'
    expect(orders[0].date_placed).to eq '2022-01-01'
    expect(orders[0].item_id).to eq 1
  end

  it 'adds a new order to the database' do
    repo = OrderRepository.new
    order = Order.new
    order.customer_name = 'Francesca'
    order.date_placed = '2023-04-28'
    order.item_id = 2
    
    repo.create(order)
    
    orders = repo.all
    expect(orders).to include (
      have_attributes(
        id: 4,
        customer_name: 'Francesca',
        date_placed: '2023-04-28',
        item_id: 2
      )
    )
  end

  it "finds the order's corresponding item" do
    repo =  OrderRepository.new
    orders = repo.all
    expect(orders[0].item_name).to eq 'Hoover'
    expect(orders[1].item_name).to eq 'Hoover'
    expect(orders[2].item_name).to eq 'Bicycle'
  end
end
