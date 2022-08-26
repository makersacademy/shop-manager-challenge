require 'item_repository'
require 'order_repository'

def reset_tables
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'orders_test' })
  connection.exec(seed_sql)
end

describe ItemRepository do
  before(:each) do 
    reset_tables
  end


  it "creates a new shop item record" do
    repository = ItemRepository.new
    item = Item.new("Chair", '15', '4')

    repository.create(item)

    all_items = repository.all
    last = all_items.last
    expect(last.name).to eq 'Chair'
    expect(last.unit_price).to eq 15
    expect(last.quantity).to eq 4
  end


  it "creates a new shop order record" do
    repository = OrderRepository.new
    order = Order.new('Pepsi', '2012-12-12')

    repository.create(order)
    
    all_orders = repository.all
    last = all_orders.last
    expect(last.customer_name).to eq 'Pepsi'
    expect(last.date).to eq '2012-12-12'
  end
end