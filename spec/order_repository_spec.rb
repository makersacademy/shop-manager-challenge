require 'order_repository'
RSpec.describe OrderRepository do
    def reset_orders_table
        seed_sql = File.read('spec/seeds.sql')
        connection = PG.connect({ host: '127.0.0.1', dbname: 'order_items_test' })
        connection.exec(seed_sql)
    end
    before(:each) do 
        rest_orders_table
    end

end