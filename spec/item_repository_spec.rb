require 'item_repository'
require 'item'

def reset_items_table
  seed_sql = File.read('spec/seeds_items.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

describe ItemRepository do
  before(:each) do 
    reset_items_table
  end

  it 'gets all items' do
    repo = ItemRepository.new

    items = repo.all

    expect(items.length).to eq  2

    expect(items[0].id).to eq  1
    expect(items[0].name).to eq  'Cookie Dough'
    expect(items[0].unit_price).to eq  2.99
    expect(items[0].quantity).to eq 25

    expect(items[1].id).to eq  2
    expect(items[1].name).to eq  'Ice Cream'
    expect(items[1].unit_price).to eq  1.99
    expect(items[1].quantity).to eq 50
        
  end

  it 'returns one item' do
    repo = ItemRepository.new

    item = repo.find(1)

    expect(item.id).to eq  1
    expect(item.name).to eq  'Cookie Dough'
    expect(item.unit_price).to eq  2.99
    expect(item.quantity).to eq 25

  end

  it 'creates new item' do
    item = Item.new
    item.name = 'Chocolate Chip Cookie'
    item.unit_price =  2.25
    item.quantity = 35

    repo = ItemRepository.new

    repo.create(item)

    last_item = repo.all.last

    expect(last_item.id).to eq  3
    expect(last_item.name).to eq  'Chocolate Chip Cookie'
    expect(last_item.unit_price).to eq  2.25
    expect(last_item.quantity).to eq 35

  end
end