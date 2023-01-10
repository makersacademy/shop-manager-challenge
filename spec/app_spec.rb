require './app.rb'
require_relative '../lib/Item_Repo'
require_relative '../lib/Order_Repo'

def reset_shop_table
    seed_sql = File.read('spec/seeds_test.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end
  
 RSpec.describe Application do
    before(:each) do 
      reset_shop_table
    end

    it "greets the user" do
        io = double :io
        order_repo = Orders_Repo.new
        item_repo = Items_Repo.new
        expect(io).to receive(:puts).with("Welcome to shop management program!")
        expect(io).to receive(:puts).with("What do you want to do?")
        expect(io).to receive(:puts).with("1 = list all shop items")
        expect(io).to receive(:puts).with("2 = create a new item")
        expect(io).to receive(:puts).with("3 = list all orders")
        expect(io).to receive(:puts).with("4 = create a new order")
        app = Application.new('shop_manager_test', io, item_repo, order_repo)
        app.run
    end
    it "It displays all hte shop items" do 
        io = double :io
        Order_Repo = Orders_Repo.new
        Item_Repo = Items_Repo.new
        expect(io).to receive(:puts).with("Welcome to shop management program!")
        expect(io).to receive(:puts).with("What do you want to do?").ordered
        expect(io).to receive(:puts).with("1 = list all shop items").ordered
        expect(io).to receive(:puts).with("2 = create a new item").ordered
        expect(io).to receive(:puts).with("3 = list all orders").ordered
        expect(io).to receive(:puts).with("4 = create a new order").ordered
        expect(io).to receive{:gets}.and_return("1").ordered
        expect(io).to receive(:puts).with("Here is the list of items").ordered
        expect(io).to receive(:puts).with("1 - Toothpaste - £3.40 - 10").ordered
        expect(io).to receive(:puts).with("2 - Mouthwash - £5.00 - 20").ordered
        app = Application.new('shop_manager_test', io, items_repo, orders_repo)
        app.run
    end
  end