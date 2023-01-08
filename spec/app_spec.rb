require "database_connection"
require_relative "../app"

def reset_shop_manager_test_table
  seed_sql = File.read("spec/seed_shop_manager_test.sql")
  connection = PG.connect({ host: "127.0.0.1", dbname: "shop_manager_test" })
  connection.exec(seed_sql)
end

describe Application do
  before(:each) do
    reset_shop_manager_test_table
  end
  it "returns list of shop items on choice 1" do
    io = double :io
    expect(io).to receive(:puts).with("Welcome to the shop management program!")
    expect(io).to receive(:puts).with("What do you want to do? \n1 - List all shop items \n2 - Create a new item \n3 - List all orders \n4 - Create a new order \nEnter your choice: ")
    expect(io).to receive(:gets).and_return(1)
    expect(io).to receive(:puts).with("Here is your list of shop items:")
    expect(io).to receive(:puts).with("#1 - Phone - £189 - Quantity: 32")
    expect(io).to receive(:puts).with("#2 - Laptop - £450 - Quantity: 25")
    app = Application.new("shop_manager_test", io, OrdersRepository.new, ItemsRepository.new)
    app.run
  end

  it "creates an item on choice 2" do
    io = double :io
    expect(io).to receive(:puts).with("Welcome to the shop management program!")
    expect(io).to receive(:puts).with("What do you want to do? \n1 - List all shop items \n2 - Create a new item \n3 - List all orders \n4 - Create a new order \nEnter your choice: ")
    expect(io).to receive(:gets).and_return(2)
    expect(io).to receive(:puts).with("Enter the name of the item:")
    expect(io).to receive(:gets).and_return("Earphones")
    expect(io).to receive(:puts).with("Enter the price of the item")
    expect(io).to receive(:gets).and_return(20)
    expect(io).to receive(:puts).with("Enter the quantity of the item")
    expect(io).to receive(:gets).and_return(200)
    app = Application.new("shop_manager_test", io, OrdersRepository.new, ItemsRepository.new)
    app.run
    repo = ItemsRepository.new
    list = repo.all.last
    expect(list.name).to eq "Earphones"
    expect(list.price).to eq "20"
    expect(list.quantity).to eq "200"
  end

  it "returns a list of all orders on choice 3" do
    io = double :io
    expect(io).to receive(:puts).with("Welcome to the shop management program!")
    expect(io).to receive(:puts).with("What do you want to do? \n1 - List all shop items \n2 - Create a new item \n3 - List all orders \n4 - Create a new order \nEnter your choice: ")
    expect(io).to receive(:gets).and_return(3)
    expect(io).to receive(:puts).with("Here is your list of all orders:")
    expect(io).to receive(:puts).with("Customer name: Lisa - Date ordered: 12/01/2023 - Item: Laptop - Price: £450")
    expect(io).to receive(:puts).with("Customer name: Rob - Date ordered: 18/12/2022 - Item: Laptop - Price: £450")
    app = Application.new("shop_manager_test", io, OrdersRepository.new, ItemsRepository.new)
    app.run
  end

  it "creates an order entry on choice 4" do
    io = double :io
    expect(io).to receive(:puts).with("Welcome to the shop management program!")
    expect(io).to receive(:puts).with("What do you want to do? \n1 - List all shop items \n2 - Create a new item \n3 - List all orders \n4 - Create a new order \nEnter your choice: ")
    expect(io).to receive(:gets).and_return(4)
    expect(io).to receive(:puts).with("Enter the customers name")
    expect(io).to receive(:gets).and_return("Orhan Khanbayov")
    expect(io).to receive(:puts).with("Enter the date of the order")
    expect(io).to receive(:gets).and_return("8/01/2023")
    expect(io).to receive(:puts).with("Choose the number of the item you want to assign to the order")
    expect(io).to receive(:puts).with("#1 - Phone")
    expect(io).to receive(:puts).with("#2 - Laptop")
    expect(io).to receive(:gets).and_return(1)
    app = Application.new("shop_manager_test", io, OrdersRepository.new, ItemsRepository.new)
    app.run
    repo = OrdersRepository.new
    list = repo.all.last
    expect(list.customer_name).to eq "Orhan Khanbayov"
    expect(list.date).to eq "8/01/2023"
  end
end
