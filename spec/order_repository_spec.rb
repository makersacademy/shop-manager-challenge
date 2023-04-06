require 'order_repository'
require 'order'
require 'item'

def reset_tables
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test'})
  connection.exec(seed_sql)
end

describe OrderRepository do
  before :each do
    reset_tables
  end

  it "returns all orders with their corresponding items" do
    repo = OrderRepository.new
    result_set = repo.all
    expect(result_set.length).to eq 2
    expect(result_set.first.customer_name).to eq "Uncle Bob"
    expect(result_set.first.date).to eq '2022-09-05'
    expect(result_set.last.id).to eq 2
    expect(result_set.last.date).to eq '2023-02-22'
  end

  it "inserts an order into the DB table with #create" do
    order = Order.new
    order.customer_name, order.date = "Matz", '2023-01-01'
    item_repo = ItemRepository.new
    # Add one of each item stored in items table into the order
    item_repo.all.each do |item|
      order.items << item
    end
    order_repo = OrderRepository.new
    expect(order_repo.create(order)).to eq nil
    result_set = order_repo.all_with_items
    expect(result_set.length).to eq 3
    expect(result_set.first.customer_name).to eq "Uncle Bob"
    expect(result_set.last.customer_name).to eq "Matz"
    expect(result_set.last.date).to eq "2023-01-01"
    expect(result_set.last.items.length).to eq 3
    expect(result_set[1].date).to eq "2023-02-22"

    # Now check stock levels have been decremented for each item ordered
    items = item_repo.all
    expect(items.first.quantity).to eq 49
    expect(items.last.quantity).to eq 24
  end

  it "returns an array of formatted strings including items for each order" do
    repo = OrderRepository.new
    result = repo.print_all_with_items
    expect(result).to be_a String
    expect(result).to eq " Order #1 - Uncle Bob - 2022-09-05\n   Items:\n     Charger, £50.49\n     Magic Mouse, £30.00\n     MacBookPro, £999.99\n Order #2 - Linus Torvalds - 2023-02-22\n   Items:\n     Magic Mouse, £30.00\n"
  end

  it "Creates a new order" do

  end
end