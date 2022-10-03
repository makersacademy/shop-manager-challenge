RSpec.describe Greeter do
  it "greets the user" do
    io = double :io
    expect(io).to receive(:puts).with("Welcome to the shop management program!

      What function would you like to do?
  
        1 = list all shop items
        2 = create a new item
        3 = list all orders
        4 = create a new order")

    greeter = Greeter.new(io)
    greeter.greet
  end
end