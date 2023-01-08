require 'order_repository'

RSpec.describe OrderRepository do
    def reset_orders_table
        seed_sql = File.read('spec/seeds_tests.sql')
        connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
        connection.exec(seed_sql)
    end

    before(:each) do 
        reset_orders_table
    end

    it 'Get all orders' do
        repo = OrderRepository.new
        orders = repo.all
        expect(orders.length).to eq 2
        expect(orders[0].id).to eq 1
        expect(orders[1].customer_name).to eq "Bob Boberto"
        expect(orders[0].order_date).to eq '7 Jan 2023'
        expect(orders[1].item_id).to eq 2
    end

    it 'Adds a new order' do
        repo = OrderRepository.new
        order = Order.new
        order.customer_name = 'Bugs Bunny'
        order.order_date = '8 Jan 2023'
        order.item_id = 1
        repo.create(order)
        all_orders = repo.all
        expect(all_orders.length).to eq 3
        expect(all_orders.last.id).to eq 3
        expect(all_orders.last.customer_name).to eq 'Bugs Bunny'
        expect(all_orders.last.item_id).to eq 1
    end
end