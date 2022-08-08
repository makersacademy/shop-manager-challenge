require "order_repository"

def reset_seeds_table  
  seeds_sql = File.read('spec/seeds.sql')
  connection = PG.connect({host: '127.0.0.1', dbname: 'shop_manager_test'})
  connection.exec(seeds_sql)
end


RSpec.describe "Integration Tests for OrderRepository Class" do 
  
  before(:each) do 
    reset_seeds_table 
  end  

  it "creates a new order" do 

    repo = OrderRepository.new  

    order = Order.new
    order.customer_name = 'Nathan'
    order.date_order_placed = '2022-08-01'
    order.item_ordered = 2
  
    repo.create(order)

    orders = repo.all

    expect(orders.last.customer_name).to eq("Nathan")
    expect(orders.last.date_order_placed).to eq("2022-08-01")

  end

end  