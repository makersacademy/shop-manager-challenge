require_relative "../lib/order_repository"

RSpec.describe OrderRepository do
    def reset_shop_table
      seed_sql = File.read("spec/seeds_shop.sql")
      connection = PG.connect({ host: "127.0.0.1", dbname: "shop_manager_test" })
      connection.exec(seed_sql)
    end
  
    before(:each) do
      reset_shop_table
    end

  it "returns all orders" do
    repo = OrderRepository.new
    all_orders = repo.all 
    expect(all_orders.length).to eq(4)
    expect(all_orders.first.customer_name).to eq "Aimee"
  end 

  it "returns a specific order from ID 1(Aimee)" do 
    repo = OrderRepository.new
    order = repo.find_by_order(1)
    expect(order.items.first.item_name).to eq ("Galaxy Tab A8")
  end

end 
