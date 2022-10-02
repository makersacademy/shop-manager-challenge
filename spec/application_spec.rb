require_relative "../lib/app.rb"
# require_relative "../lib/item_repository.rb"

RSpec.describe Application do
    it "runs" do
        io = double :io

        expect(io).to receive(:puts)
        allow(io).to receive(:puts)
        allow(io).to receive(:gets)
        app = Application.new(io)
        app.run
    end

    
    it "prints initial message to screen" do
        io = double :io

        expect(io).to receive(:puts).with("Welcome to the shop management program!")
        expect(io).to receive(:puts).with("")
        expect(io).to receive(:puts).with("What do you want to do?")
        expect(io).to receive(:puts).with("  1 = list all shop items")
        expect(io).to receive(:puts).with("  2 = create a new item")
        expect(io).to receive(:puts).with("  3 = list all orders")
        expect(io).to receive(:puts).with("  4 = create a new order")
        allow(io).to receive(:gets)
        allow(io).to receive(:puts)
        app = Application.new(io)
        app.run
    end

    it "prints a list of items if user input is 1" do
        io = double :io

        expect(io).to receive(:puts).with("Welcome to the shop management program!")
        expect(io).to receive(:puts).with("")
        expect(io).to receive(:puts).with("What do you want to do?")
        expect(io).to receive(:puts).with("  1 = list all shop items")
        expect(io).to receive(:puts).with("  2 = create a new item")
        expect(io).to receive(:puts).with("  3 = list all orders")
        expect(io).to receive(:puts).with("  4 = create a new order")
        expect(io).to receive(:gets).and_return("1")
        expect(io).to receive(:puts).with("Here's a list of all shop items:")
        expect(io).to receive(:puts).with("1 Royal Canin kitten food - Unit price: 5 - Quantity: 20")
        expect(io).to receive(:puts).with("2 Organic tomatoes - Unit price: 3 - Quantity: 10")
        expect(io).to receive(:puts).with("3 Celery - Unit price: 2 - Quantity: 7")
        expect(io).to receive(:puts).with("4 Scottish salmon - Unit price: 6 - Quantity: 9")
        expect(io).to receive(:puts).with("5 Baby leaves - Unit price: 3 - Quantity: 15")
        app = Application.new(io)
        app.run
    end
end



# What do you want to do?
#   1 = list all shop items
#   2 = create a new item
#   3 = list all orders
#   4 = create a new order

# 1 [enter]

# Here's a list of all shop items:

#  #1 Super Shark Vacuum Cleaner - Unit price: 99 - Quantity: 30
#  #2 Makerspresso Coffee Machine - Unit price: 69 - Quantity: 15
#  (...)
