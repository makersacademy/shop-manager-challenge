require 'order_repository'

RSpec.describe OrderRepository do 
  
  def reset_order_table
    seed_sql = File.read('spec/seeds_orders.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_order_table
  end 

  it "returns all orders" do 
    repo = OrderRepository.new

    orders = repo.all
    
    expect(orders.length).to eq(5) 
    expect(orders.first.id).to eq("1")
    expect(orders.first.customer_name).to eq('Lauren')
  end

  it "creates a new order" do
    repo = OrderRepository.new

    order = Order.new
    order.customer_name = 'Harry'
    order.date_order_placed = '2022-01-06'
    order.item_id = '2'

    repo.create(order)

    orders = repo.all

    expect(orders.length).to eq(6) 

    last_order = orders.last
    expect(last_order.customer_name).to eq('Harry') 
    expect(last_order.id).to eq("6")
  end
end 