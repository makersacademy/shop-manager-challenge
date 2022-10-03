require_relative "../app.rb"


RSpec.describe Application do
  describe "#welcome user" do
    it "welcomes the user" do
      io = double :io
      database_name = 'shop_manager_test'
      item_repository = double :item_repository
      order_repository = double :order_repository

      app = Application.new(database_name, io, item_repository, order_repository)
      expect(io).to receive(:puts).with("Welcome to the shop management program!")
      app.welcome_user
    end
  end
  describe "print interface" do
    it "prints the list of options" do 
      io = double :io
      database_name = 'shop_manager_test'
      item_repository = double :item_repository
      order_repository = double :order_repository

      app = Application.new(database_name, io, item_repository, order_repository)
      expect(io).to receive(:puts).with("What do you want to do?").ordered
      expect(io).to receive(:puts).with("1 = list all shop items").ordered
      expect(io).to receive(:puts).with("2 = create a new item").ordered
      expect(io).to receive(:puts).with("3 = list all orders").ordered
      expect(io).to receive(:puts).with("4 = create a new order").ordered

      app.print_interface
    end
  end
  describe "#user_selection" do
    it "makes the user re enter if input does not equal 1-4" do
      io = double :io
      database_name = 'shop_manager_test'
      item_repository = double :item_repository
      order_repository = double :order_repository

      app = Application.new(database_name, io, item_repository, order_repository)

      expect(io).to receive(:puts).with("Sorry I do not understand, please enter a number 1 to 4")
      
      app.user_selection("J")
    end
  end
end