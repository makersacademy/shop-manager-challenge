require 'order_repository'

  def reset_item_table
    seed_sql = File.read('spec/order_table_seed.sql')
    connection = PG.connect({host: '127.0.0.1', dbname: 'shop_manager'})
    connection.exec(seed_sql)
  end

describe ItemRepository do
  begin(:each) do
    reset_order_table
  end
end