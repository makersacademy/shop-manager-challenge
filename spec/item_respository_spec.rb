require 'item_repository'
require 'item'

def reset_items_table
    seed_sql = File.read('spec/seeds_items.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
end
  
  RSpec.describe ItemRepository do
    before(:each) do 
      reset_items_table
    end
  
    it "return all the items in the shop" do
        repo = ItemRepository.new

        items = repo.all

        expect(items.length).to eq 2

        expect(items[0].id).to eq 1
        expect(items[0].name).to eq 'shoes'
        expect(items[0].price).to eq 120
        expect(items[0].quantity).to eq 10

        expect(items[1].id).to eq 2
        expect(items[1].name).to eq 'jacket'
        expect(items[1].price).to eq 250
        expect(items[1].quantity).to eq 15
    end

    it "finds a single item from the shop at id 1" do
        repo = ItemRepository.new

        item = repo.find(1)

        expect(item.id).to eq 1
        expect(item.name).to eq 'shoes'
        expect(item.price).to eq 120
        expect(item.quantity).to eq 10
    end

    it "creates a new item for the shop" do
        repo = ItemRepository.new

        item = Item.new
        item.name = 'jeans'
        item.price = 180
        item.quantity = 50

        repo.create(item) 

        items = repo.all
        last_item = items.last
        expect(items.length).to eq 3
        expect(last_item.name).to eq 'jeans'
        expect(last_item.price).to eq 180
        expect(last_item.quantity).to eq 50
    end
  end