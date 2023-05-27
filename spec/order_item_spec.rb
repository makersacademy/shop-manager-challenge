require 'order_item_repository'
require 'order'
require 'item'


RSpec.describe OrderItemRepository do
  let(:repository) { OrderItemRepository.new }

  def reset_shop_manager_table
    seed_sql = File.read('spec/seeds_shop_manager.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end


  before(:each) do 
    reset_shop_manager_table
  end
  context "#all method" do
    it 'returns a list of order items with associated orders and items' do
      repository = OrderItemRepository.new

      order_items = repository.all

      expect(order_items.length).to eq(3)

      # First order item
      expect(order_items[0].order.id).to eq(1)
      expect(order_items[0].order.customer_name).to eq('Joe Hannis')
      expect(order_items[0].order.order_date).to eq('2023-05-25')      
      expect(order_items[0].item.id).to eq(1)
      expect(order_items[0].item.name).to eq('CPU')
      expect(order_items[0].item.unit_price).to eq(199.99)
      expect(order_items[0].item.quantity).to eq(10)

      # Second order item
      expect(order_items[1].order.id).to eq(1)
      expect(order_items[1].order.customer_name).to eq('Joe Hannis')
      expect(order_items[1].order.order_date).to eq('2023-05-25')
      expect(order_items[1].item.id).to eq(2)
      expect(order_items[1].item.name).to eq('GPU')
      expect(order_items[1].item.unit_price).to eq(499.99)
      expect(order_items[1].item.quantity).to eq(5)

      # Third order item
      expect(order_items[2].order.id).to eq(2)
      expect(order_items[2].order.customer_name).to eq('Sean Peters')
      expect(order_items[2].order.order_date).to eq('2023-05-26')
      expect(order_items[2].item.id).to eq(1)
      expect(order_items[2].item.name).to eq('CPU')
      expect(order_items[2].item.unit_price).to eq(199.99)
      expect(order_items[2].item.quantity).to eq(10)
    end
  end

  context 'when a valid order_id is provided' do
    it 'returns the order with associated items' do
      order_id = 1

      # Call the method under test
      order_items = repository.find(order_id)

      # Assertions
      expect(order_items.length).to eq(2)

      expect(order_items[0].item.name).to eq('CPU')
      expect(order_items[0].item.unit_price).to eq(199.99)
      expect(order_items[0].item.quantity).to eq(10)

      expect(order_items[1].item.name).to eq('GPU')
      expect(order_items[1].item.unit_price).to eq(499.99)
      expect(order_items[1].item.quantity).to eq(5)
    end
  end

  context 'when an invalid order_id is provided' do
    it 'returns an empty array' do
      order_id = 999

      # Call the method under test
      order_items = repository.find(order_id)

      # Assertion
      expect(order_items).to be_empty
    end
  end

  context '#create' do
    it 'creates a new order item record' do
      order_id = 1
      item_id = 2

      expect(DatabaseConnection).to receive(:exec_params).with(
        'INSERT INTO order_items (order_id, item_id) VALUES ($1, $2);',
        [order_id, item_id]
      )

      repository.create(order_id, item_id)
    end
  end

end