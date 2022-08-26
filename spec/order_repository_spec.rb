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
        describe '#add_order_to_orders' do
            it '' do
                repo = OrderRepository.new

                order = Order.new
                order.customer_name = 'Patrick'
                order.order_date = '2022-08-25'
                order.items_to_buy = [1]
              
                repo.send(:add_order_to_orders, order)
              
                expect(repo.all.length).to eq 3
                expect(repo.all.last.customer_name).to eq 'Patrick'
                expect(repo.all.last.order_date).to eq '2022-08-25'
            end
        end
        it 'adds an order object to the orders table' do
            repo = OrderRepository.new

            order = Order.new
            order.customer_name = 'Patrick'
            order.order_date = '2022-08-25'
            order.items_to_buy = [1]
          
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
            ordered_items = repo.find_items_by_order_id(3)
            expect(ordered_items.length).to eq 3
        end
        it 'does not create new order entry if the customer_name already exists' do
            repo = OrderRepository.new

            order = Order.new
            order.customer_name = 'Nick'
            order.order_date = '2022-08-25'
            order.items_to_buy = [3]
          
            repo.create(order)
            
            expect(repo.all.length).to eq 2
        end

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

    describe '#find_id_by_customer_name(customer_name)' do
        it 'Finds id 1 for Jimothy' do
            repo = OrderRepository.new
            id = repo.find_id_by_customer_name("Jimothy")
            
            expect(id).to eq 1
        end
        it 'Finds id when searching using an object' do
            repo = OrderRepository.new

            order = Order.new
            order.customer_name = 'Nick'


            id = repo.find_id_by_customer_name(order.customer_name)
            expect(id).to eq 2

        end
    end
end

