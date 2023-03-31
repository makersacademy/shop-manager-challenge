require_relative '../app.rb'

describe Application do
  let(:i_repo) { double(:item_repository)}
  let(:c_repo) { double(:customer_repository)}
  let(:o_repo) { double(:order_repository)}
  let(:io) { double(:io) }
  let(:app) { Application.new('shop_manager_test', io, c_repo, i_repo, o_repo)}

  ### These are unit tests for the app itself and utilize mock whenever possible.
  ### Main methods such as run and apply selection are tested in the integration specs.

  context 'when checked for UI messages' do
    ### This section checks the UI messages ###
    it 'displays a choice menu to user and returns their result' do
      expect(io).to receive(:puts).with("")
      expect(io).to receive(:puts).with("What would you like to do? Choose one from below")
      expect(io).to receive(:puts).with("1 to list all items with their prices.")
      expect(io).to receive(:puts).with("2 to list all items with their stock quantities")
      expect(io).to receive(:puts).with("3 to list all orders made to this day")
      expect(io).to receive(:puts).with("4 to list all orders made by a specific customer")
      expect(io).to receive(:puts).with("5 to create a new item")
      expect(io).to receive(:puts).with("6 to create a new order")
      expect(io).to receive(:puts).with("9 to exit program")
      expect(io).to receive(:gets).and_return("1")
      app.ask_for_choice
    end

    it 'prints the array of string passed in' do
      array = ["Item: 1, Name: Soap, Price: 10", "Item: 2, Name: Candy, Price: 2"]
      expect(io).to receive(:puts).with("Item: 1, Name: Soap, Price: 10")
      expect(io).to receive(:puts).with("Item: 2, Name: Candy, Price: 2")
      app.print_neat(array)
    end

    it 'shows the message' do
      expect(io).to receive(:puts).with("Hi")
      app.show("Hi")
    end

    it 'asks for a prompt, returns the user input' do
      expect(io).to receive(:puts).with("What is your name?")
      expect(io).to receive(:gets).and_return("Test")
      expect(app.prompt("What is your name?")).to eq "Test"
    end
  end

  context 'when asked to validate the input' do
    ### This section checks the validators ###
    it "returns the integer if user put in a number" do
      expect(app.integer_validator("3")).to eq 3
    end

    it "returns en error message if input isnt an integer" do
      expect(io).to receive(:puts).with("Please enter an integer number:")
      expect(io).to receive(:gets).and_return("3")
      app.integer_validator("Table")
    end

    it 'returns the integer if it is within allowable choices' do
      expect(app.user_input_validated("3")).to eq 3
    end

    it 'returns false if the input is not an integer' do
      expect(app.user_input_validated("three")).to eq false
    end

    it 'returns false if the input is out of choice range' do
      expect(app.user_input_validated("14")).to eq false
    end

    it 'returns a hash of information to pass into database if validated' do
      expect(i_repo).to receive(:retrieve_item_id_by_name).with("Table").and_return(false)
      expect(io).to receive(:puts).with("What is the item name?")
      expect(io).to receive(:gets).and_return("Table")
      expect(io).to receive(:puts).with("What is the item price?")
      expect(io).to receive(:gets).and_return("4")
      expect(io).to receive(:puts).with("How many items do you have in stock?")
      expect(io).to receive(:gets).and_return("100")
      parameters = {name: "Table", unit_price: 4, quantity: 100}
      expect(app.ask_for_item_parameters_to_insert).to eq parameters
    end

    it 'returns a hash of information to pass into database if validated' do
      expect(i_repo).to receive(:retrieve_item_id_by_name).with("Table").and_return(true)
      expect(i_repo).to receive(:retrieve_item_id_by_name).with("Chair").and_return(false)
      expect(io).to receive(:puts).with("What is the item name?")
      expect(io).to receive(:gets).and_return("Table")
      expect(io).to receive(:puts).with("Item with the same name already exists!")
      expect(io).to receive(:puts).with("What is the item name?")
      expect(io).to receive(:gets).and_return("Chair")
      expect(io).to receive(:puts).with("What is the item price?")
      expect(io).to receive(:gets).and_return("4")
      expect(io).to receive(:puts).with("How many items do you have in stock?")
      expect(io).to receive(:gets).and_return("100")
      parameters = {name: "Chair", unit_price: 4, quantity: 100}
      expect(app.ask_for_item_parameters_to_insert).to eq parameters
    end

    it 'returns the item id when passed in the item name' do
      expect(io).to receive(:puts).with("What would you like to order?")
      expect(i_repo).to receive(:retrieve_item_id_by_name).with("Table").and_return(3)
      expect(io).to receive(:gets).and_return("Table")
      expect(app.ask_for_item_information).to eq 3
    end

    it 'returns an error if item does not exist in database' do
      expect(i_repo).to receive(:retrieve_item_id_by_name).with("Table").and_return(false)
      expect(i_repo).to receive(:retrieve_item_id_by_name).with("Soap").and_return(1)
      expect(io).to receive(:puts).with("What would you like to order?")
      expect(io).to receive(:gets).and_return("Table")
      expect(io).to receive(:puts).with("That item has either run out or does not exist. Please try again.")
      expect(io).to receive(:gets).and_return("Soap")
      expect(app.ask_for_item_information).to eq 1
    end

    it 'returns a hash of values if customer exists in database' do 
      expect(c_repo).to receive(:retrieve_customer_by_name).with("Customer_X").and_return(false)
      expect(io).to receive(:puts).with("What is the customer name?")
      expect(io).to receive(:gets).and_return("Customer_X")
      parameters = {name: "Customer_X", id: false, exists: false}
      expect(app.verify_customer_exists).to eq parameters
    end

    it 'returns false for the hash key exists if customer does not exist in db' do
      expect(c_repo).to receive(:retrieve_customer_by_name).with("Customer_1").and_return(1)
      expect(io).to receive(:puts).with("What is the customer name?")
      expect(io).to receive(:gets).and_return("Customer_1")
      parameters = {name: "Customer_1", id: 1, exists: true}
      expect(app.verify_customer_exists).to eq parameters
    end
  end
end
