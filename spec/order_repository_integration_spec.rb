require "order_repository"
require "item_repository"

describe "Order Repository Integration" do
  def reset_tables
    seeds_sql = File.read("seeds/seeds_items_orders.sql")
    connection = PG.connect({ host: "127.0.0.1", dbname: "shop_manager_test" })
    connection.exec(seeds_sql)
  end

  before(:each) do
    reset_tables
    @order_repo = OrderRepository.new
    @item_repo = ItemRepository.new
  end

  context "#create_order" do
    it "creates a new order" do
      items = [{ item_id: 1, quantity: 5 }, { item_id: 3, quantity: 4 }, { item_id: 2, quantity: 5 }, { item_id: 4, quantity: 15 }]
      @order_repo.create_order("micheal", items, @item_repo)

      order = @order_repo.all.last
      items = @item_repo.all

      expect(order.id).to eq 4
      expect(order.items[0][:name]).to eq "Garlic Pasta Sauce"
      expect(order.items[0][:quantity]).to eq 5
      expect(order.items[3][:name]).to eq "Scottish Salmon Fillets"
      expect(order.items[3][:quantity]).to eq 15

      expect(items[0].quantity).to eq 25
      expect(items[1].quantity).to eq 50
      expect(items[2].quantity).to eq 85
      expect(items[3].quantity).to eq 35
    end
  end
end
