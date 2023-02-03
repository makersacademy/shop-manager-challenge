require_relative '../app'

describe Application do
  before(:each) do
    @database = 'items_orders_test_2'
    @io = double :io
    @item = double :item, id: 1, name: 'Apple', price: "$2.00", quantity: 10
    @item_repo = double :item_repo, all: [@item]
    @order = double :order, id: 1, customer_name: 'Ryan', placed_date: '2023-02-03', items: [['Apple',2]]
    @order_repo = double :order_repo, all: [@order]
  end

  def print_greeting
    expect(@io).to receive(:puts).with('Welcome to the shop management program!')
    expect(@io).to receive(:puts).with("\n")
    expect(@io).to receive(:puts).with('What do you want to do?')
    expect(@io).to receive(:puts).with('  1 = list all shop items')
    expect(@io).to receive(:puts).with('  2 = create a new item')
    expect(@io).to receive(:puts).with('  3 = list all orders')
    expect(@io).to receive(:puts).with('  4 = create a new order')
    expect(@io).to receive(:puts).with('  5 = exit')
  end

  context 'option 1' do
    it 'lists all shop items on the terminal' do
      print_greeting()
      expect(@io).to receive(:gets).and_return('1')
      expect(@io).to receive(:puts).with("Here's a list of all shop items:")
      expect(@io).to receive(:puts).with("\n")
      expect(@io).to receive(:puts).with(' #1 Apple - Unit price: $2.00 - Quantity: 10')
      expect(@io).to receive(:puts).with("\n")
      print_greeting()
      expect(@io).to receive(:gets).and_return('5')
      app = Application.new(@database,@io,@item_repo,@order_repo)
      app.run
    end 
  end

  context 'option 2' do
    it 'creates a new item on the terminal' do
      print_greeting()
      expect(@io).to receive(:gets).and_return('2')
      expect(@io).to receive(:puts).with('What is the new item name?') 
      expect(@io).to receive(:gets).and_return('Orange')
      expect(@io).to receive(:puts).with('How much is it?')
      expect(@io).to receive(:gets).and_return('5')
      expect(@io).to receive(:puts).with('How many in stock?')
      expect(@io).to receive(:gets).and_return('40')
      expect(@item_repo).to receive(:create)
      expect(@io).to receive(:puts).with('Successfully created!')
      expect(@io).to receive(:puts).with("\n")
      print_greeting()
      expect(@io).to receive(:gets).and_return('5')

      app = Application.new(@database,@io,@item_repo,@order_repo)
      app.run
    end
  end

  context 'option 3' do
    it 'lists all orders on the terminal' do
      print_greeting()
      expect(@io).to receive(:gets).and_return('3')
      expect(@io).to receive(:puts).with("Here's a list of all orders:")
      expect(@io).to receive(:puts).with("\n")
      expect(@io).to receive(:puts).with(' #1 Ryan - 2023-02-03 - items: Apple x 2')
      expect(@io).to receive(:puts).with("\n")
      print_greeting()
      expect(@io).to receive(:gets).and_return('5')
      app = Application.new(@database,@io,@item_repo,@order_repo)
      app.run
    end 
  end

  context 'option 4' do
    it 'creates a new order on the terminal' do
      print_greeting()
      expect(@io).to receive(:gets).and_return('4')
      expect(@io).to receive(:puts).with('What is the customer name?') 
      expect(@io).to receive(:gets).and_return('Luke')
      expect(@io).to receive(:puts).with("What item do you want to add? (Enter 'N' to end)")
      expect(@io).to receive(:gets).and_return('Peach')
      expect(@io).to receive(:puts).with('How many do you want?')
      expect(@io).to receive(:gets).and_return('5')
      expect(@io).to receive(:puts).with("What item do you want to add? (Enter 'N' to end)")
      expect(@io).to receive(:gets).and_return('Apple')
      expect(@io).to receive(:puts).with('How many do you want?')
      expect(@io).to receive(:gets).and_return('10')
      expect(@io).to receive(:puts).with("What item do you want to add? (Enter 'N' to end)")
      expect(@io).to receive(:gets).and_return('N')
      expect(@order_repo).to receive(:create)
      expect(@io).to receive(:puts).with('Successfully created!')
      expect(@io).to receive(:puts).with("\n")
      print_greeting()
      expect(@io).to receive(:gets).and_return('5')

      app = Application.new(@database,@io,@item_repo,@order_repo)
      app.run
    end
  end

  context 'option 5' do
    it 'exits' do
      print_greeting()
      expect(@io).to receive(:gets).and_return('5')

      app = Application.new(@database,@io,@item_repo,@order_repo)
      app.run
    end
  end

  context ".run" do
    it "initializes the application and calls run method" do
      expect(DatabaseConnection).to receive(:connect).with(@database)
      app = Application.new(
        @database,
        @io,
        @item_repo,
        @order_repo
      )

      expect(app).to receive(:run)
      app.run
    end
  end

  context "#initialize" do
    it "connects to the database and sets instance variables" do
      app = Application.new(
        @database,
        @io,
        @item_repo,
        @order_repo
      )

      expect(app.instance_variable_get(:@io)).to eq(@io)
      expect(app.instance_variable_get(:@item_repo)).to eq(@item_repo)
      expect(app.instance_variable_get(:@order_repo)).to eq(@order_repo)
    end
  end
end
