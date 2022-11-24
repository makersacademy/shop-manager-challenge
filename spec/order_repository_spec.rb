require 'order_repository'

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

  context 'all method' do
    it 'returns an array of all orders' do
      repo = OrderRepository.new
      all_orders = repo.all
      first_order = all_orders.first
      last_order = all_orders.last
      expect(all_orders.length).to eq 4
      expect(first_order.id).to eq '1'
      expect(first_order.customer_name).to eq 'Aaa Bbb'
      expect(first_order.date_placed).to eq '2022-11-21'
      expect(last_order.id).to eq '4'
      expect(last_order.customer_name).to eq 'Ggg Hhh'
      expect(last_order.date_placed).to eq '2015-07-21'
    end
  end
end