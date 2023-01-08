require_relative '../lib/order_repository'


RSpec.describe OrderRepository do 

    def reset_orders_table
        seed_sql = File.read('spec/seeds.sql')
        connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
        connection.exec(seed_sql)
    end
      
    
    before(:each) do 
        reset_orders_table
    end

    it 'returns all orders' do 
        repo = OrderRepository.new

        order = repo.all

        expect(order.length).to eq(2)

        expect(order[0].id).to eq('1')
        expect(order[0].customer_name).to eq('David')
        expect(order[0].date).to eq('2022-01-04')

        expect(order[1].id).to eq('2')
        expect(order[1].customer_name).to eq('Anna')
        expect(order[1].date).to eq('2022-01-05')
    end 
    it 'returns single order' do 
        repo = OrderRepository.new

        order = repo.find(1)

        expect(order.id).to eq('1')
        expect(order.customer_name).to eq('David')
        expect(order.date).to eq('2022-01-04')
    end 

    it 'creates new order' do 
        repo = OrderRepository.new

        order = Order.new
        order.customer_name = 'Mike'
        order.date = '2023-01-01'
        

        repo.create(order)

        orders = repo.all
        last_order = orders.last
        expect(last_order.customer_name).to eq('Mike')
        expect(last_order.date).to eq('2023-01-01')
        

    end 

    it 'updates the order' do 
        repo = OrderRepository.new

        order = repo.find(1)
        order.customer_name = 'name_updated'
        order.date = '2021-08-08'
        
        
        repo.update(order)
        updated_order = repo.find(1)
        expect(updated_order.id).to eq('1')
        expect(updated_order.customer_name).to eq('name_updated')
        expect(updated_order.date).to eq('2021-08-08')
    end

    it 'deletes the order' do
        repo = OrderRepository.new

        delete_order = repo.delete('1')
        orders = repo.all
        
        expect(orders.length).to eq(1)
        
        expect(orders.first.id).to eq('2')
        expect(orders.first.customer_name).to eq('Anna')
        expect(orders.first.date).to eq('2022-01-05')
    end 

end 