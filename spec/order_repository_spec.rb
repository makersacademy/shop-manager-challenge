require 'order_repository'

def reset_items_table
    seed_sql = File.read('spec/seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager' })
    connection.exec(seed_sql)
end
  
describe OrderRepository do
    before(:each) do 
        reset_items_table
    end

    it "returns the first order from db" do
        repo = OrderRepository.new
        orders = repo.all

        expect(orders.length).to eq 4

        expect(orders[0].id).to eq '1'
        expect(orders[0].customer_name).to eq 'Irina'
        expect(orders[0].date).to eq '2022-07-03 00:00:00'
    end

    it "returns the third order from db" do
        repo = OrderRepository.new
        orders = repo.all

        expect(orders[2].id).to eq '3'
        expect(orders[2].customer_name).to eq 'Julien'
        expect(orders[2].date).to eq '2022-07-02 00:00:00'
    end

    it 'creates a new order' do
        repo = OrderRepository.new
        order = Order.new
        order.customer_name = 'Timmy'
        order.date = '2021-07-02 00:00:00'

        repo.create(order)

        order = repo.all

        last_order = order.last
        expect(last_order.customer_name).to eq 'Timmy'
        expect(last_order.date).to eq '2021-07-02 00:00:00'
    end


end