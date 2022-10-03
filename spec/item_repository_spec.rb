require 'item_repository'

RSpec.describe ItemRepository do 
  
  def reset_item_table
    seed_sql = File.read('spec/seeds_items.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end

  before(:each) do 
    reset_item_table
  end 

  it "returns all items" do
    repo = ItemRepository.new

    items = repo.all
    
    expect(items.length).to eq(4)
    expect(items.first.id).to eq("1") 
    expect(items.first.name).to eq('TV')
  end

  it "creates a new item" do
    repo = ItemRepository.new

    item = Item.new
    item.name = 'Brush'
    item.unit_price = '20'
    item.quantity = '30'

    repo.create(item)

    items = repo.all

    expect(items.length).to eq(5) 

    last_item = items.last
    expect(last_item.name).to eq('Brush') 
    expect(last_item.id).to eq("5") 
  end
end