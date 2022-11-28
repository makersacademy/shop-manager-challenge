require_relative '../app'
require 'order_repository'

def reset_tables
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_database_test' })
  connection.exec(seed_sql)
end
  

describe Application do

  before(:each) do 
    reset_tables
  end

  it 'returns all shop items ' do
    terminal = double :terminal
    expect(terminal).to receive(:puts).with('Welcome to the shop management program!').ordered
    expect(terminal).to receive(:puts).with('__Main Menu__
    ').ordered
    expect(terminal).to receive(:puts).with('Please select an option').ordered
    expect(terminal).to receive(:puts).with('1 - list all shop items').ordered
    expect(terminal).to receive(:puts).with('2 - create a new item').ordered
    expect(terminal).to receive(:puts).with('3 - list all orders').ordered
    expect(terminal).to receive(:puts).with('4 - create a new order').ordered
    expect(terminal).to receive(:puts).with('5 - exit').ordered
    expect(terminal).to receive(:puts).with('Enter your choice:').ordered
    expect(terminal).to receive(:gets).and_return('1').ordered
    expect(terminal).to receive(:puts).with('_Item Menu_
    ').ordered
    expect(terminal).to receive(:puts).with('1 - Name: Semi Skimmed Milk: 2 Pints - Unit Price: £1.30 - Quantity: 30').ordered
    expect(terminal).to receive(:puts).with('2 - Name: Cathedral City Mature Cheddar: 550G - Unit Price: £5.25 - Quantity: 15').ordered
    expect(terminal).to receive(:puts).with('3 - Name: Hovis Soft White Medium Bread: 800G - Unit Price: £1.40 - Quantity: 10').ordered
    expect(terminal).to receive(:puts).with('4 - Name: Nestle Shreddies The Original Cereal 630G - Unit Price: £0.52 - Quantity: 8').ordered
    expect(terminal).to receive(:puts).with('5 - Name: Walkers Baked Cheese & Onion 37.5G - Unit Price: £2.40 - Quantity: 80').ordered
    
    application = Application.new('shop_database_test', terminal, ItemRepository.new, OrderRepository.new)
    application.run
  end 

  it 'Creates a new item' do
    terminal = double :terminal
    expect(terminal).to receive(:puts).with('Welcome to the shop management program!').ordered
    expect(terminal).to receive(:puts).with('__Main Menu__
    ').ordered
    expect(terminal).to receive(:puts).with('Please select an option').ordered
    expect(terminal).to receive(:puts).with('1 - list all shop items').ordered
    expect(terminal).to receive(:puts).with('2 - create a new item').ordered
    expect(terminal).to receive(:puts).with('3 - list all orders').ordered
    expect(terminal).to receive(:puts).with('4 - create a new order').ordered
    expect(terminal).to receive(:puts).with('5 - exit').ordered
    expect(terminal).to receive(:puts).with('Enter your choice:').ordered
    expect(terminal).to receive(:gets).and_return('2').ordered
    expect(terminal).to receive(:puts).with("Please enter item name").ordered
    expect(terminal).to receive(:gets).and_return('Fusilli Pasta Twists 1Kg').ordered
    expect(terminal).to receive(:puts).with("Now enter unit price in as a 3 digit number in the format '£.pp' - e.g. 2.35").ordered
    expect(terminal).to receive(:gets).and_return('1.65').ordered
    expect(terminal).to receive(:puts).with("Please enter current stock as a number").ordered
    expect(terminal).to receive(:gets).and_return('10').ordered
    expect(terminal).to receive(:puts).with("New item created!").ordered

    application = Application.new('shop_database_test', terminal, ItemRepository.new, OrderRepository.new)
    application.run
  end 

  it 'returns all shop orders ' do
    terminal = double :terminal
    expect(terminal).to receive(:puts).with('Welcome to the shop management program!').ordered
    expect(terminal).to receive(:puts).with('__Main Menu__
    ').ordered
    expect(terminal).to receive(:puts).with('Please select an option').ordered
    expect(terminal).to receive(:puts).with('1 - list all shop items').ordered
    expect(terminal).to receive(:puts).with('2 - create a new item').ordered
    expect(terminal).to receive(:puts).with('3 - list all orders').ordered
    expect(terminal).to receive(:puts).with('4 - create a new order').ordered
    expect(terminal).to receive(:puts).with('5 - exit').ordered
    expect(terminal).to receive(:puts).with('Enter your choice:').ordered
    expect(terminal).to receive(:gets).and_return('3').ordered
    expect(terminal).to receive(:puts).with('Here are all currently stored shop orders').ordered
    expect(terminal).to receive(:puts).with(
      "1 - Customer name: Joe Bloggs - Date: 2022-11-21 - Items: Nestle Shreddies The Original Cereal 630G, Hovis Soft White Medium Bread: 800G, Cathedral City Mature Cheddar: 550G").ordered
    expect(terminal).to receive(:puts).with(
      "2 - Customer name: Mrs Miggins - Date: 2022-11-23 - Items: Walkers Baked Cheese & Onion 37.5G, Semi Skimmed Milk: 2 Pints").ordered
    expect(terminal).to receive(:puts).with(
      "3 - Customer name: Jane Appleseed - Date: 2022-11-17 - Items: Semi Skimmed Milk: 2 Pints").ordered
    
    application = Application.new('shop_database_test', terminal, ItemRepository.new, OrderRepository.new)
    application.run
  end 

  it 'creates a new order' do
    terminal = double :terminal

    # Main Menu
    expect(terminal).to receive(:puts).with('Welcome to the shop management program!').ordered
    expect(terminal).to receive(:puts).with('__Main Menu__
    ').ordered
    expect(terminal).to receive(:puts).with('Please select an option').ordered
    expect(terminal).to receive(:puts).with('1 - list all shop items').ordered
    expect(terminal).to receive(:puts).with('2 - create a new item').ordered
    expect(terminal).to receive(:puts).with('3 - list all orders').ordered
    expect(terminal).to receive(:puts).with('4 - create a new order').ordered
    expect(terminal).to receive(:puts).with('5 - exit').ordered
    expect(terminal).to receive(:puts).with('Enter your choice:').ordered
    expect(terminal).to receive(:gets).and_return('4').ordered

    # New Order Process
    expect(terminal).to receive(:puts).with('Now creating a new order').ordered
    expect(terminal).to receive(:puts).with('Please enter the customer name').ordered
    expect(terminal).to receive(:gets).and_return('test_name').ordered
    expect(terminal).to receive(:puts).with("Please enter the date the order was placed in the format DD-MMM-YYY - e.g.: 01-Jan-2022").ordered
    expect(terminal).to receive(:gets).and_return('27-Nov-2022').ordered

    # Displaying items to add to order

    expect(terminal).to receive(:puts).with('_Item Menu_
    ').ordered
    expect(terminal).to receive(:puts).with('1 - Name: Semi Skimmed Milk: 2 Pints - Unit Price: £1.30 - Quantity: 30').ordered
    expect(terminal).to receive(:puts).with('2 - Name: Cathedral City Mature Cheddar: 550G - Unit Price: £5.25 - Quantity: 15').ordered
    expect(terminal).to receive(:puts).with('3 - Name: Hovis Soft White Medium Bread: 800G - Unit Price: £1.40 - Quantity: 10').ordered
    expect(terminal).to receive(:puts).with('4 - Name: Nestle Shreddies The Original Cereal 630G - Unit Price: £0.52 - Quantity: 8').ordered
    expect(terminal).to receive(:puts).with('5 - Name: Walkers Baked Cheese & Onion 37.5G - Unit Price: £2.40 - Quantity: 80').ordered
    
    # Adding item

    expect(terminal).to receive(:puts).with("Please select the number of the item you would like to order from the item menu").ordered
    expect(terminal).to receive(:gets).and_return('3').ordered
    expect(terminal).to receive(:puts).with("New order created!").ordered

    repo = OrderRepository.new 
    application = Application.new('shop_database_test', terminal, ItemRepository.new, OrderRepository.new)
    application.run

    expect(repo.all.last.customer_name).to eq('test_name')
    expect(repo.all.last.date).to eq('2022-11-27')
  end 

  it 'exits the programme for the options menu' do 

    terminal = double :terminal

    expect(terminal).to receive(:puts).with('Welcome to the shop management program!').ordered
    expect(terminal).to receive(:puts).with('__Main Menu__
    ').ordered
    expect(terminal).to receive(:puts).with('Please select an option').ordered
    expect(terminal).to receive(:puts).with('1 - list all shop items').ordered
    expect(terminal).to receive(:puts).with('2 - create a new item').ordered
    expect(terminal).to receive(:puts).with('3 - list all orders').ordered
    expect(terminal).to receive(:puts).with('4 - create a new order').ordered
    expect(terminal).to receive(:puts).with('5 - exit').ordered
    expect(terminal).to receive(:puts).with('Enter your choice:').ordered
    expect(terminal).to receive(:gets).and_return('5').ordered
    expect(terminal).to receive(:puts).with('Goodbye!').ordered

    application = Application.new('shop_database_test', terminal, ItemRepository.new, OrderRepository.new)
    application.run

    close_programme = application.process(5)

    expect { close_programme }.to raise_error SystemExit

  end 

  it 'recieves an invalid menu input' do 

 
    terminal = double :terminal

 
    expect(terminal).to receive(:puts).with('Welcome to the shop management program!').ordered
    expect(terminal).to receive(:puts).with('__Main Menu__
    ').ordered
    expect(terminal).to receive(:puts).with('Please select an option').ordered
    expect(terminal).to receive(:puts).with('1 - list all shop items').ordered
    expect(terminal).to receive(:puts).with('2 - create a new item').ordered
    expect(terminal).to receive(:puts).with('3 - list all orders').ordered
    expect(terminal).to receive(:puts).with('4 - create a new order').ordered
    expect(terminal).to receive(:puts).with('5 - exit').ordered
    expect(terminal).to receive(:puts).with('Enter your choice:').ordered
    expect(terminal).to receive(:gets).and_return('7').ordered
    expect(terminal).to receive(:puts).with('Input not recognised, please select a valid number').ordered
    expect(terminal).to receive(:puts).with('__Main Menu__
      ').ordered
    expect(terminal).to receive(:puts).with('Please select an option').ordered
    expect(terminal).to receive(:puts).with('1 - list all shop items').ordered
    expect(terminal).to receive(:puts).with('2 - create a new item').ordered
    expect(terminal).to receive(:puts).with('3 - list all orders').ordered
    expect(terminal).to receive(:puts).with('4 - create a new order').ordered
    expect(terminal).to receive(:puts).with('5 - exit').ordered
    expect(terminal).to receive(:puts).with('Enter your choice:').ordered

    application = Application.new('shop_database_test', terminal, ItemRepository.new, OrderRepository.new)
    application.run

    close_programme = application.process(5)

    expect { close_programme }.to raise_error SystemExit

  end 

end 
