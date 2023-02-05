require 'order_repository'

def reset_orders_table
  seed_sql = File.read('spec/seeds_items.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

describe OrderRepository do
  before(:each) do 
    reset_orders_table
  end

  it "returns the list of all orders" do
    repo = OrderRepository.new
    order = repo.all
    expect(order.length).to eq 2 # =>  2
    expect(order.first.id).to eq '1' # =>  1
    expect(order.first.customer_name).to eq 'Harry' # =>  'Harry'
    expect(order.first.date).to eq '1987-12-03' # =>  '1987-12-03'
  end

  it "returns the order with $id = 2" do
  repo = OrderRepository.new
    order = repo.find(2)
    expect(order.customer_name).to eq'Hermoine' #=> 'Hermoine'
    expect(order.date).to eq '1989-12-13'
    expect(order.item_id).to eq '2'
  end

  it "creates new order" do
    repo = OrderRepository.new
    new_order = Order.new
    new_order.id = '3'
    new_order.customer_name = 'Ron'
    new_order.date = '1991-07-11'
    new_order.item_id = '2'
    repo.create(new_order)
    all_orders = repo.all
    expect(all_orders).to include(
      have_attributes(
        id: '3',
        customer_name: new_order.customer_name,
        date: new_order.date,
        item_id: '2'
      )
    )
  end
end