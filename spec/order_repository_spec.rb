require 'order_repository'


def reset_orders_table
  seed_sql = File.read('spec/seeds_shop.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_test' })
  connection.exec(seed_sql)
end

describe OrderRepository do
  before(:each) do
    reset_orders_table
  end

  # (your tests will go here).
end
