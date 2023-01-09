require 'order_repository'

RSpec.describe OrderRepository do
  def reset_orders_table
    seed_sql = File.read('spec/orders_seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end

  before(:each) do 
    reset_orders_table
  end

  it "returns the lists of the records" do
    repo = OrderRepository.new

    orders = repo.all

    expect(orders.length).to eq 4

    expect(orders.first.id).to eq "1"
    expect(orders.first.customer_name).to eq "Marta Bianchini"
    expect(orders.first.date).to eq "2023-09-01"
  end

  it "creates a new order" do
    repo = OrderRepository.new

    new_order = Order.new
    new_order.customer_name = 'Mark Brown'
    new_order.date = '9/01/2023'
    new_order.item_id = '1'

    repo.create(new_order)

    orders = repo.all

    latest_order = orders.last
    expect(latest_order.id).to eq "5"
    expect(latest_order.customer_name).to eq "Mark Brown"
    expect(latest_order.date).to eq "2023-09-01"
    expect(latest_order.item_id).to eq "1"
  end
end
