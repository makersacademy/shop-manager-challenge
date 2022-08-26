require 'item_repository'
require 'item'

RSpec.describe ItemRepository do
    def reset_items_table
        seed_sql = File.read('spec/items_orders_test.sql')
        connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
        connection.exec(seed_sql)
    end
    
    before(:each) do 
        reset_items_table
    end

    describe '#all' do
        it 'Returns array of all item objects' do
            repo = ItemRepository.new
    
            items = repo.all
    
            expect(items.length).to eq 4
    
            expect(items[0].id).to eq 1
            expect(items[0].item_name).to eq 'Smart Watch'
            expect(items[0].item_price).to eq 250.0
            expect(items[0].item_quantity).to eq 60
    
            expect(items[1].item_name).to eq 'USB C to USB adapter'
            expect(items[1].item_price).to eq 8.99
            expect(items[1].item_quantity).to eq 430
        end
    end
    
    describe '#create' do
        it 'adds a new item to the items table' do
            repo = ItemRepository.new

            item = Item.new
            item.item_name = 'Crisps'
            item.item_price = 0.99
            item.item_quantity = 999

            repo.create(item)
            all_items = repo.all
            expect(all_items.length).to eq 5
            expect(all_items.last.item_name).to eq 'Crisps'
            expect(all_items.last.item_price).to eq 0.99
            expect(all_items.last.item_quantity).to eq 999
        end
    end

    describe '#find_by_item_name' do
        it 'Finds smart watch from items table and returns item object' do
            repo = ItemRepository.new

            found_item = repo.find_by_item_name('Smart Watch')

            expect(found_item.id).to eq 1
            expect(found_item.item_name).to eq 'Smart Watch'
            expect(found_item.item_price).to eq 250.0
            expect(found_item.item_quantity).to eq 60
        end
    end
end
