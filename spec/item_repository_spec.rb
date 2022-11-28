require 'item_repository'
require 'pg'

def reset_items_table
  seed_sql = File.read('spec/seeds.sql')
  if ENV["PG_password"] 
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test', password: ENV["PG_password"] })
  else
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  end
  connection.exec(seed_sql)
end

describe ItemRepository do
  before(:each) do 
    reset_items_table
  end

  # (your tests will go here).
  # 1
# Get all items
  it "Get all items" do
    repo = ItemRepository.new

    items = repo.all

    expect(items.length).to eq 2

    expect(items[0].id).to eq '1'
    expect(items[0].name).to eq 'item1'
    expect(items[0].unit_price).to eq '10.0'
    expect(items[0].quantity).to eq '30'

    expect(items[1].id).to eq '2'
    expect(items[1].name).to eq 'item2'
    expect(items[1].unit_price).to eq '12.1'
    expect(items[1].quantity).to eq '22'
  end

    # 2
    # Create a new item
  it "Create a new item" do
    repo = ItemRepository.new

    item = Item.new
    item.name = 'item3'
    item.unit_price = '13.3'
    item.quantity = '40'

    repo.create(item)

    items = repo.all

    last_item = items.last
    expect(last_item.name).to eq 'item3'
    expect(last_item.unit_price).to eq '13.3'
    expect(last_item.quantity).to eq '40'
  end
end
