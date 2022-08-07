require_relative '../app.rb'

def reset_tables
  seed_sql = File.read('spec/seeds_items_orders.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager' })
  connection.exec(seed_sql)
end

def run_app(io)
  app = Application.new(
      'shop_manager',
      io,
      ItemRepository.new,
      OrderRepository.new
    )  
    app.run
end

describe Application do
  before(:each) do 
    reset_tables
  end

  it "lists all shop items" do
    str = "What do you want to do?\n"
    str += "  1 = list all shop items\n  2 = create a new item\n"
    str += "  3 = list all orders\n  4 = create a new order\n"
    io = double :fake
    expect(io).to receive(:puts).with(str)
    expect(io).to receive(:gets).and_return("1")
    expect(io).to receive(:puts).with("\nHere's a list of all shop items:\n\n")
    expect(io).to receive(:puts).with("#1 - Hoover - Unit price: 100 - Quantity: 20")
    expect(io).to receive(:puts).with("#2 - Washing Machine - Unit price: 400 - Quantity: 30")
    expect(io).to receive(:puts).with("#3 - Cooker - Unit price: 389 - Quantity: 12")
    expect(io).to receive(:puts).with("#4 - Tumble Dryer - Unit price: 279 - Quantity: 44")
    expect(io).to receive(:puts).with("#5 - Fridge - Unit price: 199 - Quantity: 15")  

    run_app(io)
  end

  it "lists all orders" do
    str = "What do you want to do?\n"
      str += "  1 = list all shop items\n  2 = create a new item\n"
      str += "  3 = list all orders\n  4 = create a new order\n"
      io = double :fake
      expect(io).to receive(:puts).with(str)
      expect(io).to receive(:gets).and_return("3")
      ord = "\nHere's a list of all orders\n\n"
      ord += "  #1 - Customer: Frank - Placed: 04-Jan-2021\n"
      ord += "    * Hoover - Unit price: 100 - qty: 2\n"
      ord += "    * Washing Machine - Unit price: 400 - qty: 1\n"
      ord += "  #2 - Customer: Benny - Placed: 05-Aug-2022\n"
      ord += "    * Hoover - Unit price: 100 - qty: 1\n"
      ord += "    * Cooker - Unit price: 389 - qty: 3\n"
      expect(io).to receive(:puts).with(ord)  
  
      run_app(io)
  end
end