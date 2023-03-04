require "order_repository"

def reset_orders_table
  seed_sql = File.read('spec/seed_order.sql')
  connection = DatabaseConnection.connect("shop_manager_test")
  connection.exec(seed_sql)
end



describe OrderRepository do
  before(:each) do 
    reset_orders_table
  end

  context "all method" do
    it "returns 2 items" do
      repo = OrderRepository.new
      orders = repo.all

      expect(orders[0].id).to eq 1
      expect(orders[0].customer).to eq 'Ayoub'
      expect(orders[0].date).to eq '2022-07-23'
      expect(orders[0].item_id).to eq 1

      expect(orders[1].id).to eq 2
      expect(orders[1].customer).to eq 'Makers'
      expect(orders[1].date).to eq '2023-01-16'
      expect(orders[1].item_id).to eq 2
    end
  end

  context "create method" do
    it "adds an item" do
      repo = OrderRepository.new
      order = Order.new
      order.customer = 'Alice'
      order.date = '2023-02-13'
      order.item_id = 3
      repo.create(order)
      expect(repo.all.length).to eq 3
    end
  end
end
