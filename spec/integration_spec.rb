require_relative '../app.rb'
require 'database_connection'
require 'item_repository.rb'
require 'customer_repository.rb'
require 'order_repository.rb'

def reset_all_tables
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  seed_sql = File.read('spec/seeds_all.sql')
  connection.exec(seed_sql)
end

describe Application do
  before(:each) do 
    reset_all_tables
  end
  let(:i_repo) { ItemRepository.new }
  let(:c_repo) { CustomerRepository.new }
  let(:o_repo) { OrderRepository.new }
  let(:io) { double(:io) }
  let(:app) { Application.new('shop_manager_test', io, c_repo, i_repo, o_repo)}

  context 'user selects the listing methods (1 to 4) from the menu' do
    it 'prints the list of items with their prices in the terminal' do
      expect(io).to receive(:puts).with("Item: 1, Name: Soap, Price: 10")
      expect(io).to receive(:puts).with("Item: 2, Name: Candy, Price: 2")
      expect(io).to receive(:puts).with("Item: 3, Name: Lamp, Price: 400")
      expect(io).to receive(:puts).with("Item: 4, Name: Chocolate, Price: 5")
      expect(io).to receive(:puts).with("Item: 5, Name: Coal, Price: 100")
      expect(io).to receive(:puts).with("Item: 6, Name: Shampoo, Price: 25")
      expect(io).to receive(:puts).with("Item: 7, Name: Peanut Butter, Price: 12")
      expect(io).to receive(:puts).with("Item: 8, Name: Bread, Price: 8")
      expect(io).to receive(:puts).with("Item: 9, Name: Cheese, Price: 15")
      expect(io).to receive(:puts).with("Item: 10, Name: Jam, Price: 15")
      expect(io).to receive(:puts).with("Item: 11, Name: Chicken, Price: 18")
      app.apply_selection(1)
    end

    it 'prints the list of items with their stocks in the terminal' do
      expect(io).to receive(:puts).with("Item: 1, Name: Soap, Quantity: 100")
      expect(io).to receive(:puts).with("Item: 2, Name: Candy, Quantity: 500")
      expect(io).to receive(:puts).with("Item: 3, Name: Lamp, Quantity: 20")
      expect(io).to receive(:puts).with("Item: 4, Name: Chocolate, Quantity: 300")
      expect(io).to receive(:puts).with("Item: 5, Name: Coal, Quantity: 30")
      expect(io).to receive(:puts).with("Item: 6, Name: Shampoo, Quantity: 60")
      expect(io).to receive(:puts).with("Item: 7, Name: Peanut Butter, Quantity: 120")
      expect(io).to receive(:puts).with("Item: 8, Name: Bread, Quantity: 35")
      expect(io).to receive(:puts).with("Item: 9, Name: Cheese, Quantity: 0")
      expect(io).to receive(:puts).with("Item: 10, Name: Jam, Quantity: 88")
      expect(io).to receive(:puts).with("Item: 11, Name: Chicken, Quantity: 40")
      app.apply_selection(2)
    end

    it 'prints the list of orders' do
      expect(io).to receive(:puts).with('Date: 2023-03-01, Order ID: 17, Order Item: Peanut Butter, Customer Name: Customer_4')
      expect(io).to receive(:puts).with('Date: 2023-02-22, Order ID: 18, Order Item: Soap, Customer Name: Customer_5')
      expect(io).to receive(:puts).with('Date: 2023-02-18, Order ID: 5, Order Item: Coal, Customer Name: Customer_3')
      expect(io).to receive(:puts).with('Date: 2023-02-18, Order ID: 6, Order Item: Shampoo, Customer Name: Customer_3')
      expect(io).to receive(:puts).with('Date: 2023-02-18, Order ID: 7, Order Item: Chicken, Customer Name: Customer_3')
      expect(io).to receive(:puts).with('Date: 2023-02-11, Order ID: 14, Order Item: Soap, Customer Name: Customer_4')
      expect(io).to receive(:puts).with('Date: 2023-02-11, Order ID: 15, Order Item: Peanut Butter, Customer Name: Customer_4')
      expect(io).to receive(:puts).with('Date: 2023-01-17, Order ID: 12, Order Item: Shampoo, Customer Name: Customer_2')
      expect(io).to receive(:puts).with('Date: 2023-01-17, Order ID: 13, Order Item: Peanut Butter, Customer Name: Customer_2')
      expect(io).to receive(:puts).with('Date: 2023-01-15, Order ID: 16, Order Item: Bread, Customer Name: Customer_4')
      expect(io).to receive(:puts).with('Date: 2023-01-12, Order ID: 11, Order Item: Lamp, Customer Name: Customer_1')
      expect(io).to receive(:puts).with('Date: 2023-01-08, Order ID: 1, Order Item: Soap, Customer Name: Customer_3')
      expect(io).to receive(:puts).with('Date: 2023-01-08, Order ID: 10, Order Item: Jam, Customer Name: Customer_1')
      expect(io).to receive(:puts).with('Date: 2023-01-08, Order ID: 9, Order Item: Cheese, Customer Name: Customer_1')
      expect(io).to receive(:puts).with('Date: 2023-01-08, Order ID: 8, Order Item: Chocolate, Customer Name: Customer_1')
      expect(io).to receive(:puts).with('Date: 2023-01-08, Order ID: 4, Order Item: Bread, Customer Name: Customer_3')
      expect(io).to receive(:puts).with('Date: 2023-01-08, Order ID: 3, Order Item: Coal, Customer Name: Customer_3')
      expect(io).to receive(:puts).with('Date: 2023-01-08, Order ID: 2, Order Item: Chocolate, Customer Name: Customer_3')
      app.apply_selection(3)
    end

    it 'prints the list of orders made by a specific customer' do
      expect(io).to receive(:puts).with("What is the customer name?")
      expect(io).to receive(:gets).and_return("Customer_2")
      expect(io).to receive(:puts).with("On 2023-01-17, ordered Shampoo")
      expect(io).to receive(:puts).with("On 2023-01-17, ordered Peanut Butter")
      app.apply_selection(4)
    end

    it 'returns an error message if customer does not exist' do
      expect(io).to receive(:puts).with("What is the customer name?")
      expect(io).to receive(:gets).and_return("Customer_6")
      expect(io).to receive(:puts).with("Sorry, no such customer exists.")
      app.apply_selection(4)
    end
  end

  context 'user selects adding methods (5..7)' do
    it 'adds an item to the inventory based on user input' do
      expect(io).to receive(:puts).with("What is the item name?")
      expect(io).to receive(:gets).and_return("Wheelbarrow")
      expect(io).to receive(:puts).with("What is the item price?")
      expect(io).to receive(:gets).and_return("350")
      expect(io).to receive(:puts).with("How many items do you have in stock?")
      expect(io).to receive(:gets).and_return("5")
      expect(io).to receive(:puts).with("Item added successfully, returning to main menu.")
      app.apply_selection(5)
    end

    it 'adds an order based on user input' do
      expect(io).to receive(:puts).with("What is the customer name?")
      expect(io).to receive(:gets).and_return("Customer_6")
      expect(io).to receive(:puts).with("Looks like this customer has not shopped here before. Creating a new customer with the name.")
      expect(io).to receive(:puts).with("What would you like to order?")
      expect(io).to receive(:gets).and_return("Toffee")
      expect(io).to receive(:puts).with("That item has either run out or does not exist. Please try again.")
      expect(io).to receive(:gets).and_return("Chicken")
      expect(io).to receive(:puts).with("Order added successfully, returning to main menu.")
      app.apply_selection(6)
    end

    it 'exits' do
      app.apply_selection(9)
    end
  end
end
