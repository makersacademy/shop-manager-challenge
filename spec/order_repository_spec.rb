require_relative '../lib/order_repository'

def reset_name_table
  seed_sql = File.read('spec/seed_tables.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager' })
  connection.exec(seed_sql)
end

describe OrderRepository do
  before(:each) do 
    reset_name_table
  end

  it "returns all orders" do
    repo = OrderRepository.new

    orders = repo.all
    expect(orders.length).to eq 2
    expect(orders.first.id).to eq '1'
    expect(orders.first.item_id).to eq '1'
  end

  it "creates a new order" do
    repo = OrderRepository.new

    new_order = Order.new
    new_order.customer_name = 'Ariel'
    new_order.order_date = '27/09/2022'
    new_order.item_id = '2'

    repo.create_with_items(new_order)

    orders = repo.all
    expect(orders.length).to eq 3
    expect(orders[2].item_id).to eq '2'
  end
end
