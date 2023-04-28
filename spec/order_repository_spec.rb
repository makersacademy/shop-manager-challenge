require 'order_repository'

describe OrderRepository do
  def reset_orders_table
    seed_sql = File.read('spec/seeds_shop_manager_test.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end

  before(:each) do 
    reset_orders_table
  end

  it "returns a list of all orders" do
    repo = OrderRepository.new

    orders = repo.all

    expect(orders.length).to eq 2
    expect(orders.first.customer_name).to eq 'Sarah'
    expect(orders.first.date_placed).to eq '2023-04-06 12:57:03'
    expect(orders.first.shop_item_id).to eq '1'
  end
end
