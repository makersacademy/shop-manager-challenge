require 'order_repository'

def reset_orders_table
    seed_sql = File.read('spec/seeds_shop_data.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_database_test' })
    connection.exec(seed_sql)
  end
  
describe OrderRepository do
  before(:each) do 
    reset_orders_table
  end
  
  it 'returns all orders' do
    repo = OrderRepository.new
    orders = repo.all

    expect(orders.length).to eq 3

    expect(orders[0].id).to eq 1
    expect(orders[0].customer).to eq 'Anna'
    expect(orders[0].date).to eq '2022-06-21'

    expect(orders[1].id).to eq 2
    expect(orders[1].customer).to eq 'John'
    expect(orders[1].date).to eq '2022-06-23'
  end

  it "returns an order by its ID" do
    repo = OrderRepository.new
    order = repo.find(3)

    expect(order.id).to eq 3
    expect(order.customer).to eq 'Rachel'
    expect(order.date).to eq '2022-07-01'
  end

  it "creates a new Order object" do
    repo = OrderRepository.new
    new_order = Order.new
    new_order.customer = 'Alice'
    new_order.date = '2022-07-09'
    repo.create(new_order)
    orders = repo.all
    expect(orders.length).to eq 4
    expect(orders). to include(
      have_attributes(customer: 'Alice', date: '2022-07-09')
    ) 
  end

  context "when looking for an Order with items data by order's ID" do
    it "returns an order with associated items" do
      repo = OrderRepository.new
      order = repo.find_with_items(1)
      expect(order.customer).to eq 'Anna'
      expect(order.items.length).to eq 3
    end

    it "returns nil if the order with given index does not exist" do
      repo = OrderRepository.new
      order = repo.find_with_items(199)
      expect(order).to eq nil
    end
  end
end