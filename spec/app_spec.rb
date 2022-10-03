require_relative '../app'

def reset_shop_table
  seed_sql = File.read('spec/seeds_shop.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_test' })
  connection.exec(seed_sql)
end

RSpec.describe Application do
  before(:each) do
    reset_shop_table
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
    expect(@io).to receive(:puts).and_return('#1 Pen - Price: £1 - Quantity: 10')
    expect(@io).to receive(:puts).and_return('#2 Ruler - Price: £2 - Quantity: 15')
    expect(@io).to receive(:puts).and_return('#3 Rubber - Price: 50p - Quantity: 5')
    expect(@io).to receive(:puts).and_return('#4 Paper - Price: £2.50 - Quantity: 20')

    app = Application.new(@io, ItemRepository.new, OrderRepository.new)
    app.run
  end

  xit "creates a new Item object" do
    expect(@io).to receive(:puts).with("Welcome to the shop managment program!").ordered
    expect(@io).to receive(:puts).with("").ordered
    expect(@io).to receive(:puts).with("1 = list all shop items").ordered
    expect(@io).to receive(:puts).with("2 = create a new item").ordered
    expect(@io).to receive(:puts).with("3 = list all orders").ordered
    expect(@io).to receive(:puts).with("4 = create a new order").ordered

    expect(@io).to receive(:gets).and_return("2").ordered

    expect(@io).to receive(:puts).with('Please enter the item name:').ordered
    expect(@io).to receive(:gets).and_return("Tippex").ordered
    expect(@io).to receive(:puts).with('Please enter the item price:').ordered
    expect(@io).to receive(:gets).and_return("£3").ordered
    expect(@io).to receive(:puts).with('What quantity do we have?:').ordered
    expect(@io).to receive(:gets).and_return("7").ordered

    app = Application.new(@io, ItemRepository.new, OrderRepository.new)
    app.run
  end

  it "returns a list of shop orders" do 
    expect(@io).to receive(:puts).with("Welcome to the shop managment program!").ordered
    expect(@io).to receive(:puts).with("").ordered
    expect(@io).to receive(:puts).with("1 = list all shop items").ordered
    expect(@io).to receive(:puts).with("2 = create a new item").ordered
    expect(@io).to receive(:puts).with("3 = list all orders").ordered
    expect(@io).to receive(:puts).with("4 = create a new order").ordered

    expect(@io).to receive(:gets).and_return("3").ordered

    expect(@io).to receive(:puts).and_return('Here is a list of all shop orders:')
    expect(@io).to receive(:puts).and_return('#1 Sam - Order date: August')
    expect(@io).to receive(:puts).and_return('#1 Matt - Order date: June')
    expect(@io).to receive(:puts).and_return('#1 Max - Order date: October')
    expect(@io).to receive(:puts).and_return('#1 James - Order date: March')
    expect(@io).to receive(:puts).and_return('#1 Olly - Order date: April')

    app = Application.new(@io, ItemRepository.new, OrderRepository.new)
    app.run
  end
end
