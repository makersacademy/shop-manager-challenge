require 'order'
require 'order_repository'
require 'item'

def reset_tables
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'items_orders_test' })
  connection.exec(seed_sql)
end

describe OrderRepository do
  before(:each) do 
    reset_tables
  end

end