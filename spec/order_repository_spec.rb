require "order_repository"
require "pg"

def reset_shop_manager
  seed_sql = File.read('spec/shop_manager_seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager' })
  connection.exec(seed_sql)
end

describe OrderRepository do
  before(:each) do 
    reset_shop_manager
  end

  it "lists all orders" do
    repo = OrderRepository.new

    orders = repo.all

    expect(orders.length).to eq(3)

    expect(orders[0].id).to eq('1')
    expect(orders[0].customer_name).to eq('Pedro Pascal')
    expect(orders[0].order_date).to eq('March 10')

    expect(orders[1].id).to eq('2')
    expect(orders[1].customer_name).to eq('Alex de Souza')
    expect(orders[1].order_date).to eq('September 11')
  end

  it "gets a single order" do
    repo = OrderRepository.new

    order = repo.find(3)

    expect(order.id).to eq('3')
    expect(order.customer_name).to eq('Princess Diana')
    expect(order.order_date).to eq('January 5')
  end

  it "creates a new order" do
    repo = OrderRepository.new

    new_order = Order.new

    new_order.customer_name = 'Hugh Grant'
    new_order.order_date = 'February 3'

    repo.create(new_order) # => nil

    orders = repo.all
    last_order = orders.last
    expect(last_order.customer_name).to eq('Hugh Grant') 
    expect(last_order.order_date).to eq('February 3') 
  end

  it "deletes an order" do
    repo = OrderRepository.new
    id_to_delete = 1

    repo.delete(id_to_delete)

    all_orders = repo.all

    expect(all_orders.length).to eq(2)
    expect(all_orders.first.id).to eq('2')
  end

  it "updates an order" do
    repo = OrderRepository.new

    order = repo.find(1)
    order.customer_name = 'Zendaya'
    order.order_date = 'May 1'

    repo.update(order)

    updated_order = repo.find(1)
    expect(updated_order.customer_name).to eq('Zendaya')
    expect(updated_order.order_date).to eq('May 1')
  end
end