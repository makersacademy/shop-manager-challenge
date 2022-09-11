require 'item_repository'

  def reset_item_table
    seed_sql = File.read('spec/item_table_seed.sql')
    connection = PG.connect({host: '127.0.0.1', dbname: 'shop_manager'})
    connection.exec(seed_sql)
  end

describe ItemRepository do
  begin(:each) do
    reset_item_table
  end
end