require_relative "../app"
require "date"

describe Application do
  def reset_tables
    seeds_sql = File.read("seeds/seeds_items_orders.sql")
    connection = PG.connect({ host: "127.0.0.1", dbname: "shop_manager_test" })
    connection.exec(seeds_sql)
  end

  def expected_starter(io)
    expect(io).to receive(:puts).with("Welcome to the shop management program!")
  end

  def expected_menu(io)
    options = ["list all shop items", "create a new item", "update an item's price", "update stock of an item", "list all orders", "create a new order"]
    expect(io).to receive(:puts).with("")
    expect(io).to receive(:puts).with("What do you want to do?")
    options.each_with_index do |option, index|
      expect(io).to receive(:puts).with(" #{index + 1} = #{option}")
    end
    expect(io).to receive(:puts).with("")
    expect(io).to receive(:puts).with("Enter your option:")
  end

  def expected_quit(io)
    expect(io).to receive(:puts).with("")
    expect(io).to receive(:puts).with("Do you want to continue the programme? (y/n)")
    expect(io).to receive(:gets).and_return("!q4928==")
    expect(@io).to receive(:puts).with("Invalid input. Please enter again:")
    expect(io).to receive(:gets).and_return("n")
  end

  before(:each) do
    reset_tables
    @io = double :io
    @order_repo = double :order_repo
    @item_repo = double :item_repo
    @app = Application.new("shop_manager_test", @io, @order_repo, @item_repo)
  end

  context "#list_items" do
    it "prints out items correctly and handles invalid input" do
      item1 = double :item, id: 1, name: "Garlic Pasta Sauce", unit_price: 1.5, quantity: 25
      item2 = double :item, id: 2, name: "Shower Gel", unit_price: 2, quantity: 50
      expected_starter(@io)
      expected_menu(@io)
      expect(@io).to receive(:gets).and_return("1$!/23rwq")
      expect(@io).to receive(:puts).with("Invalid input. Please enter again:")
      expect(@io).to receive(:gets).and_return("1")
      expect(@io).to receive(:puts).with("")
      expect(@io).to receive(:puts).with("Here's a list of all shop items:")
      expect(@io).to receive(:puts).with("")
      expect(@item_repo).to receive(:all).and_return([item1, item2])
      expect(@io).to receive(:puts).with(" 1. Garlic Pasta Sauce - Unit price: 1.5 - Quantity: 25")
      expect(@io).to receive(:puts).with(" 2. Shower Gel - Unit price: 2 - Quantity: 50")
      expected_quit(@io)
      @app.run
    end
  end
  context "#list_orders" do
    it "prints out orders correctly" do
      today = DateTime.now.strftime("%Y-%m-%d")
      items = [{ name: "tomato paste", price: 5, quantity: 10 }, { name: "curry powder", price: 2, quantity: 5 }]
      order = double :order, id: 1, date: today, customer_name: "terry", items: items
      expected_starter(@io)
      expected_menu(@io)
      expect(@io).to receive(:gets).and_return("5")
      expect(@order_repo).to receive(:all).and_return([order])
      expect(order).to receive(:total_price).and_return(60)
      expect(@io).to receive(:puts).with("")
      expect(@io).to receive(:puts).with("Here's a list of all orders:")
      expect(@io).to receive(:puts).with("")
      expect(@io).to receive(:puts).with("1. #{today} Terry's Order:")
      expect(@io).to receive(:puts).with("  ----------")
      expect(@io).to receive(:puts).with("  Items:")
      expect(@io).to receive(:puts).with("    - Tomato paste - Qty: 10")
      expect(@io).to receive(:puts).with("    - Curry powder - Qty: 5")
      expect(@io).to receive(:puts).with("  ----------")
      expect(@io).to receive(:puts).with("  Grand total: $60")
      expect(@io).to receive(:puts).with("  ----------")
      expect(@io).to receive(:puts).with("")
      expected_quit(@io)
      @app.run
    end
  end

  context "#create_item" do
    it "creates a new item and handles invalid inputs" do
      expected_starter(@io)
      expected_menu(@io)
      expect(@io).to receive(:gets).and_return("2")
      expect(@io).to receive(:puts).with("")
      expect(@io).to receive(:puts).with("Create a new item")
      expect(@io).to receive(:puts).with("----------")
      expect(@io).to receive(:puts).with("Please enter the following details:")
      expect(@io).to receive(:puts).with("")
      expect(@io).to receive(:puts).with("1. Name for this new item:")
      expect(@io).to receive(:gets).and_return("4127!*@$& /!**()@$")
      expect(@io).to receive(:puts).with("Invalid input. Please enter again.")
      expect(@io).to receive(:gets).and_return("tomato paste")
      expect(@io).to receive(:puts).with("")
      expect(@io).to receive(:puts).with("2. Unit price:")
      expect(@io).to receive(:gets).and_return("rwqj*$(@)!")
      expect(@io).to receive(:puts).with("Invalid input. Please enter again.")
      expect(@io).to receive(:gets).and_return("2")
      expect(@io).to receive(:puts).with("")
      expect(@io).to receive(:puts).with("3. How many item in stock?")
      expect(@io).to receive(:gets).and_return("rwqj*$(@)!")
      expect(@io).to receive(:puts).with("Invalid input. Please enter again.")
      expect(@io).to receive(:gets).and_return("50")
      expect(@io).to receive(:puts).with("")
      expect(@io).to receive(:puts).with("----------")
      expect(@item_repo).to receive(:create_item).with("tomato paste", 2, 50)
      expect(@io).to receive(:puts).with("Item has been successfully created!")
      expected_quit(@io)
      @app.run
    end
  end

  context "#update_price" do
    it "updates price of an item and handles invalid inputs" do
      expected_starter(@io)
      expected_menu(@io)
      expect(@io).to receive(:gets).and_return("3")
      expect(@io).to receive(:puts).with("")
      expect(@io).to receive(:puts).with("Update an item's price")
      expect(@io).to receive(:puts).with("----------")
      expect(@io).to receive(:puts).with("Please enter the following details:")
      expect(@io).to receive(:puts).with("")
      expect(@io).to receive(:puts).with("1. Item's ID:")
      expect(@io).to receive(:gets).and_return("rwqj*$(@)!")
      expect(@io).to receive(:puts).with("Invalid input. Please enter again.")
      expect(@io).to receive(:gets).and_return("1")
      expect(@io).to receive(:puts).with("")
      expect(@io).to receive(:puts).with("2. Updated price of this item:")
      expect(@io).to receive(:gets).and_return("rwqj*$(@)!")
      expect(@io).to receive(:puts).with("Invalid input. Please enter again.")
      expect(@io).to receive(:gets).and_return("20")
      expect(@io).to receive(:puts).with("")
      expect(@io).to receive(:puts).with("----------")
      expect(@io).to receive(:puts).with("")
      expect(@item_repo).to receive(:update_price).with(1, 20)
      expect(@io).to receive(:puts).with("Item has been successfully updated!")
      expected_quit(@io)
      @app.run
    end

    it "displays error message while entering an invalid ID" do
      expected_starter(@io)
      expected_menu(@io)
      expect(@io).to receive(:gets).and_return("3")
      expect(@io).to receive(:puts).with("")
      expect(@io).to receive(:puts).with("Update an item's price")
      expect(@io).to receive(:puts).with("----------")
      expect(@io).to receive(:puts).with("Please enter the following details:")
      expect(@io).to receive(:puts).with("")
      expect(@io).to receive(:puts).with("1. Item's ID:")
      expect(@io).to receive(:gets).and_return("20")
      expect(@io).to receive(:puts).with("")
      expect(@io).to receive(:puts).with("2. Updated price of this item:")
      expect(@io).to receive(:gets).and_return("20")
      expect(@io).to receive(:puts).with("")
      expect(@io).to receive(:puts).with("----------")
      expect(@io).to receive(:puts).with("")
      expect(@item_repo).to receive(:update_price).with(20, 20).and_raise("Invalid id. No data is updated.")
      expect(@io).to receive(:puts).with("Invalid id. No data is updated.")
      expected_quit(@io)
      @app.run
    end
  end

  context "#update_stock" do
    it "adds stock of an item and handles invalid inputs" do
      expected_starter(@io)
      expected_menu(@io)
      expect(@io).to receive(:gets).and_return("4")
      expect(@io).to receive(:puts).with("")
      expect(@io).to receive(:puts).with("Update an item's stock")
      expect(@io).to receive(:puts).with("----------")
      expect(@io).to receive(:puts).with("Please enter the following details:")
      expect(@io).to receive(:puts).with("")
      expect(@io).to receive(:puts).with("1. Do you want to add or remove? (+/-)")
      expect(@io).to receive(:gets).and_return("qwrhio!@#&*(")
      expect(@io).to receive(:puts).with("Invalid input. Please enter again.")
      expect(@io).to receive(:gets).and_return("+")
      expect(@io).to receive(:puts).with("")
      expect(@io).to receive(:puts).with("2. Item's ID:")
      expect(@io).to receive(:gets).and_return("qwrhio!@#&*(")
      expect(@io).to receive(:puts).with("Invalid input. Please enter again.")
      expect(@io).to receive(:gets).and_return("1")
      expect(@io).to receive(:puts).with("")
      expect(@io).to receive(:puts).with("3. How many do you want to add?")
      expect(@io).to receive(:gets).and_return("qwrhio!@#&*(")
      expect(@io).to receive(:puts).with("Invalid input. Please enter again.")
      expect(@io).to receive(:gets).and_return("20")
      expect(@io).to receive(:puts).with("")
      expect(@io).to receive(:puts).with("----------")
      expect(@io).to receive(:puts).with("")
      expect(@item_repo).to receive(:update_stock).with(1, 20, "+")
      expect(@io).to receive(:puts).with("Item has been successfully updated!")
      expected_quit(@io)
      @app.run
    end

    it "removes stock of an item" do
      expected_starter(@io)
      expected_menu(@io)
      expect(@io).to receive(:gets).and_return("4")
      expect(@io).to receive(:puts).with("")
      expect(@io).to receive(:puts).with("Update an item's stock")
      expect(@io).to receive(:puts).with("----------")
      expect(@io).to receive(:puts).with("Please enter the following details:")
      expect(@io).to receive(:puts).with("")
      expect(@io).to receive(:puts).with("1. Do you want to add or remove? (+/-)")
      expect(@io).to receive(:gets).and_return("-")
      expect(@io).to receive(:puts).with("")
      expect(@io).to receive(:puts).with("2. Item's ID:")
      expect(@io).to receive(:gets).and_return("1")
      expect(@io).to receive(:puts).with("")
      expect(@io).to receive(:puts).with("3. How many do you want to add?")
      expect(@io).to receive(:gets).and_return("20")
      expect(@io).to receive(:puts).with("")
      expect(@io).to receive(:puts).with("----------")
      expect(@io).to receive(:puts).with("")
      expect(@item_repo).to receive(:update_stock).with(1, 20, "-")
      expect(@io).to receive(:puts).with("Item has been successfully updated!")
      expected_quit(@io)
      @app.run
    end

    it "displays error message while entering an invalid ID" do
      expected_starter(@io)
      expected_menu(@io)
      expect(@io).to receive(:gets).and_return("4")
      expect(@io).to receive(:puts).with("")
      expect(@io).to receive(:puts).with("Update an item's stock")
      expect(@io).to receive(:puts).with("----------")
      expect(@io).to receive(:puts).with("Please enter the following details:")
      expect(@io).to receive(:puts).with("")
      expect(@io).to receive(:puts).with("1. Do you want to add or remove? (+/-)")
      expect(@io).to receive(:gets).and_return("+")
      expect(@io).to receive(:puts).with("")
      expect(@io).to receive(:puts).with("2. Item's ID:")
      expect(@io).to receive(:gets).and_return("20")
      expect(@io).to receive(:puts).with("")
      expect(@io).to receive(:puts).with("3. How many do you want to add?")
      expect(@io).to receive(:gets).and_return("20")
      expect(@io).to receive(:puts).with("")
      expect(@io).to receive(:puts).with("----------")
      expect(@io).to receive(:puts).with("")
      expect(@item_repo).to receive(:update_stock).with(20, 20, "+").and_raise("Invalid id. No data is updated.")
      expect(@io).to receive(:puts).with("Invalid id. No data is updated.")
      expected_quit(@io)
      @app.run
    end
  end

  context "#create_order" do
    it "creates an order and handle invalid inputs" do
      expected_starter(@io)
      expected_menu(@io)
      expect(@io).to receive(:gets).and_return("6")
      expect(@io).to receive(:puts).with("")
      expect(@io).to receive(:puts).with("Create a new order")
      expect(@io).to receive(:puts).with("----------")
      expect(@io).to receive(:puts).with("Please enter the following details:")
      expect(@io).to receive(:puts).with("")
      expect(@io).to receive(:puts).with("1. What is the customer's name?")
      expect(@io).to receive(:gets).and_return("micheal")
      expect(@io).to receive(:puts).with("")
      expect(@io).to receive(:puts).with("----------")
      expect(@io).to receive(:puts).with("There is 0 item(s) in Micheal's order.")
      expect(@io).to receive(:puts).with("----------")
      expect(@io).to receive(:puts).with("Please enter item ID.")
      expect(@io).to receive(:gets).and_return("1")
      expect(@io).to receive(:puts).with("")
      expect(@io).to receive(:puts).with("Please enter quantity.")
      expect(@io).to receive(:gets).and_return("20")
      expect(@item_repo).to receive(:enough_stock?).with(1, 20).and_return(true)
      expect(@io).to receive(:puts).with("")
      expect(@io).to receive(:puts).with("Continue to add items? (y/n)")
      expect(@io).to receive(:gets).and_return("y")
      expect(@io).to receive(:puts).with("")
      expect(@io).to receive(:puts).with("----------")
      expect(@io).to receive(:puts).with("There is 1 item(s) in Micheal's order.")
      expect(@io).to receive(:puts).with("----------")
      expect(@io).to receive(:puts).with("Please enter item ID.")
      expect(@io).to receive(:gets).and_return("5")
      expect(@io).to receive(:puts).with("")
      expect(@io).to receive(:puts).with("Please enter quantity.")
      expect(@io).to receive(:gets).and_return("21")
      expect(@item_repo).to receive(:enough_stock?).with(5, 21).and_return(false)
      expect(@io).to receive(:puts).with("Sorry, there is no enough stock for this item.")
      expect(@io).to receive(:puts).with("")
      expect(@io).to receive(:puts).with("Continue to add items? (y/n)")
      expect(@io).to receive(:gets).and_return("y")
      expect(@io).to receive(:puts).with("")
      expect(@io).to receive(:puts).with("----------")
      expect(@io).to receive(:puts).with("There is 1 item(s) in Micheal's order.")
      expect(@io).to receive(:puts).with("----------")
      expect(@io).to receive(:puts).with("Please enter item ID.")
      expect(@io).to receive(:gets).and_return("20")
      expect(@io).to receive(:puts).with("")
      expect(@io).to receive(:puts).with("Please enter quantity.")
      expect(@io).to receive(:gets).and_return("20")
      expect(@item_repo).to receive(:enough_stock?).with(20, 20).and_raise("Invalid id. No data is updated.")
      expect(@io).to receive(:puts).with("Invalid id. No data is updated.")
      expect(@io).to receive(:puts).with("")
      expect(@io).to receive(:puts).with("Continue to add items? (y/n)")
      expect(@io).to receive(:gets).and_return("1h23io")
      expect(@io).to receive(:puts).with("Invalid input. Please enter again:")
      expect(@io).to receive(:gets).and_return("n")
      expect(@order_repo).to receive(:create_order).with("Micheal", [{ item_id: 1, quantity: 20 }], @item_repo)
      expect(@io).to receive(:puts).with("")
      expect(@io).to receive(:puts).with("----------")
      expect(@io).to receive(:puts).with("There is total 1 item(s) in Micheal's order.")
      expect(@io).to receive(:puts).with("Order has been successfully created!")
      expected_quit(@io)
      @app.run
    end
  end
end
