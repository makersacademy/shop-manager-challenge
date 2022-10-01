require_relative  '../lib/item_repository.rb'
require_relative '../lib/database_connection'

RSpec.describe ItemRepository do
    def reset items_table
        seed_sql = File.read('spec/items_seeds.sql')
        connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
        connection.exec(seed_sql)
    end

    before(:each) do 
      reset_items_table
    end

    it 'returns a list of model cars' do
  
      repo = ItemRepository.new
      items = repo.all
      expect(item.length).to eq 4
    end
    
    xit 'returns a list of models' do
      repo = ItemRepository.new
      items = repo.all
      expect(items[0].name).to eq "Porshe" 
      expect(items[4].name).to eq "Saab VW"
      expect(items[2].quantity).to eq "3" 
      expect(items[1].price_units).to eq "50"
    end

    
    xit 'returns a new creation' do

      repo = ItemRepository.new
      repo.create("Lambo",10, 300)
      items = repo.all

      expect(items.length).to eq 6
      expect(items[5].name).to eq "Lambo" 
      expect(items[5].price_units).to eq "100"  
    end
end