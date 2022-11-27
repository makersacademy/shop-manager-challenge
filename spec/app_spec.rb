require_relative "../app"

def reset_tables
  sql_seed = File.read("spec/seeds_orders.sql")
  connection = PG.connect({ host: "127.0.0.1", dbname: "shop_manager_test" })
  connection.exec(sql_seed)
end

def expect_input_menu(dbl)
  expect(dbl).to receive(:puts).with("Welcome to the shop management program!").ordered
  expect(dbl).to receive(:puts).with(no_args).ordered
  expect(dbl).to receive(:puts).with("What do you want to do?").ordered
  expect(dbl).to receive(:puts).with("  1 = list all shop items").ordered
  expect(dbl).to receive(:puts).with("  2 = create a new item").ordered
  expect(dbl).to receive(:puts).with("  3 = list all orders").ordered
  expect(dbl).to receive(:puts).with("  4 = create a new order").ordered
  expect(dbl).to receive(:puts).with(no_args).ordered
end

RSpec.describe Application do
  before(:each) do
    reset_tables
  end

  it "lists all shop items" do
    io_double = double(:fake_io)
    expect_input_menu(io_double)
    expect(io_double).to receive(:gets).and_return("1\n").ordered
    expect(io_double).to receive(:puts).with(no_args).ordered
    expect(io_double).to receive(:puts).with("Here is a list of all shop items:").ordered
    expect(io_double).to receive(:puts).with(no_args).ordered
    expect(io_double).to receive(:puts)
      .with(" #1 Hammer - Unit price: 5.99 - Quantity: 20").ordered
    expect(io_double).to receive(:puts)
      .with(" #2 Duct Tape - Unit price: 2.50 - Quantity: 50").ordered
    expect(io_double).to receive(:puts)
      .with(" #3 Nails (0.5kg) - Unit price: 4.50 - Quantity: 50").ordered
    expect(io_double).to receive(:puts)
      .with(" #4 Drill - Unit price: 49.99 - Quantity: 7").ordered

    item_repo_double = double(:fake_item_repo)
    expect(item_repo_double).to receive(:all).and_return([
      double(:fake_item, id: 1, name: "Hammer", unit_price: 5.99, quantity: 20),
      double(:fake_item, id: 2, name: "Duct Tape", unit_price: 2.5, quantity: 50),
      double(:fake_item, id: 3, name: "Nails (0.5kg)", unit_price: 4.5, quantity: 50),
      double(:fake_item, id: 4, name: "Drill", unit_price: 49.99, quantity: 7),
    ])

    order_repo_double = double(:fake_order_repo)
    
    app = Application.new(
      "shop_manager_test",
      io_double,
      item_repo_double,
      order_repo_double
    )
    app.run
  end

  it "creates a new item" do
    io_double = double(:fake_io)
    expect_input_menu(io_double)
    expect(io_double).to receive(:gets).and_return("2\n").ordered
    expect(io_double).to receive(:puts).with(no_args).ordered
    expect(io_double).to receive(:puts).with("Please enter the new item below:")
    expect(io_double).to receive(:print).with("id: ")
    expect(io_double).to receive(:gets).and_return("5\n")
    expect(io_double).to receive(:print).with("name: ")
    expect(io_double).to receive(:gets).and_return("Saw\n")
    expect(io_double).to receive(:print).with("unit price: ")
    expect(io_double).to receive(:gets).and_return("6.50\n")
    expect(io_double).to receive(:print).with("quantity: ")
    expect(io_double).to receive(:gets).and_return("15\n")

    item_repo_double = double(:fake_item_repo)
    expect(item_repo_double).to receive(:create).with(having_attributes(
      id: 5,
      name: "Saw",
      unit_price: 6.50,
      quantity: 15
    ))

    order_repo_double = double(:fake_order_repo)
    
    app = Application.new(
      "shop_manager_test",
      io_double,
      item_repo_double,
      order_repo_double
    )
    app.run
  end

  it "lists all orders" do
    io_double = double(:fake_io)
    expect_input_menu(io_double)
    expect(io_double).to receive(:gets).and_return("3\n").ordered
    expect(io_double).to receive(:puts).with(no_args).ordered
    expect(io_double).to receive(:puts).with("Here is a list of all orders:").ordered
    expect(io_double).to receive(:puts).with(no_args).ordered
    expect(io_double).to receive(:puts).with(" #1 Customer One - Placed on 2022-01-01").ordered
    expect(io_double).to receive(:puts).with(" #2 Customer Two - Placed on 2022-01-02").ordered
    expect(io_double).to receive(:puts).with(" #3 Customer Three - Placed on 2022-01-02").ordered
    expect(io_double).to receive(:puts).with(" #4 Customer One - Placed on 2022-01-03").ordered
    expect(io_double).to receive(:puts).with(" #5 Customer Four - Placed on 2022-01-07").ordered
    expect(io_double).to receive(:puts).with(" #6 Customer Four - Placed on 2022-01-08").ordered

    item_repo_double = double(:fake_item_repo)

    order_repo_double = double(:fake_order_repo)
    expect(order_repo_double).to receive(:all).and_return([
      double(:fake_order, id: 1, customer_name: "Customer One", date_placed: "2022-01-01"),
      double(:fake_order, id: 2, customer_name: "Customer Two", date_placed: "2022-01-02"),
      double(:fake_order, id: 3, customer_name: "Customer Three", date_placed: "2022-01-02"),
      double(:fake_order, id: 4, customer_name: "Customer One", date_placed: "2022-01-03"),
      double(:fake_order, id: 5, customer_name: "Customer Four", date_placed: "2022-01-07"),
      double(:fake_order, id: 6, customer_name: "Customer Four", date_placed: "2022-01-08")
    ])
    
    app = Application.new(
      "shop_manager_test",
      io_double,
      item_repo_double,
      order_repo_double
    )
    app.run
  end

  it "creates a new order" do
    io_double = double(:fake_io)
    expect_input_menu(io_double)
    expect(io_double).to receive(:gets).and_return("4\n").ordered
    expect(io_double).to receive(:puts).with(no_args).ordered
    expect(io_double).to receive(:puts).with("Please enter the new order below:").ordered
    expect(io_double).to receive(:print).with("id: ").ordered
    expect(io_double).to receive(:gets).and_return("7\n").ordered
    expect(io_double).to receive(:print).with("customer name: ").ordered
    expect(io_double).to receive(:gets).and_return("Customer Five\n").ordered
    expect(io_double).to receive(:print).with("date placed: ").ordered
    expect(io_double).to receive(:gets).and_return("2022-01-08\n").ordered
    expect(io_double).to receive(:puts).with(no_args).ordered
    expect(io_double).to receive(:puts).with("Enter the ids of the items in the order:").ordered
    expect(io_double).to receive(:puts)
      .with("(press ENTER a second time to create the order)").ordered
    expect(io_double).to receive(:gets).and_return("2\n")
    expect(io_double).to receive(:gets).and_return("3\n")
    expect(io_double).to receive(:gets).and_return("\n")

    item_repo_double = double(:fake_item_repo)

    order_repo_double = double(:fake_order_repo)
    expect(order_repo_double).to receive(:create)
      .with(
        having_attributes(id: 7, customer_name: "Customer Five", date_placed: "2022-01-08"),
        [2, 3]
      )
    
    app = Application.new(
      "shop_manager_test",
      io_double,
      item_repo_double,
      order_repo_double
    )
    app.run
  end
end