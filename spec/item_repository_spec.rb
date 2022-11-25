require 'item_repository'

describe ItemRepository do
  describe "#all" do
    it "returns all records from the items table" do
    end
  end
  describe "#find_with_orders" do
    it "returns a particular item record by id from the items table includes an array of all orders associated with it" do
      repo = ItemRepository.new

      item = repo.find_with_orders(2)
        
      expect(item.item_name).to eq 'My little Pony'
      expect(item.orders.length).to eq 2
      expect(item.orders.first.customer_name).to eq 'Simone'
    end
  end
end 