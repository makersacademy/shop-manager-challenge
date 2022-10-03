require './lib/orders_repository'

def reset_orders_table
  seed_sql = File.read('spec/seeds_orders.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager' })
  connection.exec(seed_sql)
end

describe OrderRepository do
  before(:each) do 
    reset_students_table
  end

  context "Listing shop orders" do
    it "lists first record" do

      repo = OrderRepository.new

      orders = repo.all

      expect(orders.length).to eq 3

      expect(orders.first.id).to eq '1'
      expect(orders.first.customer_name).to eq 'Stephen'
      expect(orders.first.date).to eq '2022-09-29'
    end

    it "lists 2nd record" do
      repo = OrderRepository.new

      orders = repo.all

      expect(orders.length).to eq 3
      expect(orders[1].id).to eq '2'
      expect(orders[1].customer_name).to eq 'Alan'
      expect(orders[1].date).to eq '2022-10-01'
    end
  end

  context "Adding new orders" do
    it "Adds a new order to the end of the table" do

      repo = OrderRepository.new
      order = Order.new

      order.customer_name = 'Ada'
      order.date = '2022-10-10'

      repo.create(order) # =>
      all_orders = repo.all
      last_order = all_orders.last

      expect(last_order.customer_name).to eq 'Ada'
      expect(last_order.date).to eq '2022-10-10'
    end
  end
end