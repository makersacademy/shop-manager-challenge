require_relative '../app'
require 'date'

describe Application do
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

  context 'initial output to terminal' do
    it 'welcomes and prints a menu' do
      io = double :io
      order_repo = double :OrderRepository
      item_repo = double :ItemRepository
      expect(io).to receive(:puts).with("Welcome to the shop management program!\n")
      expect(io).to receive(:puts).with("What would you like to do?")
      expect(io).to receive(:puts).with(' 1 - List all shop items')
      expect(io).to receive(:puts).with(' 2 - Create a new item')
      expect(io).to receive(:puts).with(' 3 - List all orders')
      expect(io).to receive(:puts).with(' 4 - Create a new order')
      expect(io).to receive(:puts).with(' 9 - Exit')
      app = Application.new('orders_items_test', io, item_repo, order_repo)
      app.print_intro
      app.print_menu
    end
  end

  
  
end
