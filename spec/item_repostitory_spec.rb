require 'item_repository'

def reset_items_table
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

RSpec.describe ItemRepository do
  before(:each) do 
    reset_items_table
  end

  it 'returns all items' do
    repo = ItemRepository.new

    items = repo.all
    
    expect(items.length).to eq 2
    expect(items[0].id).to eq '1'
    expect(items[0].name).to eq 'Ray chair'
    expect(items[0].unit_price).to eq '499'
    expect(items[0].quantity).to eq '20'
    expect(items[0].order_id).to eq '1'
  end

  it 'creates a new item' do
    repo = ItemRepository.new

    item = Item.new
    item.name = 'Kofi coffee table'
    item.unit_price = '455'
    item.quantity = '80'
    item.order_id = '2'
    
    repo.create(item)
    
    all_items = repo.all
    expect(all_items.last.id).to eq '3'
    expect(all_items.last.name).to eq 'Kofi coffee table'
    expect(all_items.last.unit_price).to eq '455'
    expect(all_items.last.quantity).to eq '80'
    expect(all_items.last.order_id).to eq '2'
  end
end