require 'item_repository'
require 'database_connection'


RSpec.describe ItemRepository do
  
  def reset_item_table
    seed_sql = File.read('spec/seeds_items.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end

  around(:each) do |example|
    # Reset the database before running the test
    reset_item_table

    # Run the test
    example.run

    # Reset the database again after the test has completed
    reset_item_table
  end

  describe '#all' do
    it 'returns all items' do
      items = ItemRepository.new.all
      expect(items.length).to eq(2)
    end
  end

  describe '#find' do
    it 'returns the item with the given id' do
      item = ItemRepository.new.find(1)
      expect(item).to be_a(Item)
      expect(item.id).to eq(1)
      expect(item.item_name).to eq('Apple')
    end
  
    it 'returns nil if the item is not found' do
      item = ItemRepository.new.find(999)
      expect(item).to be_nil
    end
  end

  describe '#create' do
    it 'creates a new item in the items table' do
      new_item = Item.new(item_name: 'Banana', unit_price: 0.70, quantity: 50)
      
      item_repository = ItemRepository.new
      item_repository.create(new_item)
  
      item = item_repository.find(new_item.id)
      expect(item).not_to be_nil
      expect(item.item_name).to eq('Banana')
      expect(item.unit_price).to eq(0.70)
      expect(item.quantity).to eq(50)
    end

    describe '#update' do
      it 'updates the item with the given id' do
        item_repository = ItemRepository.new
        updated_item = Item.new(id: 1, item_name: 'Green Apple', unit_price: 0.55, quantity: 120)
  
        item_repository.update(updated_item.id, updated_item)
        updated_item_from_db = item_repository.find(updated_item.id)
  
        expect(updated_item_from_db.item_name).to eq(updated_item.item_name)
        expect(updated_item_from_db.unit_price).to eq(updated_item.unit_price)
        expect(updated_item_from_db.quantity).to eq(updated_item.quantity)
      end
    end

    describe '#delete' do
      it 'deletes the item with the given id' do
        item_repository = ItemRepository.new
        item_id_to_delete = 1
  
        item_repository.delete(item_id_to_delete)
        deleted_item = item_repository.find(item_id_to_delete)
  
        expect(deleted_item).to be_nil
      end
    end
  end
end