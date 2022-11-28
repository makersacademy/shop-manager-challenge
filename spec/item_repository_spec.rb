require 'item'
require 'item_repository'
require 'database_connection'

def reset_items_table
  seed_sql = File.read('spec/seeds_shop.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop' })
  connection.exec(seed_sql)
end

describe ItemRepository do
  before(:each) do 
    reset_items_table
  end

  # 1
  it "Get all items" do
    io = double :io
    repo = ItemRepository.new(io)


    expect(io).to receive(:puts).with("1 - Computer £500.00 20").ordered
    expect(io).to receive(:puts).with("2 - Phone £599.00 79").ordered
    expect(io).to receive(:puts).with("3 - TV £150.00 200").ordered
    expect(io).to receive(:puts).with("4 - Shoes £30.00 250").ordered
    expect(io).to receive(:puts).with("5 - Basket £5.00 150").ordered

    repo.all
  end

  # 2
  it "Get a single item" do
    repo = ItemRepository.new
    item = repo.find(3)

    expect(item.id).to eq 3
    expect(item.name).to eq 'TV'
    expect(item.unit_price).to eq 150
    expect(item.quantity).to eq 200
  end

  # 3
  it "Get all items from a single order" do
    repo = ItemRepository.new

    items = repo.find_by_order(2)

    expect(items.length).to eq 4
    expect(items[0].id).to eq 1
    expect(items[1].name).to eq 'TV'
    expect(items[2].unit_price).to eq 30
    expect(items.last.quantity).to eq 150
  end

  #  4
  it "Add an item" do
    repo = ItemRepository.new

    new_item = Item.new
    new_item.name = 'Coat'
    new_item.unit_price = 50
    new_item.quantity = 10

    repo.create(new_item)

    item = repo.find(6)

    expect(item.name).to eq 'Coat'
    expect(item.unit_price).to eq 50
  end

  # 5
  it "Update an item" do
    repo = ItemRepository.new

    update_item = repo.find(1)

    update_item.unit_price = 400
    update_item.quantity = 15

    repo.update(update_item)

    item = repo.find(1)

    expect(item.name).to eq 'Computer'
    expect(item.unit_price).to eq 400
    expect(item.quantity).to eq 15
  end

  # 6
  it "Delete an item" do
    repo = ItemRepository.new

    repo.delete(5)

    items = repo.all

    expect(items.length).to eq 4
  end
end
