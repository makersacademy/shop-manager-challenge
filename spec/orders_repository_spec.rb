require "orders_repository"

def reset_items_orders_table
  seed_sql = File.read('spec/seeds_items_orders.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end
RSpec.describe OrdersRepository do
  before(:each) do 
    reset_items_orders_table
  end
  it 'Get all orders' do
    repo = OrdersRepository.new
    orders = repo.all

    expect(orders.length).to eq  2
    expect(orders[0].id).to eq "1"
    expect(orders[0].customer_name).to eq  'Anna'
    expect(orders[0].order_date).to eq  '4 May 2022'
    expect(orders[0].item_id).to eq '2'

    expect(orders[1].id).to eq  "2"
    expect(orders[1].customer_name).to eq  'Mike'
    expect(orders[1].order_date).to eq  '15 jun 2022'
    expect(orders[1].item_id).to eq '1'
  end 
  it 'Gets a single order' do
    repo = OrdersRepository.new
    orders = repo.find(1)

    expect(orders.id).to eq  "1"
    expect(orders.customer_name).to eq 'Anna'
    expect(orders.order_date).to eq  '4 May 2022'
    expect(orders.item_id).to eq '2'
  end
   it "create a single order" do 
    repo = OrdersRepository.new
    order = Order.new
    order.customer_name =  'JON H'
    order.order_date =  "3 feb 2022"
    order.item_id =  1
    repo.create(order)
    orders = repo.all

    expect(orders[2].id).to eq "3"
    expect(orders[2].customer_name).to eq  'JON H'
    expect(orders[2].order_date).to eq  "3 feb 2022"
    expect(orders[2].item_id).to eq "1"
   end
    it "update an order" do 
    repo = OrdersRepository.new
    order = repo.find(1)
    order.customer_name = 'new_name'
    repo.update(order)
    orders = repo.all

    expect(orders[1].id).to eql "1"
    expect(orders[1].customer_name).to eql  'new_name'
    expect(orders[1].order_date).to eql "4 May 2022"
    expect(orders[1].item_id).to eql "2"
   end
    it "delete an order" do 
    repo = OrdersRepository.new
    order = repo.find(1)

    repo.delete(order)

    orders = repo.all
    expect(orders.length).to eq 1
   end 
 

end 
