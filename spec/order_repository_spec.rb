require 'order_repository'

RSpec.describe OrderRepository do

    def reset_orders_table
        seed_sql = File.read('spec/seeds_orders.sql')
        connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
        connection.exec(seed_sql)
      end

      before(:each) do
        reset_orders_table
      end

      it 'returns the list of orders' do
        repo = OrderRepository.new
        orders = repo.all

        expect(orders.length).to eq(2)

        expect(orders.first.id).to eq('1')
        expect(orders.first.customer_name).to eq('Maya')
      end

      it 'returns a single order' do
        repo = OrderRepository.new

        order = repo.find(1)
        expect(order.customer_name).to eq('Maya')
        expect(order.date).to eq('2004-11-03 15:40:12')
        expect(order.item_id).to eq('2')
      end

      it 'returns another single order' do
        repo = OrderRepository.new

        order = repo.find(2)
        expect(order.customer_name).to eq('Anna')
        expect(order.date).to eq('2004-10-19 10:23:54')
        expect(order.item_id).to eq('1')
      end

      it 'returns a new order' do
        repo = OrderRepository.new

        new_order = Order.new
        new_order.customer_name ='Adrian'
        new_order.date = '2004-07-15 13:32:45'
        new_order.item_id = '2'

        repo.create(new_order) # => nil

        orders = repo.all
        last_order = orders.last

        expect(last_order.customer_name).to eq('Adrian')
        expect(last_order.date).to eq('2004-07-15 13:32:45')
        expect(last_order.item_id).to eq('2')
      end
    end
