require 'item_repository'

RSpec.describe ItemRepository do
  def reset_items_table
    seed_sql = File.read('spec/seeds_items.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
    end

  before(:each) do 
    reset_items_table
  end

  it 'returns a list of ALL' do
    repo = ItemRepository.new
    
    items = repo.all
    expect(items.length).to eq (2)
    expect(items.first.name).to eq ('Henry Vacuum Hoover')
    expect(items.first.unit_price).to eq (50)
    expect(items.first.quantity).to eq (20)
  end


  it 'creates a new item -Pancake Maker-' do
    repo = ItemRepository.new

    new_item = Item.new
    new_item.name = 'Pancake Maker'
    new_item.unit_price = 50
    new_item.quantity = 10

    repo.create(new_item)

    all_items = repo.all
    expect(all_items).to include(
      have_attributes(
        name: new_item.name, 
        unit_price: 50, 
        quantity: 10 
        )
    )
  end
end