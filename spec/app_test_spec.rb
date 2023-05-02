require 'app_test'
def reset_items_table
  seed_sql = File.read('spec/seeds_items.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'items_orders_test' })
  connection.exec(seed_sql)
end


RSpec.describe Application do
  before(:each) do 
    reset_items_table
  end

  it "constructs" do
    io_dbl = double :Kernel
    item_repository_dbl = double :item_repository
    order_repository_dbl = double :order_repository
    app = Application.new('items_orders_test', io_dbl, item_repository_dbl, order_repository_dbl)
  end

  describe 'Terminal behaviour' do
    it 'welcomes the user and presents four options with a prompt' do
        io_dbl = double :Kernel
        item_repository_dbl = double :item_repository
        order_repository_dbl = double :order_repository
        app = Application.new('items_orders_test', io_dbl, item_repository_dbl, order_repository_dbl)
      
        expect(io_dbl).to receive(:puts)
          .with("Welcome to the shop management program!").ordered   
        expect(io_dbl).to receive(:puts)
          .with("\nWhat do you like to do?").ordered   
        expect(io_dbl).to receive(:puts)
          .with("1 - List all shop items").ordered   
        expect(io_dbl).to receive(:puts)
          .with("2 - Create a new item").ordered   
        expect(io_dbl).to receive(:puts)
          .with("3 - List all orders").ordered 
        expect(io_dbl).to receive(:puts)
          .with("4 - Create a new order").ordered 
        expect(io_dbl).to receive(:print)
          .with("Enter your choice: ").ordered   
        expect(io_dbl).to receive(:gets)
          .and_return('choice').ordered 
      app.run
    end

    context "when the user chooses 1 - List all shop items" do
      it 'lists all items' do
        io_dbl = double :Kernel
        item_repository_dbl = double :item_repository
        item1 = double :item, name: 'book'
        item2 = double :item, name: 'pen'
        order_repository_dbl = double :order_repository
        app = Application.new('items_orders_test', io_dbl, item_repository_dbl, order_repository_dbl)
        
        
        expect(io_dbl).to receive(:puts)
            .with("Welcome to the shop management program!").ordered   
        expect(io_dbl).to receive(:puts)
            .with("\nWhat do you like to do?").ordered   
        expect(io_dbl).to receive(:puts)
            .with("1 - List all shop items").ordered   
        expect(io_dbl).to receive(:puts)
            .with("2 - Create a new item").ordered   
        expect(io_dbl).to receive(:puts)
            .with("3 - List all orders").ordered 
        expect(io_dbl).to receive(:puts)
            .with("4 - Create a new order").ordered 
        expect(io_dbl).to receive(:print)
            .with("Enter your choice: ").ordered   
        expect(io_dbl).to receive(:gets)
          .and_return('1').ordered
        expect(item_repository_dbl).to receive(:all)
          .and_return([item1, item2]).ordered
        expect(io_dbl).to receive(:puts)
          .with("* 1 - book").ordered
        expect(io_dbl).to receive(:puts)
          .with("* 2 - pen").ordered
        
        app.run
      end
    end
  end
end