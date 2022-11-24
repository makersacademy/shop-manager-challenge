require 'order_repository'
require 'item_repository'
require 'order'

describe OrderRepository do
  def reset_items_table
    seed_sql = File.read('spec/seeds_items.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'orders_items_test' })
    connection.exec(seed_sql)
  end

  def reset_orders_table
    seed_sql = File.read('spec/seeds_orders.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'orders_items_test' })
    connection.exec(seed_sql)
  end

  def reset_orders_items_table
    seed_sql = File.read('spec/seeds_orders_items.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'orders_items_test' })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_items_table
    reset_orders_table
    reset_orders_items_table
  end

  context 'create method' do
    it 'updates the quantity of items in the data base' do
      order_repo = OrderRepository.new
      item_repo = ItemRepository.new
      order = Order.new
      order.customer_name = 'Iii Jjj'
      order.date_placed = '2022-11-24'
      order_repo.create(order,5,1)
      all_items = item_repo.all
      updated_item = all_items.last
      expect(updated_item.id).to eq '1'
      expect(updated_item.quantity).to eq '95'
    end
  end
end
