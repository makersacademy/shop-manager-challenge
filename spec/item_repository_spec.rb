require_relative '../lib/item_repository'

def reset_items_table
  seed_sql = File.read('spec/seeds_shop.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

describe ItemRepository do
  before(:each) do 
    reset_items_table
  end

  # (your tests will go here).

  it 'returns a list of all items' do
    repo = ItemRepository.new
    item = repo.all
    expect(item.length).to eq 2
    expect(item.first.id).to eq '1'
    expect(item.first.name).to eq 'Super Shark Vacuum Cleaner'
  end

  it 'returns a single item object that matches the given id' do
    repo = ItemRepository.new
    item = repo.find(1)
    expect(item.name).to eq "Super Shark Vacuum Cleaner"
  end

  it 'can create a new item' do
    repo = ItemRepository.new
    item = Item.new
    item.name = 'Water Bottle'
    item.unit_price = 10
    item.quantity = 200
    repo.create(item)
    expect(repo.all.last.name).to eq item.name
  end

  it 'can delete an item that matches the given id' do
    repo = ItemRepository.new
    item = repo.find(1)
    repo.delete(item.id)
    expect(repo.all.length).to eq  1
    expect(repo.all.first.id).to eq '2'
  end

  it 'can update the details of an item' do
    repo = ItemRepository.new
    item = repo.find(1)
    item.quantity = 200
    repo.update(item)
    updated_item = repo.find(1)
    expect(updated_item.quantity).to eq '200'
  end

end