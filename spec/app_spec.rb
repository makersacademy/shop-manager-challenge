require_relative "../app"

def reset_items_items_table
  seed_sql = File.read('spec/seeds_items_orders.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end
RSpec.describe Application do 
  before(:each) do 
    reset_items_items_table
  end
  it "returns all items when input chooses 1 for items" do
    fake_items_repo = double(:fake_items_repo)
    fake_orders_repo = double(:fake_orders_repo)
    kernel = double(:kernel)
    item = double :item
    expect(kernel).to receive(:print).with("Welcome to the shop management program!\n")
    expect(kernel).to receive(:print).with("What do you want to do?\n1: list all shop items\n2: list all item options\n3: list all orders\n4: list all order options\n")
    expect(kernel).to receive(:gets).and_return("1\n")
    expect(kernel).to receive(:print).with("_________________________________________\n")   
    expect(kernel).to receive(:print).with("| item ID | item NAME | Price | Quantity |\n") 
     expect(kernel).to receive(:print).with("_________________________________________\n") 
    expect(fake_items_repo).to receive(:all).and_return(item)
    expect(item).to receive(:each).and_return("| 1       | GOLD WATCH   £3350   5      ")
    app = Application.new('shop_manager_test',kernel, fake_orders_repo, fake_items_repo )
    app.run
  end
    it "returns all orders when input chooses 3 for orders" do
    fake_items_repo = double(:fake_items_repo)
    fake_orders_repo = double(:fake_orders_repo)
    kernel = double(:kernel)
    order = double :order
    expect(kernel).to receive(:print).with("Welcome to the shop management program!\n")
    expect(kernel).to receive(:print).with("What do you want to do?\n1: list all shop items\n2: list all item options\n3: list all orders\n4: list all order options\n")
    expect(kernel).to receive(:gets).and_return("3\n")
    expect(kernel).to receive(:print).with("__________________________________________________\n")   
    expect(kernel).to receive(:print).with("| order ID | Customer NAME | Order date | Item ID |\n") 
     expect(kernel).to receive(:print).with("__________________________________________________\n") 
    expect(fake_orders_repo).to receive(:all).and_return(order)
    expect(order).to receive(:each).and_return("| order ID | Customer NAME | Order date | Item ID |\n")
    app = Application.new('shop_manager_test',kernel, fake_orders_repo, fake_items_repo )
    app.run
  end
  xit "lists all order options" do # seems to loop round when @io enters second case statement 
    fake_items_repo = double(:fake_items_repo)
    fake_orders_repo = double(:fake_orders_repo)
    kernel = double(:kernel)
    order = double :order
    expect(kernel).to receive(:print).with("Welcome to the shop management program!\n").ordered
    expect(kernel).to receive(:print).with("What do you want to do?\n1: list all shop items\n2: list all item options\n3: list all orders\n4: list all order options\n").ordered
    expect(kernel).to receive(:gets).and_return("4\n").ordered
    app = Application.new('shop_manager_test',kernel, fake_orders_repo, fake_items_repo )
    app.run
    

    expect(kernel).to receive(:print).with("1: FIND by ID\n2: CREATE new order\n3: UPDATE order\n4: DELETE order\n").ordered   
    expect(kernel).to receive(:gets).and_return("1\n").ordered
    expect(kernel).to receive(:print).with("What order id would you like to search for? :").ordered
    expect(kernel).to receive(:gets).and_return(1).ordered
    expect(fake_orders_repo).to receive(:find).and_return(order).ordered
    expect(kernel).to receive(:puts).with("__________________________________________________\n").ordered
    expect(kernel).to receive(:puts).with("| order ID | Customer NAME | Order date | Item ID |\n").ordered
    expect(kernel).to receive(:puts).with("|  1         Anna            4 May 2022   2       |\n").ordered
    expect(kernel).to receive(:puts).with("__________________________________________________\n").ordered
  end
end 