require_relative '../app'
require 'date'

RSpec.describe Application do

  xit 'displays welcome message and displays menu' do
    terminal = double :terminal
    expect(terminal).to receive(:puts).with('Welcome to the shop management program!')
    expect(terminal).to receive(:puts).with('What would you like to do?')
    expect(terminal).to receive(:puts).with('1 - list all shop items')
    expect(terminal).to receive(:puts).with('2 - create a new item')
    expect(terminal).to receive(:puts).with('3 - list all orders')
    expect(terminal).to receive(:puts).with('4 - create a new order')
    expect(terminal).to receive(:puts).with('5 - exit')
    expect(terminal).to receive(:puts).with('Enter your choice:')
    application = Application.new('shop_database_test', terminal, ItemRepository.new, OrderRepository.new)
    application.run

  end 

  xit 'returns all shop items ' do
    terminal = double :terminal
    expect(terminal).to receive(:puts).with('Welcome to the shop management program!')
    expect(terminal).to receive(:puts).with('What would you like to do?')
    expect(terminal).to receive(:puts).with('1 - list all shop items')
    expect(terminal).to receive(:puts).with('2 - create a new item')
    expect(terminal).to receive(:puts).with('3 - list all orders')
    expect(terminal).to receive(:puts).with('4 - create a new order')
    expect(terminal).to receive(:puts).with('5 - exit')
    expect(terminal).to receive(:puts).with('Enter your choice:')
    expect(terminal).to receive(:gets).and_return('1')
    expect(terminal).to receive(:puts).with('Here are all currently stored shop items')
    expect(terminal).to receive(:puts).with('1 - Name: Semi Skimmed Milk: 2 Pints - Unit Price: £1.30 - Quantity: 30')
    expect(terminal).to receive(:puts).with('2 - Name: Cathedral City Mature Cheddar: 550G - Unit Price: £5.25 - Quantity: 15')
    expect(terminal).to receive(:puts).with('3 - Name: Hovis Soft White Medium Bread: 800G - Unit Price: £1.40 - Quantity: 10')
    expect(terminal).to receive(:puts).with('4 - Name: Nestle Shreddies The Original Cereal 630G - Unit Price: £0.52 - Quantity: 8')
    expect(terminal).to receive(:puts).with('5 - Name: Walkers Baked Cheese & Onion 37.5G - Unit Price: £2.40 - Quantity: 80')
    
    application = Application.new('shop_database_test', terminal, ItemRepository.new, OrderRepository.new)
    application.run
  end 

  it 'Creates a new item' do
    terminal = double :terminal
    expect(terminal).to receive(:puts).with('Welcome to the shop management program!')
    expect(terminal).to receive(:puts).with('What would you like to do?')
    expect(terminal).to receive(:puts).with('1 - list all shop items')
    expect(terminal).to receive(:puts).with('2 - create a new item')
    expect(terminal).to receive(:puts).with('3 - list all orders')
    expect(terminal).to receive(:puts).with('4 - create a new order')
    expect(terminal).to receive(:puts).with('5 - exit')
    expect(terminal).to receive(:puts).with('Enter your choice:')
    expect(terminal).to receive(:gets).and_return('2')
    expect(terminal).to receive(:puts).with("Please enter item name")
    expect(terminal).to receive(:gets).and_return('Fusilli Pasta Twists 1Kg')
    expect(terminal).to receive(:puts).with("Now enter unit price in as a 3 digit number in the format '£.pp' - e.g. 2.35")
    expect(terminal).to receive(:gets).and_return('1.65')
    expect(terminal).to receive(:puts).with("Please enter current stock as a number")
    expect(terminal).to receive(:gets).and_return('10')
    expect(terminal).to receive(:puts).with("New item created!")

    application = Application.new('shop_database_test', terminal, ItemRepository.new, OrderRepository.new)
    application.run
  end 

  xit 'returns all shop orders ' do
    terminal = double :terminal
    expect(terminal).to receive(:puts).with('Welcome to the shop management program!')
    expect(terminal).to receive(:puts).with('What would you like to do?')
    expect(terminal).to receive(:puts).with('1 - list all shop items')
    expect(terminal).to receive(:puts).with('2 - create a new item')
    expect(terminal).to receive(:puts).with('3 - list all orders')
    expect(terminal).to receive(:puts).with('4 - create a new order')
    expect(terminal).to receive(:puts).with('5 - exit')
    expect(terminal).to receive(:puts).with('Enter your choice:')
    expect(terminal).to receive(:gets).and_return('3')
    expect(terminal).to receive(:puts).with('Here are all currently stored shop orders')
    expect(terminal).to receive(:puts).with('1 - Name: Semi Skimmed Milk: 2 Pints - Unit Price: £1.30 - Quantity: 30')
    expect(terminal).to receive(:puts).with('2 - Name: Cathedral City Mature Cheddar: 550G - Unit Price: £5.25 - Quantity: 15')
    expect(terminal).to receive(:puts).with('3 - Name: Hovis Soft White Medium Bread: 800G - Unit Price: £1.40 - Quantity: 10')
    expect(terminal).to receive(:puts).with('4 - Name: Nestle Shreddies The Original Cereal 630G - Unit Price: £0.52 - Quantity: 8')
    expect(terminal).to receive(:puts).with('5 - Name: Walkers Baked Cheese & Onion 37.5G - Unit Price: £2.40 - Quantity: 80')
    
    application = Application.new('shop_database_test', terminal, ItemRepository.new, OrderRepository.new)
    application.run
  end 

end 