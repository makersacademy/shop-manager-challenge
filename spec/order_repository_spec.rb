require 'order_repository'
require 'database_connection'

RSpec.describe OrderRepository do
  def reset_order_table
    seed_sql = File.read('spec/seeds_orders.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end

  around(:each) do |example|
    reset_order_table
    example.run
    reset_order_table
  end

  describe '#all' do
    it 'returns all orders' do
      order_repository = OrderRepository.new
      orders = order_repository.all
      expect(orders.length).to eq(2)
    end
  end

  describe '#find' do
    it 'finds an order by id' do
      order_repository = OrderRepository.new
      order = order_repository.find(1)

      expect(order).not_to be_nil
      expect(order.id).to eq(1)
    end
  end

  describe '#create' do
    it 'creates a new order' do
      order_repository = OrderRepository.new
      new_order = Order.new(customer_name: 'John Doe', item_id: 1, date: '2023-05-01') # Update this line
      order_repository.create(new_order)
  
      expect(new_order.id).not_to be_nil
  
      orders = order_repository.all
      expect(orders.length).to eq(3)
    end
  end  

  describe '#update' do
    it 'updates an existing order' do
      order_repository = OrderRepository.new
      order = order_repository.find(1)
      order.customer_name = 'Jane Doe'
      order.item_id = 2
      order.date = '2023-06-01'

      order_repository.update(order.id, order)
      updated_order = order_repository.find(1)

      expect(updated_order.customer_name).to eq('Jane Doe')
      expect(updated_order.item_id).to eq(2)
      expect(updated_order.date).to eq('2023-06-01')
    end
  end

  describe '#delete' do
    it 'deletes an order by id' do
      order_repository = OrderRepository.new
      order_repository.delete(1)

      expect(order_repository.find(1)).to be_nil

      orders = order_repository.all
      expect(orders.length).to eq(1)
    end
  end
end
