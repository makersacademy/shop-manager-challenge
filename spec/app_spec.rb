require 'app'
require 'item_repository'
require 'order_repository'

def reset_tables
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

RSpec.describe Application do
  before(:each) do
    reset_tables
    @io = double :io
    @item = double :item, id:1, name:'cereal', unit_price:3, quantity:50
    @item_repo = double :item_repo, all:[@item]
    @order = double :order, id:1, customer_name:'customer_1', date:'2023-01-10 14:10:05', item_id:1
    @order_repo = double :order_repo, all:[@order]
    @app = Application.new('shop_manager',@io,@item_repo,@order_repo)

    expect(@io).to receive(:puts).with("Welcome to the shop manager program!")
    expect(@io).to receive(:puts).with("What do you want to do?")
    expect(@io).to receive(:puts).with("1 - list all shop items")
    expect(@io).to receive(:puts).with("2 - create a new item")
    expect(@io).to receive(:puts).with("3 - list all orders")
    expect(@io).to receive(:puts).with("4 - create a new order")
  end

  it "prints a list of items" do
    expect(@io).to receive(:gets).and_return('1')
    expect(@io).to receive(:puts).with("Here's a list of all shop items:")
    expect(@io).to receive(:puts).with("#1 cereal - unit price 3 - quantity 50")
    @app.run
  end

  it "creates a new item" do
    expect(@io).to receive(:gets).and_return('2')
    expect(@io).to receive(:puts).with("Please enter name of item")
    expect(@io).to receive(:gets).and_return("bread")
    expect(@io).to receive(:puts).with("Please enter unit price of item")
    expect(@io).to receive(:gets).and_return("2")
    expect(@io).to receive(:puts).with("Please enter quantity needed")
    expect(@io).to receive(:gets).and_return("120")
    expect(@io).to receive(:puts).with("New item: bread - unit price: 2 - quantity: 120")
    @app.run
  end

  it "prints a list of orders" do
    expect(@io).to receive(:gets).and_return('3')
    expect(@io).to receive(:puts).with("Here's a list of all orders:")
    expect(@io).to receive(:puts).with("#1 customer_1 - date 2023-01-10 14:10:05 - item_id 1")
    @app.run
  end

  it "creates a new order" do
    expect(@io).to receive(:gets).and_return('4')
    expect(@io).to receive(:puts).with("Please enter customer name")
    expect(@io).to receive(:gets).and_return("customer_4")
    expect(@io).to receive(:puts).with("Please enter item_id")
    expect(@io).to receive(:gets).and_return("1")
    expect(@io).to receive(:puts).with("New order: customer name customer_4 - date " + Time.now.strftime("%Y-%m-%d %H:%M:%S") + " - item_id 1")
    @app.run
  end
end