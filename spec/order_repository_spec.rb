require 'order_repository'

def reset_orders_table
    seed_sql = File.read('spec/seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager' })
    connection.exec(seed_sql)
end
  
describe OrderRepository do
    before(:each) do 
      reset_orders_table
    end 
  
    it "returns all orders" do
        repo = OrderRepository.new

        orders = repo.all
        expect(orders.length).to eq(3)
        
        expect(orders[0].id).to eq(1)
        expect(orders[0].customer).to eq('name1')
        expect(orders[0].date).to eq('2022-07-08')
        expect(orders[0].item_id).to eq(1)
        
        expect(orders[1].id).to eq(2)
        expect(orders[1].customer).to eq('name2')
        expect(orders[1].date).to eq('2022-07-09')
        expect(orders[1].item_id).to eq(2)
        
        expect(orders[2].id).to eq(3)
        expect(orders[2].customer).to eq('name3')
        expect(orders[2].date).to eq('2022-07-10')
        expect(orders[2].item_id).to eq(3)
    end
end