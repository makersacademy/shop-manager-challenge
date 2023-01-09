require 'item'
require 'order'
require 'order_repository'
require 'database_connection'

RSpec.describe OrderRepository do 

  def reset_shop_manager_tables
    seed_sql = File.read('spec/seeds_shop_manager.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_shop_manager_tables
  end

  it "returns all orders" do
    repo = OrderRepository.new
    orders = repo.all
    expect(orders.length).to eq(4)
    expect(orders.first.id).to eq(1)
    expect(orders.first.customer_name).to eq('Joe Bloggs')
    expect(orders.first.order_date).to eq('2022-12-31')
    expect(orders.first.item_id).to eq(1)
  end
  it "returns the single record queried by its id " do 
    repo = OrderRepository.new
    order = repo.find(2)
    expect(order.id).to eq(2)
    expect(order.customer_name).to eq('John Smith')
    expect(order.order_date).to eq('2023-01-01')
    expect(order.item_id).to eq(2)
  end
   it "creates orders" do 
        order = Order.new()
        repo = OrderRepository.new
        order.customer_name = 'Mark'
        order.order_date = '2023-01-05'
        order.item_id = 3
        expect(repo.all[-1].order_date).to eq('2023-01-05')
    end
    

end
