require_relative  '../lib/order_repository.rb'
require_relative  '../lib/database_connection'

RSpec.describe OrderRepository do
    def reset orders_table
        seed_sql = File.read('spec/items_seeds.sql')
        connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
        connection.exec(seed_sql)
    end

    before(:each) do 
      reset_orders_table
    end

    it 'returns all orders of model cars' do
  
      repo = OrderRepository.new
      repo.create_order("Johnny Bravo"[1,3,4])
      expect(repo.all.length).to eq 12
    end
    
    xit 'returns a new creation' do

      repo = OrderRepository.new
      repo.create("Bugs Bunny",[2])

      expect(repo.all.length).to eq 7
      expect(repo.all.[6].name).to eq "Bugs Bunny" 
      
    end
end