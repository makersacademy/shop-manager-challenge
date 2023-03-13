# require "item"
require "item_repository"
require "pg"

def reset_items_table
  seed_sql = File.read('spec/seeds_items.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

describe ItemRepository do
  before(:each) do 
    reset_items_table
  end

  it "gets all items" do
    repo = ItemRepository.new
    items = repo.all

    expect(items.length).to eq(4)
    expect(items.first.name).to eq('Chair')
    expect(items.first.price).to eq(50)
    expect(items.first.quantity).to eq(7)

  end

  it "gets a single item" do
    repo = ItemRepository.new
    item = repo.find(1)

    expect(item.name).to eq('Chair')
    expect(item.price).to eq(50)
    expect(item.quantity).to eq(7)
  end

  it "creates an item" do
    repo = ItemRepository.new

    item = Item.new
    item.name = 'Sofa'
    item.price = 300
    item.quantity = 11

    repo.create(item)

    items = repo.all
    expect(items.length).to eq 5
    expect(items.last.name).to eq('Sofa')
  end
end
  