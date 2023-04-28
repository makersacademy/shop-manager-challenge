require "item_repository"

RSpec.describe ItemRepository do
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
    xit "creates a new item" do
    end
  end
end