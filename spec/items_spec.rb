require 'items_repository'
require 'database_connection'

def reset_items_table
    seed_sql = File.read('spec/shop_manager.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end
  
  describe ItemsRepository do
    before(:each) do 
      reset_items_table
    end
  
    it 'show all items' do
      repo = ItemsRepository.new
      items = repo.all
      expect(items.length).to eq 3
      expect(items.last.price).to eq '$38.00'
    end

    it 'return only one item given the id' do
      repo = ItemsRepository.new
      item = repo.find(2)
      expect(item.item_name).to eq 'Apple Cake'
      expect(item.price).to eq '$34.50'
      expect(item.quantity).to eq '3'
    end

    it 'create an item' do
      repo = ItemsRepository.new
      new_item = Item.new
      new_item.id = 4
      new_item.item_name = 'Pear Cake'
      new_item.price = '$40.00'
      new_item.quantity = 2
      item = repo.create(new_item)
      all_items = repo.all
      expect(all_items.length).to eq 4
      expect(all_items.last.item_name).to eq 'Pear Cake'
    end

    it 'delete an item' do 
      repo = ItemsRepository.new
      id_to_delete = 4
      item_to_delete = repo.delete(id_to_delete)
      all_items = repo.all
      expect(all_items.length).to eq 3
      expect(all_items.last.item_name).to eq 'Chocolate Cake'
    end
  end