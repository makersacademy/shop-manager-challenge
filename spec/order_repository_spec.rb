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
      # Implement test for 'find' method
    end
  end

  describe '#create' do
    it 'creates a new order' do
      # Implement test for 'create' method
    end
  end

  describe '#update' do
    it 'updates an existing order' do
      # Implement test for 'update' method
    end
  end

  describe '#delete' do
    it 'deletes an order by id' do
      # Implement test for 'delete' method
    end
  end
end
