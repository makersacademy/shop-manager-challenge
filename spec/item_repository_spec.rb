require 'item_repository'

RSpec.describe ItemRepository do
  def reset_items_table
    seed_sql = File.read('spec/seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end

  before(:each) do 
    reset_items_table
  end

  it 'returns the items list' do
    repo = ItemRepository.new

    items = repo.all   
    expect(items.length).to eq 2
    expect(items[0].id).to eq 1
    expect(items[0].name).to eq 'Repo Chocolate'
    expect(items[0].unit_price).to eq 4
    expect(items[0].quantity).to eq 97

    expect(items[1].id).to eq 2
    expect(items[1].name).to eq 'Class Popcorn'
    expect(items[1].unit_price).to eq 2
    expect(items[1].quantity).to eq 68
  end

  it 'returns a single item' do 
    repo = ItemRepository.new
    item = repo.find(2)
    expect(item.id).to eq 2
    expect(item.name).to eq 'Class Popcorn'
    expect(item.unit_price).to eq 2
    expect(item.quantity).to eq 68
  end

  it 'creates a new item' do
    repo = ItemRepository.new
    item = Item.new
    item.name = "Truncate Truffles"
    item.unit_price = 40
    item.quantity = 16

    repo.create(item)
    items = repo.all
    last_item = items.last
    expect(last_item.name).to eq "Truncate Truffles"
    expect(last_item.unit_price).to eq  40
    expect(last_item.quantity).to eq  16
  end
end