require "item_repository"
require "item"

describe ItemRepository do
  
  def reset_items_table
    seed_sql = File.read('spec/seeds_shop_manager.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop' })
    connection.exec(seed_sql)
  end
  
  before(:each) do 
    reset_items_table
  end

  it "returns a list of the items in the shop" do
    repo = ItemRepository.new
    items = repo.all
    
    expect(items.length).to eq 4
    expect(items[0].name).to eq "T-shirts"
    expect(items[1].name).to eq "Jumpers"
    expect(items[2].unit_price).to eq '100'
    expect(items[3].quantity).to eq '20'
  end

  it "adds a new item to the database" do
    new_item = Item.new
    new_item.name = "Jacket"
    new_item.unit_price = 150
    new_item.quantity = 15
    repo = ItemRepository.new
    repo.create(new_item)
    items = repo.all
    
    expect(items.length).to eq 5
    expect(items.last.id).to eq '5'
    expect(items.last.name).to eq "Jacket"
    expect(items.last.unit_price).to eq '150'
    expect(items.last.quantity).to eq '15'
  end

end
