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
  4 = Create a new order
  5 = Exit program")
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
  4 = Create a new order
  5 = Exit program")
      expect(io).to receive(:gets).and_return("1")
      expect(io).to receive(:puts).with ["\n",
        "1 - item1 - Price: 66.5 - Quantity: 70", 
        "2 - item2 - Price: 33.25 - Quantity: 35", 
        "3 - item3 - Price: 5.99 - Quantity: 300",
      "\n"]
      expect(io).to receive(:gets).and_return("")
      app.run
    end

    it "puts's list of all order after 3 is inputted" do
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
  4 = Create a new order
  5 = Exit program")
      expect(io).to receive(:gets).and_return("3")
      expect(io).to receive(:puts).with ["\n",
        "1 - Customer: Ayoub - Date: 2022-07-23 - Item: item1", 
        "2 - Customer: Makers - Date: 2023-01-16 - Item: item2", 
        "3 - Customer: Alice - Date: 2023-02-13 - Item: item3",
        "\n"]
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
      expect(app.format_items_list).to eq ["\n",
        "1 - item1 - Price: 66.5 - Quantity: 70", 
        "2 - item2 - Price: 33.25 - Quantity: 35", 
        "3 - item3 - Price: 5.99 - Quantity: 300",
        "\n"]
    end
  end  

  context "create_new_item method" do
    it "prints prompts for user and inserts to db" do
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
      expect(app.format_orders_list).to eq ["\n", 
        "1 - Customer: Ayoub - Date: 2022-07-23 - Item: item1", 
        "2 - Customer: Makers - Date: 2023-01-16 - Item: item2", 
        "3 - Customer: Alice - Date: 2023-02-13 - Item: item3",
        "\n"]
    end
  end

  context "create_new_order method" do
    it "prints prompts to user and adds order to db" do
      io = double :kernel
      app = Application.new(
        'shop_manager_test',
        io,
        ItemRepository.new,
        repo = OrderRepository.new
      )
      expect(io).to receive(:puts).with "Please enter the customer's name:"
      expect(io).to receive(:gets).and_return("Ahmed")
      expect(io).to receive(:puts).with "Please enter the ordered item's id:"
      expect(io).to receive(:gets).and_return("3")
      app.create_new_order
      expect(repo.all.length).to eq 4
    end
  end
end
