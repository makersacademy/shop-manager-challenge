require 'order_repository.rb'
require 'order.rb'

RSpec.describe OrderRepository do
    def reset_orders_repos
        seed_sql = File.read('spec/seeds.sql')
        connection = PG.connect({ host: '127.0.0.1', dbname: 'shop' })
        connection.exec(seed_sql)
    end
    before(:each) do 
        reset_orders_repos
    end
    it 'selects all orders' do
        orRe = OrderRepository.new()
        result = orRe.all()
        expect(
            result[0].id
        ).to eq "1"
    end
    it 'selects order at ID' do
        orRe = OrderRepository.new()
        #
        result = orRe.find(1,"id")
        expect(
            result.customername
        ).to eq "John Doe"
    end
    it 'creates an order' do
        orRe = OrderRepository.new()
        #
        orM = Order.new()
        orM.item=2;
        orM.customername="Jane Doe"
        orRe.create(orM)
        #
        result = orRe.find("Jane Doe","customername")
        expect(
            result.customername
        ).to eq "Jane Doe"
    end
end