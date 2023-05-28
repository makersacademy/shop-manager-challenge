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

  context 'when the order item is new' do
    it 'creates a new order item record' do
      order_id = 1
      item_id = 2

      expect(repository).to receive(:find).with(order_id).and_return([])
      expect(repository).to receive(:insert_new_order_item).with(order_id, item_id)

      repository.create(order_id, item_id)
    end
  end

  context 'when the order item already exists' do
    it 'updates the quantity of the existing order item' do
      existing_order_item = OrderItem.new
      existing_order_item.order_id = 1
      existing_order_item.item_id = 2
      existing_order_item.quantity = 1
    
      expect(repository).to receive(:find).with(existing_order_item.order_id).and_return([existing_order_item])
      expect(repository).to receive(:update_quantity).with(existing_order_item)
    
      repository.create(existing_order_item.order_id, existing_order_item.item_id)
    end

    it 'updates the quantity of the order item' do
      # Create a dummy order item for testing
      order_item = OrderItem.new
      order_item.order_id = 1
      order_item.item_id = 2
      order_item.quantity = 3

      # Stub the database connection to prevent actual database interaction
      allow(DatabaseConnection).to receive(:exec_params)

      # Call the update_quantity method
      repository.update_quantity(order_item)

      # Verify that the quantity is incremented and the correct SQL query is executed
      expect(order_item.quantity).to eq(4)
      expect(DatabaseConnection).to have_received(:exec_params).with(
        'UPDATE order_items SET quantity = $1 WHERE order_id = $2 AND item_id = $3;',
        [4, 1, 2]
      )
    end

    it 'inserts a new order item into the database' do
      # Stub the database connection to prevent actual database interaction
      allow(DatabaseConnection).to receive(:exec_params)

      # Call the insert_new_order_item method
      repository.insert_new_order_item(1, 2)

      # Verify that the correct SQL query is executed with the expected parameters
      expect(DatabaseConnection).to have_received(:exec_params).with(
        'INSERT INTO order_items (order_id, item_id, quantity) VALUES ($1, $2, $3);',
        [1, 2, 1]
      )
    end
  end

end