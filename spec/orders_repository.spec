require 'orders_repository'


RSpec.describe ItemsRepository do 

    def reset_table
        seed_sql = File.read('spec/seed_orders.sql')
        connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_challenge_test', password: 'a' })
        connection.exec(seed_sql)
      end

      describe ItemsRepository do
        before(:each) do 
          reset_table
        end
  
end 