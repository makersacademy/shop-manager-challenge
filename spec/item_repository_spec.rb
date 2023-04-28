require_relative '../lib/item_repository'

RSpec.describe ItemRepository do
  before(:each) do
    reset_stock_table
  end

  it 'reads all items' do
    repo = ItemRepository.new
    items = repo.list
    expect(items.first.id).to eq 1
    expect(items.first.name).to eq 'pens'
    expect(items.first.unit_price).to eq 2
    expect(items.first.quantity).to eq 234
    expect(items.length).to eq 4
  end

  it 'creates an item' do
    repo = ItemRepository.new
    item = double :Item, name: 'name', unit_price: 1, quantity: 1
    repo.create(item)
    items = repo.list
    expect(items.last.name).to eq item.name
    expect(items.last.unit_price).to eq item.unit_price
    expect(items.last.quantity).to eq item.quantity
  end

end
