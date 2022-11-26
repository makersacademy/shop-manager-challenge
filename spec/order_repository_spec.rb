require 'order_repository'
require 'order'

describe OrderRepository do
  def reset_orders_table
    seed_sql = File.read('spec/seeds_orders.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_test' })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_orders_table
  end
  describe 'all' do
    it "returns all records on the orders table" do
      repo = OrderRepository.new

      orders = repo.all

      expect(orders.length).to eq 5

      expect(orders[0].id).to eq '1'
      expect(orders[0].date).to eq '01/10/2022'
      expect(orders[0].customer_name).to eq 'Hillary'
      expect(orders[0].item_id).to eq '1'
      expect(orders[0].quantity).to eq '1'

      expect(orders[1].id).to eq '2'
      expect(orders[1].date).to eq '02/10/2022'
      expect(orders[1].customer_name).to eq 'Simone'
      expect(orders[1].item_id).to eq '2'
      expect(orders[1].quantity).to eq '1'
    end
  end
  describe "create" do
    it "creates a new record in the orders database" do
      repo = OrderRepository.new

      order = Order.new
      order.date = '06/11/2022'
      order.customer_name = 'Harry'
      order.item_id = 2
      order.quantity = 4

      query = repo.create(order)

      orders = repo.all

      expect(orders.length).to eq 6
      expect(orders.last.customer_name).to eq 'Harry'
    end
  end
end