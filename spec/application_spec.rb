require_relative "../lib/app.rb"
require_relative "../lib/item_repository.rb"

RSpec.describe Application do
    it "runs" do
        @io = double :io

        expect(@io).to receive(:puts)
        allow(@io).to receive(:puts)
        allow(@io).to receive(:gets)
        app = Application.new(@io)
        app.run
    end

    
    it "prints initial message to screen" do
        @io = double :io

        expect(@io).to receive(:puts).with("Welcome to the shop management program!").ordered
        expect(@io).to receive(:puts).with("").ordered
        expect(@io).to receive(:puts).with("What do you want to do?").ordered
        expect(@io).to receive(:puts).with("  1 = list all shop items").ordered
        expect(@io).to receive(:puts).with("  2 = create a new item").ordered
        expect(@io).to receive(:puts).with("  3 = list all orders").ordered
        expect(@io).to receive(:puts).with("  4 = create a new order").ordered
        allow(@io).to receive(:gets)
        allow(@io).to receive(:puts)
        app = Application.new(@io)
        app.run
    end

    it "prints a list of items if user input is 1" do
        @io = double :io

        allow(@io).to receive(:puts)
        expect(@io).to receive(:gets).and_return("1\n").ordered
        expect(@io).to receive(:puts).with("Here's a list of all shop items:").ordered
        expect(@io).to receive(:puts).with("1 Royal Canin kitten food - Unit price: 5 - Quantity: 20").ordered
        expect(@io).to receive(:puts).with("2 Organic tomatoes - Unit price: 3 - Quantity: 10").ordered
        expect(@io).to receive(:puts).with("3 Celery - Unit price: 2 - Quantity: 7").ordered
        expect(@io).to receive(:puts).with("4 Scottish salmon - Unit price: 6 - Quantity: 9").ordered
        expect(@io).to receive(:puts).with("5 Baby leaves - Unit price: 3 - Quantity: 15").ordered
        allow(@io).to receive(:puts)
        app = Application.new(@io)
        app.run
    end

    it "creates a new item" do
        @io = double :io

        allow(@io).to receive(:puts)
        expect(@io).to receive(:gets).and_return("2\n").ordered
        expect(@io).to receive(:puts).with("Please, enter the name of the item you would like to create:").ordered
        expect(@io).to receive(:gets).and_return("Rice").ordered
        expect(@io).to receive(:puts).with("Please, enter the unit price for this item:").ordered
        expect(@io).to receive(:gets).and_return("2").ordered
        expect(@io).to receive(:puts).with("Please, enter the quantity for this item:").ordered
        expect(@io).to receive(:gets).and_return("10").ordered
        expect(@io).to receive(:puts).with("Your item has been created successfully.").ordered

        app = Application.new(@io)
        app.run
    end

    it "lists all orders" do
        @io = double :io

        allow(@io).to receive(:puts)
        expect(@io).to receive(:gets).and_return("3\n").ordered
        expect(@io).to receive(:puts).with("Here is a list of all orders:").ordered
        expect(@io).to receive(:puts).with("1 Customer name: Alice - Date: 2022-09-15 - Item id: 1")
        allow(@io).to receive(:puts)

        app = Application.new(@io)
        app.run
    end

    it "creates a new order" do
        @io = double :io

        allow(@io).to receive(:puts)
        expect(@io).to receive(:gets).and_return("4\n").ordered
        expect(@io).to receive(:puts).with("Please, enter the customer name for the order:").ordered
        expect(@io).to receive(:gets).and_return("Raven").ordered
        expect(@io).to receive(:puts).with("Please, enter the date for this order:").ordered
        expect(@io).to receive(:gets).and_return("2022-10-03").ordered
        expect(@io).to receive(:puts).with("Please, enter the item id for this order:").ordered
        expect(@io).to receive(:gets).and_return("3").ordered
        expect(@io).to receive(:puts).with("Your order has been created successfully.").ordered

        app = Application.new(@io)
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
