require_relative '../app'

describe Application do

  before(:all) do
    @welcome_str = "Welcome to the shop management program!\n\n"
    @selection_str = "What do you want to do?\n" \
    "  1 = list all shop items\n" \
    "  2 = create a new item\n" \
    "  3 = list all orders\n" \
    "  4 = create a new order"
  end

  before(:each) do
    @io = double :io
    @app = Application.new(
    'shop_manager',
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
  end
    

end
