# file: spec/order_repository_spec.rb

require 'order_repository'

def reset_order_table
    seed_sql = File.read('spec/seeds_shop_manager_test.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
end
  
describe OrderRepository do
    before(:each) do 
        reset_order_table
    end

    it 'tests all method' do
        repo = OrderRepository.new

        orders = repo.all

        expect(orders.length).to eq 2
        expect(orders[0].id).to eq '1'
        expect(orders[0].customer).to eq 'chris'
    end

    it 'tests the create method' do
        repo = OrderRepository.new

        new_order = Order.new

        new_order.id = '3'
        new_order.customer = "sunny"
        new_order.date = '1999-01-08'
        new_order.order_id = '1'

        order = repo.create(new_order)
        
        created_order = repo.all
        expect(created_order.last).to (
            having_attributes(
            id: '3',
            customer: 'sunny',
            date: '1999-01-08',
            order_id: '1'
            )
        )
    end
end

