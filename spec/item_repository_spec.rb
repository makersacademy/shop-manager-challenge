require "item_repository"

def reset_tables
  seed_sql = File.read("spec/seeds.sql")
  connection = PG.connect({ host: "127.0.0.1", dbname: "shop_manager" })
  connection.exec(seed_sql)
end

describe ItemRepository do
  before(:each) do
    reset_tables
  end

  it "returns an array with all items" do
    repo = ItemRepository.new
    items = repo.all
    expect(items.length).to eq(5)
    expect(items.first.name).to eq("Kitchen Towel")
    expect(items.first.unit_price).to eq("2")
    expect(items.first.quantity).to eq("25")
    expect(items.last.name).to eq("Soap")
    expect(items.last.unit_price).to eq("4")
    expect(items.last.quantity).to eq("80")
  end

  it "creates a new item" do
    repo = ItemRepository.new
    new_item = Item.new
    new_item.name = "Shower Gel"
    new_item.unit_price = 2
    new_item.quantity = 30
    repo.create(new_item)
    items = repo.all
    expect(items.length).to eq(6)
    expect(items.last.name).to eq("Shower Gel")
    expect(items.last.unit_price).to eq("2")
    expect(items.last.quantity).to eq("30")
  end
end
