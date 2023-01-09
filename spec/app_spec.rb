require_relative '../app'

describe Application do

  before(:all) do
    @welcome_str = "Welcome to the shop management program!\n"
    @selection_str = "\nWhat do you want to do?\n" \
    "  1 = list all shop items\n" \
    "  2 = create a new item\n" \
    "  3 = list all orders\n" \
    "  4 = create a new order\n" \
    "  5 = end the program"
  end

  before(:each) do
    @io = double :io
    @app = Application.new(
    'shop_manager_test',
    @io,
    OrderRepository.new,
    ItemRepository.new)
    expect(@io).to receive(:puts).with(@welcome_str).ordered
    expect(@io).to receive(:puts).with(@selection_str).ordered
  end

  after(:each) do
    expect(@io).to receive(:puts).with(@selection_str).ordered
    expect(@io).to receive(:gets).and_return("5").ordered
    @app.run
  end

  it "Application can list all items after formatting" do
    expect(@io).to receive(:gets).and_return("1").ordered
    expect(@io).to receive(:puts).with("Here is the list of all shop items\n").ordered
    expect(@io).to receive(:puts).with("#1 Super Shark Vacuum Cleaner - Unit Price: £99.99").ordered
    expect(@io).to receive(:puts).with("#2 Makerspresso Coffee Machine - Unit Price: £69.50").ordered
    expect(@io).to receive(:puts).with("#3 ThomasTech Wireless Charger - Unit Price: £11.39").ordered
  end

  it "Application can list all orders after formatting" do
    expect(@io).to receive(:gets).and_return("2").ordered
    expect(@io).to receive(:puts).with("Here is the list of all shop orders\n").ordered
    expect(@io).to receive(:puts).with("John ordered on 2022-06-20").ordered
    expect(@io).to receive(:puts).with("Grace ordered on 2023-01-01").ordered
    expect(@io).to receive(:puts).with("Baz ordered on 2021-07-29").ordered
  end

  it "Application can list all orders after formatting" do
    expect(@io).to receive(:gets).and_return("3").ordered
    expect(@io).to receive(:puts).with("What is the name of the item to be added?").ordered
    expect(@io).to receive(:gets).and_return("Chair").ordered
    expect(@io).to receive(:puts).with("What is the unit price of item?")
    expect(@io).to receive(:gets).and_return("5.99").ordered
    expect(@io).to receive(:puts).with("How many units of the item will be in stock?")
    expect(@io).to receive(:gets).and_return("10").ordered
    expect(@io).to receive(:puts).with("Item added!")
    expect(@io).to receive(:puts).with(@selection_str).ordered
    expect(@io).to receive(:gets).and_return("1").ordered
    expect(@io).to receive(:puts).with("Here is the list of all shop items\n").ordered
    expect(@io).to receive(:puts).with("#1 Super Shark Vacuum Cleaner - Unit Price: £99.99").ordered
    expect(@io).to receive(:puts).with("#2 Makerspresso Coffee Machine - Unit Price: £69.50").ordered
    expect(@io).to receive(:puts).with("#3 ThomasTech Wireless Charger - Unit Price: £11.39").ordered
    expect(@io).to receive(:puts).with("#4 Chair - Unit Price £5.99")
  end

end
