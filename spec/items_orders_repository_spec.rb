require 'items_orders_repository'

def reset_items_orders_table
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

RSpec.describe ItemsOrdersRepository do
  before(:each) do
    reset_items_orders_table
  end

  context "add new item to an order" do
    it "creates a new instance of items_orders" do
      repo = ItemsOrdersRepository.new
      order_repo = OrderRepository.new
      item_repo = ItemRepository.new

      items_orders = ItemsOrders.new
      items_orders.order_id = "1"
      items_orders.item_id = "3"

      repo.create(items_orders)

      item = order_repo.find_by_item('eggs')
      orders = item.orders

      order = item_repo.find_by_order('Harry Styles')
      items = order.items

      expect(orders.length).to eq 3
      expect(items.length).to eq 5
    end
  end
end
