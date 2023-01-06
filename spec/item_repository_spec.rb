require_relative '../lib/item_repository'

RSpec.describe ItemRepository do
  def reset_tables
    seed_sql = File.read('spec/seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_tables
  end

  it 'provides a list of all items' do

    repo = ItemRepository.new
    
    items = repo.all
    expect(items.length).to eq 6
    expect(items[0].name).to eq 'Apple'
    expect(items[1].price).to eq '$1.00'
    expect(items[3].name).to eq 'Crisp Pack'
    expect(items[2].quantity).to eq '50'
  end

  it 'creates a new item and adds to the item repository' do
    repo = ItemRepository.new
    items = repo.all

    expect(items.length).to eq 6
    expect(items.last.name).to eq 'Chicken Breast'

    new_item = Item.new
    new_item.name = 'Champagne'
    new_item.price = '10'
    new_item.quantity = '25'
    repo.create(new_item)
    updated_items = repo.all

    expect(updated_items.length).to eq 7
    expect(updated_items.last.name).to eq 'Champagne'
  end
end
