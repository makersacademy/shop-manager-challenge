require "order_repository"

RSpec.describe OrderRepository do 

  def reset_orders_table
    seed_sql = File.read('spec/orders_items_seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end
    
  describe OrderRepository do
    before(:each) do 
      reset_orders_table
    end
  end 

  it "returns a list of all orders" do 

    repo = OrderRepository.new

    orders = repo.all

    expect(orders.length).to eq 3

    expect(orders[0].id).to eq 1
    expect(orders[0].order_number).to eq 1
    expect(orders[0].customer_name).to eq "Joe Bloggs"
    expect(orders[0].order_date).to eq 2022-10-02
  end

  it "create a new order entry" do

    repo = OrderRepository.new
    new_order = Order.new

    new_order.order_number = 4
    new_order.customer_name = "Marcus Fenix"
    new_order.order_date = 2022-10-02
    repo.create(new_order)

    all_orders = repo.all

    expect(all_orders). to include(
    have_attributes(
    order_number: new_order.order_number,
    customer_name: new_order.customer_name,
    order_date: new_order.order_date,
    )   
    )
  end
end 