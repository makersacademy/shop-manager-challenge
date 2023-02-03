require_relative '../app'

def reset_shop
  seed_sql = File.read('spec/seeds_shop.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

RSpec.describe Application do

  before(:each) do
    reset_shop
    @io = double :io
    itemRepository = ItemRepository.new
    orderRepository = OrderRepository.new
    @app = Application.new('shop_manager_test',@io,itemRepository,orderRepository)

    expect(@io).to receive(:puts).with("Welcome to the shop management program!").ordered
    expect(@io).to receive(:puts).with("").ordered
    expect(@io).to receive(:puts).with("What do you want to do?").ordered
    expect(@io).to receive(:puts).with("  1 - list all shop items").ordered
    expect(@io).to receive(:puts).with("  2 - create a new item").ordered
    expect(@io).to receive(:puts).with("  3 - list all orders").ordered
    expect(@io).to receive(:puts).with("  4 - create a new order").ordered
    expect(@io).to receive(:puts).with("").ordered

  end
  
  context "Positive cases" do

    after(:each) do
      @app.run
    end

    it 'displays a list of all items for option 1' do

      expect(@io).to receive(:gets).and_return("1").ordered
      expect(@io).to receive(:puts).with("Here's a list of all shop items:").ordered
      expect(@io).to receive(:puts).with(" #1 Super Shark Vacuum Cleaner - Unit price: 99 - Quantity: 30").ordered
      expect(@io).to receive(:puts).with(" #2 Makerspresso Coffee Machine - Unit price: 69 - Quantity: 15").ordered
      
    end

    it 'displays a list of all orders for option 3' do

      expect(@io).to receive(:gets).and_return("3").ordered
      expect(@io).to receive(:puts).with("Here's a list of all shop orders:").ordered
      expect(@io).to receive(:puts).with(" #1 Dave - Ordered: Super Shark Vacuum Cleaner - On: 2023-02-03").ordered
      expect(@io).to receive(:puts).with(" #2 John - Ordered: Makerspresso Coffee Machine - On: 2023-02-03").ordered

    end

    it "allows you to create a new item" do
      expect(@io).to receive(:gets).and_return("2").ordered
      expect(@io).to receive(:puts).with("Please enter the new item name:").ordered
      expect(@io).to receive(:gets).and_return("Duck").ordered
      expect(@io).to receive(:puts).with("Please enter the unit price to the nearest pound:").ordered
      expect(@io).to receive(:gets).and_return("20").ordered
      expect(@io).to receive(:puts).with("Please enter stocked quantity:").ordered
      expect(@io).to receive(:gets).and_return("200").ordered
      expect(@io).to receive(:puts).with("#3 Duck added to system with a quantity of 200 and a price of £20")

    end

    it "allows you to create a new order" do
      expect(@io).to receive(:gets).and_return("4").ordered
      expect(@io).to receive(:puts).with("Please enter the customer name:").ordered
      expect(@io).to receive(:gets).and_return("Bob").ordered
      expect(@io).to receive(:puts).with("Please enter the date in format YYYY-MM-DD:").ordered
      expect(@io).to receive(:gets).and_return("2023-01-01").ordered
      expect(@io).to receive(:puts).with("Please enter the item id:").ordered
      expect(@io).to receive(:gets).and_return("1").ordered
      expect(@io).to receive(:puts).with("#3 Super Shark Vacuum Cleaner ordered for Bob on 2023-01-01").ordered
      
    end
  end

  context "negative case" do

  it "fails if you choose enter an invalid option" do
  
    expect(@io).to receive(:gets).and_return("8")
    expect{@app.run}.to raise_error "Must choose one of the available options"
    
    end
  end
end
