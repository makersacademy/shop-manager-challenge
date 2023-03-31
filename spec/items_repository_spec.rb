require "item_repository"

def reset_items_table
  seed_sql = File.read('spec/seeds_items.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

describe ItemRepository do
  before(:each) do 
    reset_items_table
  end

  it "returns three items using the 'all' method" do
    repo = ItemRepository.new
    items = repo.all

    expect(items.length).to eq 3
    expect(items.first.name).to eq "Apple MacBook Air"
    expect(items.first.unit_price).to eq "999.00"
    expect(items.first.quantity).to eq "25"
  end

  it "create a new item and check how many" do
    repo = ItemRepository.new

    item = Item.new
    item.name = "Lenovo ChromeBook"
    item.unit_price = 299.99
    item.quantity = 7

    repo.create(item)

    all_items = repo.all
    expect(all_items.length).to eq 4
  end

  it "create a new item and check the last insert" do
    repo = ItemRepository.new

    item = Item.new
    item.name = "Apple Watch"
    item.unit_price = 419.00
    item.quantity = 12

    repo.create(item)

    all_items = repo.all
    expect(all_items.last.name).to eq "Apple Watch"
    expect(all_items.last.unit_price).to eq "419.00"
    expect(all_items.last.quantity).to eq "12"
  end
end