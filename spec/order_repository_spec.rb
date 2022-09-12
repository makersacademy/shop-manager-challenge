require 'order_repository'

describe OrderRepository do
    def reset_shop_table
        seed_sql = File.read('spec/seeds_items.sql')
        connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_test' })
        connection.exec(seed_sql)
    end

    before(:each) do 
        reset_shop_table
    end
    
    it 'return the list of all orders' do
        repo = OrderRepository.new

        order = repo.all

        expect(order.length).to eq 2
        
        expect(order[0].customer).to eq 'Guillermina'
        expect(order[0].date).to eq '2022-09-10'

        expect(order[1].customer).to eq 'Pablo'
        expect(order[1].date).to eq '2022-09-05'
        
    end

    it 'creates a new order' do
        repo = OrderRepository.new

        order = Order.new
        order.customer = 'Facundo'
        order.date = '2022-09-10'

        repo.create(order)

        all_orders = repo.all

        last_order = all_orders.last
        expect(last_order.customer).to eq 'Facundo'
        expect(last_order.date).to eq '2022-09-10'
    end
end