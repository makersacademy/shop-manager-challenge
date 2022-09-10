require 'item_repository'

describe ItemRepository do
    def reset_shop_table
        seed_sql = File.read('spec/seeds_items.sql')
        connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_test' })
        connection.exec(seed_sql)
    end

    before(:each) do 
        reset_shop_table
    end

    it 'return the list of all items' do
        repo = ItemRepository.new

        item = repo.all

        expect(item.length).to eq 2
        
        expect(item[0].stock).to eq '3'
        expect(item[0].name).to eq 'Coffee'
        expect(item[0].price).to eq '5'
        expect(item[0].order_id).to eq '1'

        expect(item[1].stock).to eq '5'
        expect(item[1].name).to eq 'Milk'
        expect(item[1].price).to eq '3'
        expect(item[1].order_id).to eq '2'

    end
end