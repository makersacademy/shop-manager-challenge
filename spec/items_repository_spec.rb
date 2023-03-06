require 'item_model'
require 'items_repository'

RSpec.describe ItemsRepository do
  def reset_items_table
    seed_sql = File.read('spec/seeds_shop_manager_test.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end
  
  before(:each) do 
    reset_items_table
  end
  
  it "Gets all items." do
    repo = ItemsRepository.new
    items = repo.all
    expect(items.length).to eq 5
    expect(items[0].item_name).to eq 'Item1'
    expect(items[0].item_price).to eq 1
    expect(items[0].item_quantity).to eq 5

    expect(items.last.id).to eq 5
    expect(items.last.item_name).to eq 'Item5'
    expect(items.last.item_price).to eq 8
    expect(items.last.item_quantity).to eq 70
  end

  it 'Gets a single item.' do
    repo = ItemsRepository.new
    item = repo.find(1)
    expect(item.id).to eq 1
    expect(item.item_name).to eq 'Item1'
    expect(item.item_quantity).to eq 5
  end

  it 'Creates an item' do
    repo = ItemsRepository.new
    items = repo.all
    item = Item.new
    item.item_name = 'Item6'
    item.item_price = 3
    item.item_quantity = 50
    repo.create(item)
    items = repo.all
    expect(items.length).to eq 6
  end

  it 'Updates an item.' do
    repo = ItemsRepository.new
    item = repo.find(3)
    item.item_price = 6
    repo.update(item)
    expect(item.item_price).to eq 6
  end

  it 'Deletes an item.' do
    repo = ItemsRepository.new
    items = repo.all
    
    new_item1 = Item.new
    new_item1.item_name = 'Item6'
    new_item1.item_price = 3
    new_item1.item_quantity = 50
    repo.create(new_item1)
    
    new_item2 = Item.new
    new_item2.item_name = 'Item7'
    new_item2.item_price = 16
    new_item2.item_quantity = 50
    repo.create(new_item2)

    repo.delete(6)
    items = repo.all
    expect(items.length).to eq 6
  end
end
