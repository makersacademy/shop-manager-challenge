require 'Order_Repo'
require 'Order'

def reset_shop_table
    seed_sql = File.read('spec/seeds_test.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end
  
 RSpec.describe Orders_Repo do
    before(:each) do 
      reset_shop_table
    end
        it 'Should list all the orders in the database' do
            repo = Orders_Repo.new
            orders = repo.all
            expect(orders.length).to eq 2 
            expect(orders[0].id.to_i).to eq 1 
            expect(orders[0].customer_name).to eq "John"
            expect(orders[0].date).to eq "02/01/22"
            expect(orders[0].item_id.to_i).to eq 1
        end
        it 'Should create a new order in the database' do
            New_Order = Orders.new
            repo = Orders_Repo.new
            orders = repo.all 
            New_Order.customer_name = "Dave"
            New_Order.date = "23/11/22"
            New_Order.item_id = 1
            repo.create(New_Order)
            expect(repo.all.length).to eq 3 
            expect(repo.all[2].id.to_i).to eq 3
            expect(repo.all[2].customer_name).to eq "Dave"
            expect(repo.all[2].date).to eq "23/11/22"
            expect(repo.all[2].item_id.to_i).to eq 1
        end
    end