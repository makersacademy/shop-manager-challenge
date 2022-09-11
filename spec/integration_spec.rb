def reset_items_orders_table
  seed_sql = File.read('spec/seeds_items_orders.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'book_store_solo_test'})
  connection.exec(seed_sql)
end

describe "integration" do
  before(:each) do 
    reset_items_orders_table
  end


end
