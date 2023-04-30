require 'order_repository'

RSpec.describe OrderRepository do
    def reset_items_table
        seed_sql = File.read('spec/items_orders.sql')
        connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
        connection.exec(seed_sql)
    end
      
    describe ItemRepository do
        before(:each) do 
            reset_items_table
        end

        it 'returns a list of orders' do
            repo = OrderRepository.new
            expect(repo.all.length).to eq 4
        end

    end
end