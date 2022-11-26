require "item_repository"
require "item"

def reset_items_table
  seed_sql = File.read('spec/seeds_items.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

describe ItemRepository do
  before(:each) do 
    reset_items_table
  end

  it "Gets all items" do
    item_repo = ItemRepository.new
    items = item_repo.all

    expect(items.length).to eq 4

    expect(items.first.id).to eq 1
    expect(items.first.name).to eq "Hammer"
    expect(items.first.unit_price).to eq 5.99
    expect(items.first.quantity).to eq 20

    expect(items.last.id).to eq 4
    expect(items.last.name).to eq "Drill"
    expect(items.last.unit_price).to eq 49.99
    expect(items.last.quantity).to eq 7
  end

  it "Create adds an item to the database" do
    item_repo = ItemRepository.new

    new_item = Item.new
    new_item.id = 5
    new_item.name = "Saw"
    new_item.unit_price = 6.50
    new_item.quantity = 15
    item_repo.create(new_item)

    expect(item_repo.all).to include(have_attributes(
      id: 5,
      name: "Saw",
      unit_price: 6.50,
      quantity: 15,
    ))
  end

  it "Create fails when trying to add an item with an id already being used" do
    item_repo = ItemRepository.new
    
    new_item = Item.new
    new_item.id = 3
    new_item.name = "Saw"
    new_item.unit_price = 6.50
    new_item.quantity = 15
    
    expect { item_repo.create(new_item) }.to raise_error PG::UniqueViolation
  end

  it "#find_with_order successfully fetches all items associated with an order" do
    item_repo = ItemRepository.new
    items = item_repo.find_with_order(1)

    expect(items.length).to eq 3

    expect(items[0].id).to eq 1
    expect(items[0].name).to eq "Hammer"

    expect(items[1].id).to eq 3
    expect(items[1].name).to eq "Nails (0.5kg)"

    expect(items[2].id).to eq 4
    expect(items[2].name).to eq "Drill"
  end

  it "#find_with_order fails when given an order id that doesn't exist" do
    item_repo = ItemRepository.new
    error_message = "An order with id 10 doesn't exist"
    expect { item_repo.find_with_order(10) }.to raise_error error_message
  end
end