require_relative '../app'

def reset_tables
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_challenge_test' })
  connection.exec(seed_sql)
end

describe Application do
  before(:each) do 
    reset_tables
  end

  context 'when 1 is inputted' do 
    it 'prints all shop items' do 
      terminal = double(:terminal)

      expect(terminal).to receive(:puts).with("\nWelcome to the shop management program!")
      expect(terminal).to receive(:puts).with("\nWhat would you like to do?")
      expect(terminal).to receive(:puts).with("  1 - list all shop items")
      expect(terminal).to receive(:puts).with("  2 - create a new item")
      expect(terminal).to receive(:puts).with("  3 - list all orders")
      expect(terminal).to receive(:puts).with("  4 - create a new order")
      expect(terminal).to receive(:puts).with("  9 - exit program")
      expect(terminal).to receive(:puts).with("\nEnter you choice:")
      expect(terminal).to receive(:gets).and_return('1')
      expect(terminal).to receive(:puts).with("\nHere is your list of shop items:")
      expect(terminal).to receive(:puts).with('#1 - sandwich - Unit Price - 2.99 - Quantity - 10')
      expect(terminal).to receive(:puts).with('#2 - bananas - Unit Price - 1.99 - Quantity - 15')
      expect(terminal).to receive(:puts).with('#3 - toilet roll - Unit Price - 3.00 - Quantity - 20')
      expect(terminal).to receive(:puts).with('#4 - crisps - Unit Price - 0.99 - Quantity - 15')
      expect(terminal).to receive(:puts).with('#5 - sausage roll - Unit Price - 1.50 - Quantity - 10')
      expect(terminal).to receive(:puts).with("\nWhat would you like to do?")
      expect(terminal).to receive(:puts).with("\nEnter you choice:")
      expect(terminal).to receive(:puts).with("  1 - list all shop items")
      expect(terminal).to receive(:puts).with("  2 - create a new item")
      expect(terminal).to receive(:puts).with("  3 - list all orders")
      expect(terminal).to receive(:puts).with("  4 - create a new order")
      expect(terminal).to receive(:puts).with("  9 - exit program")
      expect(terminal).to receive(:gets).and_return('9')
  

      application = Application.new('shop_challenge_test', terminal, OrderRepository.new, ShopItemRepository.new)
      application.run
    end
  end

  context 'when 2 is inputted' do 
    it 'creates a new item' do 
      terminal = double(:terminal)

      expect(terminal).to receive(:puts).with("\nWelcome to the shop management program!")
      expect(terminal).to receive(:puts).with("\nWhat would you like to do?")
      expect(terminal).to receive(:puts).with("  1 - list all shop items")
      expect(terminal).to receive(:puts).with("  2 - create a new item")
      expect(terminal).to receive(:puts).with("  3 - list all orders")
      expect(terminal).to receive(:puts).with("  4 - create a new order")
      expect(terminal).to receive(:puts).with("  9 - exit program")
      expect(terminal).to receive(:puts).with("\nEnter you choice:")
      expect(terminal).to receive(:gets).and_return('2')
      expect(terminal).to receive(:puts).with("\n Enter the name of the item:")
      expect(terminal).to receive(:gets).and_return('chocolate')
      expect(terminal).to receive(:puts).with("\n Enter the unit price of the item (format => 00.00):")
      expect(terminal).to receive(:gets).and_return('1.50')
      expect(terminal).to receive(:puts).with("\n Enter the quantity of stock:")
      expect(terminal).to receive(:gets).and_return('100')
      expect(terminal).to receive(:puts).with("\nWhat would you like to do?")
      expect(terminal).to receive(:puts).with("\nEnter you choice:")
      expect(terminal).to receive(:puts).with("  1 - list all shop items")
      expect(terminal).to receive(:puts).with("  2 - create a new item")
      expect(terminal).to receive(:puts).with("  3 - list all orders")
      expect(terminal).to receive(:puts).with("  4 - create a new order")
      expect(terminal).to receive(:puts).with("  9 - exit program")
      expect(terminal).to receive(:gets).and_return('9')
      
      shop_item_repo = ShopItemRepository.new
      application = Application.new('shop_challenge_test', terminal, OrderRepository.new, shop_item_repo)
      application.run

      expect(shop_item_repo.all.last.name).to eq('chocolate')
      expect(shop_item_repo.all.last.unit_price).to eq('1.50')
      expect(shop_item_repo.all.last.quantity).to eq('100')
    end
  end

  context 'when 3 is inputted' do 
    it 'returns all orders' do 
      terminal = double(:terminal)

      expect(terminal).to receive(:puts).with("\nWelcome to the shop management program!")
      expect(terminal).to receive(:puts).with("\nWhat would you like to do?")
      expect(terminal).to receive(:puts).with("  1 - list all shop items")
      expect(terminal).to receive(:puts).with("  2 - create a new item")
      expect(terminal).to receive(:puts).with("  3 - list all orders")
      expect(terminal).to receive(:puts).with("  4 - create a new order")
      expect(terminal).to receive(:puts).with("  9 - exit program")
      expect(terminal).to receive(:puts).with("\nEnter you choice:")
      expect(terminal).to receive(:gets).and_return('3')
      expect(terminal).to receive(:puts).with("\nHere is a list of your orders:")
      expect(terminal).to receive(:puts).with('#1 - Customer - David - Date Placed - 2022-11-08 - Items in order - sandwich, crisps, sausage roll')
      expect(terminal).to receive(:puts).with('#2 - Customer - Anna - Date Placed - 2022-11-10 - Items in order - bananas')
      expect(terminal).to receive(:puts).with('#3 - Customer - Jill - Date Placed - 2022-11-11 - Items in order - sandwich, toilet roll')
      expect(terminal).to receive(:puts).with("\nWhat would you like to do?")
      expect(terminal).to receive(:puts).with("\nEnter you choice:")
      expect(terminal).to receive(:puts).with("  1 - list all shop items")
      expect(terminal).to receive(:puts).with("  2 - create a new item")
      expect(terminal).to receive(:puts).with("  3 - list all orders")
      expect(terminal).to receive(:puts).with("  4 - create a new order")
      expect(terminal).to receive(:puts).with("  9 - exit program")
      expect(terminal).to receive(:gets).and_return('9')
      
      application = Application.new('shop_challenge_test', terminal, OrderRepository.new, ShopItemRepository.new)
      application.run
    end
  end

  context 'when 4 is inputted' do 
    it 'creates a new order' do 
      terminal = double(:terminal)

      expect(terminal).to receive(:puts).with("\nWelcome to the shop management program!")
      expect(terminal).to receive(:puts).with("\nWhat would you like to do?")
      expect(terminal).to receive(:puts).with("  1 - list all shop items")
      expect(terminal).to receive(:puts).with("  2 - create a new item")
      expect(terminal).to receive(:puts).with("  3 - list all orders")
      expect(terminal).to receive(:puts).with("  4 - create a new order")
      expect(terminal).to receive(:puts).with("  9 - exit program")
      expect(terminal).to receive(:puts).with("\nEnter you choice:")
      expect(terminal).to receive(:gets).and_return('4')
      expect(terminal).to receive(:puts).with("\n Enter the name of the customer that placed the order:")
      expect(terminal).to receive(:gets).and_return('Kayleigh')
      expect(terminal).to receive(:puts).with("\n Enter the date that order was placed (format => YYYY-MM-DD):")
      expect(terminal).to receive(:gets).and_return('2022-11-24')
      expect(terminal).to receive(:puts).with('What items were added to this order? Enter "done" when you are done')
      expect(terminal).to receive(:gets).and_return('sandwich')
      expect(terminal).to receive(:puts).with('What items were added to this order? Enter "done" when you are done')
      expect(terminal).to receive(:gets).and_return('bananas')
      expect(terminal).to receive(:puts).with('What items were added to this order? Enter "done" when you are done')
      expect(terminal).to receive(:gets).and_return('done')
      expect(terminal).to receive(:puts).with("\nWhat would you like to do?")
      expect(terminal).to receive(:puts).with("  1 - list all shop items")
      expect(terminal).to receive(:puts).with("  2 - create a new item")
      expect(terminal).to receive(:puts).with("  3 - list all orders")
      expect(terminal).to receive(:puts).with("  4 - create a new order")
      expect(terminal).to receive(:puts).with("  9 - exit program")
      expect(terminal).to receive(:puts).with("\nEnter you choice:")
      expect(terminal).to receive(:gets).and_return('3')
      expect(terminal).to receive(:puts).with("\nHere is a list of your orders:")
      expect(terminal).to receive(:puts).with('#1 - Customer - David - Date Placed - 2022-11-08 - Items in order - crisps, sausage roll, sandwich')
      expect(terminal).to receive(:puts).with('#2 - Customer - Anna - Date Placed - 2022-11-10 - Items in order - bananas')
      expect(terminal).to receive(:puts).with('#3 - Customer - Jill - Date Placed - 2022-11-11 - Items in order - toilet roll, sandwich')
      expect(terminal).to receive(:puts).with('#4 - Customer - Kayleigh - Date Placed - 2022-11-24 - Items in order - sandwich, bananas')
      expect(terminal).to receive(:puts).with("\nWhat would you like to do?")
      expect(terminal).to receive(:puts).with("  1 - list all shop items")
      expect(terminal).to receive(:puts).with("  2 - create a new item")
      expect(terminal).to receive(:puts).with("  3 - list all orders")
      expect(terminal).to receive(:puts).with("  4 - create a new order")
      expect(terminal).to receive(:puts).with("  9 - exit program")
      expect(terminal).to receive(:puts).with("\nEnter you choice:")
      expect(terminal).to receive(:gets).and_return('9')
      
      order_repo = OrderRepository.new
      application = Application.new('shop_challenge_test', terminal, order_repo, ShopItemRepository.new)
      application.run

      expect(order_repo.all.last.customer_name).to eq('Kayleigh')
      expect(order_repo.all.last.date_placed).to eq('2022-11-24')
    end

    it 'decreases the quantity of stock for each item that is added to the order' do 
      item_repo = ShopItemRepository.new 
      expect(item_repo.all.last.quantity).to eq('10')

      terminal = double(:terminal)

      expect(terminal).to receive(:puts).with("\nWelcome to the shop management program!")
      expect(terminal).to receive(:puts).with("\nWhat would you like to do?")
      expect(terminal).to receive(:puts).with("  1 - list all shop items")
      expect(terminal).to receive(:puts).with("  2 - create a new item")
      expect(terminal).to receive(:puts).with("  3 - list all orders")
      expect(terminal).to receive(:puts).with("  4 - create a new order")
      expect(terminal).to receive(:puts).with("  9 - exit program")
      expect(terminal).to receive(:puts).with("\nEnter you choice:")
      expect(terminal).to receive(:gets).and_return('4')
      expect(terminal).to receive(:puts).with("\n Enter the name of the customer that placed the order:")
      expect(terminal).to receive(:gets).and_return('Kayleigh')
      expect(terminal).to receive(:puts).with("\n Enter the date that order was placed (format => YYYY-MM-DD):")
      expect(terminal).to receive(:gets).and_return('2022-11-24')
      expect(terminal).to receive(:puts).with('What items were added to this order? Enter "done" when you are done')
      expect(terminal).to receive(:gets).and_return('sandwich')
      expect(terminal).to receive(:puts).with('What items were added to this order? Enter "done" when you are done')
      expect(terminal).to receive(:gets).and_return('done')
      expect(terminal).to receive(:puts).with("\nWhat would you like to do?")
      expect(terminal).to receive(:puts).with("  1 - list all shop items")
      expect(terminal).to receive(:puts).with("  2 - create a new item")
      expect(terminal).to receive(:puts).with("  3 - list all orders")
      expect(terminal).to receive(:puts).with("  4 - create a new order")
      expect(terminal).to receive(:puts).with("  9 - exit program")
      expect(terminal).to receive(:puts).with("\nEnter you choice:")
      expect(terminal).to receive(:gets).and_return('9')

      application = Application.new('shop_challenge_test', terminal, OrderRepository.new, ShopItemRepository.new)
      application.run

      expect(item_repo.all.last.quantity).to eq('9')
    end
  end

  context 'when 1-4 isnt inputted' do 
    it 'putses invalid input when input is not valid' do 
      terminal = double(:terminal)
      expect(terminal).to receive(:puts).with("\nWelcome to the shop management program!")
      expect(terminal).to receive(:puts).with("\nWhat would you like to do?")
      expect(terminal).to receive(:puts).with("  1 - list all shop items")
      expect(terminal).to receive(:puts).with("  2 - create a new item")
      expect(terminal).to receive(:puts).with("  3 - list all orders")
      expect(terminal).to receive(:puts).with("  4 - create a new order")
      expect(terminal).to receive(:puts).with("  9 - exit program")
      expect(terminal).to receive(:puts).with("\nEnter you choice:")
      expect(terminal).to receive(:gets).and_return('8')
      expect(terminal).to receive(:puts).with("\nInvalid Input\n")
      expect(terminal).to receive(:puts).with("\nWhat would you like to do?")
      expect(terminal).to receive(:puts).with("\nEnter you choice:")
      expect(terminal).to receive(:puts).with("  1 - list all shop items")
      expect(terminal).to receive(:puts).with("  2 - create a new item")
      expect(terminal).to receive(:puts).with("  3 - list all orders")
      expect(terminal).to receive(:puts).with("  4 - create a new order")
      expect(terminal).to receive(:puts).with("  9 - exit program")
      expect(terminal).to receive(:gets).and_return('9')

      application = Application.new('shop_challenge_test', terminal, OrderRepository.new, ShopItemRepository.new)
      application.run
    end
  end
end