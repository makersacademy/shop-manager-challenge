require_relative '../app'

describe Application do

  before(:all) do
    @welcome_str = "Welcome to the shop management program!\n"
    @selection_str = "\nWhat do you want to do?\n" \
    "  1 = list all shop items\n" \
    "  2 = create a new item\n" \
    "  3 = list all orders\n" \
    "  4 = create a new order" \
    "  5 = end the program"
  end

  before(:each) do
    @io = double :io
    @app = Application.new(
    'shop_manager_test',
    @io,
    OrderRepository.new,
    ItemRepository.new)
    expect(@io).to receive @welcome_str
    expect(@io).to receive @selection_str
  end

  after(:each) do
    @app.run
  end
  
  it "Application is told to list all items" do
    expect(@io).to receive(:puts).with("Here is the list of all shop items\n").ordered
    expect(@io).to receive(:puts).with("#1 Super Shark Vacuum Cleaner - Unit Price: £99.99").ordered
    expect(@io).to receive(:puts).with("#2 Makerspresso Coffee Machine Unit Price: £69.50").ordered
    expect(@io).to receive(:puts).with("#1 ThomasTech Wireless Charger - Unit Price: £11.39").ordered
    expect(@io).to receive(:puts).with(@welcome_str).ordered
    expect(@io).to receive(:gets).with("5").ordered

  end
    

end
