require 'item_repository'

RSpec.describe ItemRepository do

    def reset_items_table
        seed_sql = File.read('spec/items_orders.sql')
        connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
        connection.exec(seed_sql)
    end
      
    describe ItemRepository do
        before(:each) do 
            reset_items_table
        end


        it 'shows all items' do
            repo = ItemRepository.new

            items = repo.all
            expect(items.length).to eq 4
            expect(items.first.id).to eq '1'
            expect(items.first.name).to eq 'Eggs'
        end

        it 'returns a single item' do
            repo = ItemRepository.new

            item = repo.find(1)
            expect(item.name).to eq 'Eggs'
            expect(item.price).to eq '2.99'
        end

        it 'returns another item' do
            repo = ItemRepository.new

            item = repo.find(2)
            expect(item.name).to eq 'Coffee'
            expect(item.price).to eq '5.99'
        end

        

    end

end