# file: spec/item_repository_spec.rb

requie 'item_repository'

def reset_item_table
    seed_sql = File.read('spec/seeds_shop_manager_test.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
end
  
describe ItemRepository do
    before(:each) do 
        reset_item_table
    end
end