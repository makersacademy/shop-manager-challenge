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
end