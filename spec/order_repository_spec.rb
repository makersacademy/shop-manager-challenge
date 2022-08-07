require_relative 'order_repository'

def reset_orders_table
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

RSpec.describe OrderRepository do
  before(:each) do 
    reset_order_table
  end

  # (your tests will go here).
end