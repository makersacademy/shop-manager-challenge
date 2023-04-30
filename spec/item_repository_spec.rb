require "item_repository"

RSpec.describe ItemRepository do
  before(:each) do
    reset_tables
  end

  describe "#all" do
    it "returns a list of all items" do
      repo = ItemRepository.new
      items = repo.all

      expect(items.length).to eq 6

      item1 = items.first
      item2 = items.last

      expect(item1.name).to eq "milk"
      expect(item1.unit_price).to eq "175"
      expect(item1.quantity).to eq "20"

      expect(item2.name).to eq "coffee"
      expect(item2.unit_price).to eq "450"
      expect(item2.quantity).to eq "2"
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

      expect(repo.all).to include(
        have_attributes(id: "7", name: "new_item", unit_price: "200", quantity: "1")
      )
    end
  end
end
