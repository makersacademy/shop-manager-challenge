require "order_repository"

RSpec.describe OrderRepository do
  before(:each) do
    reset_tables
  end

  describe "#all" do
    it "returns a list of all orders" do
      repo = OrderRepository.new
      orders = repo.all

      expect(orders.length).to eq 4

      order1 = orders.first
      expect(order1.id).to eq "1"
      expect(order1.customer_name).to eq "Alice"
      expect(order1.date_placed).to eq "2021-02-05"
      
      order2 = orders.last
      expect(order2.id).to eq "4"
      expect(order2.customer_name).to eq "Dom"
      expect(order2.date_placed).to eq "2023-10-16"
    end
  end
  
  describe "#create" do
    it "creates a new order" do
      repo = OrderRepository.new

      new_order = Order.new
      new_order.customer_name = "Z"
      new_order.date_placed = "2023-04-28"

      repo.create(new_order)

      expect(repo.all).to include(
        have_attributes(id: "5", customer_name: "Z", date_placed: "2023-04-28")
      )
    end
  end
end
