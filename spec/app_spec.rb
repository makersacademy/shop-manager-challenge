require_relative '../app'

def reset_name_table
  seed_sql = File.read('spec/seed_tables.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager' })
  connection.exec(seed_sql)
end

RSpec.describe Application do
  before(:each) do
    reset_name_table
    @io = double :io
  end

  it "returns a list of shop items" do 
    expect(@io).to receive(:puts).with("Welcome to the shop managment program!").ordered
    expect(@io).to receive(:puts).with("").ordered
    expect(@io).to receive(:puts).with("1 = list all shop items").ordered
    expect(@io).to receive(:puts).with("2 = create a new item").ordered
    expect(@io).to receive(:puts).with("3 = list all orders").ordered
    expect(@io).to receive(:puts).with("4 = create a new order").ordered

    expect(@io).to receive(:gets).and_return("1").ordered

    expect(@io).to receive(:puts).and_return('Here is a list of all shop items:')
    expect(@io).to receive(:puts).and_return('#1 Book case - Unit price: 300 - Quantity: 5')
    expect(@io).to receive(:puts).and_return('#1 Chicken treats - Unit price: 3 - Quantity: 30')

    app = Application.new(@io, ItemRepository.new, OrderRepository.new)
    app.run
  end

  it "creates a new item" do
    expect(@io).to receive(:puts).with("Welcome to the shop managment program!").ordered
    expect(@io).to receive(:puts).with("").ordered
    expect(@io).to receive(:puts).with("1 = list all shop items").ordered
    expect(@io).to receive(:puts).with("2 = create a new item").ordered
    expect(@io).to receive(:puts).with("3 = list all orders").ordered
    expect(@io).to receive(:puts).with("4 = create a new order").ordered

    expect(@io).to receive(:gets).and_return("2").ordered

    expect(@io).to receive(:puts).with('Please give the item name:').ordered
    expect(@io).to receive(:gets).and_return("Rubber duck").ordered
    expect(@io).to receive(:puts).with('Please give the unit price:').ordered
    expect(@io).to receive(:gets).and_return("15").ordered
    expect(@io).to receive(:puts).with('Please give the item quantity:').ordered
    expect(@io).to receive(:gets).and_return("20").ordered

    app = Application.new(@io, ItemRepository.new, OrderRepository.new)
    app.run
  end

  it "returns a list of orders" do 
    expect(@io).to receive(:puts).with("Welcome to the shop managment program!").ordered
    expect(@io).to receive(:puts).with("").ordered
    expect(@io).to receive(:puts).with("1 = list all shop items").ordered
    expect(@io).to receive(:puts).with("2 = create a new item").ordered
    expect(@io).to receive(:puts).with("3 = list all orders").ordered
    expect(@io).to receive(:puts).with("4 = create a new order").ordered

    expect(@io).to receive(:gets).and_return("3").ordered

    expect(@io).to receive(:puts).and_return('Here is a list of all orders:')
    expect(@io).to receive(:puts).and_return('#1 Customer name: Chris - Order date: 01/10/2022 - Item ID: 1')
    expect(@io).to receive(:puts).and_return('#1 Customer name: Forest - Order date: 01/10/2022 - Item ID: 2')

    app = Application.new(@io, ItemRepository.new, OrderRepository.new)
    app.run
  end

  it "creates a new order" do
    expect(@io).to receive(:puts).with("Welcome to the shop managment program!").ordered
    expect(@io).to receive(:puts).with("").ordered
    expect(@io).to receive(:puts).with("1 = list all shop items").ordered
    expect(@io).to receive(:puts).with("2 = create a new item").ordered
    expect(@io).to receive(:puts).with("3 = list all orders").ordered
    expect(@io).to receive(:puts).with("4 = create a new order").ordered

    expect(@io).to receive(:gets).and_return("4").ordered

    expect(@io).to receive(:puts).with('Please give the order name:').ordered
    expect(@io).to receive(:gets).and_return("Ariel").ordered
    expect(@io).to receive(:puts).with('Please give the order date:').ordered
    expect(@io).to receive(:gets).and_return("27/09/2022").ordered
    expect(@io).to receive(:puts).with('Please give the item id:').ordered
    expect(@io).to receive(:gets).and_return("2").ordered

    app = Application.new(@io, ItemRepository.new, OrderRepository.new)
    app.run
  end

  context "User enters number not on list" do
    it "returns error" do
      expect(@io).to receive(:puts).with("Welcome to the shop managment program!").ordered
      expect(@io).to receive(:puts).with("").ordered
      expect(@io).to receive(:puts).with("1 = list all shop items").ordered
      expect(@io).to receive(:puts).with("2 = create a new item").ordered
      expect(@io).to receive(:puts).with("3 = list all orders").ordered
      expect(@io).to receive(:puts).with("4 = create a new order").ordered

      expect(@io).to receive(:gets).and_return("5").ordered

      app = Application.new(@io, ItemRepository.new, OrderRepository.new)

      expect { app.run }.to raise_error "Please enter a valid number"
    end
  end
end
