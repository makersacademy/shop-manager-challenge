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

    it "returns full list of orders" do
        repo = OrderRepository.new
        orders = repo.all

        expect(orders.length).to eq 5
        expect(orders[0].id).to eq 1
        expect(orders[0].customer_name).to eq 'John Smith'
        expect(orders[0].order_date).to eq '2023-01-01'
        expect(orders[0].item_id).to eq 1
    end

    context "it finds a single order" do
        it "returns John's order" do
            repo = OrderRepository.new
            order = repo.find(1)
    
            expect(order.id).to eq 1
            expect(order.customer_name).to eq 'John Smith'
            expect(order.order_date).to eq '2023-01-01'
            expect(order.item_id).to eq 1
        end

        it "returns Harry's order" do
            repo = OrderRepository.new
            order = repo.find(2)
    
            expect(order.id).to eq 2
            expect(order.customer_name).to eq 'Harry Styles'
            expect(order.order_date).to eq '2023-01-02'
            expect(order.item_id).to eq 2
        end
    end

    it "creates new order" do
        repo = OrderRepository.new

        order = Order.new
        order.customer_name = 'Dan Taylor'
        order.order_date = '2023-01-08'
        order.item_id = 3

        repo.create(order)


        expect(repo.all).to include (
            have_attributes(
                customer_name: 'Dan Taylor',
                order_date: '2023-01-08',
                item_id: 3
            )
        )
    end

    it "deletes an order" do
        repo = OrderRepository.new
        repo.delete(2)
        orders = repo.all

        expect(orders[1].customer_name).to eq 'Megan Rapinoe'
    end
end