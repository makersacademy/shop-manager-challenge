require 'item_repository'

def reset_items_table
  seed_sql = File.read('spec/seeds_orders.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

describe ItemRepository do
  before(:each) do 
    reset_items_table
  end

  describe '#all' do
    it 'returns an array of item objects for each record on items table' do
      repo = ItemRepository.new

      items = repo.all

      expect(items.first.id).to eq 1
      expect(items.first.name).to eq 'item_one'
      expect(items.first.price).to eq 1
      expect(items.first.quantity).to eq 1

      expect(items.last.id).to eq 5
      expect(items.last.name).to eq 'item_five'
      expect(items.last.price).to eq 5
      expect(items.last.quantity).to eq 5

    end
  end

  describe '#create' do  
    it 'creates a new item object and adds it to the items table' do
      repo = ItemRepository.new
      new_item = Item.new
      
      new_item.name = 'new item'
      new_item.price = 6
      new_item.quantity = 6
      
      repo.create(new_item)
      
      inventory = repo.all
      
      expect(inventory.length).to eq 6
      expect(inventory.last.id).to eq 6
      expect(inventory.last.name).to eq 'new item'
      expect(inventory.last.price).to eq 6
      expect(inventory.last.quantity).to eq 6
    end
  end

  describe '#find_by_id' do
    it 'returns an time with matching id' do
      repo = ItemRepository.new

      item = repo.find_by_id(3)

      expect(item.id).to eq 3
      expect(item.name).to eq 'item_three' 
      expect(item.price).to eq 3
      expect(item.quantity).to eq 3 
    end

    # fails if id doesn't exist?
  end 

  describe '#find_by_order' do
    it 'returns a list of items assigned to an order' do
      repo = ItemRepository.new

      items_on_order = repo.find_by_order(1)

      expect(items_on_order.length).to eq 2

      first_item = items_on_order.first
      last_item = items_on_order.last
      
      expect(first_item.id).to eq 1
      expect(last_item.id).to eq 5
    end

    it 'returns nil when no items are assigned to an order' do
      repo = ItemRepository.new

      expect(repo.find_by_order(2)).to eq nil   
    end

    # fails if order doesn't exist?
  end

end
