require 'item_repository'

RSpec.describe ItemRepository do
  def reset_items_table
    seed_sql = File.read('spec/items_seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end

  before(:each) do 
    reset_items_table
  end
  
  it "returns the lists of the records" do
    repo = ItemRepository.new

    items = repo.all

    expect(items.length).to eq 3

    expect(items.first.id).to eq "1"
    expect(items.first.name).to eq "Black Trousers"
    expect(items.first.unit_price).to eq "30"
    expect(items.first.quantity).to eq "52"
  end

  it "creates a new item" do
    repo = ItemRepository.new

    new_item = Item.new
    new_item.name = 'Blue Jeans'
    new_item.unit_price = 80
    new_item.quantity = 23

    repo.create(new_item)

    items = repo.all

    latest_order = items.last
    expect(latest_order.id).to eq "4"
    expect(latest_order.name).to eq "Blue Jeans"
    expect(latest_order.unit_price).to eq "80"
    expect(latest_order.quantity).to eq "23"
  end
end
