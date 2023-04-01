require 'order_repository'
require 'item_repository'

def reset_orders_table
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

RSpec.describe OrderRepository do
  before(:each) do
    reset_orders_table
  end

  it "gets all orders" do
    repo = OrderRepository.new
    orders = repo.all

    expect(orders.length).to eq 3
    expect(orders[0].id).to eq '1'
    expect(orders[0].customer).to eq 'Quack Overflow'
    expect(orders[0].date).to eq '2023-04-01'
  end

  it "gets a single order" do
    repo = OrderRepository.new
    order = repo.find(1)

    expect(order.id).to eq '1'
    expect(order.customer).to eq 'Quack Overflow'
    expect(order.date).to eq '2023-04-01'
  end

  it "adds a new order to the database" do
    new_order = Order.new
    item_repo = ItemRepository.new
    items = item_repo.all
    order_repo = OrderRepository.new

    new_order.customer = 'Big Bird'
    new_order.date = '03/29/23'

    order_repo.create(new_order)
    orders = order_repo.all
    last_order = orders.last

    expect(last_order.id).to eq '4'
    expect(last_order.customer).to eq 'Big Bird'
    expect(last_order.date).to eq '2023-03-29'
  end

  it "adds items to an order" do
    new_order = Order.new
    item_repo = ItemRepository.new
    items = item_repo.all
    order_repo = OrderRepository.new

    new_order.customer = 'Big Bird'
    new_order.date = '03/29/23'

    order_repo.create(new_order)
    order = order_repo.find(4)
    order.add_item(items[3])
    order.add_item(items[2])
    orders = order_repo.all
    last_order = orders.last
    expect(item_repo.find_by_order(4)[0].name).to eq 'cake'
    expect(item_repo.find_by_order(4)[0].price).to eq '9'
  end
end
