require 'app'
require 'item_repository'
require 'item'

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
  describe "run_menu" do
    it "prints a menu and asks the user to choose and option by typing a number" do
      terminal = double :terminal
      # t_menu1 = double :t_menu1
      expect(terminal).to receive(:puts).with("Welcome to the shop management program!\n\nWhat would you like to do? (type a number)\n1 = list all shop items\n2 = create a new item\n3 = list all orders\n4 = create a new order").ordered
      expect(terminal).to receive(:gets).and_return("1").ordered
      menu_choice = Menu.new(terminal)
      menu_choice.run_menu
    end
    describe "menu_1" do
      it "returns a list of all items if menu choice is 1" do
        terminal = double :terminal
        # t_menu1 = double :t_menu1
        repo = ItemRepository.new
        repo_array = []
        repo.all.each do |record|
          repo_array << "#{record.id} - #{record.item_name} - #{record.unit_price} - #{record.quantity}"
        end
        expect(terminal).to receive(:puts).with("Here's a list of shop items").ordered
        expect(repo_array.first).to eq "1 - Lego - 9.99 - 20"
        expect(repo_array.last).to eq("2 - My Little Pony - 13.99 - 50")
        menu_choice = Menu.new(terminal)
        menu_choice.menu_1
      end
    end
    it "creates a new item if the menu choice is 2" do
      terminal = double :terminal      
      repo = ItemRepository.new
      
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
      menu_choice.menu_2
    end
  end
end