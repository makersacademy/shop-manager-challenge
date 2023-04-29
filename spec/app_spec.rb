require_relative '../app'

RSpec.describe Application do
  def reset_items_and_orders_tables
    seed_sql = File.read('spec/seeds_shop_manager.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end
    
  before(:each) do 
    reset_items_and_orders_tables
  end

  describe "#run" do
    context "when the users selects 1" do
      xit "returns the list of items" do
        io = double :terminal
        expect(io).to receive(:puts).with("Welcome to the shop management program!").ordered
        expect(io).to receive(:puts).with("").ordered
        expect(io).to receive(:puts).with("What do you want to do?").ordered
        expect(io).to receive(:puts).with("1 = list all shop items").ordered
        expect(io).to receive(:puts).with("2 = create a new item").ordered
        expect(io).to receive(:puts).with("3 = list all orders").ordered
        expect(io).to receive(:puts).with("4 = create a new order").ordered
        expect(io).to receive(:puts).with("").ordered
        expect(io).to receive(:gets).and_return("1").ordered

        app = Application.new('shop_manager_test', io, ItemRepository.new, OrderRepository.new)
        all_items = app.list_all_items
        expect(all_items.length).to eq 3
        expect(all_items.first.name).to eq "Coffee Machine"
        app.run
      end
    end  
 
    context "when the users selects 2" do
      xit "creates a new item" do
        io = double :terminal
        expect(io).to receive(:puts).with("Welcome to the shop management program!").ordered
        expect(io).to receive(:puts).with("").ordered
        expect(io).to receive(:puts).with("What do you want to do?").ordered
        expect(io).to receive(:puts).with("1 = list all shop items").ordered
        expect(io).to receive(:puts).with("2 = create a new item").ordered
        expect(io).to receive(:puts).with("3 = list all orders").ordered
        expect(io).to receive(:puts).with("4 = create a new order").ordered
        expect(io).to receive(:puts).with("").ordered
        expect(io).to receive(:gets).and_return("3").ordered
        app = Application.new('shop_manager_test', io, ItemRepository.new, OrderRepository.new)
        app.run
        app.create_new_item("Projector", "37.40", "44")
        all_items = app.list_all_items
        expect(all_items.length).to eq 4
        expect(all_items.last.name).to eq "Projector"
        expect(all_items.last.unit_price).to eq '37.40'
        expect(all_items.last.stock_quantity).to eq "44"
        expect(all_items.last.id).to eq '4'
      end
    end  
    
    context "when the users selects 3" do
      xit "returns the list of orders" do
        io = double :terminal
        expect(io).to receive(:puts).with("Welcome to the shop management program!").ordered
        expect(io).to receive(:puts).with("").ordered
        expect(io).to receive(:puts).with("What do you want to do?").ordered
        expect(io).to receive(:puts).with("1 = list all shop items").ordered
        expect(io).to receive(:puts).with("2 = create a new item").ordered
        expect(io).to receive(:puts).with("3 = list all orders").ordered
        expect(io).to receive(:puts).with("4 = create a new order").ordered
        expect(io).to receive(:puts).with("").ordered
        expect(io).to receive(:gets).and_return("1").ordered
        app = Application.new('shop_manager_test', io, ItemRepository.new, OrderRepository.new)
        all_orders = app.list_all_orders
        expect(all_orders.length).to eq 3
        expect(all_orders.first.customer_name).to eq "Andrea"
        expect(all_orders[2].date).to eq '2023-04-19'
        app.run
      end
    end     

    context "when the users selects 4" do
      it "creates a new order" do
        io = double :terminal
        expect(io).to receive(:puts).with("Welcome to the shop management program!").ordered
        expect(io).to receive(:puts).with("").ordered
        expect(io).to receive(:puts).with("What do you want to do?").ordered
        expect(io).to receive(:puts).with("1 = list all shop items").ordered
        expect(io).to receive(:puts).with("2 = create a new item").ordered
        expect(io).to receive(:puts).with("3 = list all orders").ordered
        expect(io).to receive(:puts).with("4 = create a new order").ordered
        expect(io).to receive(:puts).with("").ordered
        expect(io).to receive(:gets).and_return("4").ordered
        app = Application.new('shop_manager_test', io, ItemRepository.new, OrderRepository.new)
        app.run
        app.create_new_order("Ilaria", '2023-04-29', "1")
        all_orders = app.list_all_orders
        expect(all_orders.length).to eq 4
        expect(all_orders.last.customer_name).to eq "Ilaria"
        expect(all_orders.last.date).to eq '2023-04-29'
        expect(all_orders.last.item_id).to eq "1"
      end
    end  
  end
end
