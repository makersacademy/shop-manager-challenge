require 'item_repository'

def reset_item_table
  seed_sql = File.read('spec/seeds_items_orders.sql')
  connection = PG.connect({host:'127.0.0.1',dbname:'items_orders_test'})
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
    item = double :item, name:'Kiwi', price:'$5.00', quantity:20
    repo = ItemRepository.new

    repo.create(item)

    items = repo.all

    expect(items.length).to eq 6 
    expect(items.last.id).to eq 6
    expect(items.last.name).to eq 'Kiwi' 
    expect(items.last.price).to eq '$5.00'
    expect(items.last.quantity).to eq 20

  end
end 
