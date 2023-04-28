require "order_repository"

def reset_tables
  sql_seeds = File.read("spec/spec_seeds.sql")
  connection = PG.connect({ host: "127.0.0.1", dbname: "shop_manager_test" })
  connection.exec(sql_seeds)
end

RSpec.describe OrderRepository do
  before(:each) do
    reset_tables
  end

  describe "#all" do
    it "returns a list of all orders" do
      repo = OrderRepository.new
      orders = repo.all

      expect(orders.length).to eq 4

      order_1 = orders.first
      expect(order_1.id).to eq "1"
      expect(order_1.customer_name).to eq "Alice"
      expect(order_1.date_placed).to eq "2021-02-05"
      
      order_2 = orders.last
      expect(order_2.id).to eq "4"
      expect(order_2.customer_name).to eq "Dom"
      expect(order_2.date_placed).to eq "2023-10-16"
    end
  end

  describe "#all_with_items" do
    xit "returns a list of all orders with their associated items" do
    end
  end

  describe "#create" do
    xit "creates a new order" do
    end
  end
end