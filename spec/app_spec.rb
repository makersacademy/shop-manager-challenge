require_relative '../app'

RSpec.describe Application do
  it "prints the list of items if user input is 1" do
    terminal = double :terminal
    item1 = double :item, id: 1, name: "TV", price: 99.99, quantity: "5"
    item2 = double :item, id: 2, name: "Fridge", price: 80.00, quantity: "10"
    item3 = double :item, id: 3, name: "Toaster", price: 9.99, quantity: "10"
    item_repository = double :item_repository, all: [item1, item2, item3]
    order_repository = double :order_repository
    expect(terminal).to receive(:puts).with("Welcome to the shop management program!").ordered
    expect(terminal).to receive(:puts).with("").ordered
    expect(terminal).to receive(:puts).with("What do you want to do?").ordered
    expect(terminal).to receive(:puts).with("  1 = list all shop items").ordered
    expect(terminal).to receive(:puts).with("  2 = create a new item").ordered
    expect(terminal).to receive(:puts).with("  3 = list all orders").ordered
    expect(terminal).to receive(:puts).with("  4 = create a new shop order").ordered
    expect(terminal).to receive(:puts).with("").ordered
    expect(terminal).to receive(:gets).and_return("1").ordered
    expect(terminal).to receive(:puts).with("").ordered
    expect(terminal).to receive(:puts).with("Here's a list of all shop items:").ordered
    expect(terminal).to receive(:puts).with("").ordered
    expect(terminal).to receive(:puts).with("#1 TV - Unit price: 99.99 - Quantity: 5")
    expect(terminal).to receive(:puts).with("#2 Fridge - Unit price: 80.0 - Quantity: 10")
    expect(terminal).to receive(:puts).with("#3 Toaster - Unit price: 9.99 - Quantity: 10")
    app = Application.new("shop_inventory_test", terminal, item_repository, order_repository)
    app.run
  end

  it "prints the list of orders if user input is 3" do
    terminal = double :terminal
    order1 = double :order, id: 1, customer: "Rob", date: '2022-01-01'
    order2 = double :order, id: 2, customer: "Tom", date: '2022-01-02'
    order3 = double :order, id: 3, customer: "Anisha", date: '2022-01-02'
    order_repository = double :order_repository, all: [order1, order2, order3]
    item_repository = double :item_repository
    expect(terminal).to receive(:puts).with("Welcome to the shop management program!").ordered
    expect(terminal).to receive(:puts).with("").ordered
    expect(terminal).to receive(:puts).with("What do you want to do?").ordered
    expect(terminal).to receive(:puts).with("  1 = list all shop items").ordered
    expect(terminal).to receive(:puts).with("  2 = create a new item").ordered
    expect(terminal).to receive(:puts).with("  3 = list all orders").ordered
    expect(terminal).to receive(:puts).with("  4 = create a new shop order").ordered
    expect(terminal).to receive(:puts).with("").ordered
    expect(terminal).to receive(:gets).and_return("3").ordered
    expect(terminal).to receive(:puts).with("").ordered
    expect(terminal).to receive(:puts).with("Here's a list of all orders:").ordered
    expect(terminal).to receive(:puts).with("").ordered
    expect(terminal).to receive(:puts).with("#1 Rob - Date: 2022-01-01")
    expect(terminal).to receive(:puts).with("#2 Tom - Date: 2022-01-02")
    expect(terminal).to receive(:puts).with("#3 Anisha - Date: 2022-01-02")
    app = Application.new("shop_inventory_test", terminal, item_repository, order_repository)
    app.run
  end

  it "creates an item if user input is 2" do
    terminal = double :terminal
    item4 = double :item, id: 4, name: "Kettle", price: 8.99, quantity: "13"
    item_repository = double :item_repository, create: item4
    order_repository = double :order_repository
    expect(terminal).to receive(:puts).with("Welcome to the shop management program!").ordered
    expect(terminal).to receive(:puts).with("").ordered
    expect(terminal).to receive(:puts).with("What do you want to do?").ordered
    expect(terminal).to receive(:puts).with("  1 = list all shop items").ordered
    expect(terminal).to receive(:puts).with("  2 = create a new item").ordered
    expect(terminal).to receive(:puts).with("  3 = list all orders").ordered
    expect(terminal).to receive(:puts).with("  4 = create a new shop order").ordered
    expect(terminal).to receive(:puts).with("").ordered
    expect(terminal).to receive(:gets).and_return("2").ordered
    expect(terminal).to receive(:puts).with("").ordered
    expect(terminal).to receive(:puts).with("Item name:").ordered
    expect(terminal).to receive(:gets).and_return("Kettle").ordered
    expect(terminal).to receive(:puts).with("Item price:").ordered
    expect(terminal).to receive(:gets).and_return(8.99).ordered
    expect(terminal).to receive(:puts).with("Item quantity:").ordered
    expect(terminal).to receive(:gets).and_return(13).ordered
    app = Application.new("shop_inventory_test", terminal, item_repository, order_repository)
    app.run
  end

  it "creates an order if user input is 4" do
    terminal = double :terminal
    item1 = double :item, id: 1, name: "TV", price: 99.99, quantity: "5"
    item_repository = double :item_repository, find: item1
    order4 = double :order, id: 4, customer: 'Shah', date: '2022-10-10'
    order_repository = double :order_repository, create: order4
    expect(terminal).to receive(:puts).with("Welcome to the shop management program!").ordered
    expect(terminal).to receive(:puts).with("").ordered
    expect(terminal).to receive(:puts).with("What do you want to do?").ordered
    expect(terminal).to receive(:puts).with("  1 = list all shop items").ordered
    expect(terminal).to receive(:puts).with("  2 = create a new item").ordered
    expect(terminal).to receive(:puts).with("  3 = list all orders").ordered
    expect(terminal).to receive(:puts).with("  4 = create a new shop order").ordered
    expect(terminal).to receive(:puts).with("").ordered
    expect(terminal).to receive(:gets).and_return("4").ordered
    expect(terminal).to receive(:puts).with("").ordered
    expect(terminal).to receive(:puts).with("Customer name:").ordered
    expect(terminal).to receive(:gets).and_return("Shah").ordered
    expect(terminal).to receive(:puts).with("Order date:").ordered
    expect(terminal).to receive(:gets).and_return("2022-10-10").ordered
    expect(terminal).to receive(:puts).with("Item ordered:").ordered
    expect(terminal).to receive(:gets).and_return("1").ordered
    app = Application.new("shop_inventory_test", terminal, item_repository, order_repository)
    app.run
  end
end
