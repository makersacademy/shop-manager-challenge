require "order_repository"

def reset_seeds_table  
  seeds_sql = File.read('spec/seeds.sql')
  connection = PG.connect({host: '127.0.0.1', dbname: 'shop_manager_test'})
  connection.exec(seeds_sql)
end


RSpec.describe OrderRepository do  

  before(:each) do 
    reset_seeds_table 
  end  

  it "lists the orders with customer's name and date of order placed" do 

    repo = OrderRepository.new 

    orders = repo.all 

    expect(orders.length).to eq(6)
    expect(orders[0].customer_name).to eq("John")
    expect(orders[1].date_order_placed).to eq("2022-07-30")
    expect(orders[2].customer_name).to eq("Bob")
    expect(orders[3].date_order_placed).to eq("2022-08-05")

  end

  it "creates a new order" do 

    repo = OrderRepository.new  

    order = double(:order, customer_name: 'Wendy', date_order_placed: '2022-08-07', item_ordered: 2)
  
    repo.create(order)

    orders = repo.all

    expect(orders.last.customer_name).to eq("Wendy")
    expect(orders.last.date_order_placed).to eq("2022-08-07")

  end

end  