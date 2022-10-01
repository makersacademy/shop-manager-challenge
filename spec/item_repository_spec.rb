require 'item_repository'
require 'database_connection'

describe ItemRepository do
  def reset_items_table
    seed_sql = File.read('spec/seeds_items.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'items_orders_test' })
    connection.exec(seed_sql)
  end

  before(:each) do 
    reset_items_table
  end
  
  it "returns all item records" do
    repository = ItemRepository.new
    all_items = repository.all_item
    
    expect(all_items.length).to eq (2)
    expect(all_items.first.name).to eq ('Tower Air Fryer')
    expect(all_items.first.unit_price).to eq (55)
    expect(all_items.first.quantity).to eq (10)
  end

  xit "creates an item record" do
    repository = ItemRepository.new
    item = Item.new
    item.name = 'Nescafe capsule coffee machine'
    item.unit_price = 78
    item.quantity = 3
  
    repository.create(item)
  
    all_items = repository.all
    expect(all_itmes).to include(
      have_attributes(
        name: 'Nescate capsule coffee machine'
        unit_price: 78
        quantity: 3
      )
    )
  end
end