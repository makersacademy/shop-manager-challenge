require_relative '../app'

RSpec.describe Application do

  before(:each) do

    @io = double :io
    itemRepository = double :itemRepository
    orderRepository = double :orderRepository
    @app = Application.new('shop_manager_test',@io,itemRepository,orderRepository)

    item1 = double(:item, :name => 'Super Shark Vacuum Cleaner', :id =>'1', :unit_price => '99', :quantity => '30')
    item2 = double(:item, :name => 'Makerspresso Coffee Machine', :id =>'2', :unit_price => '69', :quantity => '15')
    
    allow(itemRepository).to receive(:all).and_return([item1,item2])

    allow(itemRepository).to receive(:find).with('1').and_return(item1)
    allow(itemRepository).to receive(:find).with('2').and_return(item2)

    order1 = double(:order, :customer_name => 'Dave', :id =>'1', :date => '2023-02-03', :item_id => '1')
    order2 = double(:order, :customer_name => 'John', :id =>'1', :date => '2023-02-03', :item_id => '2')

    
    allow(orderRepository).to receive(:all).and_return([order1,order2])
    
    expect(@io).to receive(:puts).with("Welcome to the shop management program!").ordered
    expect(@io).to receive(:puts).with("").ordered
    expect(@io).to receive(:puts).with("What do you want to do?").ordered
    expect(@io).to receive(:puts).with("  1 - list all shop items").ordered
    expect(@io).to receive(:puts).with("  2 - create a new item").ordered
    expect(@io).to receive(:puts).with("  3 - list all orders").ordered
    expect(@io).to receive(:puts).with("  4 - create a new order").ordered
    expect(@io).to receive(:puts).with("").ordered

  end

  after(:each) do
    @app.run
  end

  it 'displays a list of all items for option 1' do

    expect(@io).to receive(:gets).and_return("1").ordered
    expect(@io).to receive(:puts).with("Here's a list of all shop items:").ordered
    expect(@io).to receive(:puts).with(" #1 Super Shark Vacuum Cleaner - Unit price: 99 - Quantity: 30").ordered
    expect(@io).to receive(:puts).with(" #2 Makerspresso Coffee Machine - Unit price: 69 - Quantity: 15").ordered
    
  end

  it 'displays a list of all orders for option 3' do

    expect(@io).to receive(:gets).and_return("3").ordered
    expect(@io).to receive(:puts).with("Here's a list of all shop orders:").ordered
    expect(@io).to receive(:puts).with(" #1 Dave - Ordered: Super Shark Vacuum Cleaner - On: 2023-02-03").ordered
    expect(@io).to receive(:puts).with(" #1 John - Ordered: Makerspresso Coffee Machine - On: 2023-02-03").ordered

  end


end
