require 'item'
require 'item_repository'
require 'database_connection'

RSpec.describe ItemRepository do

  def reset_shop_manager_tables
    seed_sql = File.read('spec/seeds_shop_manager.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_shop_manager_tables
  end

  it "returns all items" do
    repo = ItemRepository.new
    items = repo.all
    expect(items.length).to eq(5)
    expect(items.first.id).to eq(1)
    expect(items.first.item_name).to eq('paint set')
    expect(items.first.quantity).to eq(8)
  end
  it "returns the single item  " do 
    repo = ItemRepository.new
    item = repo.find(2)
    expect(item.id).to eq(2)
    expect(item.item_name).to eq('brush set')
    expect(item.quantity).to eq(24)
  end
  it "updates item name" do 
    repo = ItemRepository.new
    items = repo.update_item_name('clay', 1)
    expect(items.length).to eq(1)
    expect(items.first.id).to eq(1)
    expect(items.first.item_name).to eq('clay')
 
  end
  it "updates item quantity" do 
    repo = ItemRepository.new
    items = repo.update_item_quantity(50, 1)
    expect(items.length).to eq(1)
    expect(items.first.id).to eq(1)
    expect(items.first.quantity).to eq(50)
        
  end
  it "updates unit price" do 
    repo = ItemRepository.new
    items = repo.update_unit_price(20, 1)
    expect(items.length).to eq(1)
    expect(items.first.id).to eq(1)
    expect(items.first.unit_price).to eq(20)
  end
  
  it "creates items" do 
  
        item = Item.new()
        repo = ItemRepository.new
        item.item_name = 'apron'
        item.quantity = 16
        item.unit_price = 14
        repo.create(item)
        expect(repo.all[-1].item_name).to eq('apron')
  
  end
end
