require_relative "../app"

def reset_tables
  seed_sql = File.read("spec/seeds.sql")
  connection = PG.connect({ host: "127.0.0.1", dbname: "shop_manager" })
  connection.exec(seed_sql)
end

describe Application do
  before(:each) do
    reset_tables
  end

  it "prints out a list of all items" do
    io = double(:io)

    expect(io).to receive(:puts).with("What do you want to do?")
    expect(io).to receive(:puts).with("1 = list all shop items")
    expect(io).to receive(:puts).with("2 = create a new item")
    expect(io).to receive(:puts).with("3 = list all orders")
    expect(io).to receive(:puts).with("4 = create a new order")

    expect(io).to receive(:gets).and_return("1")
    expect(io).to receive(:puts).with("Here's a list of all shop items:")
    expect(io).to receive(:puts).with("#1 Kitchen Towel - Unit price: 2 - Quantity: 25")
    expect(io).to receive(:puts).with("#2 Cling Film - Unit price: 1 - Quantity: 41")
    expect(io).to receive(:puts).with("#3 Washing Up Liquid - Unit price: 3 - Quantity: 32")
    expect(io).to receive(:puts).with("#4 Washing Powder - Unit price: 10 - Quantity: 71")
    expect(io).to receive(:puts).with("#5 Soap - Unit price: 4 - Quantity: 80")

    app = Application.new(
      "shop_manager",
      io,
      ItemRepository.new,
      OrderRepository.new
    )
    app.run
  end

  it "takes user input and creates a new item" do
    io = double(:io)

    expect(io).to receive(:puts).with("What do you want to do?")
    expect(io).to receive(:puts).with("1 = list all shop items")
    expect(io).to receive(:puts).with("2 = create a new item")
    expect(io).to receive(:puts).with("3 = list all orders")
    expect(io).to receive(:puts).with("4 = create a new order")

    expect(io).to receive(:gets).and_return("2")
    expect(io).to receive(:puts).with("Item name:")
    expect(io).to receive(:gets).and_return("Shower Gel")
    expect(io).to receive(:puts).with("Unit price:")
    expect(io).to receive(:gets).and_return("2")
    expect(io).to receive(:puts).with("Quantity:")
    expect(io).to receive(:gets).and_return("30")

    app = Application.new(
      "shop_manager",
      io,
      ItemRepository.new,
      OrderRepository.new
    )
    app.run
  end

  it "prints out a list of all orders" do
    io = double(:io)

    expect(io).to receive(:puts).with("What do you want to do?")
    expect(io).to receive(:puts).with("1 = list all shop items")
    expect(io).to receive(:puts).with("2 = create a new item")
    expect(io).to receive(:puts).with("3 = list all orders")
    expect(io).to receive(:puts).with("4 = create a new order")

    expect(io).to receive(:gets).and_return("3")
    expect(io).to receive(:puts).with("Here's a list of all orders:")
    expect(io).to receive(:puts).with("#1 Bruce - 2022-03-06")
    expect(io).to receive(:puts).with("#2 Clark - 2022-05-07")
    expect(io).to receive(:puts).with("#3 Diana - 2022-07-08")

    app = Application.new(
      "shop_manager",
      io,
      ItemRepository.new,
      OrderRepository.new
    )
    app.run
  end

  it "takes user input and creates a new order" do
    io = double(:io)

    expect(io).to receive(:puts).with("What do you want to do?")
    expect(io).to receive(:puts).with("1 = list all shop items")
    expect(io).to receive(:puts).with("2 = create a new item")
    expect(io).to receive(:puts).with("3 = list all orders")
    expect(io).to receive(:puts).with("4 = create a new order")

    expect(io).to receive(:gets).and_return("4")
    expect(io).to receive(:puts).with("Customer name:")
    expect(io).to receive(:gets).and_return("Hal")
    expect(io).to receive(:puts).with("Order date:")
    expect(io).to receive(:gets).and_return("2022-07-07")

    app = Application.new(
      "shop_manager",
      io,
      ItemRepository.new,
      OrderRepository.new
    )
    app.run
  end
end
