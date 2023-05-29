require 'item_repository'
require 'item'
require 'app'

def reset_database
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager' })
  connection.exec(seed_sql)
end

RSpec.describe Application do
  before(:each) do 
    reset_database
  end
  
  let(:io)  { double(:io) }
  let(:app) { Application.new(
              'shop_manager',
              io,
              OrderRepository.new,
              ItemRepository.new
            )
  }
  
  describe "#show_menu" do
    it "show the user a menu of options" do
      expect(io).to receive(:puts).with("\n\e[0;31;49m====== Welcome to the shop management program! ======\e[0m").ordered
      expect(io).to receive(:puts).at_least(6).times.ordered
      expect(io).to receive(:gets).and_return("1").ordered
      app.show_menu(false)
    end
  end
  
  # describe "#process_selection" do
  #   context "when selecting option 1" do
  #     it "prints a list of all items" do
  #       
  #     end
  #   end
  # end
  
  describe "#show_all_items" do
    it "prints a list of items" do
      expect(io).to receive(:puts).with("\n\e[0;31;49m====== All items ======\e[0m").ordered
      expect(io).to receive(:puts).at_least(10).times.ordered
      app.show_all_items
    end
  end
  
  describe "#create_new_item" do
    it "gets the item details and passes them to ItemRepository#create" do
      expect(io).to receive(:puts).exactly(6).times.ordered
      expect(io).to receive(:gets).exactly(3).times.and_return("New test item", "4.50", "3")
      app.create_new_item
      repo = ItemRepository.new
      expect(repo.all.length).to eq 11
      expect(repo.all.last.name).to eq "New test item"
    end
  end

end
