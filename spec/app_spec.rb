require 'app'
require 'item_repository'

describe Menu do
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
        expect(repo_array.last).to eq("3 - Magformers - 24.99 - 40")
        menu_choice = Menu.new(terminal)
        menu_choice.menu_1
      end
    end
    xit "creates a new item if the menu choice is 2" do
      io = double :io
      repo = ItemRepository.new
      repo_array = []
      repo.all.each do |record|
        repo_array << "#{record.id} - #{record.item_name} - #{record.unit_price} - #{record.quantity}"
      end
      expect(io).to receive(:puts).with("Welcome to the shop management program!\n\nWhat would you like to do? (type a number)\n1 = list all shop items\n2 = create a new item\n3 = list all orders\n4 = create a new order").ordered
      expect(io).to receive(:gets).and_return("1").ordered
      expect(repo_array.first).to eq "1 - Lego - 9.99 - 20"
      expect(repo_array.last).to eq("3 - Magformers - 24.99 - 40")
      menu_choice = Menu.new(io)
      menu_choice.run_menu
    end
  end
end