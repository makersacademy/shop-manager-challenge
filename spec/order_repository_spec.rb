require 'order_repository'
require 'order'

  def reset_table
    seed_sql = File.read('spec/table_seed.sql')
    connection = PG.connect({host: '127.0.0.1', dbname: 'shop_manager'})
    connection.exec(seed_sql)
  end

describe OrderRepository do
  before(:each) do
    reset_table
  end
  it "should return all orders" do
    shop = OrderRepository.new
    order_list = shop.all
    expect(order_list.length).to eq 3
  end
  it "should create an order" do
    shop = OrderRepository.new
    order = double :order, customer_name: "test", order_date: "2022-01-01"
    shop.create(order)
    expect(shop.all.length).to eq 4
    expect(shop.all.last.customer_name).to eq "test"
    expect(shop.all.last.order_date).to eq "2022-01-01"
  end
  it "should return an order by id" do
    shop = OrderRepository.new
    order = shop.find(1)
    expect(order.customer_name).to eq "Thomas Mannion"
    expect(order.order_date).to eq "2022-01-01"
    expect(order.items.length).to eq 3
  end
  it "should return an orders containing a specified item" do
    shop = OrderRepository.new
    order = shop.find_with_item("Bread")
    expect(order.length).to eq 1
    expect(order.first.customer_name).to eq "Thomas Mannion"
  end
end