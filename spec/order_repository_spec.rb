require_relative '../lib/order_repository'

def reset_items_orders_table
  seed_sql = File.read('spec/seeds_items_orders.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

RSpec.describe OrderRepository do

  before(:each) do 
    reset_items_orders_table
  end

  it "returns all orders" do
    repo = OrderRepository.new

    orders = repo.all
    
    expect(orders.length).to eq 6
    expect(orders[0].id).to eq '1'
    expect(orders[0].customer).to eq 'Andy'
    expect(orders[0].date).to eq '2022-01-01'
    expect(orders[0].item_id).to eq '1'
    expect(orders[1].id).to eq '1'
    expect(orders[1].customer).to eq 'Andy'
    expect(orders[1].date).to eq '2022-01-01'
    expect(orders[1].item_id).to eq '2'
  end

  it "adds an order" do
    repo = OrderRepository.new

    info = Order.new
    info.customer = 'Dan'
    info.date = '2022-04-04'
    items = [1,3]

    repo.add(info, items)

    orders = repo.all

    expect(orders.length).to eq 8
    expect(orders[-1].id).to eq '4'
    expect(orders[-1].customer).to eq 'Dan'
    expect(orders[-1].date).to eq '2022-04-04'
    expect(orders[-1].item_id).to eq '3'
  end

end