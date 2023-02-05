require_relative '../app'


def reset_shop
  seed_sql = File.read('spec/seeds_shop_manager.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

describe Application do 
  before(:each) do 
    reset_shop
    @io = double :io 
    # @order_repository = double :order_repository
    # @item_repository = double :item_repository
    
    @item_repository = ItemRepository.new
    @order_repository = OrderRepository.new
  
    @database_name = 'shop_manager_test'

    # item_1 = double(:item, :id => '1', :name => 'pencil', :price => '1', :quantity => '10')
    # item_2 = double(:item, :id => '2', :name => 'socks', :price => '3', :quantity => '20')

    # allow(@item_repository).to receive(:all).and_return([item_1, item_2])

    # order_1 = double(:order, :id => '1', :customer_name => "Angela", :order_date => "2022-11-22", :item_id => 1)
    # order_2 = double(:order, :id => '2', :customer_name => "Mike", :order_date => "2022-09-10", :item_id => 2)

    # allow(@order_repository).to receive(:all).and_return([order_1, order_2])

    @app = Application.new(@database_name, @io, @item_repository, @order_repository)

    expect(@io).to receive(:puts).with("Welcome to the shop management program!").ordered
    expect(@io).to receive(:puts).with("What do you want to do?").ordered
    expect(@io).to receive(:puts).with("1 = list all shop items").ordered
    expect(@io).to receive(:puts).with("2 = create a new item").ordered
    expect(@io).to receive(:puts).with("3 = list all orders").ordered
    expect(@io).to receive(:puts).with("4 = create a new order").ordered
  end 

  after(:each) do 
    @app.run

    
  end

  # it 'prints the menu of options' do 
    
    
  # end 

  it 'gets selection input #1 from the user and prints a list of shop items' do
    expect(@io).to receive(:gets).and_return("1").ordered
    expect(@io).to receive(:puts).with("Here's a list of shop items:").ordered
    expect(@io).to receive(:puts).with("1 - Notebook - Unit Price: £1 - Quantity: 10")
    expect(@io).to receive(:puts).with("2 - Shirt - Unit Price: £5 - Quantity: 6")
    expect(@io).to receive(:puts).with("3 - Trousers - Unit Price: £10 - Quantity: 15")
    expect(@io).to receive(:puts).with("4 - Boots - Unit Price: £20 - Quantity: 5")

  end 

  it 'gets selection input #3 from the user and prints a list of shop orders' do
    expect(@io).to receive(:gets).and_return("3").ordered
    expect(@io).to receive(:puts).with("Here's a list of shop orders:").ordered
    expect(@io).to receive(:puts).with("1 - Customer Name: Janet - Order date: 2023-01-02 - Item ID: 1").ordered
    expect(@io).to receive(:puts).with("2 - Customer Name: Aaron - Order date: 2022-12-12 - Item ID: 3").ordered
    expect(@io).to receive(:puts).with("3 - Customer Name: Emily - Order date: 2022-10-23 - Item ID: 2").ordered
    expect(@io).to receive(:puts).with("4 - Customer Name: Camille - Order date: 2023-01-24 - Item ID: 4").ordered

  end 

  it 'gets selection input #2 and creates a new item' do 
    expect(@io).to receive(:gets).and_return("2").ordered
    expect(@io).to receive(:puts).with("Enter the name of the item: ")
    expect(@io).to receive(:gets).and_return("Blanket")
    expect(@io).to receive(:puts).with("Enter the unit price: ")
    expect(@io).to receive(:gets).and_return("15")
    expect(@io).to receive(:puts).with("Enter the quantity: ")
    expect(@io).to receive(:gets).and_return("12")
    expect(@io).to receive(:puts).with("New Item Created.")
  end

  it 'gets selection input #4 and creates a new order' do 
    expect(@io).to receive(:gets).and_return("4").ordered
    expect(@io).to receive(:puts).with("Enter the customer name: ").ordered
    expect(@io).to receive(:gets).and_return("Oscar").ordered
    expect(@io).to receive(:puts).with("Enter the order date in format YYYY-MM-DD: ").ordered
    expect(@io).to receive(:gets).and_return("2023-01-01").ordered
    expect(@io).to receive(:puts).with("Enter the item ID: ").ordered
    expect(@io).to receive(:gets).and_return("1").ordered
    expect(@io).to receive(:puts).with("New Order Created.").ordered
  end


end 