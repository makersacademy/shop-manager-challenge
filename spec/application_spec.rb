require "application"

RSpec.describe Application do
  describe "#run" do
    context "when user chooses option 1" do
      it "prints all the shop items when user inputs option" do
        fake_io = double :fake_io
        expect(fake_io).to receive(:puts).with("Welcome to the shop management program!\n")
        expect(fake_io).to receive(:puts).with("What do you want to do?")
        expect(fake_io).to receive(:puts).with("  1 = list all shop items")
        expect(fake_io).to receive(:puts).with("  2 = create a new item")
        expect(fake_io).to receive(:puts).with("  3 = list all orders")
        expect(fake_io).to receive(:puts).with("  4 = create a new order")
        expect(fake_io).to receive(:puts).with("")
        fake_item_repo = double :fake_item_repo
        fake_order_repo = double :fake_order_repo
        allow(fake_io).to receive(:gets).and_return("1\n")
        expect(fake_io).to receive(:puts).with("Here's a list of all shop items:\n")
        expect(fake_io).to receive(:puts).with(
          "#1 name1 - Unit price: £3.40 - Quantity: 3"
        )
        expect(fake_io).to receive(:puts).with(
          "#2 name2 - Unit price: £0.55 - Quantity: 101"
        )
        
        fake_item1 = double(
          :fake_item1,
          id: "3",
          name: "name1",
          unit_price: "340",
          quantity: "3"
        ) 
        fake_item2 = double(
          :fake_item2,
          id: "4",
          name: "name2",
          unit_price: "55",
          quantity: "101"
        )
        allow(fake_item_repo).to receive(:all).and_return(
          [fake_item1, fake_item2]
        )
      
        app = Application.new(
          database = "shop_manager_test",
          io = fake_io,
          fake_item_repo,
          fake_order_repo
        )
        app.run
      end
    end
    
    context "when user chooses option 2" do
      it "creates a new item" do
        fake_io = double :fake_io
        expect(fake_io).to receive(:puts).with("Welcome to the shop management program!\n")
        expect(fake_io).to receive(:puts).with("What do you want to do?")
        expect(fake_io).to receive(:puts).with("  1 = list all shop items")
        expect(fake_io).to receive(:puts).with("  2 = create a new item")
        expect(fake_io).to receive(:puts).with("  3 = list all orders")
        expect(fake_io).to receive(:puts).with("  4 = create a new order")
        expect(fake_io).to receive(:puts).with("")
        expect(fake_io).to receive(:gets).and_return("2\n")
        expect(fake_io).to receive(:print).with("What's the name of the new item: ")
        expect(fake_io).to receive(:gets).and_return("new_item\n")
        expect(fake_io).to receive(:print).with("What's the unit price of the new item: ")
        expect(fake_io).to receive(:gets).and_return("105\n")
        expect(fake_io).to receive(:print).with("What's the quantity of the new item: ")
        expect(fake_io).to receive(:gets).and_return("3\n")
        
        fake_item_repo = double :fake_item_repo
        fake_order_repo = double :fake_order_repo
        
        expect(fake_item_repo).to receive(:create).with(
          have_attributes(
            name: "new_item",
            unit_price: "105",
            quantity: "3"
          )
        )

        app = Application.new(
          database = "shop_manager_test",
          io = fake_io,
          fake_item_repo,
          fake_order_repo
        )
        app.run        
      end
    end
    
    context "when user chooses option 3" do
      it "lists all orders" do
        fake_io = double :fake_io
        expect(fake_io).to receive(:puts).with("Welcome to the shop management program!\n")
        expect(fake_io).to receive(:puts).with("What do you want to do?")
        expect(fake_io).to receive(:puts).with("  1 = list all shop items")
        expect(fake_io).to receive(:puts).with("  2 = create a new item")
        expect(fake_io).to receive(:puts).with("  3 = list all orders")
        expect(fake_io).to receive(:puts).with("  4 = create a new order")
        expect(fake_io).to receive(:puts).with("")
        fake_item_repo = double :fake_item_repo
        fake_order_repo = double :fake_order_repo
        allow(fake_io).to receive(:gets).and_return("3\n")
        allow(fake_io).to receive(:gets).and_return("3\n")
        expect(fake_io).to receive(:puts).with("Here's a list of all orders:\n")
        expect(fake_io).to receive(:puts).with(
          "#1 Customer: customer1 - Date placed: 2023-04-29"
        )
        expect(fake_io).to receive(:puts).with("    item1 - Unit price: £2.45")
        expect(fake_io).to receive(:puts).with("    item2 - Unit price: £1.09")
        expect(fake_io).to receive(:puts).with("")
        expect(fake_io).to receive(:puts).with(
          "#2 Customer: customer2 - Date placed: 2023-03-20"
        )
        expect(fake_io).to receive(:puts).with("    item1 - Unit price: £2.45")
        expect(fake_io).to receive(:puts).with("")

        fake_item1 = double(
          :fake_item1,
          id: "1",
          name: "item1",
          unit_price: "245",
          quantity: "3"
        )
        fake_item2 = double(
          :fake_item2,
          id: "2",
          name: "item2",
          unit_price: "109",
          quantity: "5"
        )
        fake_order1 = double(
          :fake_order1,
          id: "1",
          customer_name: "customer1",
          date_placed: "2023-04-29",
          items: [fake_item1, fake_item2]
        )
        fake_order2 = double(
          :fake_order2,
          id: "4",
          customer_name: "customer2",
          date_placed: "2023-03-20",
          items: [fake_item1]
        )
        allow(fake_order_repo).to receive(:all_with_items).and_return(
          [fake_order1, fake_order2]
        )
       
        app = Application.new(
          database = "shop_manager_test",
          io = fake_io,
          fake_item_repo,
          fake_order_repo
        )
        app.run        
      end
    end
    
    context "when user chooses option 4" do
      it "creates a new order" do
        fake_io = double :fake_io
        expect(fake_io).to receive(:puts).with("Welcome to the shop management program!\n")
        expect(fake_io).to receive(:puts).with("What do you want to do?")
        expect(fake_io).to receive(:puts).with("  1 = list all shop items")
        expect(fake_io).to receive(:puts).with("  2 = create a new item")
        expect(fake_io).to receive(:puts).with("  3 = list all orders")
        expect(fake_io).to receive(:puts).with("  4 = create a new order")
        expect(fake_io).to receive(:puts).with("")
        expect(fake_io).to receive(:gets).and_return("4\n")
        expect(fake_io).to receive(:print).with("What's the customer name of the new order: ")
        expect(fake_io).to receive(:gets).and_return("customer1\n")
        expect(fake_io).to receive(:print).with("What's the date this order was placed: ")
        expect(fake_io).to receive(:gets).and_return("2022-01-02")
        
        fake_item_repo = double :fake_item_repo
        fake_order_repo = double :fake_order_repo
        
        expect(fake_order_repo).to receive(:create).with(
          have_attributes(
            customer_name: "customer1",
            date_placed: "2022-01-02"
          )
        )

        app = Application.new(
          database = "shop_manager_test",
          io = fake_io,
          fake_item_repo,
          fake_order_repo
        )
        app.run      
      end
    end
  end
end
