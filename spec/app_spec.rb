require_relative '../app'


RSpec.describe Application do
	def reset_shop
		seed_sql = File.read('spec/seeds_items.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_directory_test' })
    connection.exec(seed_sql)
	end
	before(:each) do 
		reset_shop
		@database = 'shop_directory_test'
		@io = double :io
		# @items_repository = double :items_repository
		# @orders_repository = double :orders_repository
		@items_repository = ItemsRepository.new
		@orders_repository = OrdersRepository.new
		#item_1 = double(:item, :id => '1', :name => "Chocolate", :unit_price => 3, :quantity => 6)
		#item_2 = double(:item, :id => '2', :name => "Crisps", :unit_price => 2, :quantity => 10)
	
		#allow(@items_repository).to receive(:all).and_return([item_1, item_2])
	
		#order_1 = double(:order, :id => '1', :customer_name => 'John', :order_date => '2023-02-02', :item_id => '1')
		
	
	
		#allow(@orders_repository).to receive(:all).and_return([order_1])
		@app = Application.new(@database, @io, @items_repository, @orders_repository)

		expect(@io).to receive(:puts).with('Welcome to the shop management program!').ordered
		expect(@io).to receive(:puts).with('What do you want to do?').ordered
		expect(@io).to receive(:puts).with('1 = list all shop items').ordered
		expect(@io).to receive(:puts).with('2 = create a new item').ordered
		expect(@io).to receive(:puts).with('3 = list all orders').ordered
		expect(@io).to receive(:puts).with('4 = create a new order').ordered
	end

	after(:each) do 
		
		@app.run
  end

	it 'asks the user for input and returns option 1' do

		expect(@io).to receive(:gets).and_return("1")
		expect(@io).to receive(:puts).with("Here is the list of items:")
		expect(@io).to receive(:puts).with("1 - Chocolate - Unit price: 3 - Quantity: 6")
		expect(@io).to receive(:puts).with("2 - Crisps - Unit price: 2 - Quantity: 10")
	end

	it 'asks the user for input and returns option 2' do

		expect(@io).to receive(:gets).and_return("2")
		expect(@io).to receive(:puts).with("What is the name of the item").ordered
		expect(@io).to receive(:gets).and_return("Book_2")
		expect(@io).to receive(:puts).with("What is the price of the item").ordered
		expect(@io).to receive(:gets).and_return("10")
		expect(@io).to receive(:puts).with("What is the quantity of the item").ordered
		expect(@io).to receive(:gets).and_return("45")
		expect(@io).to receive(:puts).with("New Item Created").ordered


	end

	it 'asks the user for input and returns option 3' do

		expect(@io).to receive(:gets).and_return("3")
		expect(@io).to receive(:puts).with("Here is the list of orders:")
		expect(@io).to receive(:puts).with("1 - John - Order date: 2023-02-02 - Item id: 1")
	end

	it 'asks the user for input and returns option 2' do

		expect(@io).to receive(:gets).and_return("4")
		expect(@io).to receive(:puts).with("What is the name of the Customer").ordered
		expect(@io).to receive(:gets).and_return("Jake")
		expect(@io).to receive(:puts).with("What is the date of the order").ordered
		expect(@io).to receive(:gets).and_return("2023-02-01")
		expect(@io).to receive(:puts).with("What is the item id").ordered
		expect(@io).to receive(:gets).and_return("2")
		expect(@io).to receive(:puts).with("New Order Created").ordered
	end

	it "is given wrong input" do
		expect(@io).to receive(:gets).and_return("a")
		expect(@io).to receive(:puts).with('Wrong Input').ordered
	end

end