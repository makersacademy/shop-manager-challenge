require 'item_repository'

RSpec.describe ItemRepository do
  def reset_items_table
    seed_sql = File.read('spec/seeds_shop.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_test' })
    connection.exec(seed_sql)
  end

  describe ItemRepository do
    before(:each) do
      reset_items_table
    end

    # (your tests will go here).
  end




end