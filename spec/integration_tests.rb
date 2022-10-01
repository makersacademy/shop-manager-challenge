require 'item_repository'
require 'order_repository'
require 'item'

def reset_items_table
  seed_sql = File.read('spec/seeds_shop_manager.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

describe ItemRepository do
  before(:each) do 
    reset_items_table
  end


  it "Creates a new shop item" do
    repository = ItemRepository.new
    item = Item.new
    item.name = 'Bread'
    item.unit_price = '$1.50'
    item.quantity = 20

    repository.create(item)

    all_items = repository.all
    last_item = all_items.last
    expect(last_item.name).to eq 'Bread'
    expect(last_item.unit_price).to eq '$1.50'
    expect(last_item.quantity).to eq 20
  end


  it "Creates a new shop order" do
    repository = OrderRepository.new
    order = Order.new
    order.customer_name = 'Maya'
    order.date = '2022-08-07 16:00:00'
    order.item_id = 3
    repository.create(order)
    
    all_orders = repository.all
    last_order = all_orders.last
    expect(last_order.customer_name).to eq 'Maya'
    expect(last_order.date).to eq '2022-08-07 16:00:00'
    expect(last_order.order_id).to eq 3
  end
end