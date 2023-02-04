require './app'
require 'item_repository'
require 'order_repository'

RSpec.describe 'class Application' do

def reset_tables
    seed_sql = File.read('spec/seeds_shop_db.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager' })
    connection.exec(seed_sql)
  end

before(:each) do 
   reset_tables
end
 
  it 'displays the list of all items' do
      item = ItemRepository.new
      order = OrderRepository.new
      terminal = double :terminal
      expect(terminal).to receive(:puts).with("Here is the list of items:").ordered
      expect(terminal).to receive(:puts).with("* 1 Butter Bear").ordered
      expect(terminal).to receive(:puts).with("* 2 Greek Yoghurt").ordered
      expect(terminal).to receive(:puts).with("* 3 Curry Rice").ordered
      expect(terminal).to receive(:puts).with("* 4 Chocolate").ordered
      shop = Application.new('shop_manager', terminal, item, order)
      shop.list_items
  end

    it 'creates a new item' do
      item_repo = ItemRepository.new
      order_repo = OrderRepository.new
      terminal = double :terminal
      expect(terminal).to receive(:puts).with("Enter item ID")
      expect(terminal).to receive(:gets).and_return("5")
      expect(terminal).to receive(:puts).with("Enter the name of item")
      expect(terminal).to receive(:gets).and_return("Onion Bhaji")
      expect(terminal).to receive(:puts).with("Enter the price of the item(in a whole number)")
      expect(terminal).to receive(:gets).and_return("6")
      expect(terminal).to receive(:puts).with("Enter item quantity")
      expect(terminal).to receive(:gets).and_return("10")
      expect(terminal).to receive(:puts).with("New item added")
      shop = Application.new('shop_manager', terminal, item_repo, order_repo)
      shop.create_item
  end


end