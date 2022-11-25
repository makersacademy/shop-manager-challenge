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
      expect(all_orders.length).to eq 3
      expect(first_order.id).to eq '1'
      expect(first_order.customer_name).to eq 'Aaa Bbb'
      expect(first_order.date_placed).to eq '2022-11-21'
      expect(last_order.id).to eq '3'
      expect(last_order.customer_name).to eq 'Eee Fff'
      expect(last_order.date_placed).to eq '1994-03-16'
    end
  end

  context 'create method' do
    it 'creates an order object which is also added to the database' do
      repo = OrderRepository.new
      order = Order.new
      order.customer_name = 'Iii Jjj'
      order.date_placed = '2022-11-24'
      repo.create(order,5,1)
      all_orders = repo.all
      last_order = all_orders.last
      expect(all_orders.length).to eq 4
      expect(last_order.id).to eq '4'
      expect(last_order.customer_name).to eq 'Iii Jjj'
      expect(last_order.date_placed).to eq '2022-11-24'
    end

    it "doesn't let you create and order if not enough stock" do
      repo = OrderRepository.new
      order = Order.new
      order.customer_name = 'Iii Jjj'
      order.date_placed = '2022-11-24'
      repo.create(order,40,4)
      all_orders = repo.all
      last_order = all_orders.last
      expect(all_orders.length).to eq 3
      expect(last_order.id).to eq '3'
      expect(last_order.customer_name).to eq 'Eee Fff'
      expect(last_order.date_placed).to eq '1994-03-16'
    end
  end
end
