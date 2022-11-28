require 'item_repository'
require 'item'

RSpec.describe ItemRepository do

    def reset_items_table
        seed_sql = File.read('spec/seeds_items.sql')
        connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_2_test' })
        connection.exec(seed_sql)
      end
      

        before(:each) do 
          reset_items_table
        end

    it 'gets all items' do
        repo = ItemRepository.new
        all_items = repo.all

        expect(all_items[0]['name']).to eq 'Banana'
        expect(all_items[0]['price']).to eq '$2.00'
        expect(all_items[0]['quantity']).to eq "14"
    end

    it 'adds an item' do
        repo = ItemRepository.new
        item = Item.new
        item.name = 'chocolate'
        item.price = '4.00'
        item.quantity = 6

        repo.create(item)
        items = repo.all

        expect(items[2]['name']).to eq 'chocolate'
        expect(items[2]['price']).to eq '$4.00'
        expect(items[2]['quantity']).to eq '6'
    end
end