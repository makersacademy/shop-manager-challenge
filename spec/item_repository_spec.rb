require_relative '../lib/item_repository'
require_relative 'reset_tables'

describe ItemRepository do
  before(:each) do
    reset_tables
  end

  describe "#all" do
    it "returns all records" do
      repo = ItemRepository.new

      expected = [
        have_attributes(id: 1, name: 'Super Shark Vacuum Cleaner', unit_price: 99, quantity: 30),
        have_attributes(id: 2, name: 'Makerspresso Coffee Machine', unit_price: 69, quantity: 15)
      ]

      expect(repo.all).to match_array(expected)
    end
  end

  describe "#create" do
    it "creates a record" do
      repo = ItemRepository.new
      new_item = Item.new(name: 'Shiny New Item', unit_price: 49, quantity: 100)

      repo.create(new_item)
      
      expected = have_attributes(new_item.to_h.except(:id))

      expect(repo.all).to include(expected)
    end
  end
end
