require 'order_repository'

def reset_order_table
  seed_sql = File.read('spec/seeds_items_orders.sql')
  connection = PG.connect({host:'127.0.0.1',dbname:'items_orders_test'})
  connection.exec(seed_sql)
end

describe OrderRepository do
  before(:each) do
    reset_order_table
  end

  it 'returns all the order objects' do
    repo = OrderRepository.new
    orders = repo.all

    expect(orders.length).to eq 3
    expect(orders.first.id).to eq 1
    expect(orders.first.customer_name).to eq 'Ryan'
    expect(orders.first.placed_date).to eq '2023-01-08'
    expect(orders.first.items).to eq ['Apple','Orange']
  end

  it 'creates a new order object and shows up in the list of all orders' do
    repo = OrderRepository.new

    # date = Time.new
    formated_date = Time.now.strftime("%Y-%m-%d")
    order = double :orders, customer_name:'Luke', placed_date: formated_date, items:['Apple','Apple','Banana']

  repo.create(order)

  orders = repo.all
  expect(orders.length).to eq 4
  expect(orders.last.id).to eq 4
  expect(orders.last.customer_name).to eq 'Luke'
  expect(orders.last.placed_date).to eq formated_date 
  expect(orders.last.items).to eq ['Apple','Apple','Banana']
  end
end
