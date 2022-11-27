require 'order_repository'
require 'item_repository'

def reset_orders_table
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_inventory_test' })
  connection.exec(seed_sql)
end

describe OrderRepository do
  before(:each) do 
    reset_orders_table
  end

  it "gets all orders" do
    repo = OrderRepository.new
    orders = repo.all

    expect(orders.length).to eq 3

    expect(orders[0].id).to eq 1
    expect(orders[0].customer).to eq 'Rob'
    expect(orders[0].date).to eq '2022-01-01'

    expect(orders[1].id).to eq 2
    expect(orders[1].customer).to eq 'Tom'
    expect(orders[1].date).to eq '2022-01-02'
  end

  it "gets a single order" do
    repo = OrderRepository.new
    order = repo.find(1)

    expect(order.id).to eq 1
    expect(order.customer).to eq 'Rob'
    expect(order.date).to eq '2022-01-01'
  end

  it "creates a single order and adds to join table with related items" do
    order_repo = OrderRepository.new
    order = Order.new
    order.customer = 'Shah'
    order.date = 'Jan-13-2022'
    item_repo = ItemRepository.new
    item = item_repo.find(1)
    order_repo.create(order, item)
    all_orders = order_repo.all
    expect(all_orders.last.id).to eq 4
    expect(all_orders.last.customer).to eq 'Shah'
    expect(all_orders.last.date).to eq '2022-01-13'
  end

  it "deletes a single order" do
    repo = OrderRepository.new
    repo.delete(2)
    orders = repo.all
    expect(orders.length).to eq 2
    expect(orders[0].id).to eq 1
    expect(orders[1].id).to eq 3
  end

  it "updates a single order" do
    repo = OrderRepository.new
    order = repo.find(2)
    order.customer = 'Graeme'
    repo.update(order)
    order = repo.find(2)
    expect(order.date).to eq "2022-01-02"
    expect(order.customer).to eq 'Graeme'
  end

  it "finds an order and it's related items" do
    repo = OrderRepository.new
    order = repo.find_with_item(1)
    expect(order.items.length).to eq 2
    expect(order.customer).to eq 'Rob'
    expect(order.date).to eq '2022-01-01'
    expect(order.items.first.name).to eq 'TV'
    expect(order.items.first.price).to eq 99.99
    expect(order.items.last.name).to eq 'Fridge'
    expect(order.items.last.price).to eq 80.0
  end

end
