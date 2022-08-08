require_relative '../app'

RSpec.describe Application do
  it 'prints all the list items' do
    item_1 = double :item, id: 'ID1', name: 'FAKE_NAME_1', unit_price: 'FAKE_PRICE_1', quantity: 'FAKE_QUANTITY_1', order_id: 'O_ID1'
    item_2 = double :item, id: 'ID2', name: 'FAKE_NAME_2', unit_price: 'FAKE_PRICE_2', quantity: 'FAKE_QUANTITY_2', order_id: 'O_ID2'
    item_repository = double :item_repository, all: [item_1, item_2]
    order_repository = double :order_repository
    io = double :io
    expect(io).to receive(:puts).with('Welcome to the shop management program!').ordered
    expect(io).to receive(:puts).with('What do you want to do?').ordered
    expect(io).to receive(:puts).with(['1 = list all shop items',
      '2 = create a new item', '3 = list all orders', '4 = create a new order']).ordered
    
    expect(io).to receive(:gets).and_return('1').ordered
    expect(io).to receive(:puts).with('Here is a list with all shop items').ordered
    expect(io).to receive(:puts).with('#ID1 FAKE_NAME_1 - Unit price: FAKE_PRICE_1 - Quantity: FAKE_QUANTITY_1').ordered
    expect(io).to receive(:puts).with('#ID2 FAKE_NAME_2 - Unit price: FAKE_PRICE_2 - Quantity: FAKE_QUANTITY_2').ordered
    
    application = Application.new('shop_manager_test', io, order_repository, item_repository)
    application.run
  end

  xit 'creates a new item' do
    item = double :item, id: 'ID1', name: 'FAKE_NAME', unit_price: 'FAKE_PRICE', quantity: 'FAKE_QUANTITY', order_id: 'O_ID'
    item_repository = double :item_repository 
    order_repository = double :order_repository
    io = double :io
    expect(io).to receive(:puts).with('Welcome to the shop management program!').ordered
    expect(io).to receive(:puts).with('What do you want to do?').ordered
    expect(io).to receive(:puts).with(['1 = list all shop items',
      '2 = create a new item', '3 = list all orders', '4 = create a new order']).ordered
    
    expect(io).to receive(:gets).and_return('2')
    expect(io).to receive(:puts).with('What is the name of the item?')
    expect(io).to receive(:gets).and_return(item.name)
    expect(io).to receive(:puts).with('What is the price of the item?')
    expect(io).to receive(:gets).and_return(item.unit_price)
    expect(io).to receive(:puts).with('What is the quantity of the item?')
    expect(io).to receive(:gets).and_return(item.quantity)
    expect(item_repository).to receive(:create).with(item)

    application = Application.new('shop_manager_test', io, order_repository, item_repository)
    application.run
  end

  it 'prints all the order items' do
    order_1 = double :order, id: 'ID1', customer: 'FAKE_CUSTOMER_1', date: 'FAKE_DATE_1'
    order_2 = double :order, id: 'ID2', customer: 'FAKE_CUSTOMER_2', date: 'FAKE_DATE_2'
    order_repository = double :order_repository, all: [order_1, order_2]
    item_repository = double :item_repository
    io = double :io
    expect(io).to receive(:puts).with('Welcome to the shop management program!').ordered
    expect(io).to receive(:puts).with('What do you want to do?').ordered
    expect(io).to receive(:puts).with(['1 = list all shop items',
      '2 = create a new item', '3 = list all orders', '4 = create a new order']).ordered
   
    expect(io).to receive(:gets).and_return('3').ordered
    expect(io).to receive(:puts).with('Here is a list with all orders').ordered
    expect(io).to receive(:puts).with('#ID1 FAKE_CUSTOMER_1 - FAKE_DATE_1').ordered
    expect(io).to receive(:puts).with('#ID2 FAKE_CUSTOMER_2 - FAKE_DATE_2').ordered
    
    application = Application.new('shop_manager_test', io, order_repository, item_repository)
    application.run
  end
end