require 'order_repository'
require 'order'

def reset_database
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager' })
  connection.exec(seed_sql)
end

RSpec.describe OrderRepository do
  before(:each) do 
    reset_database
  end
  
  describe "#all" do
    it "returns all orders" do
      repo = OrderRepository.new
      orders = repo.all
      expect(orders.length).to eq 2
      expect(orders.first.customer_name).to eq 'Rodney Howell'
    end
  end
  
  describe "#create" do
    it "adds a new order to the `orders` table" do
      repo = OrderRepository.new
      order = double(Order, customer_name: 'Sheldon Emmerich', date: '27 April 2023', items: [1, 2, 3])
      repo.create(order)
      orders = repo.all
      expect(orders.length).to eq 3
      expect(orders.last.customer_name).to eq order.customer_name
    end
    
    it "adds a new order to the `orders` table, and updates `items_orders`" do
      repo = OrderRepository.new
      order = Order.new
      
      order.customer_name = "Sheldon Emmerich"
      order.date = "27 April 2023"
      order.items = [1, 2, 3]
      repo.create(order)
      orders = repo.all
      expect(orders.length).to eq 3
      expect(orders.last.customer_name).to eq order.customer_name
    end
  end
  
  describe "#find_items_by_order" do
    it "returns the order's items" do
      repo = OrderRepository.new
      items = repo.find_items_by_order(1)
      expect(items.length).to eq 3
      expect(items.last.id).to eq '10'
    end
  end
end
