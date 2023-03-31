require 'item'
require 'item_repository'
require 'order'

def reset_tables
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'items_orders_test' })
  connection.exec(seed_sql)
end

describe ItemRepository do
  before(:each) do 
    reset_tables
  end

  it "finds all items" do
    repo = ItemRepository.new

    items = repo.all

    expect(items.length).to eq 7

    expect(items.first.id).to eq 1
    expect(items.first.name).to eq 'Pizza'
    expect(items.first.unit_price).to eq 9.99
    expect(items.first.quantity).to eq 100
  end
  
  it "creates an item" do
    repo = ItemRepository.new

    item = Item.new
    item.name = 'Doughnut'
    item.unit_price = 3.99
    item.quantity = 250

    repo.create(item)

    created_item = repo.all.last

    expect(created_item.id).to eq 8
    expect(created_item.name).to eq 'Doughnut'
    expect(created_item.unit_price).to eq 3.99
    expect(created_item.quantity).to eq 250
  end

  it "finds items associated to an order" do
    repo = ItemRepository.new

    items = repo.find_by_order(1)

    expect(items.length).to eq 4
    expect(items.first.id).to eq 1
    expect(items.first.name).to eq 'Pizza'
    expect(items.first.unit_price).to eq 9.99
    expect(items.first.quantity).to eq 100
  end
end