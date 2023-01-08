require "database_connection"
require "orders"

def reset_shop_manager_test_table
  seed_sql = File.read("spec/seed_shop_manager_test.sql")
  connection = PG.connect({ host: "127.0.0.1", dbname: "shop_manager_test" })
  connection.exec(seed_sql)
end

describe OrdersRepository do
  before(:each) do
    reset_shop_manager_test_table
  end
end
