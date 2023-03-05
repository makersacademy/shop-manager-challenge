require 'orders_repository'
require 'orders'


RSpec.describe OrdersRepository do 

    def reset_table
        seed_sql = File.read('spec/seed_orders.sql')
        connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_challenge_test', password: 'a' })
        connection.exec(seed_sql)
      end

      describe OrdersRepository do
        before(:each) do 
          reset_table
        end

        describe "all method" do 
          it "lists all orders" do
            repo = OrdersRepository.new
            result=repo.all
            expect(result.first.id).to eq 1
            expect(result.first.customer_name).to eq 'Henry Smith'
            expect(result.first.order_date).to eq '2023-12-02'
            expect(result.first.item_id).to eq 1

          end
        end

        describe "create method" do
          it 'adds a new order' do
            order = Orders.new
            order.customer_name = "Sarah Makers"
            order.order_date = "1997-05-28"
            order.item_id = 1 

            repo = OrdersRepository.new
            repo.create(order)
            result = repo.all

            expect(result.last.customer_name).to eq "Sarah Makers"
            expect(result.last.order_date).to eq "1997-05-28"
            expect(result.last.item_id).to eq 1
          end 
        end
  
    end 
end