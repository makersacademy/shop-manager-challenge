require 'order_repository'

describe OrderRepository do
    def reset_orders_table
        seed_sql = File.read('spec/seeds.sql')
        connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_challenge_test' })
        connection.exec(seed_sql)
    end

    before(:each) do 
        reset_orders_table
    end

    it 'returns all orders and their info' do
        repo = OrderRepository.new
        order = repo.all

        expect(order[0].id).to eq 1
        expect(order[0].customer_name).to eq "Grace"
        expect(order[0].date).to eq "2022-11-26"

        expect(order[1].id).to eq 2
        expect(order[1].customer_name).to eq "Frankie"
        expect(order[1].date).to eq "2022-11-24"
    end

    it 'creates a new order' do
        repo = OrderRepository.new

        new_order = Order.new

        new_order.id = 3
        new_order.customer_name = "Magdaline"
        new_order.date = "2022-11-27"

        repo.create(new_order)
        all_orders = repo.all

        expect(all_orders).to include(have_attributes(customer_name: new_order.customer_name, date: new_order.date,))
    end
end