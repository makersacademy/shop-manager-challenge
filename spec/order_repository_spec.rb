require 'order_repository'

def reset_tables
  seed_sql = File.read('spec/seeds_items_orders.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'items_orders_test' })
  connection.exec(seed_sql)
end

describe OrderRepository do
  
  before(:each) do 
    reset_tables
  end

  describe "#all" do
    it "returns a list of all orders" do
      repo = OrderRepository.new
      orders = repo.all
      
      expect(orders.length).to eq 6
      expect(orders.first.id).to eq '1'
      expect(orders.last.id).to eq '6'
      expect(orders.first.customer_name).to eq 'Andy Lewis'
      expect(orders.last.customer_name).to eq 'Catherine Wells'
      expect(orders[1].item_id).to eq '5'
      expect(orders[2].date).to eq '2022-11-24'
    end
  end

  describe "#create(new_order)" do
    it "adds a new order" do
      new_order = Order.new
      new_order.customer_name = 'James Jameson'
      new_order.item_id = 5
      new_order.date = '2022-11-27' # Or could require 'date' library and use Date.today if all new orders are to be marked as today's date
      
      repo = OrderRepository.new
      repo.create(new_order)
      
      orders = repo.all
      
      expect(orders.last.id).to eq '7'
      expect(orders.last.customer_name).to eq 'James Jameson'
      expect(orders.last.item_id).to eq '5'
      expect(orders.last.date).to eq '2022-11-27'
    end

    it "raises an error if passed a non-Order object" do
      new_item = Item.new
      new_item.name = 'Nespresso Coffee Machine'
      new_item.unit_price = 59
      new_item.quantity = 20

      repo = OrderRepository.new
      expect{ repo.create(new_item) }.to raise_error "Only orders can be added"
    end
  end
end