require 'item_repository'
require 'item'

def reset_tables
  seed_sql = File.read('spec/seeds_tables.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

describe ItemRepository do
  before(:each) do 
    reset_tables
  end

  it "returns all items" do

    # 1
    # Get all items

    repo = ItemRepository.new

    items = repo.all

    expect(items.length ).to eq 4

    expect(items[0].id ).to eq '1'
    expect(items[0].name ).to eq 'Tartan Paint'
    expect(items[0].price ).to eq '6.75'
    expect(items[0].quantity).to eq '30'
    expect(items[0].orders).to eq ['3']

    expect(items[2].id ).to eq '3'
    expect(items[2].name ).to eq 'Rocking Horse Droppings'
    expect(items[2].price ).to eq '45.95'
    expect(items[2].quantity).to eq '1'
    expect(items[2].orders).to eq ['1', '2', '3']
  end

  it "creates an item" do

    # 2
    # Create an item

    repo = ItemRepository.new

    item = Item.new
    item.name = 'Fairy Dust'
    item.price = 200.85
    item.quantity = 0
    item.orders = []

    repo.create(item)

    result = repo.all.last

    expect(result.id).to eq '5'
    expect(result.name).to eq 'Fairy Dust'
    expect(result.price).to eq '200.85'
    expect(result.quantity).to eq '0'
    expect(result.orders).to eq []
  end
end