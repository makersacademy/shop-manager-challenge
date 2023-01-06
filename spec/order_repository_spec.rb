require 'pg'
require_relative "../lib/order_repository"

def reset_orders_table
  seed_sql = File.read('spec/seeds_items_orders.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
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

    expect(orders[0].id).to eq "1"
    expect(orders[0].customer_name).to eq "John Smith"
    expect(orders[0].date).to eq '2022-06-01'
    expect(orders[0].item_id).to eq '1'

    expect(orders[1].id).to eq "2"
    expect(orders[1].customer_name).to eq "Pauline Jones"
    expect(orders[1].date).to eq "2022-05-01"
    expect(orders[1].item_id).to eq "2"
  end

  it "gets a single order" do
    repo = OrderRepository.new

    order = repo.find(1)

    expect(order.id).to eq "1"
    expect(order.customer_name).to eq "John Smith"
    expect(order.date).to eq "2022-06-01"
    expect(order.item_id).to eq "1"
  end

  it "deletes an order" do
    repo = OrderRepository.new

    delete_order = repo.delete('1')
    orders = repo.all

    expect(orders.length).to eq 2

    expect(orders[0].id).to eq "2"
    expect(orders[0].customer_name).to eq "Pauline Jones"
    expect(orders[0].date).to eq "2022-05-01"
    expect(orders[0].item_id).to eq "2"
  end

  it "updates an order" do
    repo = OrderRepository.new

    order = repo.find(2)
    order.customer_name = 'John Smith'
    order.date = '06/01/22'
    order.item_id = '1'

    repo.update(order)

    updated_order = repo.find(2)

    expect(updated_order.id).to eq "2"
    expect(updated_order.customer_name).to eq "John Smith"
    expect(updated_order.date).to eq '2022-06-01'
    expect(updated_order.item_id).to eq '1'
  end

  it "creates an order entry" do
    repo = OrderRepository.new

    order = Order.new
    order.customer_name = 'Alex Appleby'
    order.date = '06/01/22'
    order.item_id = '2'

    repo.create(order)

    orders = repo.all
    last_order = orders.last
    expect(last_order.customer_name).to eq 'Alex Appleby'
    expect(last_order.date).to eq '2022-06-01'
    expect(last_order.item_id).to eq '2'
  end

  it "resets test database" do
    # not testing anything
  end
end
