require 'item_repository'

def reset_items_table
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'items_orders_test' })
  connection.exec(seed_sql)
end

describe ItemRepository do
  before(:each) do 
    reset_items_table
  end

end