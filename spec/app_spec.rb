require './app'

RSpec.describe Application do
  context "lists all items" do
    it "prints all items in a list" do
      io = double :io
      item = double :item, name: "blueberries", unit_price: "4", quantity: "30"
      item2 = double :item, name: "raspberries", unit_price: "5", quantity: "20"
      item3 = double :item, name: "eggs", unit_price: "2", quantity: "50"
      items = [item, item2, item3]
      item_repository = double :item_repository, all: items
      order_repository = double :order_repository
      items_orders_repository = double :items_orders_repository
      app = Application.new('shop_manager_test', io, item_repository, order_repository, items_orders_repository)
      expect(io).to receive(:puts).with("Welcome to the shop management program!")
      expect(io).to receive(:puts).with("What do you want to do?")
      expect(io).to receive(:puts).with("  1. List all shop items")
      expect(io).to receive(:puts).with("  2. Create a new item")
      expect(io).to receive(:puts).with("  3. Restock item")
      expect(io).to receive(:puts).with("  4. List all orders")
      expect(io).to receive(:puts).with("  5. Create a new order")
      expect(io).to receive(:puts).with("  6. Find a customers full order by customers name")
      expect(io).to receive(:puts).with("  7. Find all orders including a specific item")
      expect(io).to receive(:puts).with("Enter your choice: ")
      expect(io).to receive(:gets).and_return("1\n")
      expect(io).to receive(:puts).with("All Items in stock: ")
      expect(io).to receive(:puts).with("  #1 Blueberries - Unit Price: £4 - Quantity: 30")
      expect(io).to receive(:puts).with("  #2 Raspberries - Unit Price: £5 - Quantity: 20")
      expect(io).to receive(:puts).with("  #3 Eggs - Unit Price: £2 - Quantity: 50")
      app.run
    end
  end

  context "adds an item" do
    it "prints all items in a list with the added item" do
      io = double :io
      item1 = double :item, name: "blueberries", unit_price: "4", quantity: "30"
      item2 = double :item, name: "raspberries", unit_price: "5", quantity: "20"
      item3 = double :item, name: "eggs", unit_price: "2", quantity: "50"
      item = double :item, name: "bananas", unit_price: "2", quantity: "20"
      items = [item1, item2, item3, item]
      item_repository = double :item_repository, all: items
      order_repository = double :order_repository
      items_orders_repository = double :items_orders_repository
      app = Application.new('shop_manager_test', io, item_repository, order_repository, items_orders_repository)
      expect(io).to receive(:puts).with("Welcome to the shop management program!")
      expect(io).to receive(:puts).with("What do you want to do?")
      expect(io).to receive(:puts).with("  1. List all shop items")
      expect(io).to receive(:puts).with("  2. Create a new item")
      expect(io).to receive(:puts).with("  3. Restock item")
      expect(io).to receive(:puts).with("  4. List all orders")
      expect(io).to receive(:puts).with("  5. Create a new order")
      expect(io).to receive(:puts).with("  6. Find a customers full order by customers name")
      expect(io).to receive(:puts).with("  7. Find all orders including a specific item")
      expect(io).to receive(:puts).with("Enter your choice: ")
      expect(io).to receive(:gets).and_return("2\n")
      expect(io).to receive(:puts).with("Enter the name of the item you wish to add: ")
      expect(io).to receive(:gets).and_return("bananas\n")
      expect(io).to receive(:puts).with("Enter the unit price of the item you wish to add: ")
      expect(io).to receive(:gets).and_return("2\n")
      expect(io).to receive(:puts).with("Enter the quantity of the item you wish to add: ")
      expect(io).to receive(:gets).and_return("20\n")
      allow(item).to receive(:name).with("bananas")
      allow(item).to receive(:unit_price).with("2")
      allow(item).to receive(:quantity).with("20")
      expect(item_repository).to receive(:create).with(instance_of(Item))
      expect(io).to receive(:puts).with("Item successfully added!")
      expect(io).to receive(:puts).with("All Items in stock: ")
      expect(io).to receive(:puts).with("  #1 Blueberries - Unit Price: £4 - Quantity: 30")
      expect(io).to receive(:puts).with("  #2 Raspberries - Unit Price: £5 - Quantity: 20")
      expect(io).to receive(:puts).with("  #3 Eggs - Unit Price: £2 - Quantity: 50")
      expect(io).to receive(:puts).with("  #4 Bananas - Unit Price: £2 - Quantity: 20")
      app.run
    end
  end

  context "lists all orders" do
    it "prints all orders in a list" do
      io = double :io
      order = double :order, customer_name: "Harry Styles", order_date: "2022-03-10"
      order2 = double :order, customer_name: "Taylor Swift", order_date: "2022-04-14"
      order3 = double :order, customer_name: "Billie Eillish", order_date: "2022-05-21"
      orders = [order, order2, order3]
      item_repository = double :item_repository
      order_repository = double :order_repository, all: orders
      items_orders_repository = double :items_orders_repository
      app = Application.new('shop_manager_test', io, item_repository, order_repository, items_orders_repository)
      expect(io).to receive(:puts).with("Welcome to the shop management program!")
      expect(io).to receive(:puts).with("What do you want to do?")
      expect(io).to receive(:puts).with("  1. List all shop items")
      expect(io).to receive(:puts).with("  2. Create a new item")
      expect(io).to receive(:puts).with("  3. Restock item")
      expect(io).to receive(:puts).with("  4. List all orders")
      expect(io).to receive(:puts).with("  5. Create a new order")
      expect(io).to receive(:puts).with("  6. Find a customers full order by customers name")
      expect(io).to receive(:puts).with("  7. Find all orders including a specific item")
      expect(io).to receive(:puts).with("Enter your choice: ")
      expect(io).to receive(:gets).and_return("4\n")
      expect(io).to receive(:puts).with("All Orders: ")
      expect(io).to receive(:puts).with("  Order #1 - Customer Name: Harry Styles - Order Date: 2022-03-10")
      expect(io).to receive(:puts).with("  Order #2 - Customer Name: Taylor Swift - Order Date: 2022-04-14")
      expect(io).to receive(:puts).with("  Order #3 - Customer Name: Billie Eillish - Order Date: 2022-05-21")
      app.run
    end
  end

  context "adds an order" do
    it "prints all orders in a list with the added order" do
      io = double :io
      items_orders = double :items_orders
      item = double :item, name: "blueberries", unit_price: "4", quantity: "30", id: 1
      item2 = double :item, name: "raspberries", unit_price: "5", quantity: "20", id: 2
      items = [item, item2]
      order1 = double :order, customer_name: "Harry Styles", order_date: "2022-03-10", id: 1
      order2 = double :order, customer_name: "Taylor Swift", order_date: "2022-04-14", id: 2
      order3 = double :order, customer_name: "Billie Eillish", order_date: "2022-05-21", id: 3
      order = double :order, customer_name: "Lizzie McAlpine", order_date: "2022-10-08", id: 4
      orders = [order1, order2, order3, order]
      item_repository = double :item_repository, all: items
      order_repository = double :order_repository, all: orders
      items_orders_repository = double :items_orders_repository
      app = Application.new('shop_manager_test', io, item_repository, order_repository, items_orders_repository)
      expect(io).to receive(:puts).with("Welcome to the shop management program!")
      expect(io).to receive(:puts).with("What do you want to do?")
      expect(io).to receive(:puts).with("  1. List all shop items")
      expect(io).to receive(:puts).with("  2. Create a new item")
      expect(io).to receive(:puts).with("  3. Restock item")
      expect(io).to receive(:puts).with("  4. List all orders")
      expect(io).to receive(:puts).with("  5. Create a new order")
      expect(io).to receive(:puts).with("  6. Find a customers full order by customers name")
      expect(io).to receive(:puts).with("  7. Find all orders including a specific item")
      expect(io).to receive(:puts).with("Enter your choice: ")
      expect(io).to receive(:gets).and_return("5\n")
      expect(io).to receive(:puts).with("Add an order: ")
      expect(io).to receive(:puts).with("Enter the customers name: ")
      expect(io).to receive(:gets).and_return("Lizzie McAlpine\n")
      allow(order).to receive(:customer_name).and_return("Lizzie McAlpine")
      allow(order).to receive(:order_date).and_return("2022-10-08")
      expect(order_repository).to receive(:create).with(instance_of(Order))
      expect(order_repository).to receive(:find).with("Lizzie McAlpine").and_return(order)
      expect(io).to receive(:puts).with("Here are items we have in stock: ")
      expect(io).to receive(:puts).with("  #1 Blueberries - Unit Price: £4 - Quantity: 30")
      expect(io).to receive(:puts).with("  #2 Raspberries - Unit Price: £5 - Quantity: 20")
      expect(io).to receive(:puts).with("What item would you like to add: ")
      expect(io).to receive(:gets).and_return("blueberries\n")
      expect(item_repository).to receive(:find).with("blueberries").and_return(item)
      allow(items_orders).to receive(:item_id).with("1")
      allow(item).to receive(:id)
      allow(items_orders).to receive(:order_id).with("3")
      allow(order).to receive(:id)
      allow(items_orders_repository).to receive(:create).with(instance_of(ItemsOrders))
      expect(item).to receive(:quantity=).with("29")
      allow(item_repository).to receive(:update_quantity).with(item)
      expect(io).to receive(:puts).with("Would you like to add anything else? [Yes/No]")
      expect(io).to receive(:gets).and_return("No\n")
      expect(io).to receive(:puts).with("Order successfully added!")
      expect(io).to receive(:puts).with("All Orders: ")
      expect(io).to receive(:puts).with("  Order #1 - Customer Name: Harry Styles - Order Date: 2022-03-10")
      expect(io).to receive(:puts).with("  Order #2 - Customer Name: Taylor Swift - Order Date: 2022-04-14")
      expect(io).to receive(:puts).with("  Order #3 - Customer Name: Billie Eillish - Order Date: 2022-05-21")
      expect(io).to receive(:puts).with("  Order #4 - Customer Name: Lizzie McAlpine - Order Date: 2022-10-08")
      app.run
    end
  end

  context "restock an item" do
    it "prints all items in a list with the updated quantity" do
      io = double :io
      item1 = double :item1, name: "blueberries", unit_price: "4", quantity: "30"
      item2 = double :item2, name: "raspberries", unit_price: "5", quantity: "20"
      item3 = double :item3, name: "eggs", unit_price: "2", quantity: "50"
      item = double :item, name: "bananas", unit_price: "2", quantity: "50"
      items = [item1, item2, item3, item]
      item_repository = double :item_repository, all: items
      order_repository = double :order_repository
      items_orders_repository = double :items_orders_repository
      app = Application.new('shop_manager_test', io, item_repository, order_repository, items_orders_repository)
      expect(io).to receive(:puts).with("Welcome to the shop management program!")
      expect(io).to receive(:puts).with("What do you want to do?")
      expect(io).to receive(:puts).with("  1. List all shop items")
      expect(io).to receive(:puts).with("  2. Create a new item")
      expect(io).to receive(:puts).with("  3. Restock item")
      expect(io).to receive(:puts).with("  4. List all orders")
      expect(io).to receive(:puts).with("  5. Create a new order")
      expect(io).to receive(:puts).with("  6. Find a customers full order by customers name")
      expect(io).to receive(:puts).with("  7. Find all orders including a specific item")
      expect(io).to receive(:puts).with("Enter your choice: ")
      expect(io).to receive(:gets).and_return("3\n")
      expect(io).to receive(:puts).with("Enter the name of the item you wish to restock: ")
      expect(io).to receive(:gets).and_return("bananas\n")
      expect(io).to receive(:puts).with("Enter the new quantity of the item: ")
      expect(io).to receive(:gets).and_return("50\n")
      expect(item_repository).to receive(:find).with("bananas").and_return(item)
      expect(item).to receive(:quantity=).with("50")
      expect(item_repository).to receive(:update_quantity).with(item)
      expect(io).to receive(:puts).with("Item successfully updated!")
      expect(io).to receive(:puts).with("All Items in stock: ")
      expect(io).to receive(:puts).with("  #1 Blueberries - Unit Price: £4 - Quantity: 30")
      expect(io).to receive(:puts).with("  #2 Raspberries - Unit Price: £5 - Quantity: 20")
      expect(io).to receive(:puts).with("  #3 Eggs - Unit Price: £2 - Quantity: 50")
      expect(io).to receive(:puts).with("  #4 Bananas - Unit Price: £2 - Quantity: 50")
      app.run
    end
  end

  context "full order by name" do
    it "returns the order and all items in the order" do
      io = double :io
      items_orders = double :items_orders, item_id: 1, order_id: 1
      items_orders2 = double :items_orders2, item_id: 2, order_id: 1
      item = double :item, name: "blueberries", unit_price: "4", quantity: "30", id: 1
      item2 = double :item, name: "raspberries", unit_price: "5", quantity: "20", id: 2
      items = [item, item2]
      order1 = double :order, customer_name: "Harry Styles", order_date: "2022-03-10", id: 1, items: items
      item_repository = double :item_repository
      order_repository = double :order_repository
      items_orders_repository = double :items_orders_repository
      app = Application.new('shop_manager_test', io, item_repository, order_repository, items_orders_repository)
      expect(io).to receive(:puts).with("Welcome to the shop management program!")
      expect(io).to receive(:puts).with("What do you want to do?")
      expect(io).to receive(:puts).with("  1. List all shop items")
      expect(io).to receive(:puts).with("  2. Create a new item")
      expect(io).to receive(:puts).with("  3. Restock item")
      expect(io).to receive(:puts).with("  4. List all orders")
      expect(io).to receive(:puts).with("  5. Create a new order")
      expect(io).to receive(:puts).with("  6. Find a customers full order by customers name")
      expect(io).to receive(:puts).with("  7. Find all orders including a specific item")
      expect(io).to receive(:puts).with("Enter your choice: ")
      expect(io).to receive(:gets).and_return("6\n")
      expect(io).to receive(:puts).with("Enter the customer name of the order you wish to find: ")
      expect(io).to receive(:gets).and_return("Harry Styles\n")
      allow(item_repository).to receive(:find_by_order).with("Harry Styles").and_return(order1)
      expect(io).to receive(:puts).with("Your order: ")
      expect(io).to receive(:puts).with("  Order - Customer Name: Harry Styles - Order Date: 2022-03-10")
      expect(io).to receive(:puts).with("     #1 - Blueberries")
      expect(io).to receive(:puts).with("     #2 - Raspberries")
      expect(io).to receive(:puts).with("          Total Price: £9")
      app.run
    end
  end
end
