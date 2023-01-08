require "database_connection"
require "items"
require "items_repository"

def reset_shop_manager_test_table
  seed_sql = File.read("spec/seed_shop_manager_test.sql")
  connection = PG.connect({ host: "127.0.0.1", dbname: "shop_manager_test" })
  connection.exec(seed_sql)
end

describe ItemsRepository do
  before(:each) do
    reset_shop_manager_test_table
  end
  it "returns all items list" do
    repo = ItemsRepository.new
    list = repo.all
    expect(list.length).to eq 2
    expect(list[0].id).to eq "1"
    expect(list[0].name).to eq "Phone"
    expect(list[0].price).to eq "189"
    expect(list[0].quantity).to eq "32"
  end

  it "it creates an item entry" do
    repo = ItemsRepository.new
    item = Items.new
    item.name = "Memory stick"
    item.price = 15
    item.quantity = 385
    repo.create(item)
    list = repo.all.last
    expect(list.name).to eq "Memory stick"
    expect(list.price).to eq "15"
    expect(list.quantity).to eq "385"
  end
end
