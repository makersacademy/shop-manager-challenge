require "orders_repository"

RSpec.describe OrdersRepository do 

    def reset_orders_table
        seed_sql = File.read('spec/shop_seeds.sql')
        connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager' })
        connection.exec(seed_sql)
    end
      
    describe OrdersRepository do
        before(:each) do 
          reset_orders_table
        end
    end 

    it "returns all the order list" do 

        repo = OrdersRepository.new

        orders = repo.all

        expect(orders.length).to eq(2)

        expect(orders[0].id).to eq("1")
        expect(orders[0].name).to eq("Blake ODonnell")  
        expect(orders[0].order_number).to eq("1")   
        expect(orders[0].date).to eq("2022-10-02")
    end

    it "create a new order entry" do

        repo = OrdersRepository.new
        new_order = Orders.new

        new_order.name = "Joe Bloggs"
        new_order.order_number = "3" 
        new_order.date = "2022-10-03"
        repo.create(new_order)

        all_orders = repo.all

        expect(all_orders). to include(
        have_attributes(
        name: new_order.name,
        order_number: new_order.order_number,
        date: new_order.date,
        )   
        )
    end
end  

