require "order_repository"
require "date"

describe OrderRepository do
  def reset_tables
    seeds_sql = File.read("seeds/seeds_items_orders.sql")
    connection = PG.connect({ host: "127.0.0.1", dbname: "shop_manager_test" })
    connection.exec(seeds_sql)
  end

  before(:each) do
    reset_tables
    @repo = OrderRepository.new
  end

  context "#all" do
    it "returns a list of Order objects" do
      orders = @repo.all
      today = DateTime.now.strftime("%Y-%m-%d")
      expect(orders.length).to eq 3

      expect(orders.first.id).to eq 1
      expect(orders.first.customer_name).to eq "terry"
      expect(orders.first.date).to eq today
      expect(orders.first.total_price).to eq 98.9
      expect(orders.first.items[0][:name]).to eq "Daily Moisture Conditioner"
      expect(orders.first.items[2][:price]).to eq 5
      expect(orders.first.items[1][:quantity]).to eq 2

      expect(orders.last.id).to eq 3
      expect(orders.last.customer_name).to eq "luke"
      expect(orders.last.date).to eq today
    end
  end

  context "#create_order" do
  end

  context "#delete_order" do
    it "deletes an order" do
      @repo.delete_order(3)
      orders = @repo.all
      expect(orders.length).to eq 2
      expect(orders.last.customer_name).to eq "ryan"
    end
  end
end
