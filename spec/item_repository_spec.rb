require_relative "../lib/item_repository"

RSpec.describe ItemRepository do
  def reset_shop_table
    seed_sql = File.read("spec/seeds_shop.sql")
    connection = PG.connect({ host: "127.0.0.1", dbname: "shop_manager_test" })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_shop_table
  end

  it "returns all items in the shop" do
    repo = ItemRepository.new
    list_items = repo.all
    expect(list_items.length).to eq(6)
    expect(list_items.first.id).to eq "1"
  end

  it "returns a specific item with ID 1 (Dyson Vaccum)" do
    repo = ItemRepository.new
    list_items = repo.find(1)
    expect(list_items.item_name).to eq "Dyson Vaccum"
    expect(list_items.item_price).to eq "$319.00"
    expect(list_items.item_quantity).to eq "10"
    expect(list_items.id).to eq "1"
  end

  it "creates a new item in the shop" do
    repo = ItemRepository.new
    new_item = Item.new
    new_item.item_name = "LG 4K Ultra HD TV"
    new_item.item_price = "1999"
    new_item.item_quantity = "9"
    new_item.id = "7"

    repo.create(new_item)

    list_items = repo.all

    expect(list_items).to include(
      have_attributes(
        item_name: "LG 4K Ultra HD TV",
        item_price: "$1,999.00",
        item_quantity: "9",
        id: "7",
      )
    )
  end

  it "updates a item and its values" do
    repo = ItemRepository.new
    item_name = repo.find(2)
    item_name.item_name = "Dyson Vaccum "
    item_name.item_price = "$319.00"
    item_name.item_quantity = "10"

    repo.update(item_name)

    updated_item = repo.find(1)

    expect(updated_item.item_name).to eq ("Dyson Vaccum")
    expect(updated_item.item_price).to eq("$319.00")
    expect(updated_item.item_quantity).to eq("10")
  end

  it "Updates an Item object with new values" do
    repo = ItemRepository.new
    item = repo.find(1)
    item.item_quantity = item.item_quantity.to_i - 1
    repo.update(item)
    new_item = repo.find(1)
    expect(new_item.item_quantity).to eq "9"
    expect(new_item.item_name).to eq "Dyson Vaccum"
  end
end
