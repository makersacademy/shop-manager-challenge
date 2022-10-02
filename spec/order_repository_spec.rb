require_relative "../lib/order_repository.rb"

RSpec.describe OrderRepository do

  def reset_orders_table
    seed_sql = File.read('spec/orders_items_seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end
  
  before(:each) do 
    reset_orders_table
  end

  it "returns all orders in the directory" do
    repo = OrderRepository.new

    orders = repo.all
    expect(orders.length).to eq 3
    expect(orders.first.id).to eq 1
    expect(orders[0].customer_name).to eq 'Joe Bloggs'
    expect(orders[0].order_date).to eq '2011-10-02'
  end

  it "creates a new stock entry" do
    repo = ItemRepository.new
    new_item = Item.new

    new_item.item_name = "Logitech Mouse"
    new_item.price = 45
    new_item.quantity = 8

    repo.create(new_item)
    all_items = repo.all
    expect(all_items).to include(
    have_attributes(
    name: new_item.name,
    price: new_item.price,
    quantity: new_item.quantity,
    )
    )
  end
end