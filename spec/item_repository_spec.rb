require "item_repository"

describe ItemRepository do
  def reset_tables
    seed_sql = File.read("spec/seeds.sql")
    connection = PG.connect({ host: "127.0.0.1", dbname: "shop_manager_test" })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_tables
  end

  it "returns all items" do
    repo = ItemRepository.new
    items = repo.all

    expect(items.length).to eq 3

    expect(items.first.id).to eq 1
    expect(items.first.name).to eq "KitKat"
    expect(items.first.price).to eq "1.00"

    expect(items.last.id).to eq 3
    expect(items.last.name).to eq "Notepad"
    expect(items.last.price).to eq "1.50"
  end

  it "creates a new item" do
    new_item = Item.new
    new_item.name = "Oat milk (4 pints)"
    new_item.price = "2.10"

    repo = ItemRepository.new
    repo.create(new_item)
    items = repo.all

    expect(items.length).to eq 4

    expect(items.last.id).to eq 4
    expect(items.last.name).to eq "Oat milk (4 pints)"
    expect(items.last.price).to eq "2.10"
  end
end
