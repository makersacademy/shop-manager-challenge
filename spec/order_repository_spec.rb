require 'order_repository'
require 'order'

def reset_tables
    seed_sql = File.read('spec/seeds_tables.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
end
  
describe OrderRepository do
    before(:each) do 
      reset_tables
    end

    it "gets all orders" do
        # 1
        # Get all orders

        repo = OrderRepository.new

        orders = repo.all

        expect(orders.length).to eq 3

        expect(orders[0].id).to eq '1'
        expect(orders[0].customer_name).to eq 'Bob'
        expect(orders[0].date).to eq '2022-10-20'
        expect(orders[0].items).to eq ['3']

        expect(orders[2].id).to eq '3'
        expect(orders[2].customer_name).to eq 'Mavis'
        expect(orders[2].date).to eq '2021-08-10'
        expect(orders[2].items).to eq ['1', '2', '3']
    end

    it "creates an order" do

        # 2
        # Create an order

        repo = OrderRepository.new

        order = Order.new
        order.customer_name = 'Andy'
        order.date = '10-21-2022'
        order.items = ['1', '2']

        repo.create(order)

        result = repo.all

        expect(result[3].id).to eq '4'
        expect(result[3].customer_name).to eq 'Andy'
        expect(result[3].date).to eq '2022-10-21'
        expect(result[3].items).to eq ['1', '2']
    end
end