require 'order_repository'
RSpec.describe OrderRepository do
    def reset_orders_table
        seed_sql = File.read('spec/seeds.sql')
        connection = PG.connect({ host: '127.0.0.1', dbname: 'order_items_test' })
        connection.exec(seed_sql)
    end
    before(:each) do 
        reset_orders_table
    end
    it 'returns length of table' do
        repo = OrderRepository.new
        items = repo.all
        expect(items.length).to eq (4)
    end
    it 'returns what the first customer name is' do
        repo = OrderRepository.new
        orders = repo.all
        expect(orders.first.customer_name).to eq ("David")
    end
    it 'returns what the last customer name is' do
        repo = OrderRepository.new
        orders = repo.all
        expect(orders.last.customer_name).to eq ("Annad")
    end
    it 'returns what the first date is' do
        repo = OrderRepository.new
        orders = repo.all
        expect(orders.first.the_date).to eq ("2022")
    end

end