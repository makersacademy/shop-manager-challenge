require "order_repository"
require "order"

describe OrderRepository do
  
  def reset_orders_table
    seed_sql = File.read('spec/seeds_shop_manager.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop' })
    connection.exec(seed_sql)
  end
  
  before(:each) do 
    reset_orders_table
  end

  it "returns a list of the orders from the database" do
    repo = OrderRepository.new
    orders = repo.all
    
    expect(orders.length).to eq 4
    expect(orders[0].id).to eq "1"
    expect(orders[1].customer_name).to eq 'Anna'
    expect(orders[2].date).to eq '21-06-2022'
    expect(orders[3].item_id).to eq '3'
  end

  it "adds a new order to the database" do 
    new_order = Order.new
    new_order.customer_name = "Francesco"
    new_order.date = "05-03-2023"
    new_order.item_id = 4
    repo = OrderRepository.new
    repo.create(new_order)
    orders = repo.all
    
    expect(orders.length).to eq 5
    expect(orders.last.id).to eq '5'
    expect(orders.last.customer_name).to eq "Francesco"
    expect(orders.last.date).to eq "05-03-2023"
    expect(orders.last.item_id).to eq '4'
  end

end
