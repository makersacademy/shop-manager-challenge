require_relative "../app"
require "item_repository"
require "order_repository"

describe Application do
  it "prints the menu and a list of the items" do
    io = double(:io)
    expect(io).to receive(:puts).with("Welcome to the shop management app!").ordered
    expect(io).to receive(:puts).with("\nWhat would you like to do?").ordered.ordered
    expect(io).to receive(:puts).with("1 - List all shop items").ordered
    expect(io).to receive(:puts).with("2 - Create a new item").ordered
    expect(io).to receive(:puts).with("3 - List all orders").ordered
    expect(io).to receive(:puts).with("4 - Create a new order").ordered
    expect(io).to receive(:print).with("\nEnter your choice: ").ordered
    expect(io).to receive(:gets).and_return("1").ordered
    expect(io).to receive(:puts).with("\nHere is the list of all shop items:").ordered
    expect(io).to receive(:puts).with("1 - White Desk Lamp, unit price: £18.00, quantity available: 12").ordered
    expect(io).to receive(:puts).with("2 - Mahogani Dining Table, unit price: £235.00, quantity available: 5").ordered
    expect(io).to receive(:puts).with("3 - Oak Bookshelf, unit price: £80.00, quantity available: 15").ordered
    expect(io).to receive(:puts).with("4 - Oriental Rug, unit price: £139.00, quantity available: 21").ordered
    expect(io).to receive(:puts).with("5 - Aloe Vera Houseplant, unit price: £12.00, quantity available: 150").ordered
    expect(io).to receive(:puts).with("6 - Leather Sofa, unit price: £1699.00, quantity available: 2").ordered

    app = Application.new(
      'items_orders',
      io,
      ItemRepository.new,
      OrderRepository.new
    )
    app.run
  end

  it "prints the menu then lets me add a new item" do
    io = double(:io)
    expect(io).to receive(:puts).with("Welcome to the shop management app!").ordered
    expect(io).to receive(:puts).with("\nWhat would you like to do?").ordered
    expect(io).to receive(:puts).with("1 - List all shop items").ordered
    expect(io).to receive(:puts).with("2 - Create a new item").ordered
    expect(io).to receive(:puts).with("3 - List all orders").ordered
    expect(io).to receive(:puts).with("4 - Create a new order").ordered
    expect(io).to receive(:print).with("\nEnter your choice: ").ordered
    expect(io).to receive(:gets).and_return("2").ordered

    expect(io).to receive(:print).with("\nEnter the name of the new item: ").ordered
    expect(io).to receive(:gets).and_return("Velvet Armchair").ordered
    expect(io).to receive(:print).with("\nEnter the price of the new item in pounds: £").ordered
    expect(io).to receive(:gets).and_return("150").ordered
    expect(io).to receive(:print).with("\nHow many of these items have we got in stock?").ordered
    expect(io).to receive(:gets).and_return("23").ordered
    expect(io).to receive(:puts).with("\nNew item created successfully.").ordered


    app = Application.new(
      'items_orders_test',
      io,
      ItemRepository.new,
      OrderRepository.new
    )
    app.run
  end

  it "prints the menu and a list of all orders with the items that were ordered" do
    io = double(:io)
    expect(io).to receive(:puts).with("Welcome to the shop management app!").ordered
    expect(io).to receive(:puts).with("\nWhat would you like to do?").ordered
    expect(io).to receive(:puts).with("1 - List all shop items").ordered
    expect(io).to receive(:puts).with("2 - Create a new item").ordered
    expect(io).to receive(:puts).with("3 - List all orders").ordered
    expect(io).to receive(:puts).with("4 - Create a new order").ordered
    expect(io).to receive(:print).with("\nEnter your choice: ").ordered
    expect(io).to receive(:gets).and_return("3").ordered

    expect(io).to receive(:puts).with("\nHere is the list of all orders:").ordered
    expect(io).to receive(:print).with("1 - Customer: John Treat, Date placed: 2022-08-12, Items ordered: ").ordered
    expect(io).to receive(:print).with("Oak Bookshelf").ordered
    expect(io).to receive(:print).with(", ").ordered
    expect(io).to receive(:print).with("Oriental Rug").ordered
    expect(io).to receive(:print).with(", ").ordered
    expect(io).to receive(:print).with("Leather Sofa").ordered
    expect(io).to receive(:print).with("\n").ordered

    expect(io).to receive(:print).with("2 - Customer: Amelia Macfarlane, Date placed: 2022-08-14, Items ordered: ").ordered
    expect(io).to receive(:print).with("White Desk Lamp").ordered
    expect(io).to receive(:print).with("\n").ordered

    expect(io).to receive(:print).with("3 - Customer: Eleanor Borgate, Date placed: 2022-09-02, Items ordered: ").ordered
    expect(io).to receive(:print).with("Aloe Vera Houseplant").ordered
    expect(io).to receive(:print).with(", ").ordered
    expect(io).to receive(:print).with("White Desk Lamp").ordered
    expect(io).to receive(:print).with(", ").ordered
    expect(io).to receive(:print).with("Oak Bookshelf").ordered
    expect(io).to receive(:print).with("\n").ordered

    expect(io).to receive(:print).with("4 - Customer: Richard Karow, Date placed: 2022-09-11, Items ordered: ").ordered
    expect(io).to receive(:print).with("Oak Bookshelf").ordered
    expect(io).to receive(:print).with("\n").ordered

    app = Application.new(
      'items_orders',
      io,
      ItemRepository.new,
      OrderRepository.new
    )
    app.run
  end

  it "prints the menu then lets me add a new order" do
    io = double(:io)
    expect(io).to receive(:puts).with("Welcome to the shop management app!").ordered
    expect(io).to receive(:puts).with("\nWhat would you like to do?").ordered
    expect(io).to receive(:puts).with("1 - List all shop items").ordered
    expect(io).to receive(:puts).with("2 - Create a new item").ordered
    expect(io).to receive(:puts).with("3 - List all orders").ordered
    expect(io).to receive(:puts).with("4 - Create a new order").ordered
    expect(io).to receive(:print).with("\nEnter your choice: ").ordered
    expect(io).to receive(:gets).and_return("4").ordered

    expect(io).to receive(:print).with("\nEnter the name of the customer: ").ordered
    expect(io).to receive(:gets).and_return("Richard Karow").ordered
    expect(io).to receive(:print).with("\nEnter an item the customer ordered: ").ordered
    expect(io).to receive(:gets).and_return("Oak Bookshelf").ordered
    expect(io).to receive(:print).with("\nDid the customer order any more items (Yes/No): ").ordered
    expect(io).to receive(:gets).and_return("No").ordered
    expect(io).to receive(:puts).with("The order was created successfully.").ordered

    app = Application.new(
      'items_orders_test',
      io,
      ItemRepository.new,
      OrderRepository.new
    )
    app.run
  end
end