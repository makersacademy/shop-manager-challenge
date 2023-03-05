require 'item_repository'

def reset_items_table
  seed_sql = File.read('spec/seeds_items_orders.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

RSpec.describe ItemRepository do

  before(:each) do 
    reset_items_table
  end

  it "returns a list of items" do
    repo = ItemRepository.new

    items = repo.all

    expect(items.length).to eq 3

    expect(items[0].name).to eq 'Super Shark Vacuum Cleaner'
    expect(items[0].price).to eq 99
    expect(items[0].quantity).to eq 30

    expect(items[1].name).to eq 'Makerspresso Coffee Machine'
    expect(items[1].price).to eq 69
    expect(items[1].quantity).to eq 15

    expect(items[2].name).to eq 'Toastie Maker'
    expect(items[2].price).to eq 30
    expect(items[2].quantity).to eq 60
  end

  it "creates a new item" do
    repo = ItemRepository.new

    item = Item.new
    item.name = 'Ice Cream Maker'
    item.price = 50
    item.quantity = 20

    repo.create(item)

    items = repo.all 

    expect(items).to include(
      have_attributes(
        name: item.name,
        price: item.price,
        quantity: item.quantity
      )
    )
  end

end
