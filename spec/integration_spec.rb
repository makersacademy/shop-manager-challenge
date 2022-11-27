require 'order_repository'
require 'item_repository'
require 'order'

describe OrderRepository do
  def reset_items_table
    seed_sql = File.read('spec/seeds_items.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'orders_items_test' })
    connection.exec(seed_sql)
  end

  def reset_orders_table
    seed_sql = File.read('spec/seeds_orders.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'orders_items_test' })
    connection.exec(seed_sql)
  end

  def reset_orders_items_table
    seed_sql = File.read('spec/seeds_orders_items.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'orders_items_test' })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_items_table
    reset_orders_table
    reset_orders_items_table
  end

  context 'create method' do
    it 'updates the quantity of items in the data base' do
      order_repo = OrderRepository.new
      item_repo = ItemRepository.new
      order = Order.new
      order.customer_name = 'Iii Jjj'
      order.date_placed = '2022-11-24'
      order_repo.create(order,5,1)
      all_items = item_repo.all
      updated_item = all_items.first
      expect(updated_item.id).to eq '1'
      expect(updated_item.quantity).to eq '95'
    end
  end
end

describe Application do
  def reset_items_table
    seed_sql = File.read('spec/seeds_items.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'orders_items_test' })
    connection.exec(seed_sql)
  end

  def reset_orders_table
    seed_sql = File.read('spec/seeds_orders.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'orders_items_test' })
    connection.exec(seed_sql)
  end

  def reset_orders_items_table
    seed_sql = File.read('spec/seeds_orders_items.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'orders_items_test' })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_items_table
    reset_orders_table
    reset_orders_items_table
  end
  context 'using the interactive menu' do
    it 'lets you print all items' do
      order_repo = OrderRepository.new
      item_repo = ItemRepository.new
      expect(Kernel).to receive(:puts).with("1 - Socks - £2.75 - Quantity: 100")
      expect(Kernel).to receive(:puts).with("2 - T-shirts - £10.00 - Quantity: 50")
      expect(Kernel).to receive(:puts).with('3 - Trousers - £18.50 - Quantity: 80')
      expect(Kernel).to receive(:puts).with('4 - Shoes - £45.00 - Quantity: 30')
      app = Application.new('orders_items_test', Kernel, item_repo, order_repo)
      app.list_items
    end

    it 'lets you print all orders' do
      order_repo = OrderRepository.new
      item_repo = ItemRepository.new
      expect(Kernel).to receive(:puts).with("1 - Name: Aaa Bbb - Date: 2022-11-21 - Items: Socks, Trousers")
      expect(Kernel).to receive(:puts).with("2 - Name: Ccc Ddd - Date: 2022-10-17 - Items: T-shirts, Trousers")
      expect(Kernel).to receive(:puts).with('3 - Name: Eee Fff - Date: 1994-03-16 - Items: Socks, T-shirts, Trousers, Shoes')
      app = Application.new('orders_items_test', Kernel, item_repo, order_repo)
      app.list_orders
    end
    
    it "lets you create an order through terminal selection" do
      io = double :io
      order_repo = OrderRepository.new
      item_repo = ItemRepository.new
      expect(io).to receive(:puts).with("Please enter your name")
      expect(io).to receive(:gets).and_return('Jude')
      expect(io).to receive(:puts).with("Please enter the name of the item you would like")
      expect(io).to receive(:gets).and_return('Socks')
      expect(io).to receive(:puts).with("How many would you like?")
      expect(io).to receive(:gets).and_return('2')
      expect(io).to receive(:puts).with("Would you like to add anything else to your order? y/n")
      expect(io).to receive(:gets).and_return('n')
      app = Application.new('orders_items_test', io, item_repo, order_repo)
      app.create_order
    end

    it "lets you create an item through terminal selection" do
      io = double :io
      order_repo = OrderRepository.new
      item_repo = ItemRepository.new
      expect(io).to receive(:puts).with("What is the name of the item?")
      expect(io).to receive(:gets).and_return('Ties')
      expect(io).to receive(:puts).with("Please enter the unit price")
      expect(io).to receive(:gets).and_return('4.50')
      expect(io).to receive(:puts).with("How many do you have in stock?")
      expect(io).to receive(:gets).and_return('80')
      app = Application.new('orders_items_test', io, item_repo, order_repo)
      app.create_item
    end

    it "create an item through terminal selection testing dodgy inputs" do
      io = double :io
      order_repo = OrderRepository.new
      item_repo = ItemRepository.new
      expect(io).to receive(:puts).twice.with("What is the name of the item?")
      expect(io).to receive(:gets).and_return('')
      expect(io).to receive(:gets).and_return('Ties')
      expect(io).to receive(:puts).twice.with("Please enter the unit price")
      expect(io).to receive(:gets).and_return('kjhgjhgjfg')
      expect(io).to receive(:gets).and_return('4.50')
      expect(io).to receive(:puts).twice.with("How many do you have in stock?")
      expect(io).to receive(:gets).and_return('hjgfjhgfj')
      expect(io).to receive(:gets).and_return('80')
      app = Application.new('orders_items_test', io, item_repo, order_repo)
      app.create_item
    end

    it 'welcomes and prints all items' do
      io = double :io
      order_repo = OrderRepository.new
      item_repo = ItemRepository.new
      expect(io).to receive(:puts).with("Welcome to the shop management program!\n")
      expect(io).to receive(:puts).with("What would you like to do?")
      expect(io).to receive(:puts).with(' 1 - List all shop items')
      expect(io).to receive(:puts).with(' 2 - Create a new item')
      expect(io).to receive(:puts).with(' 3 - List all orders')
      expect(io).to receive(:puts).with(' 4 - Create a new order')
      expect(io).to receive(:puts).with(' 9 - Exit')
      expect(io).to receive(:gets).and_return('1')
      expect(io).to receive(:puts).with("1 - Socks - £2.75 - Quantity: 100")
      expect(io).to receive(:puts).with("2 - T-shirts - £10.00 - Quantity: 50")
      expect(io).to receive(:puts).with('3 - Trousers - £18.50 - Quantity: 80')
      expect(io).to receive(:puts).with('4 - Shoes - £45.00 - Quantity: 30')
      app = Application.new('orders_items_test', io, item_repo, order_repo)
      app.run
    end

    it 'welcomes and prints all orders' do
      io = double :io
      order_repo = OrderRepository.new
      item_repo = ItemRepository.new
      expect(io).to receive(:puts).with("Welcome to the shop management program!\n")
      expect(io).to receive(:puts).with("What would you like to do?")
      expect(io).to receive(:puts).with(' 1 - List all shop items')
      expect(io).to receive(:puts).with(' 2 - Create a new item')
      expect(io).to receive(:puts).with(' 3 - List all orders')
      expect(io).to receive(:puts).with(' 4 - Create a new order')
      expect(io).to receive(:puts).with(' 9 - Exit')
      expect(io).to receive(:gets).and_return('3')
      expect(io).to receive(:puts).with("1 - Name: Aaa Bbb - Date: 2022-11-21 - Items: Socks, Trousers")
      expect(io).to receive(:puts).with("2 - Name: Ccc Ddd - Date: 2022-10-17 - Items: T-shirts, Trousers")
      expect(io).to receive(:puts).with('3 - Name: Eee Fff - Date: 1994-03-16 - Items: Socks, T-shirts, Trousers, Shoes')
      app = Application.new('orders_items_test', io, item_repo, order_repo)
      app.run
    end

    it 'welcomes and creates an order' do
      io = double :io
      order_repo = OrderRepository.new
      item_repo = ItemRepository.new
      expect(io).to receive(:puts).with("Welcome to the shop management program!\n")
      expect(io).to receive(:puts).with("What would you like to do?")
      expect(io).to receive(:puts).with(' 1 - List all shop items')
      expect(io).to receive(:puts).with(' 2 - Create a new item')
      expect(io).to receive(:puts).with(' 3 - List all orders')
      expect(io).to receive(:puts).with(' 4 - Create a new order')
      expect(io).to receive(:puts).with(' 9 - Exit')
      expect(io).to receive(:gets).and_return('4')
      expect(io).to receive(:puts).with("Please enter your name")
      expect(io).to receive(:gets).and_return('Jude')
      expect(io).to receive(:puts).with("Please enter the name of the item you would like")
      expect(io).to receive(:gets).and_return('Socks')
      expect(io).to receive(:puts).with("How many would you like?")
      expect(io).to receive(:gets).and_return('2')
      expect(io).to receive(:puts).with("Would you like to add anything else to your order? y/n")
      expect(io).to receive(:gets).and_return('n')
      app = Application.new('orders_items_test', io, item_repo, order_repo)
      app.run
      last_order = order_repo.all.last
      expect(last_order.customer_name).to eq 'Jude'
      expect(last_order.date_placed).to eq Date.today.to_s
    end

    it 'welcomes and creates an order with multiple items' do
      io = double :io
      order_repo = OrderRepository.new
      item_repo = ItemRepository.new
      expect(io).to receive(:puts).with("Welcome to the shop management program!\n")
      expect(io).to receive(:puts).with("What would you like to do?")
      expect(io).to receive(:puts).with(' 1 - List all shop items')
      expect(io).to receive(:puts).with(' 2 - Create a new item')
      expect(io).to receive(:puts).with(' 3 - List all orders')
      expect(io).to receive(:puts).with(' 4 - Create a new order')
      expect(io).to receive(:puts).with(' 9 - Exit')
      expect(io).to receive(:gets).and_return('4')
      expect(io).to receive(:puts).with("Please enter your name")
      expect(io).to receive(:gets).and_return('Jude')
      expect(io).to receive(:puts).twice.with("Please enter the name of the item you would like")
      expect(io).to receive(:gets).and_return('Socks')
      expect(io).to receive(:puts).twice.with("How many would you like?")
      expect(io).to receive(:gets).and_return('2')
      expect(io).to receive(:puts).with("Would you like to add anything else to your order? y/n")
      expect(io).to receive(:gets).and_return('y')
      expect(io).to receive(:gets).and_return('Shoes')
      expect(io).to receive(:gets).and_return('4')
      expect(io).to receive(:puts).with("Would you like to add anything else to your order? y/n")
      expect(io).to receive(:gets).and_return('n')
      app = Application.new('orders_items_test', io, item_repo, order_repo)
      app.run
      last_order = order_repo.all.last
      expect(last_order.customer_name).to eq 'Jude'
      expect(last_order.date_placed).to eq Date.today.to_s
    end

    it 'creates an order with multiple items, testing for dodgy input' do
      io = double :io
      order_repo = OrderRepository.new
      item_repo = ItemRepository.new
      expect(io).to receive(:puts).with("Welcome to the shop management program!\n")
      expect(io).to receive(:puts).with("What would you like to do?")
      expect(io).to receive(:puts).with(' 1 - List all shop items')
      expect(io).to receive(:puts).with(' 2 - Create a new item')
      expect(io).to receive(:puts).with(' 3 - List all orders')
      expect(io).to receive(:puts).with(' 4 - Create a new order')
      expect(io).to receive(:puts).with(' 9 - Exit')
      expect(io).to receive(:gets).and_return('4')
      expect(io).to receive(:puts).with("Please enter your name")
      expect(io).to receive(:gets).and_return('')
      expect(io).to receive(:puts).with("Please enter your name")
      expect(io).to receive(:gets).and_return('2398756324987568934')
      expect(io).to receive(:puts).with("Please enter your name")
      expect(io).to receive(:gets).and_return('Jude')
      expect(io).to receive(:puts).thrice.with("Please enter the name of the item you would like")
      expect(io).to receive(:gets).and_return('Socks')
      expect(io).to receive(:puts).twice.with("How many would you like?")
      expect(io).to receive(:gets).and_return('2')
      expect(io).to receive(:puts).with("Would you like to add anything else to your order? y/n")
      expect(io).to receive(:gets).and_return('sdfgaksdjgfaksgf')
      expect(io).to receive(:puts).with("Would you like to add anything else to your order? y/n")
      expect(io).to receive(:gets).and_return('y')
      expect(io).to receive(:gets).and_return('wkfgalsdjflsgf')
      expect(io).to receive(:gets).and_return('Shoes')
      expect(io).to receive(:gets).and_return('4')
      expect(io).to receive(:puts).with("Would you like to add anything else to your order? y/n")
      expect(io).to receive(:gets).and_return('n')
      app = Application.new('orders_items_test', io, item_repo, order_repo)
      app.run
      last_order = order_repo.all.last
      expect(last_order.customer_name).to eq 'Jude'
      expect(last_order.date_placed).to eq Date.today.to_s
    end

    it 'welcomes and creates an item' do
      io = double :io
      order_repo = OrderRepository.new
      item_repo = ItemRepository.new
      expect(io).to receive(:puts).with("Welcome to the shop management program!\n")
      expect(io).to receive(:puts).with("What would you like to do?")
      expect(io).to receive(:puts).with(' 1 - List all shop items')
      expect(io).to receive(:puts).with(' 2 - Create a new item')
      expect(io).to receive(:puts).with(' 3 - List all orders')
      expect(io).to receive(:puts).with(' 4 - Create a new order')
      expect(io).to receive(:puts).with(' 9 - Exit')
      expect(io).to receive(:gets).and_return('2')
      expect(io).to receive(:puts).with("What is the name of the item?")
      expect(io).to receive(:gets).and_return('Ties')
      expect(io).to receive(:puts).with("Please enter the unit price")
      expect(io).to receive(:gets).and_return('3.99')
      expect(io).to receive(:puts).with("How many do you have in stock?")
      expect(io).to receive(:gets).and_return('55')
      app = Application.new('orders_items_test', io, item_repo, order_repo)
      app.run
      last_item = item_repo.all.last
      expect(last_item.name).to eq 'Ties'
      expect(last_item.unit_price).to eq '3.99'
      expect(last_item.quantity).to eq '55'
    end
  end
end
