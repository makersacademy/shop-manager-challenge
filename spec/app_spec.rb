require_relative "../app"
require 'date'

describe "Application class for shop_manager_challenge" do
  context "prompts user for options and performs an action" do
    it "takes user input of 1 and lists all shop items" do
      io = double :io

      expect(io).to receive(:puts).with("Welcome to the shop management program!")
      expect(io).to receive(:puts).with("\nWhat would you like to do?\n 1 - List all shop items\n 2 - create a new item\n 3 - list all orders\n 4 - create a new order")
      expect(io).to receive(:puts).with("\nEnter your choice: ")
      expect(io).to receive(:gets).and_return("1")
      expect(io).to receive(:puts).with("Here is the list of all shop items:")
      expect(io).to receive(:puts).with("#1 - Super Shark Vacuum Cleaner - Unit price: 99 - Quantity: 30")
      expect(io).to receive(:puts).with("#2 - Makerspresso Coffee Machine - Unit price: 70 - Quantity: 15")
      expect(io).to receive(:puts).with("#3 - Magic Beans - Unit price: 20 - Quantity: 40")
      expect(io).to receive(:puts).with("#4 - Beanstalk - Unit price: 30 - Quantity: 50")

      app = Application.new('shop_manager_test', io, 'item_repository', 'order_repository')
      app.run
    end

    it "takes user input of 2 and allows the user to create a new item" do
      io = double :io

      expect(io).to receive(:puts).with("Welcome to the shop management program!")
      expect(io).to receive(:puts).with("\nWhat would you like to do?\n 1 - List all shop items\n 2 - create a new item\n 3 - list all orders\n 4 - create a new order")
      expect(io).to receive(:puts).with("\nEnter your choice: ")
      expect(io).to receive(:gets).and_return("2")
      expect(io).to receive(:puts).with("What is the name of the new item? ")
      expect(io).to receive(:gets).and_return("Teapot")
      expect(io).to receive(:puts).with("What is the price of 'Teapot'? ")
      expect(io).to receive(:gets).and_return("15")
      expect(io).to receive(:puts).with("What is the quantity of 'Teapot'? ")
      expect(io).to receive(:gets).and_return("30")
      expect(io).to receive(:puts).with("Added 'Teapot - Unit price: 15 - Quantity: 30' to items")

      app = Application.new('shop_manager_test', io, 'item_repository', 'order_repository')
      app.run
    end
    
    it "takes user input of 3 and lists all orders" do
      io = double :io

      expect(io).to receive(:puts).with("Welcome to the shop management program!")
      expect(io).to receive(:puts).with("\nWhat would you like to do?\n 1 - List all shop items\n 2 - create a new item\n 3 - list all orders\n 4 - create a new order")
      expect(io).to receive(:puts).with("\nEnter your choice: ")
      expect(io).to receive(:gets).and_return("3")
      expect(io).to receive(:puts).with("Here is the list of all orders:")
      expect(io).to receive(:puts).with("#1 - Customer name: John Smith - Order date: 2022-06-01 - Item ID: 1")
      expect(io).to receive(:puts).with("#2 - Customer name: Pauline Jones - Order date: 2022-05-01 - Item ID: 2")
      expect(io).to receive(:puts).with("#3 - Customer name: Colonel Mustard - Order date: 2022-05-01 - Item ID: 2")

      app = Application.new('shop_manager_test', io, 'item_repository', 'order_repository')
      app.run
    end

    it "takes user input of 4 and allows the user to create a new item" do
      io = double :io

      expect(io).to receive(:puts).with("Welcome to the shop management program!")
      expect(io).to receive(:puts).with("\nWhat would you like to do?\n 1 - List all shop items\n 2 - create a new item\n 3 - list all orders\n 4 - create a new order")
      expect(io).to receive(:puts).with("\nEnter your choice: ")
      expect(io).to receive(:gets).and_return("4")
      expect(io).to receive(:puts).with("What is the customer's name? ")
      expect(io).to receive(:gets).and_return("Alex")
      expect(io).to receive(:puts).with("What is the item ID that 'Alex' wishes to order? ")
      expect(io).to receive(:gets).and_return("1")
      expect(io).to receive(:puts).with("Order added! - 'Customer Name: Alex - Date: #{Date.today} - Item: Super Shark Vacuum Cleaner'")

      app = Application.new('shop_manager_test', io, 'item_repository', 'order_repository')
      app.run
    end
  end
end
