require 'order_repository'

RSpec.describe OrderRepository do 
    def reset_orders_table
        seed_sql = File.read('spec/seeds.sql')
        connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager' })
        connection.exec(seed_sql)
    end
      
    before(:each) do 
        reset_orders_table
    end

    it "returns all orders" do
        repo = OrderRepository.new
        orders = repo.all
        expect(orders.length).to eq 3

        expect(orders[0].id).to eq "1" 
        expect(orders[0].cname).to eq "A"
        expect(orders[0].time).to eq "11:00"
        expect(orders[0].date).to eq "20.04.2022"

        expect(orders[1].id).to eq "2" 
        expect(orders[1].cname).to eq "B"
        expect(orders[1].time).to eq "12:00"
        expect(orders[1].date).to eq "21.04.2022"
    end 
    it "returns a single order" do 
        repo = OrderRepository.new
        order = repo.find(1)

        expect(order.id).to eq "1" 
        expect(order.cname).to eq "A"
        expect(order.time).to eq "11:00"
        expect(order.date).to eq "20.04.2022"
    end 

    it "creates new order and returns nil" do 
        repo = OrderRepository.new
        order = Order.new

        order.id = "5"
        order.cname = 'new'
        order.time = '21:00'
        order.date = '25.04.2022'

        repo.create(order)

        orders = repo.all
        expect(orders).to include(
            have_attributes(
                id: order.id,
                cname: order.cname, 
                time: order.time, 
                date: order.date
            )
        )
    end 

    it "deletes order" do 
        repo = OrderRepository.new
        repo.delete(1)
        orders = repo.all
        expect(orders.length).to eq 2
    end

    it "changes name" do 
        repo = OrderRepository.new
        repo.update(1, 'cname', "new")
        orders = repo.all
        expect(orders[2].id).to eq "1"
        expect(orders[2].cname).to eq "new"
        expect(orders[2].time).to eq "11:00"
        expect(orders[2].date).to eq "20.04.2022"
    end

    it "changes time" do  
        repo = OrderRepository.new
        repo.update(2, 'time', "20:00")
        orders = repo.all
        expect(orders[2].id).to eq "2"
        expect(orders[2].cname).to eq "B"
        expect(orders[2].time).to eq "20:00"
        expect(orders[2].date).to eq "21.04.2022"
    end
    
    it "changes date" do  
        repo = OrderRepository.new
        repo.update(2, 'date', "27.04.2022")
        orders = repo.all
        expect(orders[2].id).to eq "2"
        expect(orders[2].cname).to eq "B"
        expect(orders[2].time).to eq "12:00"
        expect(orders[2].date).to eq "27.04.2022"
    end

end 