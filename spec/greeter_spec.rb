require "greeter"

RSpec.describe Greeter do
  it "greets the user" do
    stocks_repo = StocksRepository.new
    all_stocks = stocks_repo.all 
    io = double :io
    expect(io).to receive(:puts).with(
      "Welcome to the shop management program!
  
      What do you want to do?
      1 = list all shop items
      2 = create a new item
      3 = list all orders
      4 = create a new order"
      )
    expect(io).to receive(:gets).and_return("1")
     expect(io).to receive(:puts).with all_stocks
  
    greeter = Greeter.new(io)
    greeter.greet
  end
end