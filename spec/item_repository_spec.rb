require 'item_repository'

def reset_table
  seed_sql = File.read('spec/seeds_shop_manager.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

describe ItemRepository do
  before(:each) do 
    reset_table
  end

  it "gets all items" do
    item_repository = ItemRepository.new
    items = item_repository.all
    expect(items.length).to eq 5
    expect(items[0].id).to eq "1"
    expect(items[0].name).to eq "Climbing rope"
    expect(items[0].unit_price).to eq "40.99"
    expect(items[0].quantity).to eq "5"
    expect(items[4].id).to eq "5"
    expect(items[4].name).to eq "Family tent"
    expect(items[4].unit_price).to eq "70.99"
    expect(items[4].quantity).to eq "0"
  end

  it "creates new items" do
    item_repository = ItemRepository.new
    item = Item.new
    item.name = "Fishing rod"
    item.unit_price = "200.00"
    item.quantity = "4"
    item_repository.create(item)
    items = item_repository.all
    expect(items.length).to eq 6
    expect(items[5].id).to eq "6"
    expect(items[5].name).to eq "Fishing rod"
    expect(items[5].unit_price).to eq "200.00"
    expect(items[5].quantity).to eq "4"
  end
end
