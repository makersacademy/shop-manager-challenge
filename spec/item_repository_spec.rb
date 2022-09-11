require 'item_repository'
require 'item'

  def reset_table
    seed_sql = File.read('spec/table_seed.sql')
    connection = PG.connect({host: '127.0.0.1', dbname: 'shop_manager'})
    connection.exec(seed_sql)
  end

describe ItemRepository do
  before(:each) do
    reset_table
  end
  
  it "should return all items" do
    shop = ItemRepository.new
    item_list = shop.all
    expect(item_list.length).to eq 10
  end
  it "should create an item" do
    shop = ItemRepository.new
    item = double :item, name: "test", price: 1.00, quantity: 1
    shop.create(item)
    expect(shop.all.length).to eq 11
    expect(shop.all.last.name).to eq "test"
  end
  it "should return an item by id" do
    shop = ItemRepository.new
    item = shop.find(1)
    expect(item.name).to eq "Bread"
    expect(item.price).to eq 1.50
    expect(item.quantity).to eq 10
    expect(item.orders.length).to eq 1
  end
  it "should return all items containing a specified order date" do
    shop = ItemRepository.new
    item = shop.find_with_order("2022-01-01")
    expect(item.length).to eq 3
    expect(item.first.name).to eq "Bread"
  end

end