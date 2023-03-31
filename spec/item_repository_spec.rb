# file: spec/item_repository_spec.rb

require './lib/item_repository'

def reset_item_table
    seed_sql = File.read('spec/seeds_shop_manager_test.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
end
  
describe ItemRepository do
    before(:each) do 
        reset_item_table
    end

    it 'tests the the all method' do 
        repo = ItemRepository.new
        item = repo.all

        expect(item.length).to eq 2
        expect(item[1].id).to eq '2'
        expect(item[1].name).to eq 'glue'  
        expect(item[1].price).to eq '2.99'
        expect(item[1].quantity).to eq '5'
    end
end