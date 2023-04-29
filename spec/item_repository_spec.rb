require_relative '../lib/item_repository'
require_relative "../lib/database_connection"


RSpec.describe ItemRepository do
  def reset_items_and_orders_tables
    seed_sql = File.read('spec/seeds_shop_manager.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end

  describe ItemRepository do
    before(:each) do 
      reset_items_and_orders_tables
    end

    it "returns a list of all the items" do
      repo = ItemRepository.new

      items = repo.all
      
      expect(items.length).to eq 3
      expect(items[0].id).to eq '1'
      expect(items[0].name).to eq 'Coffee Machine'
      expect(items[0].unit_price).to eq '99'
      expect(items[0].stock_quantity).to eq '7'

      expect(items[2].id).to eq '3'
      expect(items[2].name).to eq 'Curtain'
      expect(items[2].unit_price).to eq '34'
      expect(items[2].stock_quantity).to eq '205'
    end
  end
end
  # # 2
  # # Add a new item
  
  # repo = ItemRepository.new
  # repo.create('Table', '147', '21')
  # items = repo.all
  # items.length # =>  4