require 'order_repository'

def reset_orders_table
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

RSpec.describe OrderRepository do
  before(:each) do
    reset_orders_table
  end

  context "all orders" do
    it "returns all orders" do
      repo = OrderRepository.new

      orders = repo.all

      expect(orders.length).to eq 4

      expect(orders[0].id).to eq "1"
      expect(orders[0].customer_name).to eq 'Harry Styles'
      expect(orders[0].order_date).to eq '2022-03-10'
    end
  end

  context "find a singular order" do
    it "returns first order" do
      repo = OrderRepository.new

      order = repo.find('Harry Styles')

      expect(order.customer_name).to eq 'Harry Styles'
      expect(order.order_date).to eq '2022-03-10'
    end
  end

  context "add an order" do
    it "adds an order" do
      repo = OrderRepository.new

      order = Order.new
      order.customer_name = 'Lizzy McAlpine'
      order.order_date = '2022-08-08'

      repo.create(order)

      orders = repo.all
      expect(orders.length).to eq 5
      expect(orders.last.id).to eq '5'
      expect(orders.last.customer_name).to eq 'Lizzy McAlpine'
    end
  end

  context "find orders by item" do
    it 'returns orders that include the item' do
      repo = OrderRepository.new

      item = repo.find_by_item('cheese')
      orders = item.orders

      expect(orders.length).to eq 3
    end
  end
end
