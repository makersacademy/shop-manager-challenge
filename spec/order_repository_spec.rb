require "order_repository"

def reset_orders_table
    seed_sql = File.read('spec/seeds_orders.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'items_orders_test' })
    connection.exec(seed_sql)
end

RSpec.describe OrderRepository do

    before(:each) do
        reset_orders_table
      end

  it "return all orders" do 
    repo = OrderRepository.new
    orders = repo.all
    expect(orders.length).to eq(2) 
    expect(orders.first.customer_name).to eq("David")
  end 

  it "create a new order" do 
    repo = OrderRepository.new
    order = Order.new
    order.customer_name = 'Taylor'
    order.placed_date = '2023-04-01'
    expect(repo.create(order)).to eq(nil)
    repo.create(order)
    all_orders = repo.all
    expect(all_orders).to include(
        have_attributes(
            customer_name: order.customer_name,
            placed_date: '2023-04-01'
        )
    )
   end

   it 'finds order 1 with corresponding items' do
    repo = OrderRepository.new
    order = repo.find_with_items(1)

    expect(order.items.length).to eq(2)
    expect(order.id).to eq('1')
   end
end 

