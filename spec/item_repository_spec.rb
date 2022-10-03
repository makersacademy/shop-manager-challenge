require 'item_repository'

def reset_items_table
  seed_sql = File.read('spec/seeds_shop_manager.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

describe ItemRepository do
  before(:each) do 
    reset_items_table
  end

  it "Gets a list of all shop items" do

    repository = ItemRepository.new
    items = repository.all

    expect(items.length).to eq 3
    expect(items[0].id).to eq 1
    expect(items[0].name).to eq 'Bananas'
    expect(items[0].unit_price).to eq '$1.00'
    expect(items[0].quantity).to eq 5

    expect(items[-1].id).to eq 3
    expect(items[-1].name).to eq 'Fish'
    expect(items[-1].unit_price).to eq '$4.00'
    expect(items[-1].quantity).to eq 8
  end

  it "Creates a new shop item" do
    repository = ItemRepository.new
    item = double :item, name: 'Bread', unit_price: '$1.50', quantity: 20

    repository.create(item)

    all_items = repository.all
    last_item = all_items.last
    expect(last_item.name).to eq 'Bread'
    expect(last_item.unit_price).to eq '$1.50'
    expect(last_item.quantity).to eq 20
  end
end
