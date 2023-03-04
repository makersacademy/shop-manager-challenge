require_relative "../app"

describe Application do
  context "run method" do
    it "puts's user prompts and breaks loop with no input" do
      io = double :kernel
      app = Application.new(
        'shop_manager_test',
        io,
        ItemRepository.new,
        OrderRepository.new
      )
      expect(io).to receive(:puts).with("Welcome to the shop managment program!")
      expect(io).to receive(:puts).with(
      "What do you want to do?  
  1 = List all shop items  
  2 = Create a new item  
  3 = List all orders  
  4 = Create a new order")
      expect(io).to receive(:gets).and_return("")
      app.run
    end

    it "puts's list of all items after 1 is inputted" do
      io = double :kernel
      app = Application.new(
        'shop_manager_test',
        io,
        ItemRepository.new,
        OrderRepository.new
      )
      expect(io).to receive(:puts).with("Welcome to the shop managment program!")
      allow(io).to receive(:puts).with(
      "What do you want to do?  
  1 = List all shop items  
  2 = Create a new item  
  3 = List all orders  
  4 = Create a new order")
      expect(io).to receive(:gets).and_return("1")
      expect(io).to receive(:puts).with ["1 - item1 - Price: 66.5 - Quantity: 70", "2 - item2 - Price: 33.25 - Quantity: 35", "3 - item3 - Price: 5.99 - Quantity: 300"]
      expect(io).to receive(:gets).and_return("")
      app.run
    end
  end

  context "format_items_list method" do
    it "returns list of items" do
      app = Application.new(
        'shop_manager_test',
        Kernel,
        ItemRepository.new,
        OrderRepository.new
      )
      expect(app.format_items_list).to eq ["1 - item1 - Price: 66.5 - Quantity: 70", "2 - item2 - Price: 33.25 - Quantity: 35", "3 - item3 - Price: 5.99 - Quantity: 300"]
    end
  end  

  context "create_new_item method and inserts to db" do
    it "prints prompts for user" do
      io = double :kernel
      app = Application.new(
        'shop_manager_test',
        io,
        repo = ItemRepository.new,
        OrderRepository.new
      )
      expect(io).to receive(:puts).with "Please enter the item name:"
      expect(io).to receive(:gets).and_return("Headphones")
      expect(io).to receive(:puts).with "Please enter the item's price:"
      expect(io).to receive(:gets).and_return("39.99")
      expect(io).to receive(:puts).with "Please enter the item quantity:"
      expect(io).to receive(:gets).and_return("50")
      app.create_new_item
      expect(repo.all.length).to eq 4
    end
  end

  context "format_orders_list" do
    it "returns orders list" do
      app = Application.new(
        'shop_manager_test',
        Kernel,
        ItemRepository.new,
        OrderRepository.new
      )
      expect(app.format_orders_list).to eq ["1 - item1 - Price: 66.5 - Quantity: 70", "2 - item2 - Price: 33.25 - Quantity: 35", "3 - item3 - Price: 5.99 - Quantity: 300"]
    end
  end
end
