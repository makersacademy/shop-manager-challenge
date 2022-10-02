require '/Users/saritaradia/Desktop/Projects/shop-manager-challenge/lib/order_repository.rb'
require '/Users/saritaradia/Desktop/Projects/shop-manager-challenge/lib/order.rb'
require '/Users/saritaradia/Desktop/Projects/shop-manager-challenge/lib/item_repository.rb'
require '/Users/saritaradia/Desktop/Projects/shop-manager-challenge/lib/item.rb'

RSpec.describe ItemRepository do

def reset_itemsorders_table
  seed_sql = File.read('spec/seeds_itemsorders.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

  before(:each) do
    reset_itemsorders_table
  end

  context "#all" do
    it "Gets all items" do
      repo = ItemRepository.new
      item = repo.all
      expect(item.length).to eq(3)
      expect(item[0].id).to eq('1')
      expect(item[0].item_name).to eq('Chips')
      expect(item[0].unit_price).to eq("$2.99")
      expect(item[0].quantity).to eq('1')
      expect(item[1].id).to eq('2')
      expect(item[1].item_name).to eq('Pizza')
      expect(item[1].unit_price).to eq("$3.49")
      expect(item[1].quantity).to eq('2')
      expect(item[2].id).to eq('3')
      expect(item[2].item_name).to eq('Sandwich')
      expect(item[2].unit_price).to eq("$1.99")
      expect(item[2].quantity).to eq('3')
    end

      it "Gets a single item" do
          repo = ItemRepository.new
          item = repo.all
          expect(item.length).to eq(3)
          expect(item[0].id).to eq('1')
          expect(item[0].item_name).to eq('Chips')
          expect(item[0].unit_price).to eq("$2.99")
          expect(item[0].quantity).to eq('1')
      end
  end

  context "#create" do
    it "Creates a new item" do
      repo = ItemRepository.new

      new_item = Item.new
      new_item.item_name = 'New item'
      new_item.unit_price = '$1.50'
      new_item.quantity = '5'

      repo.create(new_item)
      items = repo.all
      last_item = items.last

      expect(last_item.item_name).to eq('New item')
      expect(last_item.unit_price).to eq('$1.50')
      expect(last_item.quantity).to eq('5')
    end
  end

  context "#delete" do
    it "Deletes an item" do
      repo = ItemRepository.new
      id_to_delete = 1
      repo.delete(id_to_delete)

      all_items = repo.all
      expect(all_items.length).to eq(2)
      expect(all_items.first.id).to eq('2')
    end
  end

end