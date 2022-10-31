require_relative '../lib/item_repository'
require_relative '../lib/database_connection'

describe ItemRepository do
  def reset_items_table
    seed_sql = File.read('spec/seeds_items.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_test' })
    connection.exec(seed_sql)
  end

  before(:each) do 
    reset_items_table
  end
  
  it "returns 3 items, check first" do
    repository = ItemRepository.new
    all_items = repository.all_item
    expect(all_items.length).to eq (3)
    expect(all_items.first.name).to eq ('Iphone 11')
    expect(all_items.first.price).to eq (1000)
    expect(all_items.first.quantity).to eq (10)
  end

  it "create new item" do
    repository = ItemRepository.new
    item = Item.new
    item.name = 'Nexus'
    item.price = '100'
    item.quantity = '30'
    repository.create_item(item)
  
    all_items = repository.all_item
    expect(all_items.size).to eq 4
  end
end
