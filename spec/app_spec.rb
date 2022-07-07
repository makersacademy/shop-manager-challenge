require "app.rb"

describe Application do
  def reset_tables
    seed_sql = File.read("spec/seeds.sql")
    connection = PG.connect({ host: "127.0.0.1", dbname: "shop_manager_test" })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_tables
  end

  it "lists all shop items if user inputs 1" do
    io = double(:io)
    expect(io).to receive(:puts).with("Welcome to the shop management program!").ordered
    expect(io).to receive(:puts).with("\nWhat do you want to do?\n  1 = list all shop items\n  2 = create a new item\n  3 = list all orders\n  4 = create a new order").ordered
    expect(io).to receive(:gets).and_return("1").ordered
    expect(io).to receive(:puts).with("Item 1: KitKat, Unit Price: 1.00").ordered
    expect(io).to receive(:puts).with("Item 2: PS5, Unit Price: 499.99").ordered
    expect(io).to receive(:puts).with("Item 3: Notepad, Unit Price: 1.50").ordered

    app = Application.new("shop_manager_test", io, ItemRepository.new, OrderRepository.new)
    app.run
  end

  it "creates new shop item if user inputs 2 and lists all items with new one included" do
    io = double(:io)
    expect(io).to receive(:puts).with("Welcome to the shop management program!").ordered
    expect(io).to receive(:puts).with("\nWhat do you want to do?\n  1 = list all shop items\n  2 = create a new item\n  3 = list all orders\n  4 = create a new order").ordered
    expect(io).to receive(:gets).and_return("2").ordered
    expect(io).to receive(:puts).with("Enter name of item you would like to create").ordered
    expect(io).to receive(:gets).and_return("Designer shirt").ordered
    expect(io).to receive(:puts).with("Enter price of item you would like to create").ordered
    expect(io).to receive(:gets).and_return("44.99").ordered
    expect(io).to receive(:puts).with("This is your new list of items").ordered
    expect(io).to receive(:puts).with("Item 1: KitKat, Unit Price: 1.00").ordered
    expect(io).to receive(:puts).with("Item 2: PS5, Unit Price: 499.99").ordered
    expect(io).to receive(:puts).with("Item 3: Notepad, Unit Price: 1.50").ordered
    expect(io).to receive(:puts).with("Item 4: Designer shirt, Unit Price: 44.99").ordered

    app = Application.new("shop_manager_test", io, ItemRepository.new, OrderRepository.new)
    app.run
  end

  it "lists all orders if user inputs 3" do
    io = double(:io)
    expect(io).to receive(:puts).with("Welcome to the shop management program!").ordered
    expect(io).to receive(:puts).with("\nWhat do you want to do?\n  1 = list all shop items\n  2 = create a new item\n  3 = list all orders\n  4 = create a new order").ordered
    expect(io).to receive(:gets).and_return("3").ordered
    expect(io).to receive(:puts).with("Alex, 2022-06-28: KitKat").ordered
    expect(io).to receive(:puts).with("Bob, 2022-01-01: PS5").ordered
    expect(io).to receive(:puts).with("Jemima, 2022-07-01: KitKat").ordered

    app = Application.new("shop_manager_test", io, ItemRepository.new, OrderRepository.new)
    app.run
  end

  it "creates new order if user inputs 4 and lists all orders with new one included" do
    io = double(:io)
    expect(io).to receive(:puts).with("Welcome to the shop management program!").ordered
    expect(io).to receive(:puts).with("\nWhat do you want to do?\n  1 = list all shop items\n  2 = create a new item\n  3 = list all orders\n  4 = create a new order").ordered
    expect(io).to receive(:gets).and_return("4").ordered
    expect(io).to receive(:puts).with("Enter customer name of the order you would like to create").ordered
    expect(io).to receive(:gets).and_return("Elijah").ordered
    expect(io).to receive(:puts).with("Enter the order date of the order you would like to create").ordered
    expect(io).to receive(:gets).and_return("2020-12-25").ordered
    expect(io).to receive(:puts).with("Enter the item id of the order you would like to create").ordered
    expect(io).to receive(:gets).and_return("2").ordered
    expect(io).to receive(:puts).with("This is your new list of orders").ordered
    expect(io).to receive(:puts).with("Alex, 2022-06-28: KitKat").ordered
    expect(io).to receive(:puts).with("Bob, 2022-01-01: PS5").ordered
    expect(io).to receive(:puts).with("Jemima, 2022-07-01: KitKat").ordered
    expect(io).to receive(:puts).with("Elijah, 2020-12-25: PS5").ordered

    app = Application.new("shop_manager_test", io, ItemRepository.new, OrderRepository.new)
    app.run
  end
end
