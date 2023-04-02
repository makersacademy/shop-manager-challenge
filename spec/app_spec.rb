require_relative '../app'

# could double ItemRepository and OrderRepository as well

def reset_items_table
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

RSpec.describe Application do
  before(:each) do
    reset_items_table
  end

  let(:intro) do
    "\nWelcome to the shop management program!\n"
  end

  let(:action_list) do
    "\nWhat do you want to do?\n1 = list all shop items\n2 = create a new item\n3 = list all orders\n4 = create a new order\n5 = quit program\n\n"
  end

  it "lists all shop items" do
    @io = double :io

    expect(@io).to receive(:puts).with(intro).ordered
    expect(@io).to receive(:puts).with(action_list).ordered
    expect(@io).to receive(:gets).and_return("1").ordered
    expect(@io).to receive(:puts).with("\n1. milk - unit price: 2 - quantity: 50").ordered
    expect(@io).to receive(:puts).with("\n2. bread - unit price: 3 - quantity: 30").ordered
    expect(@io).to receive(:puts).with("\n3. cake - unit price: 9 - quantity: 10").ordered
    expect(@io).to receive(:puts).with("\n4. bananas - unit price: 4 - quantity: 100").ordered
    expect(@io).to receive(:puts).with("\n5. broccoli - unit price: 1 - quantity: 45").ordered
    expect(@io).to receive(:puts).with("\n6. rare item - unit price: 1000 - quantity: 0").ordered
    expect(@io).to receive(:puts).with(action_list).ordered
    expect(@io).to receive(:gets).and_return("5").ordered

    app = Application.new('shop_manager_test', @io, ItemRepository.new, OrderRepository.new)
    app.run
  end

  it "creates a new item" do
    @io = double :io

    expect(@io).to receive(:puts).with(intro).ordered
    expect(@io).to receive(:puts).with(action_list).ordered
    expect(@io).to receive(:gets).and_return("2").ordered
    expect(@io).to receive(:puts).with("What is the name of the item?").ordered
    expect(@io).to receive(:gets).and_return("cereal").ordered
    expect(@io).to receive(:puts).with("What is the price of the item?").ordered
    expect(@io).to receive(:gets).and_return("5").ordered
    expect(@io).to receive(:puts).with("How many of the item will be in stock?").ordered
    expect(@io).to receive(:gets).and_return("70").ordered
    expect(@io).to receive(:puts).with("cereal added to the database.").ordered
    expect(@io).to receive(:puts).with(action_list).ordered
    expect(@io).to receive(:gets).and_return("5").ordered

    app = Application.new('shop_manager_test', @io, ItemRepository.new, OrderRepository.new)
    app.run
  end

  it "lists all orders with their associated items" do
    @io = double :io

    expect(@io).to receive(:puts).with(intro).ordered
    expect(@io).to receive(:puts).with(action_list).ordered
    expect(@io).to receive(:gets).and_return("3").ordered
    expect(@io).to receive(:puts).with("\n1. customer name: Quack Overflow - order date: 2023-04-01\nOrder contents:\n").ordered
    expect(@io).to receive(:puts).with("milk - unit price: 2\n").ordered
    expect(@io).to receive(:puts).with("bread - unit price: 3\n").ordered
    expect(@io).to receive(:puts).with("cake - unit price: 9\n").ordered
    expect(@io).to receive(:puts).with("bananas - unit price: 4\n").ordered
    expect(@io).to receive(:puts).with("broccoli - unit price: 1\n").ordered
    expect(@io).to receive(:puts).with("\n2. customer name: Scrooge McDuck - order date: 2023-03-31\nOrder contents:\n").ordered
    expect(@io).to receive(:puts).with("broccoli - unit price: 1\n").ordered
    expect(@io).to receive(:puts).with("\n3. customer name: Silly Goose - order date: 2023-03-30\nOrder contents:\n").ordered
    expect(@io).to receive(:puts).with("bread - unit price: 3\n").ordered
    expect(@io).to receive(:puts).with("bananas - unit price: 4\n").ordered
    expect(@io).to receive(:puts).with("broccoli - unit price: 1\n").ordered
    expect(@io).to receive(:puts).with(action_list).ordered
    expect(@io).to receive(:gets).and_return("5").ordered

    app = Application.new('shop_manager_test', @io, ItemRepository.new, OrderRepository.new)
    app.run
  end

  it "creates a new order" do
    @io = double :io

    expect(@io).to receive(:puts).with(intro).ordered
    expect(@io).to receive(:puts).with(action_list).ordered
    expect(@io).to receive(:gets).and_return("4").ordered
    expect(@io).to receive(:puts).with("What is the customer's name?").ordered
    expect(@io).to receive(:gets).and_return("Big Bird").ordered
    expect(@io).to receive(:puts).with("What date was the order made?").ordered
    expect(@io).to receive(:gets).and_return("2023-01-01").ordered
    expect(@io).to receive(:puts).with("How many items do you want to add to the order?").ordered
    expect(@io).to receive(:gets).and_return("1").ordered
    expect(@io).to receive(:puts).with("What is the id of the item you want to add?").ordered
    expect(@io).to receive(:gets).and_return("1").ordered
    expect(@io).to receive(:puts).with("milk added to order.").ordered
    expect(@io).to receive(:puts).with(action_list).ordered
    expect(@io).to receive(:gets).and_return("5").ordered

    app = Application.new('shop_manager_test', @io, ItemRepository.new, OrderRepository.new)
    app.run
  end

  it "updates an item's stock when it is added to an order" do
    @io = double :io

    expect(@io).to receive(:puts).with(intro).ordered
    expect(@io).to receive(:puts).with(action_list).ordered
    expect(@io).to receive(:gets).and_return("4").ordered
    expect(@io).to receive(:puts).with("What is the customer's name?").ordered
    expect(@io).to receive(:gets).and_return("Big Bird").ordered
    expect(@io).to receive(:puts).with("What date was the order made?").ordered
    expect(@io).to receive(:gets).and_return("2023-01-01").ordered
    expect(@io).to receive(:puts).with("How many items do you want to add to the order?").ordered
    expect(@io).to receive(:gets).and_return("1").ordered
    expect(@io).to receive(:puts).with("What is the id of the item you want to add?").ordered
    expect(@io).to receive(:gets).and_return("1").ordered
    expect(@io).to receive(:puts).with("milk added to order.").ordered
    expect(@io).to receive(:puts).with(action_list).ordered
    expect(@io).to receive(:gets).and_return("5").ordered

    @item_repository = ItemRepository.new
    app = Application.new('shop_manager_test', @io, @item_repository, OrderRepository.new)
    app.run

    expect(@item_repository.find(1).quantity).to eq "49"
  end

  it "cancels order creation if user attempts to add an out of stock item" do
    @io = double :io

    expect(@io).to receive(:puts).with(intro).ordered
    expect(@io).to receive(:puts).with(action_list).ordered
    expect(@io).to receive(:gets).and_return("4").ordered
    expect(@io).to receive(:puts).with("What is the customer's name?").ordered
    expect(@io).to receive(:gets).and_return("Big Bird").ordered
    expect(@io).to receive(:puts).with("What date was the order made?").ordered
    expect(@io).to receive(:gets).and_return("2023-01-01").ordered
    expect(@io).to receive(:puts).with("How many items do you want to add to the order?").ordered
    expect(@io).to receive(:gets).and_return("1").ordered
    expect(@io).to receive(:puts).with("What is the id of the item you want to add?").ordered
    expect(@io).to receive(:gets).and_return("6").ordered
    expect(@io).to receive(:puts).with("That item is out of stock. Item could not be added. Please start again.").ordered
    expect(@io).to receive(:puts).with(action_list).ordered
    expect(@io).to receive(:gets).and_return("5").ordered

    @order_repository = OrderRepository.new
    app = Application.new('shop_manager_test', @io, ItemRepository.new, @order_repository)
    app.run

    expect(@order_repository.all.length).to eq 3
  end

  it "prompts user to input a valid input at the action list" do
    @io = double :io

    expect(@io).to receive(:puts).with(intro).ordered
    expect(@io).to receive(:puts).with(action_list).ordered
    expect(@io).to receive(:gets).and_return("blah").ordered
    expect(@io).to receive(:puts).with("Invalid input. Please input a number from 1 to 5.").ordered
    expect(@io).to receive(:puts).with(action_list).ordered
    expect(@io).to receive(:gets).and_return("5").ordered

    app = Application.new('shop_manager_test', @io, ItemRepository.new, OrderRepository.new)
    app.run
  end
end
