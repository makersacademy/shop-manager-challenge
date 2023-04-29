require_relative '../app'

RSpec.describe Application do
  before(:each) do
    reset_stock_table
  end

  it 'it displays the options menu to the user' do
    io = double :Kernel
    app = Application.new(io)
    expect(io).to receive(:puts).with(
      "What would you like to do?\n\t1 -> List all shop items\n\t2 -> Create a new item\n\t3 -> List all orders\n\t4 -> Create a new order \n\t5 -> Add items to order"
    )
    expect(io).to receive(:gets).and_return('quit')

    app.run
  end

  it 'displays a list of all items' do
    io = double :Kernel
    app = Application.new(io)
    expect(io).to receive(:puts).with(
      "What would you like to do?\n\t1 -> List all shop items\n\t2 -> Create a new item\n\t3 -> List all orders\n\t4 -> Create a new order \n\t5 -> Add items to order"
    )
    expect(io).to receive(:gets).and_return('1')
    expect(io).to receive(:puts).with("Item id: 1 - Item: pens - Unit price: 2 - Quantity: 234")
    expect(io).to receive(:puts).with("Item id: 2 - Item: pencils - Unit price: 1 - Quantity: 998")
    expect(io).to receive(:puts).with("Item id: 3 - Item: paper - Unit price: 5 - Quantity: 123")
    expect(io).to receive(:puts).with("Item id: 4 - Item: brush - Unit price: 4 - Quantity: 927")

    app.run
  end

  it 'creates an item' do
    io = double :Kernel
    app = Application.new(io)
    expect(io).to receive(:puts).with(
      "What would you like to do?\n\t1 -> List all shop items\n\t2 -> Create a new item\n\t3 -> List all orders\n\t4 -> Create a new order \n\t5 -> Add items to order"
    )
    expect(io).to receive(:gets).and_return('2')
    expect(io).to receive(:puts).with(
      "Please enter the name of the item to add:"
    )
    expect(io).to receive(:gets).and_return('eraser')
    expect(io).to receive(:puts).with(
      "Please enter the price of the item:"
    )
    expect(io).to receive(:gets).and_return('1')
    expect(io).to receive(:puts).with(
      "Please enter the quantity of the item:"
    )
    expect(io).to receive(:gets).and_return('777')
    expect(io).to receive(:puts).with(
      "Item id: 5 - Item: eraser - Unit price: 1 - Quantity: 777 added"
    )

    app.run
  end

  it 'displays a list of orders' do
    io = double :Kernel
    app = Application.new(io)
    expect(io).to receive(:puts).with(
      "What would you like to do?\n\t1 -> List all shop items\n\t2 -> Create a new item\n\t3 -> List all orders\n\t4 -> Create a new order \n\t5 -> Add items to order"
    )
    expect(io).to receive(:gets).and_return('3')
    expect(io).to receive(:puts).with("Order id: 1 - Customer name: Mike - Order date: 2023-04-28")
    expect(io).to receive(:puts).with("Order id: 2 - Customer name: Steve - Order date: 2023-04-27")

    app.run
  end

  it 'creates a new order' do
    io = double :Kernel
    date = double :Date, today: '2023-04-29'
    app = Application.new(io, date)
    expect(io).to receive(:puts).with(
      "What would you like to do?\n\t1 -> List all shop items\n\t2 -> Create a new item\n\t3 -> List all orders\n\t4 -> Create a new order \n\t5 -> Add items to order"
    )
    expect(io).to receive(:gets).and_return('4')
    expect(io).to receive(:puts).with("Please enter the customer name:")
    expect(io).to receive(:gets).and_return("Barney")
    expect(io).to receive(:puts).with(
      "Order id: 3 - Customer name: Barney - Order date: 2023-04-29 added"
    )

    app.run
  end
end
