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
  
  describe "#all_with_items" do
    it "returns a list of all orders with associated items" do
      repo = OrderRepository.new
      orders = repo.all_with_items
    
      expect(orders.length).to eq 4
    
      order1 = orders.first
      expect(order1.id).to eq "1"
      expect(order1.customer_name).to eq "Alice"
      expect(order1.date_placed).to eq "2021-02-05"
      expect(order1.items.length).to eq 1
      expect(order1.items).to include(
        have_attributes(
          id: "1",
          name: "milk",
          unit_price: "175",
          quantity: "20"
        )
      )
      order2 = orders.last
      expect(order2.id).to eq "4"
      expect(order2.customer_name).to eq "Dom"
      expect(order2.date_placed).to eq "2023-10-16"
      expect(order2.items.length).to eq 3
      expect(order2.items).to include(
        have_attributes(
          id: "4",
          name: "chocolate",
          unit_price: "210",
          quantity: "16"
        )
      )
    end
  end

  describe "#find_with_items" do
    it "returns a list of orders with items" do
      repo = OrderRepository.new
      order = repo.find_with_items(4)

      expect(order.id).to eq "4"
      expect(order.customer_name).to eq "Dom"
      expect(order.date_placed).to eq "2023-10-16"

      expect(order.items.length).to eq 3
      expect(order.items).to include(
        have_attributes(
          id: "1",
          name: "milk",
          unit_price: "175",
          quantity: "20"
        )
      )
      expect(order.items).to include(
        have_attributes(
          id: "2",
          name: "spinach",
          unit_price: "115",
          quantity: "1"
        )
      )
      expect(order.items).to include(
        have_attributes(
          id: "4",
          name: "chocolate",
          unit_price: "210",
          quantity: "16"
        )
      )
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
