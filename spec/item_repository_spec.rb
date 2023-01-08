require 'item_repository'

RSpec.describe ItemRepository do
    def reset_items_table
      seed_sql = File.read('spec/seeds_tests.sql')
      connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
      connection.exec(seed_sql)
    end
  
    before(:each) do 
      reset_items_table
    end
  
    it 'Get all items' do

        repo = ItemRepository.new

        items = repo.all

        expect(items.length).to eq 2

        expect(items[0].id).to eq 1
        expect(item[1].name).to eq 'Makerspresso Coffee Machine'
        expect(item[0].unit_price).to eq 99
        expect(item[1].quantity).to eq 15
    end

    it 'Adds a new item' do

        repo = ItemRepository.new

        item = Item.new
        item.name = 'Black Rubber Duck'
        item.unit_price = 5
        item.quantity = 150

        repo.create(item)

        all_items = repo.all

        expect(all_items.length).to eq 3
        expect(all_items.last.id).to eq 3
        expect(all_items.last.name).to eq 'Black Rubber Duck'
        expect(all_items.last.quantity).to eq 150
    end
end