require 'order_repository'

def reset_students_table
    seed_sql = File.read('spec/items_orders_test.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
end

    

RSpec.describe OrderRepository do
    before(:each) do 
        reset_students_table
    end

    describe '#all' do
        it 'returns array of all order objects' do
            repo = OrderRepository.new

            orders = repo.all

            expect(orders.length).to eq 2

            expect(orders[0].id).to eq 1
            expect(orders[0].customer_name).to eq 'Jimothy'
            expect(orders[0].order_date).to eq '2022-05-07'

            expect(orders[1].id).to eq 2
            expect(orders[1].customer_name).to eq 'Nick'
            expect(orders[1].order_date).to eq '2022-04-25'
        end
    end

    describe '#create' do
        it 'adds an order object to the orders table' do
            repo = OrderRepository.new

            order = Order.new
            order.customer_name = 'Patrick'
            order.order_date = '2022-08-25'
            order.items_to_buy = [1,2,3]
          
            repo.create(order)
          
            expect(repo.all.length).to eq 3
            expect(repo.all.last.customer_name).to eq 'Patrick'
            expect(repo.all.last.order_date).to eq '2022-08-25'
        end
        it 'joins a new object to items in the items_orders table' do
            repo = OrderRepository.new

            order = Order.new
            order.customer_name = 'Patrick'
            order.order_date = '2022-08-25'
            order.items_to_buy = [1,2,3]
          
            repo.create(order)
        end
    describe '#find_items_by_order_id' do
        it 'Finds 3 items matching order_id 1' do
            repo = OrderRepository.new
            items = repo.find_items_by_order_id(1)
            
            expect(items.length).to eq 3
            
            expect(items[0].item_name).to eq 'Smart Watch'
            expect(items[0].item_price).to eq 250.0
        end
    end
    end
end

