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

        it 'returns a single order' do
            repo = OrderRepository.new
            first_order = repo.find(1)
            expect(first_order.customer_name).to eq 'John Key'
            expect(first_order.date).to eq '2023-01-08'
        end

        it 'creates a new order' do
            repo = OrderRepository.new

            order = Order.new
            order.customer_name = 'Jo Blogs'
            order.date = '2023-01-11'
            
            repo.create(order)

            expect(repo.all.length).to eq 5
        end

    end
end