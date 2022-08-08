require 'order_repository'

def reset_table
  seed_sql = File.read('spec/seeds_shop_manager.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

describe OrderRepository do
  before(:each) do 
    reset_table
  end

  it "gets all items" do
    order_repository = OrderRepository.new
    orders = order_repository.all
    expect(orders.length).to eq 6
    expect(orders[0].id).to eq "1"
    expect(orders[0].customer_name).to eq "David Green"
    expect(orders[0].date_ordered).to eq "2022-08-05"
    expect(orders[0].item_id).to eq "3"
    expect(orders[5].id).to eq "6"
    expect(orders[5].customer_name).to eq "Barry Clark"
    expect(orders[5].date_ordered).to eq "2022-08-01"
    expect(orders[5].item_id).to eq "3"
  end

  it "creates new items" do
    order_repository = OrderRepository.new
    order = Order.new
    order.customer_name = "Michael John"
    order.date_ordered = "2022-08-05"
    order.item_id = "3"
    order_repository.create(order)
    orders = order_repository.all
    expect(orders.length).to eq 7
    expect(orders[6].id).to eq "7"
    expect(orders[6].customer_name).to eq "Michael John"
    expect(orders[6].date_ordered).to eq "2022-08-05"
    expect(orders[6].item_id).to eq "3"
  end
end
