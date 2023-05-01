require 'order_repository'

RSpec.describe OrderRepository do
    def reset_orders_table
        seed_sql = File.read('spec/items_orders.sql')
        connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
        connection.exec(seed_sql)
    end
      
    describe OrderRepository do
        before(:each) do 
            reset_orders_table
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

        it 'deletes an order' do
            repo = OrderRepository.new
            id_to_delete = 1
            repo.delete(id_to_delete)

            expect(repo.all.length).to eq 3 
        end

        it 'returns order 1 alongside related items' do
            repo = OrderRepository.new
            order = repo.find_with_items(1)
            item = double :item, name: 'Eggs'

            expect(item.name).to eq 'Eggs'
        end

        it 'returns order 2 alongside related items' do
            repo = OrderRepository.new
            order = repo.find_with_items(2)
            item = double :item, name: ['Eggs' 'Coffee']
            
            expect(item.name).to eq ['Eggs' 'Coffee']
        end

    end
end