require 'app'
require 'item_repository'

describe Menu do
  describe "run_menu" do
    it "prints a menu and asks the user to choose and option by typing a number" do
      io = double :io
      expect(io).to receive(:puts).with("Welcome to the shop management program!\n\nWhat would you like to do? (type a number)\n1 = list all shop items\n2 = create a new item\n3 = list all orders\n4 = create a new order")
        expect(io).to receive(:gets).and_return("1")
      menu_choice = Menu.new(io)
      menu_choice.run_menu
    end
    it "returns a list of all items if menu choice is 1" do
      io = double :io
      repo = ItemRepository.new
      repo_array = []
      repo.all.each do |record|
        repo_array << "#{record.id} - #{record.item_name} - #{record.unit_price} - #{record.quantity}"
      end
      expect(io).to receive(:puts).with("Welcome to the shop management program!\n\nWhat would you like to do? (type a number)\n1 = list all shop items\n2 = create a new item\n3 = list all orders\n4 = create a new order")
      expect(io).to receive(:gets).and_return("1")
      expect(repo_array.first).to eq "1 - Lego - 9.99 - 20"
      expect(repo_array.last).to eq "3 - Magformers - 24.99 - 40"
      menu_choice = Menu.new(io)
      menu_choice.run_menu
    end
  end
end