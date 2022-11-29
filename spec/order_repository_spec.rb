require "order_repository"
require "order"

def reset_orders_table
  seed_sql = File.read('spec/seeds_orders.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

RSpec.describe OrderRepository do
  before(:each) do 
    reset_orders_table
  end

  it "returns all orders" do 
    repo = OrderRepository.new 
    orders = repo.all 

    expect(orders[0].customer_name).to eq "Anisha"
    expect(orders[0].date).to eq "2022-11-24"
    expect(orders[0].item_id).to eq 1

    expect(orders[1].customer_name).to eq "Robbie"
    expect(orders[1].date).to eq "2022-11-25"
    expect(orders[1].item_id).to eq 2

    expect(orders[2].customer_name).to eq "Shah"
    expect(orders[2].date).to eq "2022-11-26"
    expect(orders[2].item_id).to eq 3
  end 

  it "creates a new order" do 
    repo = OrderRepository.new 

    order = Order.new

    order.customer_name = "Thomas"
    order.date = "2022-11-27"
    order.item_id = 3

    repo.create(order)
    orders = repo.all 


    expect(order.customer_name).to eq "Thomas"
    expect(order.date).to eq "2022-11-27"
    expect(order.item_id).to eq 3
  end 
end 
