require 'item_repository'

def reset_tables
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

describe ItemRepository do
  before(:each) do 
    reset_tables
  end
  
  describe "#all" do
    it "returns an array of Item objects" do
      repo = ItemRepository.new
      all_items = repo.all
      
      expect(all_items.length).to eq 10
      expect(all_items.first.id).to eq 1
      expect(all_items.first.item).to eq 'item_1'
      expect(all_items.first.unit_price).to eq 2.99
      expect(all_items.first.quantity).to eq 2
      expect(all_items.last.id).to eq 10
      expect(all_items.last.item).to eq 'item_10'
      expect(all_items.last.unit_price).to eq 1.49
      expect(all_items.last.quantity).to eq 9
    end
  end
  
  describe "#find" do
    it "returns an Item object given a record id" do
      repo = ItemRepository.new
      id_to_find = 2
      found_item = repo.find(id_to_find)
      
      expect(found_item.id).to eq 2
      expect(found_item.item).to eq 'item_2'
      expect(found_item.unit_price).to eq 3.99
      expect(found_item.quantity).to eq 5
    end
    
    it "returns false if the record id doesn't exist" do
      repo = ItemRepository.new
      id_to_find = 100
      expect(repo.find(id_to_find)).to eq false
    end
  end
  
  describe "#create" do
    it "add a record to the table given an Item object" do
      new_item = Item.new
      new_item.item = 'new_item'
      new_item.unit_price = 99.99
      new_item.quantity = 29
      
      repo = ItemRepository.new
      number_of_items = repo.all.length
      new_id = repo.create(new_item)
      
      expect(repo.all.length).to eq (number_of_items + 1)
      expect(repo.all).to include (
        have_attributes(
          id: new_id,
          item: 'new_item',
          unit_price: 99.99,
          quantity: 29
        )
      )
    end
  end
  
  describe "#find_by_order" do
    it "returns an array of all items contained in a given order" do
      repo = ItemRepository.new
      order_id = 5
      items = repo.find_by_order(order_id)
      
      expect(items.length).to eq 2
      expect(items.first.id).to eq 2
      expect(items.first.item).to eq 'item_2'
      expect(items.first.unit_price).to eq 3.99
      expect(items.first.quantity).to eq 5
    end
    
    it "returns false if the array is empty" do
      repo = ItemRepository.new
      order_id = 100
      items = repo.find_by_order(order_id)
      expect(items).to eq false
    end
  end
  
end
