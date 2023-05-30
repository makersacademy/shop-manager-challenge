require_relative '../lib/item_repo.rb'

RSpec.describe ItemRepository do

  def reset_items_table
    seed_sql = File.read('./spec/seeds_items.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'database_orders_test' })
    connection.exec(seed_sql)
  end

    before(:each) do 
      reset_items_table
    end

    it 'returns the list of items' do
      repo = ItemRepository.new

      items = repo.all

      expect(items.length).to eq(2) # => 2
      expect(items.first.id).to eq('1') # => '1'
      expect(items.first.name).to eq('Orange') # => 'Orange'
      expect(items.first.unit_price).to eq('0.85')# => '0.85'
      expect(items.first.quantity).to eq('5') # => '5'
      expect(items.first.order_id).to eq('1') # => '1'
    end 
    # 2
    # Get a single order
    it 'returns item with id number 1' do 

      repo = ItemRepository.new

      item = repo.find(1)
      expect(item.id).to eq('1') # => '1'
      expect(item.name).to eq('Orange') # => 'Orange'
      expect(item.unit_price).to eq('0.85')# => '0.85'
      expect(item.quantity).to eq('5') # => '5'
      expect(item.order_id).to eq('1') # => '1'
      #3 
    # Get another single artist 
    end 

    it 'returns item with id number 2' do
      repo = ItemRepository.new

      item = repo.find(2)

      expect(item.id).to eq('2') # => '1'
      expect(item.name).to eq('Apple') # => 'Orange'
      expect(item.unit_price).to eq('2')# => '0.85'
      expect(item.quantity).to eq('3') # => '5'
      expect(item.order_id).to eq('1') # => '1'
    end 
    
    it 'creates a new item called Biscuit' do 

      repo = ItemRepository.new

      new_item = repo.create(name: 'Biscuit', unit_price: '3.50', quantity: '5', order_id: '2')
      
      expect(new_item.id).to eq(3)
      expect(new_item.name).to eq('Biscuit')
      expect(new_item.unit_price).to eq('3.50')
      expect(new_item.quantity).to eq('5')
      expect(new_item.order_id).to eq('2')
    end 
  end

