# file: spec/order_repository_spec.rb

def reset_order_table
    seed_sql = File.read('spec/seeds_shop_manager_test.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
end
  
describe OrderRepository do
    before(:each) do 
        reset_order_table
    end
end
