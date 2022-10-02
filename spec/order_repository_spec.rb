require '/Users/saritaradia/Desktop/Projects/shop-manager-challenge/lib/order_repository.rb'
require '/Users/saritaradia/Desktop/Projects/shop-manager-challenge/lib/order.rb'
require '/Users/saritaradia/Desktop/Projects/shop-manager-challenge/lib/item_repository.rb'
require '/Users/saritaradia/Desktop/Projects/shop-manager-challenge/lib/item.rb'

RSpec.describe OrderRepository do
  def reset_itemsorders_table
    seed_sql = File.read('spec/seeds_itemsorders.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_itemsorders_table
  end

  context "#all" do
    it "Gets all orders" do
      repo = OrderRepository.new
      order = repo.all
      expect(order.length).to eq(2)
      expect(order[0].customer_name).to eq('Sara')
      expect(order[0].order_date).to eq('1995-09-01')
      expect(order[1].customer_name).to eq('Anne')
      expect(order[1].order_date).to eq('2022-12-12')
    end

    it "Gets a single order" do
      repo = OrderRepository.new
      order = repo.all
      expect(order.length).to eq(2)
      expect(order[0].customer_name).to eq('Sara')
      expect(order[0].order_date).to eq('1995-09-01')
    end
  end

  context "#Create" do
    it "Creates a new order" do
      repo = OrderRepository.new
      new_order = Order.new
      new_order.customer_name = 'Teun'
      new_order.order_date = '2001-05-03'

      repo.create(new_order)
      orders = repo.all
      last_order = orders.last

      expect(last_order.customer_name).to eq('Teun')
      expect(last_order.order_date).to eq('2001-05-03')
    end
  end

  context "#delete" do
    it "Deletes an order" do
      repo = OrderRepository.new
      id_to_delete = 1
      repo.delete(id_to_delete)

      all_orders = repo.all
      expect(all_orders.length).to eq(1)
      expect(all_orders.first.id).to eq('2')
  end
  end
end