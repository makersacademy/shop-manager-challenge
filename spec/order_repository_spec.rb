require './lib/order_repository.rb'

def reset_orders_table
    seed_sql = File.read('spec/order_seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
end

RSpec.describe  OrderRepostiory do
        
    before(:each) do 
        reset_orders_table
    end
   
    it "lists orders" do
        repo = OrderRepostiory.new
        orders = repo.all
        expect(orders.length).to eq(3)
        expect(orders.first.customer).to eq('David')
        expect(orders.first.date).to eq('2022-11-09')
        expect(orders.first.item_id).to eq('3')
    end

    it "creates a order" do
        repository = OrderRepostiory.new
        order = Order.new
        order.customer = 'Hana'
        order.date = "2022-01-09"
        order.item_id = "1"

        repository.create(order)

        all_orders = repository.all
	    last_order = all_orders.last
	    expect(last_order.customer ).to eq('Hana')
	    expect(last_order.date).to eq("2022-01-09")
	    expect(last_order.item_id).to eq("1")
    end



end