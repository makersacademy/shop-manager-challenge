require_relative "../lib/app.rb"

RSpec.describe Application do
    it "runs" do
        io = double :io
        expect(io).to receive(:puts).with("Welcome to the shop management program!")
        expect(io).to receive(:puts).with("")
        expect(io).to receive(:puts).with("What do you want to do?")
        expect(io).to receive(:puts).with("  1 = list all shop items")
        expect(io).to receive(:puts).with("  2 = create a new item")
        expect(io).to receive(:puts).with("  3 = list all orders")
        expect(io).to receive(:puts).with("  4 = create a new order")
        expect(io).to receive(:gets)
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
