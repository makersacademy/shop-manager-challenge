require 'item_repository'


RSpec.describe ItemRepository do
def reset_shop_manager_table
  seed_sql = File.read('spec/seeds_shop_manager.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end


before(:each) do 
  reset_shop_manager_table
end

  # (your tests will go here).
end