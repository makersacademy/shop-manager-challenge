require_relative "../lib/order_repository.rb"

def reset_tables
  seed_sql = File.read('spec/orders_items_seeds.sql')
  connection = PG.connect({ host: ENV['HOST'], dbname: 'shop_test', user: 'postgres', password: ENV['PASSWORD'] })
  connection.exec(seed_sql)
end

RSpec.describe OrderRepository do
  before(:each) do
    reset_tables
  end

  let(:repo) {OrderRepository.new}

  it "Returns a list of Order objects" do 
    orders = repo.all
    expect(orders.length).to eq 3
    expect(orders.first.id).to eq "1"
  end

  it "Creates a new Order object linked to item" do 
    order = Order.new
    order.customer_name = 'Sasha'
    order.order_date = '2022-10-01'
    item_id = 2
    repo.create(order)
    order_id = repo.all.last.id
    repo.link_to_item(order_id, item_id)
    items = repo.find_by_order(order_id).items
    expect(items.first.id).to eq "2"
  end

  it "Returns an Order object with array of linked items" do
    order = repo.find_by_order(1)
    items = order.items
    expect(order.customer_name).to eq "Kate"
    expect(items.length).to eq 2
  end
end