require "item_repository"

def reset_tables
  seed_sql = File.read('spec/seeds_all.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

describe ItemRepository do
  before(:each) do
    reset_tables
  end

  it "Returns all items" do
    repo = ItemRepository.new
    results = repo.all

    expect(results.length).to eq 4
    expect(results[0].id).to eq 1
    expect(results[0].name).to eq "Super Shark Vacuum Cleaner"
    expect(results[0].unit_price).to eq 99
    expect(results[0].quantity).to eq 30

    expect(results[1].id).to eq 2
    expect(results[1].name).to eq "Makerspresso Coffee Machine"
    expect(results[1].unit_price).to eq 69
    expect(results[1].quantity).to eq 15
  end

  it "Adds a new item to the table" do
    repo = ItemRepository.new

    item = Item.new
    item.name = "A test item"
    item.unit_price = 12.99
    item.quantity = 10

    repo.create(item)
    items = repo.all

    expect(
      items.any? { |i| i.name == item.name && i.unit_price == item.unit_price }
    ).to eq true
  end

end