require_relative '../lib/order_repository'

def reset_order_table
  seed_sql = File.read('spec/seeds_orders.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

describe OrderRepository do
  before(:each) do 
    reset_order_table
  end

  it "#all returns all order items in the orders table" do
    repo = OrderRepository.new

    orders = repo.all

    expect(orders.length).to eq(2)

    expect(orders[0].id).to eq(1)
    expect(orders[0].customer_name).to eq 'M. Jones'
    expect(orders[0].date).to eq '2023-01-07'
    expect(orders[0].item_id).to eq 1

    expect(orders[1].id).to eq(2)
    expect(orders[1].customer_name).to eq 'R. Davids'
    expect(orders[1].date).to eq '2023-01-08'
    expect(orders[1].item_id).to eq 2
  end

  it "#create makes a new order in the orders table" do
    repo = OrderRepository.new
  
    new_order = Order.new
    new_order.customer_name = 'B. Young'
    new_order.date = '2022-12-22'
    new_order.item_id = 2
    repo.create(new_order)
    expect(repo.all).to include(
      have_attributes(customer_name: 'B. Young', date: '2022-12-22', item_id: 2)
    )

  end
end