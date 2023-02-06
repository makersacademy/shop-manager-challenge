require_relative '../app.rb'

def reset_tables
  seed_sql = File.read('spec/seeds_items_orders.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end
describe ItemRepository do
  before(:each) do 
    reset_tables
    io = double :io

  end
end