require 'order_repository'
require 'order'

def reset_orders_table
    seed_sql = File.read('spec/seeds_orders.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
end
  
  RSpec.describe ItemRepository do
    before(:each) do 
      reset_orders_table
    end

    it "lists all the orders from the shop" do
        repo = OrderRepository.new

        orders = repo.all

        expect(orders.length).to eq 2

        expect(orders[0].id).to eq 1
        expect(orders[0].customer).to eq 'Jake'
        expect(orders[0].order_date).to eq '2022-01-30'
        expect(orders[0].item_id).to eq 1

        expect(orders[1].id).to eq 2
        expect(orders[1].customer).to eq 'Sophie'
        expect(orders[1].order_date).to eq '2022-01-01'
        expect(orders[1].item_id).to eq 2
    end

    it "finds a specific order from the order id 1" do
        repo = OrderRepository.new

        order = repo.find(1)

        expect(order.id).to eq 1
        expect(order.customer).to eq 'Jake'
        expect(order.order_date).to eq '2022-01-30'
        expect(order.item_id).to eq 1
    end

    it "adds an order to the shops order list" do
        repo = OrderRepository.new

        order = Order.new
        order.customer = 'Steve'
        order.order_date = '2022-09-02'
        order.item_id = 1

        repo.create(order) 

        orders = repo.all
        last_order = orders.last
        expect(orders.length).to eq 3
        expect(last_order.customer).to eq 'Steve'
        expect(last_order.order_date).to eq '2022-09-02'
        expect(last_order.item_id).to eq 1
    end
end