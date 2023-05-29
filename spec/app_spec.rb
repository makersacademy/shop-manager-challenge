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
      expect(io).to receive(:puts).with("Welcome to the shop management program!\n\n").ordered
      expect(io).to receive(:puts).at_least(6).times.ordered
      expect(io).to receive(:gets).and_return("1").ordered
      app.show_menu(false)
    end
  end
  
  describe "#process_selection" do
    context "when selecting option 1" do
      it "prints a list of all items" do
        
      end
    end
  end

end
