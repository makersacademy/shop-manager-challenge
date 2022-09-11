require_relative '../app'

def reset_items_orders_table
  seed_sql = File.read('spec/seeds_items_orders.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'book_store_solo_test'})
  connection.exec(seed_sql)
end

describe Application do
  before(:each) do 
    reset_items_orders_table
  end
  it 'prints the header' do
    io = double(:io)
    expect(io).to receive(:puts).with("Welcome to the shop management program!")

    app = Application.new('book_store_solo_test', io, ItemRepository.new, OrderRepository.new)
    app.print_header
  end

  it 'prints the menu options' do
    io = double(:io)
    expect(io).to receive(:puts).with("What do you want to do?")
    expect(io).to receive(:puts).with("1 = list all shop items")
    expect(io).to receive(:puts).with("2 = create a new item")
    expect(io).to receive(:puts).with("3 = list all orders")
    expect(io).to receive(:puts).with("4 = create a new order")
    expect(io).to receive(:puts).with("Enter your choice:")

    app = Application.new('book_store_solo_test', io, ItemRepository.new, OrderRepository.new)
    app.print_options
  end

  it "lists all items if asked" do
    io = double(:io)
    expect(io).to receive(:puts).with("Welcome to the shop management program!")
    expect(io).to receive(:puts).with("What do you want to do?")
    expect(io).to receive(:puts).with("1 = list all shop items")
    expect(io).to receive(:puts).with("2 = create a new item")
    expect(io).to receive(:puts).with("3 = list all orders")
    expect(io).to receive(:puts).with("4 = create a new order")
    expect(io).to receive(:puts).with("Enter your choice:")
    expect(io).to receive(:gets).and_return("1")
    expect(io).to receive(:puts).with("Here's a list of all shop items:")
    expect(io).to receive(:puts).with("1 - Unit price: 9.99 - Quantity: 54")
    expect(io).to receive(:puts).with("2 - Unit price: 7.99 - Quantity: 14")
    app = Application.new('book_store_solo_test', io, ItemRepository.new, OrderRepository.new)
    app.run
  end 

  it "creates a new item if asked" do
    io = double(:io)
    expect(io).to receive(:puts).with("Welcome to the shop management program!")
    expect(io).to receive(:puts).with("What do you want to do?")
    expect(io).to receive(:puts).with("1 = list all shop items")
    expect(io).to receive(:puts).with("2 = create a new item")
    expect(io).to receive(:puts).with("3 = list all orders")
    expect(io).to receive(:puts).with("4 = create a new order")
    expect(io).to receive(:puts).with("Enter your choice:")
    expect(io).to receive(:gets).and_return("2")
    expect(io).to receive(:puts).with("Please enter item name:")
    expect(io).to receive(:gets).and_return("new_book")
    expect(io).to receive(:puts).with("Please enter item price:")
    expect(io).to receive(:gets).and_return("5.66")
    expect(io).to receive(:puts).with("Please enter item quantity:")
    expect(io).to receive(:gets).and_return("46")
    app = Application.new('book_store_solo_test', io, ItemRepository.new, OrderRepository.new)
    app.run
  end 

  it "lists all orders if asked" do
    io = double(:io)
    expect(io).to receive(:puts).with("Welcome to the shop management program!")
    expect(io).to receive(:puts).with("What do you want to do?")
    expect(io).to receive(:puts).with("1 = list all shop items")
    expect(io).to receive(:puts).with("2 = create a new item")
    expect(io).to receive(:puts).with("3 = list all orders")
    expect(io).to receive(:puts).with("4 = create a new order")
    expect(io).to receive(:puts).with("Enter your choice:")
    expect(io).to receive(:gets).and_return("3")
    expect(io).to receive(:puts).with("Here's a list of all shop orders:")
    expect(io).to receive(:puts).with("1 - Customer: Anna - ordered on: 2022-08-15")
    expect(io).to receive(:puts).with("2 - Customer: David - ordered on: 2022-08-23")
    app = Application.new('book_store_solo_test', io, ItemRepository.new, OrderRepository.new)
    app.run
  end 

  it "creates a new order if asked" do
    io = double(:io)
    expect(io).to receive(:puts).with("Welcome to the shop management program!")
    expect(io).to receive(:puts).with("What do you want to do?")
    expect(io).to receive(:puts).with("1 = list all shop items")
    expect(io).to receive(:puts).with("2 = create a new item")
    expect(io).to receive(:puts).with("3 = list all orders")
    expect(io).to receive(:puts).with("4 = create a new order")
    expect(io).to receive(:puts).with("Enter your choice:")
    expect(io).to receive(:gets).and_return("4")
    expect(io).to receive(:puts).with("Please enter customer name:")
    expect(io).to receive(:gets).and_return("Maria")
    expect(io).to receive(:puts).with("Please enter the date of the order:")
    expect(io).to receive(:gets).and_return("2022-08-23")
    app = Application.new('book_store_solo_test', io, ItemRepository.new, OrderRepository.new)
    app.run
  end 
end
