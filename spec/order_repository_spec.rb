require 'order_repository'

def reset_order_table
  seed_sql = File.read('spec/seeds_items_orders_2.sql')
  connection = PG.connect({host:'127.0.0.1',dbname:'items_orders_test_2'})
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
    expect(orders.first.items).to eq [["Apple", 2], ["Orange", 1]]
  end

  it 'creates a new order object and shows up in the list of all orders' do
    repo = OrderRepository.new

    formated_date = Time.now.strftime("%Y-%m-%d")
    order = double :orders, customer_name:'Luke', placed_date: formated_date, items:[["Apple", 2], ["Banana", 1]]

    repo.create(order)

    orders = repo.all
    expect(orders.length).to eq 4
    expect(orders.last.id).to eq 4
    expect(orders.last.customer_name).to eq 'Luke'
    expect(orders.last.placed_date).to eq formated_date 
    expect(orders.last.items).to eq [["Apple", 2], ["Banana", 1]]
  end

  it 'decreases the quantity of the item after an order is placed' do
    repo = OrderRepository.new

    formated_date = Time.now.strftime("%Y-%m-%d")
    order = double :orders, customer_name:'Luke', placed_date: formated_date, items:[["Apple", 2], ["Banana", 1]]

    repo.create(order)

    result_set = DatabaseConnection.exec_params("SELECT quantity FROM items WHERE name = 'Apple';",[])
    apple_quantity = result_set[0]['quantity'].to_i

    expect(apple_quantity).to eq 8
  end

  it 'raises an error when out of stock' do
    repo = OrderRepository.new

    formated_date = Time.now.strftime("%Y-%m-%d")
    order = double :orders, customer_name:'Luke', placed_date: formated_date, items:[["Apple", 20]]

    expect {repo.create(order)}.to raise_error 'Apple is out of stock'
  end

  it 'raises an error if the item does not exsit in stock' do
  repo = OrderRepository.new

    formated_date = Time.now.strftime("%Y-%m-%d")
    order = double :orders, customer_name:'Luke', placed_date: formated_date, items:[["Meat", 20]]
    
  # repo.create(order)
    expect {repo.create(order)}.to raise_error 'Meat does not exist in the stock'
  end
end
