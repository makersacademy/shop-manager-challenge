require "item_repository"

RSpec.describe ItemRepository do
  def reset_orders_table
    seed_sql = File.read("spec/seeds_orders.sql")
    connection = PG.connect({ host: "127.0.0.1", dbname: "shop_manager_test" })
    connection.exec(seed_sql)
  end

  before(:each) { reset_orders_table }

  it "returns all the items" do
    repo = ItemRepository.new
    items = repo.all
    expect(items.length).to eq (3)
    expect(items[0].id).to eq "1"
    expect(items[0].item_name).to eq "Super Shark Vacuum Cleaner"
    expect(items[0].price).to eq "199"
    expect(items[0].quantity).to eq "60"
    expect(items[0].order_id).to eq "1"
    expect(items[1].id).to eq "2"
    expect(items[1].item_name).to eq "Makerspresso Coffee Machine"
    expect(items[1].price).to eq "90"
    expect(items[1].quantity).to eq "20"
    expect(items[1].order_id).to eq "1"
    expect(items[2].id).to eq "3"
    expect(items[2].item_name).to eq "iPhone 14"
    expect(items[2].price).to eq "800"
    expect(items[2].quantity).to eq "50"
    expect(items[2].order_id).to eq "2"
  end

  it "gets a single item" do
    repo = ItemRepository.new
    item = repo.find(1)
    expect(item.id).to eq "1"
    expect(item.item_name).to eq "Super Shark Vacuum Cleaner"
    expect(item.price).to eq "199"
    expect(item.quantity).to eq "60"
    expect(item.order_id).to eq "1"
  end

  it "creates an item" do
    repo = ItemRepository.new
    item = Item.new
    item.item_name = "Washing Machine"
    item.price = "299"
    item.quantity = "45"
    item.order_id = "2"
    expect(repo.all.length).to eq (3)
    repo.create(item)
    expect(repo.all.length).to eq (4)
  end
end
