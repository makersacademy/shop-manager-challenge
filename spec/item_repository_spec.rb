require 'item_repository'

RSpec.describe ItemRepository do

    def reset_table
        seed_sql = File.read('spec/seeds.sql')
        connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager' })
        connection.exec(seed_sql)
    end

    before(:each) do
        reset_table
    end

    it 'returns the list of users' do 
        repo = ItemRepository.new

        items = repo.all
        expect(items.length).to eq(2)
        expect(items.first.id).to eq('1')
        expect(items.first.price).to eq('200')
        expect(items.first.price).to eq('10')
    end
end

# testing ended due to simplecov error