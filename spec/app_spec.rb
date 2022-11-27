require_relative '../app'

RSpec.describe Application do
  def load_app
    @io = double :io
    @app = Application.new(
      'shop_manager_test',
      @io,
      ItemRepository.new,
      OrderRepository.new
    )
  end
  def reset_items_table
    seed_sql = File.read('spec/seeds_shop_manager.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end

  describe Application do
    before(:each) do 
      load_app
      reset_items_table
    end 
 
    it 'puts interactive menu' do
      interactive_menu
      expect(@io).to receive(:gets).and_return("\n")
      @app.run
    end


    it 'puts all items when 1 input' do
      interactive_menu
      expect(@io).to receive(:gets).and_return("1")
      expect(@io).to receive(:puts).with("Here's a list of all shop items:")
      expect(@io).to receive(:puts).with("#1 item 1 - Unit price: £1.11 - Quantity: 1")
      expect(@io).to receive(:puts).with("#2 item 2 - Unit price: £22.22 - Quantity: 22")
      expect(@io).to receive(:puts).with("#3 item 3 - Unit price: £333.33 - Quantity: 333")
      expect(@io).to receive(:puts).with("#4 item 4 - Unit price: £4,444.44 - Quantity: 4444")
      @app.run
    end

    it 'Puts all order when 3 input' do
      interactive_menu
      expect(@io).to receive(:gets).and_return("3")
      expect(@io).to receive(:puts).with("Here's a list of all shop orders:")
      expect(@io).to receive(:puts).with("#1 customer 1 Order Date: 2022-01-25 Item: item 1")
      expect(@io).to receive(:puts).with("#2 customer 2 Order Date: 2022-12-01 Item: item 2")
      expect(@io).to receive(:puts).with("#3 customer 3 Order Date: 2021-01-03 Item: item 2")
      expect(@io).to receive(:puts).with("#4 customer 4 Order Date: 2022-03-19 Item: item 3")
      expect(@io).to receive(:puts).with("#5 customer 5 Order Date: 2022-02-01 Item: item 1")
      expect(@io).to receive(:puts).with("#6 customer 6 Order Date: 2021-04-03 Item: item 3")
      expect(@io).to receive(:puts).with("#7 customer 7 Order Date: 2022-05-30 Item: item 1")
      expect(@io).to receive(:puts).with("#8 customer 8 Order Date: 2022-11-25 Item: item 4")
      @app.run
    end

    it 'Inserts new item when 3 input' do
      interactive_menu
      expect(@io).to receive(:gets).and_return("2").ordered
      expect(@io).to receive(:puts).with("Enter Item name:").ordered
      expect(@io).to receive(:gets).and_return("item 5").ordered
      expect(@io).to receive(:puts).with("Enter Unit Price:").ordered
      expect(@io).to receive(:gets).and_return("55555.55").ordered
      expect(@io).to receive(:puts).with("Enter Quantity:").ordered
      expect(@io).to receive(:gets).and_return("55555").ordered
      expect(@io).to receive(:puts).with("item 5 has been added").ordered
      @app.run
    end

    it 'Asks for unit price again if incorrect unit price' do
      interactive_menu
      expect(@io).to receive(:gets).and_return("2").ordered
      expect(@io).to receive(:puts).with("Enter Item name:").ordered
      expect(@io).to receive(:gets).and_return("item 5").ordered
      expect(@io).to receive(:puts).with("Enter Unit Price:").ordered
      expect(@io).to receive(:gets).and_return("string").ordered
      expect(@io).to receive(:puts).with("Enter Unit Price:").ordered
      expect(@io).to receive(:gets).and_return("55555.55").ordered
      expect(@io).to receive(:puts).with("Enter Quantity:").ordered
      expect(@io).to receive(:gets).and_return("55555").ordered
      expect(@io).to receive(:puts).with("item 5 has been added").ordered
      @app.run
    end

    private

    def interactive_menu
      expect(@io).to receive(:puts).with("Welcome to the shop management program!").ordered
      expect(@io).to receive(:puts).with("What do you want to do?").ordered
      expect(@io).to receive(:puts).with("  1 = list all shop items").ordered
      expect(@io).to receive(:puts).with("  2 = create a new item").ordered
      expect(@io).to receive(:puts).with("  3 = list all orders").ordered
      expect(@io).to receive(:puts).with("  4 = create a new order").ordered
    end 
  end
end