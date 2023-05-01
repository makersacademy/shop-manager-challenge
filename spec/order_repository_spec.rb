require 'order_repository'

def reset_orders_table
  seed_sql = File.read('spec/seeds_orders.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

RSpec.describe OrderRepository do
  before(:each) do 
    reset_orders_table
  end

  context '#all' do
    it 'returns all orders' do
      repo = OrderRepository.new

      orders = repo.all

      expect(orders.length).to eq 3

      expect(orders[0].id).to eq '1'
      expect(orders[0].customer_name).to eq 'David'
      expect(orders[0].date).to eq '2023-03-03'
      expect(orders[0].item_id).to eq '1'

      expect(orders[1].id).to eq '2'
      expect(orders[1].customer_name).to eq 'David'
      expect(orders[1].date).to eq '2023-05-01'
      expect(orders[1].item_id).to eq '1'

      expect(orders[2].id).to eq '3'
      expect(orders[2].customer_name).to eq 'Anna'
      expect(orders[2].date).to eq '2023-05-01'
      expect(orders[2].item_id).to eq '2'
    end
  end

  context '#find' do
    it 'returns the first order' do
      repo = OrderRepository.new

      order = repo.find(1)

      expect(order.id).to eq '1'
      expect(order.customer_name).to eq 'David'
      expect(order.date).to eq '2023-03-03'
      expect(order.item_id).to eq '1'
    end

    it 'returns the second order' do
      repo = OrderRepository.new

      order = repo.find(2)

      expect(order.id).to eq '2'
      expect(order.customer_name).to eq 'David'
      expect(order.date).to eq '2023-05-01'
      expect(order.item_id).to eq '1'
    end
  end

  context '#create' do
    it 'creates a new order' do
      repo = OrderRepository.new

      order = Order.new

      order.customer_name = 'Will'
      order.date = '2023-05-01'
      order.item_id = 1

      repo.create(order)

      orders = repo.all

      last_order = orders.last

      expect(last_order.id).to eq '4'
      expect(last_order.customer_name).to eq 'Will'
      expect(last_order.date).to eq '2023-05-01'
      expect(last_order.item_id).to eq '1'
    end
  end
end
