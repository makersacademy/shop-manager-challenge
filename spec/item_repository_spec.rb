require 'item_repository'

def reset_item_table
  seed_sql = File.read('spec/seeds_items_orders_2.sql')
  connection = PG.connect({ host: '127.0.0.1',dbname: 'items_orders_test_2' })
  connection.exec(seed_sql)
end

describe ItemRepository do
  before(:each) do
    reset_item_table
  end

  it 'returns all the shop item objects' do
    repo = ItemRepository.new
    items = repo.all

    expect(items.length).to eq 5
    expect(items.first.id).to eq 1
    expect(items.first.name).to eq 'Apple'  
    expect(items.first.price).to eq "$2.00"
    expect(items.first.quantity).to eq 10
    expect(items.last.id).to eq 5
    expect(items.last.name).to eq 'Banana'  
  end

  it 'creates a new item to the list of item objects' do
    item = double :item, name: 'Kiwi', price: 5, quantity: 20
    repo = ItemRepository.new

    repo.create(item)

    items = repo.all

    expect(items.length).to eq 6 
    expect(items.last.id).to eq 6
    expect(items.last.name).to eq 'Kiwi' 
    expect(items.last.price).to eq '$5.00'
    expect(items.last.quantity).to eq 20
  end

  it 'raises an error when trying to create an exisiting item' do
    item = double :item, name: 'Kiwi', price: 5, quantity: 20
    repo = ItemRepository.new

    repo.create(item)
    expect { repo.create(item) }.to raise_error 'Item is already created'
  end

  it 'raises an error when trying to create item with invalid information' do
    item_1 = double :item, name: '', price: 5, quantity: 20
    item_2 = double :item, name: 'Chocolate', price: 0, quantity: 20
    item_3 = double :item, name: 'Rice', price: 10, quantity: 0
    repo = ItemRepository.new

    expect { repo.create(item_1) }.to raise_error 'Invalid inputs'
    expect { repo.create(item_2) }.to raise_error 'Invalid inputs'
    expect { repo.create(item_3) }.to raise_error 'Invalid inputs'
  end
end 
