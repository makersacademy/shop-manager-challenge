require 'item_repository'

def reset_tables
  seed_sql = File.read('spec/seeds_items_orders.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end
describe ItemRepository do
  before(:each) do 
    reset_tables
  end
  it "returns all items in table" do
    repo = ItemRepository.new
    items = repo.all
    expect(items.length).to eq 4
    expect(items[0].name).to eq 'steak'
    expect(items[0].quantity).to eq "10"
    expect(items[2].name).to eq 'chicken thigh'
    expect(items[2].price).to eq "3"
    expect(items[3].id).to eq "4"
  end

  it "creates a new item in the table" do 
    repo = ItemRepository.new
    item = Item.new
    item.name = "mash potato"
    item.price = 1
    item.quantity = 10
    repo.create(item)
    all_items = repo.all
    expect(all_items).to include(
      have_attributes(
        price: "1",
        quantity: "10",
        name: "mash potato"
      )
    )
  end
end