require 'item_repo'

RSpec.describe ItemRepo do
  before(:each) do
    reset_tables
  end

  it "returns a list of all items in the items table" do
    repo = ItemRepo.new

    items = repo.all
    expect(items.length).to eq 4
    expect(items.first.name).to eq 'Star Wars Jedi: Survivor'
    expect(items.first.unit_price).to eq '60'
    expect(items.first.quantity).to eq '420'

    expect(items.last.name).to eq 'Metroid Prime'
    expect(items.last.unit_price).to eq '3'
    expect(items.last.quantity).to eq '12'
  end

  it "can create a new item and add it to the items table" do
    repo = ItemRepo.new

    item = double :item, name: 'fake_game', unit_price: 1, quantity: 1
    
    repo.create_item(item)
    items = repo.all
    
    expect(items.length).to eq 5
  end

  it "returns an array of items assigned to order 1" do
    repo = ItemRepo.new

    items = repo.find_items_by_order(1)
    expect(items.length).to eq 2
    expect(items.first.name).to eq 'Star Wars Jedi: Survivor'
    expect(items.last.name).to eq 'Dead Space'
  end
end
