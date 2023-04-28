require "item_repository"

def reset_tables
  sql_seeds = File.read "spec/spec_seeds.sql"
  connection = PG.connect({ host: "127.0.0.1", dbname: "shop_manager_test" })
  connection.exec(sql_seeds)
end

RSpec.describe ItemRepository do
  before(:each) do
    reset_tables
  end

  describe "#all" do
    it "returns a list of all items" do
      repo = ItemRepository.new
      items = repo.all

      expect(items.length).to eq 6

      item_1 = items.first
      item_2 = items.last

      expect(item_1.name).to eq "milk"
      expect(item_1.unit_price).to eq "175"
      expect(item_1.quantity).to eq "20"

      expect(item_2.name).to eq "coffee"
      expect(item_2.unit_price).to eq "450"
      expect(item_2.quantity).to eq "2"
    end
  end

  describe "#create" do
    it "creates a new item" do
      repo = ItemRepository.new
      new_item = Item.new
      new_item.name = "new_item"
      new_item.unit_price = 200
      new_item.quantity = 1
      repo.create(new_item)

      item_from_database = repo.all.last

      expect(item_from_database.id).to eq "7"
      expect(item_from_database.name).to eq "new_item"
      expect(item_from_database.unit_price).to eq "200"
      expect(item_from_database.quantity).to eq "1"
    end
  end
end