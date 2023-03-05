require './app'

RSpec.describe Application do
  
  it "asks the user for input and lists all items when asked" do
    io = double :io

    expect(io).to receive(:puts).with("Welcome to the shop management program!")
    expect(io).to receive(:puts).with("What do you want to do?
    1 = list all shop items
    2 = create a new item
    3 = list all orders
    4 = create a new order")
    expect(io).to receive(:gets).and_return("1")
    expect(io).to receive(:puts).with("Here's a list of all shop items:")
    expect(io).to receive(:puts).with("#1 Super Shark Vacuum Cleaner - Unit Price: 99 - Quantity: 30")
    expect(io).to receive(:puts).with("#2 Makerspresso Coffee Machine - Unit Price: 69 - Quantity: 15")
    expect(io).to receive(:puts).with("#3 Toastie Maker - Unit Price: 30 - Quantity: 60")

    app = Application.new(
      'shop_manager_test',
      io,
      ItemRepository.new,
      OrderRepository.new
    )
    app.run
  end 

end