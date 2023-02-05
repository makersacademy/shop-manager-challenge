require "order"

describe Order do
  context "#total_price" do
    it "returns grand total of the order" do
      items = [{ name: "tomato sauce", price: 2, quantity: 4 }, { name: "smoked salmon", price: 5, quantity: 10 }]
      order = Order.new(items)
      expect(order.total_price).to eq 58
    end
  end
end
