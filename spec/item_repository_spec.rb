require 'item_repository'

def reset_items_table
  seed_sql = File.read('spec/seeds_items.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

describe ItemRepository do
  before(:each) do 
    reset_items_table
  end

  it 'Returns all (2) items' do
    repo = ItemRepository.new

    items = repo.all

    expect(items.length).to eq 2

    expect(items[0].id).to eq '1'
    expect(items[0].name).to eq 'Correction tape'
    expect(items[0].unit_price).to eq '4.95'
    expect(items[0].quantity).to eq '26'

    expect(items[1].id).to eq '2'
    expect(items[1].name).to eq 'Cute eraser'
    expect(items[1].unit_price).to eq '3.25'
    expect(items[1].quantity).to eq '14'
  end

  it 'Finds item by id' do
    repo = ItemRepository.new

    item = repo.find(1)

    expect(item.id).to eq '1'
    expect(item.name).to eq 'Correction tape'
    expect(item.unit_price).to eq '4.95'
    expect(item.quantity).to eq '26'
  end

  it 'Creates a new item' do
    new_item = Item.new
    new_item.name = 'Protractor'
    new_item.unit_price = '9.99'
    new_item.quantity = '33'
    repo = ItemRepository.new
    repo.create(new_item)
    items = repo.all

    expect(items[-1].name).to eq 'Protractor'
    expect(items[-1].unit_price).to eq '9.99'
    expect(items[-1].quantity).to eq '33'
  end
end
