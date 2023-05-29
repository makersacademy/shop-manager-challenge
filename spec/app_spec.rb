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
  
  describe "#show_all_orders" do
    it "lists all the orders" do
      expect(io).to receive(:puts).with("\n\e[0;31;49m====== All orders ======\e[0m").ordered
      expect(io).to receive(:puts).with("  Order #1: 2023-05-03 – Rodney Howell").ordered
      expect(io).to receive(:puts).ordered
      app.show_all_orders
    end
  end
  
  describe "#create_new_order" do
    it "adds a new order to the database" do
      expect(io).to receive(:puts).at_least(6).times.ordered
      expect(io).to receive(:gets).exactly(5).times.and_return("Sadie Quitzon", "1", "3", "7", "")
      app.create_new_order
      repo = OrderRepository.new
      expect(repo.all.length).to eq 3
      expect(repo.all.last.customer_name).to eq "Sadie Quitzon"
    end
  end
  
  describe "#choose_order_items" do
    it "shows a menu of items to add to the order" do
      allow(io).to receive(:puts)
      expect(io).to receive(:gets).exactly(4).times.and_return("1", "3", "7", "")
      items = app.choose_order_items
      expect(items).to eq([1, 3, 7])
    end
  end

end
