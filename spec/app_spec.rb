require_relative '../app'

RSpec.describe Application do
  def reset_items_table
      seed_sql = File.read('spec/items_orders.sql')
      connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
      connection.exec(seed_sql)
  end

  def reset_orders_table
    seed_sql = File.read('spec/items_orders.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
end

  describe Application do
    before(:each) do 
        reset_items_table
    end

    before(:each) do 
        reset_orders_table
    end

    it "returns list of all items if user choice is 1" do
        io = double :io
        item = double :fake_item, id: "1", name: "Eggs", price: "2.99", quantity: "10"
        item_list = double :fake_item_list, all: [item]
        order_list = double :fake_order_list

        expect(io).to receive(:puts).with("Welcome to the shop management program!").ordered
        expect(io).to receive(:puts).with("What do you want to do?
            \n1 = list all shop items\n2 = create a new item
            \n3 = list all orders\n4 = create a new order").ordered
        expect(io).to receive(:gets).and_return("1").ordered
        expect(io).to receive(:puts).with("Here is the list of all items:")
        expect(io).to receive(:puts).with("#1 Eggs - Unit price: 2.99 - Quantity: 10").ordered

        app = Application.new('shop_manager_test', io, 'item_repository', 'order_repository')
        app.run(item_list, order_list)
    end

    it "returns list of orders if choice is 3" do
        io = double :io
        item_list = double :fake_item_list
        order = double :fake_order, id: "1", customer_name: "John Key", date: "2023-01-08"
        order_list = double :fake_order_list, all: [order]
        
        expect(io).to receive(:puts).with("Welcome to the shop management program!").ordered
        expect(io).to receive(:puts).with("What do you want to do?
            \n1 = list all shop items\n2 = create a new item
            \n3 = list all orders\n4 = create a new order").ordered
        expect(io).to receive(:gets).and_return("3").ordered
        expect(io).to receive(:puts).with("Here is the list of all orders:")
        expect(io).to receive(:puts).with("#1 John Key - Date: 2023-01-08").ordered

        app = Application.new('shop_manager_test', io, 'item_repository', 'order_repository')
        app.run(item_list, order_list)
    end

    it "creates a new item when user choice is 2" do
        io = double :io
        new_item = double :item_object, name: 'Bananas', price: '1.99', quantity: '10'
        item_list = double :fake_item_list, create: new_item
        order_list = double :fake_order_list

        expect(io).to receive(:puts).with("Welcome to the shop management program!").ordered
        expect(io).to receive(:puts).with("What do you want to do?
            \n1 = list all shop items\n2 = create a new item
            \n3 = list all orders\n4 = create a new order").ordered
        expect(io).to receive(:gets).and_return("2").ordered
        expect(io).to receive(:puts).with("Please enter new item name.").ordered
        expect(io).to receive(:gets).and_return("Bananas").ordered
        expect(io).to receive(:puts).with("Please enter new item price.").ordered
        expect(io).to receive(:gets).and_return("1.99").ordered
        expect(io).to receive(:puts).with("Please enter new item quantity.").ordered
        expect(io).to receive(:gets).and_return("10").ordered

        app = Application.new('shop_manager_test', io, 'item_repository', 'order_repository')
        app.run(item_list, order_list)
    end

    it "creates a new order when user choice is 4" do
        io = double :io
        new_order = double :order_object, customer_name: 'Daisy Jones', date: '2023-01-08'
        item_list = double :fake_item_list
        order_list = double :fake_order_list, create: new_order

        expect(io).to receive(:puts).with("Welcome to the shop management program!").ordered
        expect(io).to receive(:puts).with("What do you want to do?
            \n1 = list all shop items\n2 = create a new item
            \n3 = list all orders\n4 = create a new order").ordered
        expect(io).to receive(:gets).and_return("4").ordered
        expect(io).to receive(:puts).with("Please enter customer name.").ordered
        expect(io).to receive(:gets).and_return("Daisy Jones").ordered
        expect(io).to receive(:puts).with("Please enter date.").ordered
        expect(io).to receive(:gets).and_return("2023-01-08").ordered

        app = Application.new('shop_manager_test', io, 'item_repository', 'order_repository')
        app.run(item_list, order_list)
    end 

  end
end