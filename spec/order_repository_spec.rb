require 'order_repository'
require 'item_repository'

def reset_orders_table
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

RSpec.describe OrderRepository do
  before(:each) do
    reset_orders_table
  end

  
end
