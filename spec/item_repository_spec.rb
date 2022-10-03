require_relative '../lib/item_repository.rb'

def reset_items_table
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

describe ItemRepository do
  before(:each) do 
    reset_items_table
  end

  it 'lists all shop items' do
    repo = ItemRepository.new
    items = repo.all
    expect(items.length).to eq 4
    expect(items[0].name).to eq 'Bread'
    expect(items[0].price).to eq '1.00'
    expect(items[0].quantity).to eq '10'
  end

  it 'finds an item' do
    repo = ItemRepository.new 
    item = repo.find(1)
    expect(item.name).to eq 'Bread'
    expect(item.price).to eq '1.00'
    expect(item.quantity).to eq '10'
  end  
  
  it 'creates a new item' do
    repo = ItemRepository.new
    new_item = Item.new
    new_item.name = 'Biscuits'
    new_item.price = '0.50'
    new_item.quantity = '5'
    
    repo.create(new_item)  
    items = repo.all
    last_item = items.last
    expect(last_item.name).to eq 'Biscuits'
    expect(last_item.price).to eq '0.50'
    expect(last_item.quantity).to eq '5'
  end
  
  it 'updates an item' do
    repo = ItemRepository.new 
    item = repo.find(1)
    repo.update(item.quantity.to_i)  
    items = repo.all
    expect(items[0].quantity).to eq '9'
  end
end