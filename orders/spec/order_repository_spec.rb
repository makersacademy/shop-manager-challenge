require 'order_repository'

RSpec.describe OrderRepository do
  def reset_orders_table
    seed_sql = File.read('spec/seeds_orders.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager' })
    connection.exec(seed_sql)
  end

  before(:each) do 
    reset_orders_table
  end

  describe '#all' do
    it 'returns the list of orders' do
      repo = OrderRepository.new

      orders = repo.all

      expect(orders.length).to eq(6)
      expect(orders.first.id).to eq('1')
      expect(orders.first.customer_name).to eq("Jeff Winger")
      expect(orders.first.item_id).to eq("2")
      expect(orders.first.order_date).to eq("24.12.2021")
    end
  end

  describe '#create' do
    it 'inserts a new order into the orders library' do
      repo = OrderRepository.new

      order = Order.new
      order.customer_name = 'Troy Barnes'
      order.item_id = '5'
      order.order_date = '25.11.2022'

      repo.create(order)

      all_orders = repo.all
      
      expect(all_orders).to include(
        have_attributes(
          customer_name: order.customer_name, 
          item_id: order.item_id,
          order_date: order.order_date
        )
      )
    end
  end
end
