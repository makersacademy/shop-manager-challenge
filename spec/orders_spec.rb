
def reset_orders_table
  seed_sql = File.read('spec/seeds_orders.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'orders' })
  connection.exec(seed_sql)
end

describe StudentRepository do
  before(:each) do 
    reset_orders_table
  end