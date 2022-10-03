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

  it 'gets all items' do
    repo = ItemRepository.new

    items = repo.all
      
    expect(items.length).to eq 2
  
    expect(items[0].id).to eq "1"
    expect(items[0].name).to eq "1950s Wedding Dresses"
    expect(items[0].price).to eq "50"
    expect(items[0].quantity).to eq "2"

    expect(items[1].id).to eq "2"
    expect(items[1].name).to eq "Band Merch"
    expect(items[1].price).to eq "100"
    expect(items[1].quantity).to eq "10"
  end

  it 'creates an item' do
    repo = ItemRepository.new

    new_item = Item.new
    new_item.name = "Rat Cage"
    new_item.price = 3
    new_item.quantity = 6

    repo.create(new_item)

    all_items = repo.all

    expect(all_items). to include(
      have_attributes(
        name: new_item.name,
        price: "3",
        quantity: "6"
      )
    )
  end
end
