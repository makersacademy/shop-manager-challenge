# it lists all shop items and quantity
# it creates a new item
# it list all orders
# it creates a new order

require "./app"

RSpec.describe Application do
  it "lists all shop items using the terminal" do
    terminal = double :terminal
    app =
      Application.new(
        "shop_manager_test",
        terminal,
        ItemRepository.new,
        OrderRepository.new,
      )
    expect(terminal).to receive(:puts).with(
      "Welcome to the shop management program!",
    )
    expect(terminal).to receive(:puts).with(
      "What do you want to do?
      1 = list all shop items
      2 = create a new item
      3 = list all orders
      4 = create a new order",
    )
    expect(terminal).to receive(:gets).and_return("1")
    expect(terminal).to receive(:puts).with(
      "#1 Super Shark Vacuum Cleaner - Unit price: 199 - Quantity: 60",
    )
    expect(terminal).to receive(:puts).with(
      "#2 Makerspresso Coffee Machine - Unit price: 90 - Quantity: 20",
    )
    expect(terminal).to receive(:puts).with(
      "#3 iPhone 14 - Unit price: 800 - Quantity: 50",
    )
    app.run
  end

  it "lists all shop orders using the terminal" do
    terminal = double :terminal
    app =
      Application.new(
        "shop_manager_test",
        terminal,
        ItemRepository.new,
        OrderRepository.new,
      )
    expect(terminal).to receive(:puts).with(
      "Welcome to the shop management program!",
    )
    expect(terminal).to receive(:puts).with(
      "What do you want to do?
      1 = list all shop items
      2 = create a new item
      3 = list all orders
      4 = create a new order",
    )
    expect(terminal).to receive(:gets).and_return("3")
    expect(terminal).to receive(:puts).with(
      "#1 Customer Name: Sarah - Order Date: 2023-03-03",
    )
    expect(terminal).to receive(:puts).with(
      "#2 Customer Name: Emma - Order Date: 2023-02-03",
    )
    expect(terminal).to receive(:puts).with(
      "#3 Customer Name: Daniel - Order Date: 2023-02-28",
    )
    app.run
  end

  it "creates a new item" do
    terminal = double :terminal
    app =
      Application.new(
        "shop_manager_test",
        terminal,
        ItemRepository.new,
        OrderRepository.new,
      )
    expect(terminal).to receive(:puts).with(
      "Welcome to the shop management program!",
    )
    expect(terminal).to receive(:puts).with(
      "What do you want to do?
      1 = list all shop items
      2 = create a new item
      3 = list all orders
      4 = create a new order",
    )
    expect(terminal).to receive(:gets).and_return("2")
    expect(terminal).to receive(:puts).with("What is the item name?")
    expect(terminal).to receive(:gets).and_return("Apple Watch")
    expect(terminal).to receive(:puts).with("What is the item price?")
    expect(terminal).to receive(:gets).and_return("300")
    expect(terminal).to receive(:puts).with("What is the item quantity?")
    expect(terminal).to receive(:gets).and_return("30")
    expect(terminal).to receive(:puts).with("Your item has been added")
    app.run
  end

  it "creates a new order" do
    terminal = double :terminal
    app =
      Application.new(
        "shop_manager_test",
        terminal,
        ItemRepository.new,
        OrderRepository.new,
      )
    expect(terminal).to receive(:puts).with(
      "Welcome to the shop management program!",
    )
    expect(terminal).to receive(:puts).with(
      "What do you want to do?
      1 = list all shop items
      2 = create a new item
      3 = list all orders
      4 = create a new order",
    )
    expect(terminal).to receive(:gets).and_return("4")
    expect(terminal).to receive(:puts).with("What is the customer name?")
    expect(terminal).to receive(:gets).and_return("Natalie")
    expect(terminal).to receive(:puts).with("What is the order date?")
    expect(terminal).to receive(:gets).and_return("2023-02-28")
    expect(terminal).to receive(:puts).with("Your order has been added")
    app.run
  end
end
