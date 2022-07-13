require 'order_repository'
require 'order'
require 'database_connection'

def reset_shop_database
  seed_sql = File.read('spec/seeds_shop_manager.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager' })
  connection.exec_params(seed_sql)
end

describe OrderRepository do
  before(:each) do
    reset_shop_database
  end

  context "Rspec tests " do
    it "all_orders# method returns all 5 orders " do
      io = double :io
      repo = OrderRepository.new(io)
      orders = repo.all_orders

      expect(orders.length).to eq(5)
      expect(orders[0].id).to eq(1)
      expect(orders[0].customer_name).to eq("Joseph")
      expect(orders[0].order_date).to eq("2022-07-08")
      expect(orders[0].item_id).to eq(1)
      expect(orders.length).to eq(5)
    end

    it "new_order# method adds a new order " do
      io = double :io
      repo = OrderRepository.new(io)
      expect(io).to receive(:puts).with("Add order")
      expect(io).to receive(:puts).with("What is the order id?")
      expect(io).to receive(:gets).and_return(6)
      expect(io).to receive(:puts).with("What is the customer's name?")
      expect(io).to receive(:gets).and_return("Joy")
      expect(io).to receive(:puts).with("What is the order date?")
      expect(io).to receive(:gets).and_return("2022-07-09")
      expect(io).to receive(:puts).with("What is the ordered item's id?")
      expect(io).to receive(:gets).and_return(1)
      expect(io).to receive(:puts).with("Order added!")
      repo.add_order
      orders = repo.all_orders
      expect(orders.length).to eq(6)
      expect(orders.last.customer_name).to eq("Joy")
      expect(orders.last.order_date).to eq("2022-07-09")
    end

  end
end
