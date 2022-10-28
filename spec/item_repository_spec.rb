require 'item_repository'

RSpec.describe ItemRepository do

  def reset_shop_table
    seed_sql = File.read('spec/seeds_shop.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_challenge_test' })
    connection.exec(seed_sql)
  end

  before(:each) do 
    reset_shop_table
  end

  it 'returns the list of all the items' do
    repo = ItemRepository.new

    items = repo.all 

    expect(items.length).to eq 5
    expect(items.first.id).to eq '1'
    expect(items.first.item_name).to eq "Sherbet Lemons"
  end

  it 'creates a new item' do
    repo = ItemRepository.new

    new_item = Item.new
    new_item.item_name = 'Maoam'
    new_item.item_price = '3'
    new_item.item_quantity = '14'

    repo.create(new_item)

    all_items = repo.all

    expect(all_items).to include (
      have_attributes(
        item_name: new_item.item_name,
        item_price: new_item.item_price,
        item_quantity: new_item.item_quantity
      ))
  end
end
