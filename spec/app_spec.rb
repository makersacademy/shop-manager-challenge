require_relative '../app'
require 'database_connection'

def reset_table
  seed_sql = File.read('spec/seeds.sql')
  if ENV['PG_password']
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test', password: ENV['PG_password']})
  else
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test'})
  end
  connection.exec(seed_sql)
end

RSpec.describe Application do
  before(:each) do
    reset_table
  end

  it "runs command line shop management program and ask for list all shop items" do 
    io_double = double :fake_io
    expect(io_double).to receive(:puts).with("What do you want to do?").ordered
    expect(io_double).to receive(:puts).with(" 1 = list all shop items").ordered
    expect(io_double).to receive(:puts).with(" 2 = create a new item").ordered
    expect(io_double).to receive(:puts).with(" 3 = list all orders").ordered
    expect(io_double).to receive(:puts).with(" 4 = create a new order").ordered
    expect(io_double).to receive(:gets).and_return("1").ordered
    expect(io_double).to receive(:puts).with("Here's a list of all shop items:").ordered
    expect(io_double).to receive(:puts).with(" #1 item1 - Unit price: 10.0 - Quantity: 30").ordered
    expect(io_double).to receive(:puts).with(" #2 item2 - Unit price: 12.1 - Quantity: 22").ordered

    item_repo_double = double :fake_item_repo
    expect(item_repo_double).to receive(:all).and_return([
      double(:fake_item, id: 1, name: "item1", unit_price: '10.0', quantity: '30'),
      double(:fake_item, id: 2, name: "item2", unit_price: '12.1', quantity: '22'),
    ])
    order_repo_double = double :fake_order_repo
    app = Application.new(
      "shop_manager_test",
      io_double,
      item_repo_double,
      order_repo_double
    )
    app.run
  end

  it "runs command line shop management program and create a new item" do 
    io_double = double :fake_io
    expect(io_double).to receive(:puts).with("What do you want to do?").ordered
    expect(io_double).to receive(:puts).with(" 1 = list all shop items").ordered
    expect(io_double).to receive(:puts).with(" 2 = create a new item").ordered
    expect(io_double).to receive(:puts).with(" 3 = list all orders").ordered
    expect(io_double).to receive(:puts).with(" 4 = create a new order").ordered
    expect(io_double).to receive(:gets).and_return("2").ordered
    expect(io_double).to receive(:puts).with("Please enter the item name:").ordered
    expect(io_double).to receive(:gets).and_return("item4").ordered
    expect(io_double).to receive(:puts).with("Please enter the unit price:").ordered
    expect(io_double).to receive(:gets).and_return("14.4").ordered
    expect(io_double).to receive(:puts).with("Please enter the quantity:").ordered
    expect(io_double).to receive(:gets).and_return("25").ordered
    expect(io_double).to receive(:puts).with("New item created").ordered

    item_repo_double = double :fake_item_repo
    order_repo_double = double :fake_order_repo
    app = Application.new(
      "shop_manager_test",
      io_double,
      item_repo_double,
      order_repo_double
    )
    app.run
  end

  it "runs command line shop management program and ask for list all shop orders" do 
    io_double = double :fake_io
    expect(io_double).to receive(:puts).with("What do you want to do?").ordered
      expect(io_double).to receive(:puts).with(" 1 = list all shop items").ordered
      expect(io_double).to receive(:puts).with(" 2 = create a new item").ordered
      expect(io_double).to receive(:puts).with(" 3 = list all orders").ordered
      expect(io_double).to receive(:puts).with(" 4 = create a new order").ordered
      expect(io_double).to receive(:gets).and_return("3").ordered
      expect(io_double).to receive(:puts).with("Here's a list of all shop orders:").ordered
      expect(io_double).to receive(:puts).with(" #1 David - Order date: 2022-06-22 19:10:25").ordered
      expect(io_double).to receive(:puts).with(" #2 Anna - Order date: 2022-07-22 19:10:25").ordered


    order_repo_double = double :fake_order_repo
    expect(order_repo_double).to receive(:all).and_return([
      double(:fake_order, id: 1, customer_name: "David", order_date: "2022-06-22 19:10:25"),
      double(:fake_order, id: 2, customer_name: "Anna", order_date: "2022-07-22 19:10:25"),
    ])
    item_repo_double = double :fake_item_repo
    app = Application.new(
      "shop_manager_test",
      io_double,
      item_repo_double,
      order_repo_double
    )
    app.run
  end

  it "runs command line shop management program and create a new order" do 
    io_double = double :fake_io
    expect(io_double).to receive(:puts).with("What do you want to do?").ordered
    expect(io_double).to receive(:puts).with(" 1 = list all shop items").ordered
    expect(io_double).to receive(:puts).with(" 2 = create a new item").ordered
    expect(io_double).to receive(:puts).with(" 3 = list all orders").ordered
    expect(io_double).to receive(:puts).with(" 4 = create a new order").ordered
    expect(io_double).to receive(:gets).and_return("4").ordered
    expect(io_double).to receive(:puts).with("Please enter the customer name:").ordered
    expect(io_double).to receive(:gets).and_return("Dennis").ordered
    expect(io_double).to receive(:puts).with("Please enter the order date:").ordered
    expect(io_double).to receive(:gets).and_return("2022-11-22 19:10:25").ordered
    expect(io_double).to receive(:puts).with("New order created").ordered

    item_repo_double = double :fake_item_repo
    order_repo_double = double :fake_order_repo
    app = Application.new(
      "shop_manager_test",
      io_double,
      item_repo_double,
      order_repo_double
    )
    app.run
  end

end