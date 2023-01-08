require_relative '../lib/item_repository'
require_relative '../app'
def reset_table
  seed_sql = File.read('spec/seeds_cohort_test.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_test' })
  connection.exec(seed_sql)
end

RSpec.describe App do
  before(:each) do
    @repo = ItemRepository.new
    reset_table
  end
  it 'lists all shop items in app' do
    io = double :io
    test = App.new('shop_test', io, 'item_repository')
    expect(io).to receive(:puts).with('Welcome to the shop management program!')
    expect(io).to receive(:puts).with('What do you want to do?')
    expect(io).to receive(:puts).with('1 = list all shop items')
    expect(io).to receive(:puts).with('2 = create a new item')
    expect(io).to receive(:puts).with('3 = list all orders')
    expect(io).to receive(:puts).with('4 = create a new order')
    expect(io).to receive(:gets).and_return('1')
    expect(io).to receive(:puts).with("Here's a list of all shop items:")
    expect(io).to receive(:puts).with(
      '#1 Pickles - Unit price: 10 - Quantity: 5',
    )
    expect(io).to receive(:puts).with(
      '#2 Tomatos - Unit price: 10 - Quantity: 5',
    )
    expect(io).to receive(:puts).with(
      '#3 Cucumber - Unit price: 10 - Quantity: 5',
    )

    test.run
  end
  it 'adds a shop item to app' do
    io = double :io
    test = App.new('shop_test', io, 'item_repository')
    expect(io).to receive(:puts).with('Welcome to the shop management program!')
    expect(io).to receive(:puts).with('What do you want to do?')
    expect(io).to receive(:puts).with('1 = list all shop items')
    expect(io).to receive(:puts).with('2 = create a new item')
    expect(io).to receive(:puts).with('3 = list all orders')
    expect(io).to receive(:puts).with('4 = create a new order')
    expect(io).to receive(:gets).and_return('2')
    expect(io).to receive(:puts).with('Create a new item')
    expect(io).to receive(:puts).with('Add the name of the item now')
    expect(io).to receive(:gets).and_return('Coffee')
    expect(io).to receive(:puts).with('Add the unit price of the item now')
    expect(io).to receive(:gets).and_return('10')
    expect(io).to receive(:puts).with('Add the quantity of the item now')
    expect(io).to receive(:gets).and_return('10')
    expect(io).to receive(:puts).with(
      'Item added.. displaying updated list now...',
    )
    expect(io).to receive(:puts).with(
      '#1 Pickles - Unit price: 10 - Quantity: 5',
    )
    expect(io).to receive(:puts).with(
      '#2 Tomatos - Unit price: 10 - Quantity: 5',
    )
    expect(io).to receive(:puts).with(
      '#3 Cucumber - Unit price: 10 - Quantity: 5',
    )
    expect(io).to receive(:puts).with(
      '#4 Coffee - Unit price: 10 - Quantity: 10',
    )

    test.run
  end

  it 'lists all shop orders in app' do
    io = double :io
    test = App.new('shop_test', io, 'item_repository')
    expect(io).to receive(:puts).with('Welcome to the shop management program!')
    expect(io).to receive(:puts).with('What do you want to do?')
    expect(io).to receive(:puts).with('1 = list all shop items')
    expect(io).to receive(:puts).with('2 = create a new item')
    expect(io).to receive(:puts).with('3 = list all orders')
    expect(io).to receive(:puts).with('4 = create a new order')
    expect(io).to receive(:gets).and_return('3')
    expect(io).to receive(:puts).with("Here's a list of all shop orders:")
    expect(io).to receive(:puts).with(
      '#1 Order name: Thomas - Product ordered: Cucumber - Date: 2001-01-01',
    )
    expect(io).to receive(:puts).with(
      '#2 Order name: David - Product ordered: Pickles - Date: 2001-01-01',
    )
    expect(io).to receive(:puts).with(
      '#3 Order name: Steven - Product ordered: Pickles - Date: 2001-01-01',
    )

    test.run
  end

  it 'adds an order to app' do
    io = double :io
    test = App.new('shop_test', io, 'item_repository')
    expect(io).to receive(:puts).with('Welcome to the shop management program!')
    expect(io).to receive(:puts).with('What do you want to do?')
    expect(io).to receive(:puts).with('1 = list all shop items')
    expect(io).to receive(:puts).with('2 = create a new item')
    expect(io).to receive(:puts).with('3 = list all orders')
    expect(io).to receive(:puts).with('4 = create a new order')
    expect(io).to receive(:gets).and_return('4')
    expect(io).to receive(:puts).with('Create a new order')
    expect(io).to receive(:puts).with(
      'Add the name of the customer making the order now',
    )
    expect(io).to receive(:gets).and_return('John')
    expect(io).to receive(:puts).with('Add the product name for the order now')
    expect(io).to receive(:gets).and_return('Pickles')
    expect(io).to receive(:puts).with('Add the product id for the order now')
    expect(io).to receive(:gets).and_return('1')
    expect(io).to receive(:puts).with('Add the date of the order now')
    expect(io).to receive(:gets).and_return('2010-10-10')
    expect(io).to receive(:puts).with(
      'Order added.. displaying updated list now...',
    )
    expect(io).to receive(:puts).with(
      '#1 Order name: Thomas - Product ordered: Cucumber - Date: 2001-01-01',
    )
    expect(io).to receive(:puts).with(
      '#2 Order name: David - Product ordered: Pickles - Date: 2001-01-01',
    )
    expect(io).to receive(:puts).with(
      '#3 Order name: Steven - Product ordered: Pickles - Date: 2001-01-01',
    )
    expect(io).to receive(:puts).with(
      '#4 Order name: John - Product ordered: Pickles - Date: 2010-10-10',
    )

    test.run
  end
end
# Welcome to the shop management program!

# What do you want to do?
#   1 = list all shop items
#   2 = create a new item
#   3 = list all orders
#   4 = create a new order

# 1 [enter]

# Here's a list of all shop items:

#  #1 Super Shark Vacuum Cleaner - Unit price: 99 - Quantity: 30
#  #2 Makerspresso Coffee Machine - Unit price: 69 - Quantity: 15
#  (...)
