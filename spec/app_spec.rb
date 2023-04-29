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
      it "returns the list of items" do
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

    # context "when the users selects 2" do
    #   it "returns the list of items" do
    #     io = double :terminal
    #     expect(io).to receive(:gets).and_return("1")

    #     app = Application.new('shop_manager_test', io, ItemRepository.new, OrderRepository.new)
    #     all_items = app.list_all_items
    #     expect(all_items.length).to eq 3
    #     expect(all_items.first.name).to eq "Coffee Machine"
    #     app.run
    #   end
    # end  
  end
end