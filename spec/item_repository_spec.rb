require "item_repository"

RSpec.describe ItemRepository do 

  def reset_items_table
      seed_sql = File.read('spec/orders_items_seeds.sql')
      connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
      connection.exec(seed_sql)
  end
    
  describe ItemRepository do
      before(:each) do 
        reset_items_table
      end
  end 

  it "returns a list of all the items in the shop" do 

      repo = ItemRepository.new
      items = repo.all

      expect(items.length).to eq 3
      expect(items[0].id).to eq 1  
      expect(items[0].item_name).to eq "MacBook"  
      expect(items[0].price).to eq "1000"   
      expect(items[0].quantity).to eq "13"
  end

  it "creates a new entry for an item" do

      repo = ItemRepository.new
      new_item = Item.new

      new_item.item_name = "Logitech Mouse"
      new_item.price = "65"
      new_item.quantity = "7"
      repo.create(new_item)
      
      all_items = repo.all

      expect(all_items).to include(
      have_attributes(
      name: new_item.item_name,
      price: new_item.price,
      quantity: new_item.quantity)   
      )
  end
end