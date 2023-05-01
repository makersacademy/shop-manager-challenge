require_relative '../app'

def reset_items_table
  seed_sql = File.read('spec/seeds_items.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

def reset_orders_table
  seed_sql = File.read('spec/seeds_orders.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

RSpec.describe Application do
  before(:each) do 
    reset_items_table
    reset_orders_table
  end

  context '#run' do
    it 'outputs the welcome interface' do
      io = double :io

      expect(io).to receive(:puts).with("Welcome to the shop management program!\n\n").ordered
      expect(io).to receive(:puts).with(
        "What do you want to do?\n" \
        "  1 = list all shop items\n" \
        "  2 = create a new item\n" \
        "  3 = list all orders\n" \
        "  4 = create a new order"
      ).ordered


      app = Application.new(
        'shop_manager_test',
        io,
        ItemRepository.new,
        OrderRepository.new
      )
      app.run
    end
  end
end