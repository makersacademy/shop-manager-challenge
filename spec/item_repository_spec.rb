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

  it 'returns the first item' do
    repo = ItemRepository.new

    item = repo.find(1)

    expect(item.id).to eq("1") 
    expect(item.name).to eq('TV') 
    expect(item.quantity).to eq('10') 
  end
  it 'returns the second item' do
    repo = ItemRepository.new

    item = repo.find(2)

    expect(item.id).to eq("2") 
    expect(item.name).to eq('Microwave') 
    expect(item.unit_price).to eq('80') 
    expect(item.quantity).to eq('50') 
  end
  it "updates the quantity of the item" do
    repo = ItemRepository.new
    item = repo.find(1)

    item.quantity = (item.quantity.to_i - 1)

    repo.update(item)

    updated_item = repo.find(1)

    expect(updated_item.name).to eq('TV') 
    expect(updated_item.quantity).to eq ('9') 
  end
end