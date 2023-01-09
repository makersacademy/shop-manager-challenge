require 'app'

RSpec.describe Run do
  it "runs the application" do
    io = double :io
    expect(io).to receive(:puts).with('Welcome to the shop management program!')
    expect(io).to receive(:puts).with('What do you want to do?')
    expect(io).to receive(:puts).with('1 = list all shop items')
    expect(io).to receive(:puts).with('2 = create a new item')
    expect(io).to receive(:puts).with('3 = list all orders')
    expect(io).to receive(:puts).with('4 = create a new order')
    expect(io).to receive(:gets).and_return("1 - entered")
    expect(io).to receive(:puts).with("Here is the list of items:
    #1 Super Shark Vacuum Cleaner -Unit price: 99 - Quantity: 30
    #2 Makerspresso Coffee Machine - Unit price: 69 - Quantity: 15
    #3 Kettle - Unit price: 50 - Quantity: 25
    #4 Cooker - Unit price: 200 - Quantity: 10
    #5 Mug - Unit price: 20 - Quantity: 2")

    test = Application.new(io)
    test.run
  end
end
