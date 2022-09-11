require 'order_repository'

RSpec.describe OrderRepository do
  # snippet and function call copied and modified from repository class recipe
  def reset_tables
    seed_sql = File.read('spec/seeds_shop_manager.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end

  before(:each) do 
    reset_tables
  end

  describe "#all_with_item" do
    it "returns a list of [Order, item name string] for each order" do
      order_repo = OrderRepository.new
      orders = order_repo.all_with_item
      expect(orders.length).to eq 4
      expect(orders.first[0].id).to eq 1
      expect(orders.first[0].customer_name).to eq "John Doe"
      expect(orders.first[0].order_date).to eq "2022-08-21"
      expect(orders.first[0].item_id).to eq 2
      expect(orders.first[1]).to eq "Makerspresso Coffee Machine"
      expect(orders.last[0].id).to eq 4
      expect(orders.last[0].customer_name).to eq "Jane Doe"
      expect(orders.last[0].order_date).to eq "2022-08-24"
      expect(orders.last[0].item_id).to eq 1
      expect(orders.last[1]).to eq "Super Shark Vacuum Cleaner"
    end
  end
  
  describe "#create(order)" do
    it "creates an order record from Order object" do
      order_repo = OrderRepository.new
      order = Order.new
      order.customer_name = "JD"
      order.order_date = "2022-08-26"
      order.item_id = 1
      order_repo.create(order)
      latest_order = order_repo.all_with_item.last[0]
      expect(latest_order.customer_name).to eq "JD"
      expect(latest_order.order_date).to eq "2022-08-26"
      expect(latest_order.item_id).to eq 1
    end
  end
end
