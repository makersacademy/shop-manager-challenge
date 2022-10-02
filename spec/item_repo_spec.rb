require_relative "../lib/item"
require_relative "../lib/item_repository"

RSpec.describe ItemRepository do
  def reset_items_table
    seed_sql = File.read('spec/shop_manager_seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end
  
  before(:each) do 
    reset_items_table
  end

  it "Shows all items" do 
    repo = ItemRepository.new
    items = repo.all
    expect(items.length).to eq 10
    expect(items[3].item_name).to eq 'Spinach Gnocchi' 
    expect(items[3].unit_price).to eq '1'
    expect(items[3].quantity).to eq '3' 
    expect(items[3].order_id).to eq '3'
  end
    
  it "Shows all items" do 
    repo = ItemRepository.new
    items = repo.all
    expect(items.length).to eq 10
    expect(items[6].item_name).to eq 'E-Cover Laundry Detergent' 
    expect(items[6].unit_price).to eq '3'
    expect(items[6].quantity).to eq '8' 
    expect(items[6].order_id).to eq '3'
  end

  it "creates a new item" do
    repo = ItemRepository.new
    item = Item.new
    item.item_name = 'Kuchella' 
    item.unit_price = 2 
    item.quantity = 50 
    item.order_id = 3
    repo.create(item)
    items = repo.all
    expect(items.length).to eq 11
    expect(items[10].item_name).to eq 'Kuchella'  
    expect(items[10].unit_price).to eq '2'
    expect(items[10].quantity).to eq '50' 
    expect(items[10].order_id).to eq '3'
  end
end
