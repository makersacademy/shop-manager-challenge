
require 'item_repository'

describe ItemRepository do
  def reset_tables
    seed_sql = File.read('seeds/test_seed.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_tables
  end

  it 'returns an array of all the items available in stock' do
    repo = ItemRepository.new

    items = repo.all

    expect(items.length).to eq 5
    expect(items.first.item_name).to eq '叉烧包'
    expect(items.first.unit_price).to eq '5'
    expect(items.first.quantity).to eq '10'
  end

  it 'returns an item based on id' do
    repo = ItemRepository.new

    item = repo.find(1)

    expect(item.quantity).to eq '10'
  end

  it 'creates a new item and adds it to the items table' do
    repo = ItemRepository.new

    new_item = Item.new
    new_item.item_name = 'Bowl of 汤圆'
    new_item.unit_price = 5
    new_item.quantity = 15

    repo.create(new_item)

    items = repo.all
    expect(items.length).to eq 6
    expect(items[-1].item_name).to eq 'Bowl of 汤圆'
    expect(items[-1].unit_price).to eq '5'
    expect(items[-1].quantity).to eq '15'
  end
end