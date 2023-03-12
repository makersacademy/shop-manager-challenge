require "./lib/greeter"
RSpec.describe Greeter do
  
  it "returns a list of all items" do
    io = double :io
    expect(io).to receive(:puts).with("What do you want to do?")
    expect(io).to receive(:puts).with("1 = list all shop items")
    expect(io).to receive(:puts).with("2 = create a new item")
    expect(io).to receive(:puts).with("3 = list all orders")
    expect(io).to receive(:puts).with("4 = create a new order")
    expect(io).to receive(:gets).and_return("1")
    expect(io).to receive(:puts).with("Here's a list of all shop items: ")
    expect(io).to receive(:puts).with("#1 Chair - price: 50 - quantity: 7")
    expect(io).to receive(:puts).with("#2 Bed - price: 150 - quantity: 11")
    expect(io).to receive(:puts).with("#3 Wardrobe - price: 90 - quantity: 15")
    expect(io).to receive(:puts).with("#4 Shelf - price: 25 - quantity: 21")
    expect(io).to receive(:puts).with("#5 Sofa - price: 300 - quantity: 11")

    greeter = Greeter.new(io)
    greeter.greet
  end

  it "returns a list of all orders" do
    io = double :io
    expect(io).to receive(:puts).with("What do you want to do?")
    expect(io).to receive(:puts).with("1 = list all shop items")
    expect(io).to receive(:puts).with("2 = create a new item")
    expect(io).to receive(:puts).with("3 = list all orders")
    expect(io).to receive(:puts).with("4 = create a new order")
    expect(io).to receive(:gets).and_return("3")
    expect(io).to receive(:puts).with("Here's a list of all orders: ")
    expect(io).to receive(:puts).with("#1 Mary Jones, made on 2023-03-11")
    expect(io).to receive(:puts).with("#2 Anna Smith, made on 2023-03-12")
    expect(io).to receive(:puts).with("#3 Jack Jackson, made on 2023-03-13")
    expect(io).to receive(:puts).with("#4 Victor Potter, made on 2023-03-14")
    expect(io).to receive(:puts).with("#5 Jane Peters, made on 2023-03-15")
    expect(io).to receive(:puts).with("#6 Peter Jones, made on 2023-03-16")
    expect(io).to receive(:puts).with("#7 Sofia Brown, made on 2023-03-08")

    greeter = Greeter.new(io)
    greeter.greet
  end

  xit "creates a new item" do
    io = double :io
    expect(io).to receive(:puts).with("What do you want to do?")
    expect(io).to receive(:puts).with("1 = list all shop items")
    expect(io).to receive(:puts).with("2 = create a new item")
    expect(io).to receive(:puts).with("3 = list all orders")
    expect(io).to receive(:puts).with("4 = create a new order")

    expect(io).to receive(:gets).and_return("2")

    expect(io).to receive(:puts).with("Please input the name of the new item")
    expect(io).to receive(:gets).and_return("Kettle")
    expect(io).to receive(:puts).with("Please input the price of the new item")
    expect(io).to receive(:gets).and_return("12")
    expect(io).to receive(:puts).with("Please input the quantity of the new item")
    expect(io).to receive(:gets).and_return("22")
    greeter = Greeter.new(io)
    greeter.greet
  end

    
  
end
