require 'order_repository'

  def reset_table
    seed_sql = File.read('spec/table_seed.sql')
    connection = PG.connect({host: '127.0.0.1', dbname: 'shop_manager'})
    connection.exec(seed_sql)
  end

describe ItemRepository do
  before(:each) do
    reset_table
  end
end