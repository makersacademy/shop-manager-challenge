require 'app'
require 'item_repository'
require 'item'
require 'order_repository'
require 'order'

describe Menu do
  def reset_items_table
    seed_sql = File.read('spec/seeds_items.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_test' })
    connection.exec(seed_sql)
  end

  def reset_orders_table
    seed_sql = File.read('spec/seeds_orders.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_test' })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_items_table
    reset_orders_table
  end
  describe Menu do
    it "prints a menu, asks the user to choose and runs the menu_1 method if the user chooses 1" do
      terminal = double :terminal
      repo = ItemRepository.new
      repo_array = []
      repo.all.each do |record|
        repo_array << "#{record.id} - #{record.item_name} - #{record.unit_price} - #{record.quantity}"
      end
      expect(terminal).to receive(:puts).with("Welcome to the shop management program!\n\nWhat would you like to do? (type a number)\n1 = list all shop items\n2 = create a new item\n3 = list all orders\n4 = create a new order").ordered
      expect(terminal).to receive(:gets).and_return("1").ordered
      # expect(Menu).to receive(:menu_1).and_call_original
      expect(terminal).to receive(:puts).with("Here's a list of shop items").ordered
      expect(repo_array.first).to eq "1 - Lego - 9.99 - 20"
      expect(repo_array.last).to eq("2 - My Little Pony - 13.99 - 50")
      menu_choice = Menu.new(terminal)
      menu_choice.run_menu
    end
  # describe "choose_menu" do
  #   it "runs the method menu_1 if the user chooses 1" do
  #     terminal = double :terminal
  #     # expect(terminal).to receive(:puts).with("Welcome to the shop management program!\n\nWhat would you like to do? (type a number)\n1 = list all shop items\n2 = create a new item\n3 = list all orders\n4 = create a new order").ordered
  #     # expect(terminal).to receive(:gets).and_return("1").ordered
      
  #     expect(terminal).to receive(:menu_1)
  #     expect(terminal).to receive(:puts).with("Here's a list of shop items")
  #     # called_menu_1 = false
  #     # subject.stub(:menu_1).with("1") {called_menu_1 = true}
  #     menu = Menu.new(terminal)
  #     menu.choose_menu("1")
  #   end
  # end
    it "prints a menu, asks the user to choose and runs the menu_2 method if the user chooses 2" do
      terminal = double :terminal      
      repo = ItemRepository.new
      expect(terminal).to receive(:puts).with("Welcome to the shop management program!\n\nWhat would you like to do? (type a number)\n1 = list all shop items\n2 = create a new item\n3 = list all orders\n4 = create a new order").ordered
      expect(terminal).to receive(:gets).and_return("2").ordered
      expect(terminal).to receive(:puts).with("Let's create a new item!\nEnter a name for this item").ordered
      expect(terminal).to receive(:gets).and_return("Moana Boat").ordered
      expect(terminal).to receive(:puts).with("Enter a price for this item").ordered
      expect(terminal).to receive(:gets).and_return("9.99").ordered
      expect(terminal).to receive(:puts).with("Enter a quantity for this item").ordered
      expect(terminal).to receive(:gets).and_return("30").ordered

      new_item = Item.new
      new_item.item_name = "Moana Boat"
      new_item.unit_price = "9.99"
      new_item.quantity = "30"

      repo.create(new_item)

      expect(repo.all.length).to eq 3
      menu_choice = Menu.new(terminal)
      menu_choice.run_menu
    end
    it "prints a menu, asks the user to choose and runs the menu_3 method if the user chooses 3" do
      terminal = double :terminal
      repo = OrderRepository.new
      repo_array = []
      repo.all.each do |record|
        repo_array << "#{record.id} - #{record.date} - #{record.customer_name} - #{record.item_id} - #{record.quantity}"
      end
      expect(terminal).to receive(:puts).with("Welcome to the shop management program!\n\nWhat would you like to do? (type a number)\n1 = list all shop items\n2 = create a new item\n3 = list all orders\n4 = create a new order").ordered
      expect(terminal).to receive(:gets).and_return("3").ordered
      # expect(Menu).to receive(:menu_1).and_call_original
      expect(terminal).to receive(:puts).with("Here's a list of orders").ordered
      expect(repo_array.first).to eq "1 - 01/10/2022 - Hillary - 1 - 1"
      expect(repo_array.last).to eq("5 - 05/11/2022 - Helen - 2 - 2")
      menu_choice = Menu.new(terminal)
      menu_choice.run_menu
    end
    it "prints a menu, asks the user to choose and runs the menu_4 method if the user chooses 4" do
      terminal = double :terminal      
      repo = OrderRepository.new
      expect(terminal).to receive(:puts).with("Welcome to the shop management program!\n\nWhat would you like to do? (type a number)\n1 = list all shop items\n2 = create a new item\n3 = list all orders\n4 = create a new order").ordered
      expect(terminal).to receive(:gets).and_return("4").ordered
      expect(terminal).to receive(:puts).with("Let's create a new order!\nEnter a date for this order").ordered
      expect(terminal).to receive(:gets).and_return("01/05/2022").ordered
      expect(terminal).to receive(:puts).with("Enter a customer name for this order").ordered
      expect(terminal).to receive(:gets).and_return("Jacob").ordered
      expect(terminal).to receive(:puts).with("Enter an item id for this order").ordered
      expect(terminal).to receive(:gets).and_return("2").ordered
      expect(terminal).to receive(:puts).with("Enter a quantity for this order").ordered
      expect(terminal).to receive(:gets).and_return("6").ordered

      order = Order.new
      order.date = "01/05/2022"
      order.customer_name = "Jacob"
      order.item_id = "2"
      order.quantity = "6"

      repo.create(order)

      expect(repo.all.length).to eq 6
      menu_choice = Menu.new(terminal)
      menu_choice.run_menu
    end
  end
end