require_relative '../app'

RSpec.describe Application do
  it "input = 1" do
    io = double :io
    expect(io).to receive(:puts).with("Welcome to the shop management program!")
    expect(io).to receive(:puts).with("What do you want to do?\n  1 = list all shop items\n  2 = create a new item\n  3 = list all orders\n  4 = create a new order\n  5 = find order with items\n  exit")
    expect(io).to receive(:gets).and_return('1')

    item_1 = double :item, id: 1, name: 'voile', unit_price: 13, quantity: 260
    # expect(item_1).to receive(:id).and_return(1)
    # expect(item_1).to receive(:name).and_return('voile')
    # expect(item_1).to receive(:unit_price).and_return(13)
    # expect(item_1).to receive(:quantity).and_return(260)
    item_2 = double :item, id: 2, name: 'microSD', unit_price: 30, quantity: 50
    # expect(item_2).to receive(:id).and_return(2)
    # expect(item_2).to receive(:name).and_return('microSD')
    # expect(item_2).to receive(:unit_price).and_return(30)
    # expect(item_2).to receive(:quantity).and_return(50)
    item_repository = double :item_repository
    expect(item_repository).to receive(:all).and_return([item_1, item_2])

    order_repository = double :order_repository

    expect(io).to receive(:puts).with("Here's a list of all shop items:")
    expect(io).to receive(:puts).with("#1 voile - Unit price: 13 - Quantity: 260")
    expect(io).to receive(:puts).with("#2 microSD - Unit price: 30 - Quantity: 50")
    #repeat the welcome page unless input = 0 ('exit'.to_s)
    expect(io).to receive(:puts).with("What do you want to do?\n  1 = list all shop items\n  2 = create a new item\n  3 = list all orders\n  4 = create a new order\n  5 = find order with items\n  exit")
    expect(io).to receive(:gets).and_return('exit')

    app = Application.new(
      'shop',
      io,
      item_repository,
      order_repository
    )
    app.run
  end

  xit "input = 2" do
    io = double :io
    expect(io).to receive(:puts).with("Welcome to the shop management program!")
    expect(io).to receive(:puts).with("What do you want to do?\n  1 = list all shop items\n  2 = create a new item\n  3 = list all orders\n  4 = create a new order\n  5 = find order with items\n  exit")
    expect(io).to receive(:gets).and_return('2')

    expect(io).to receive(:gets).and_return('coffee pods')
    expect(io).to receive(:gets).and_return('5')
    expect(io).to receive(:gets).and_return('10')
    new_item = Item.new
    new_item.name = 'coffee pods'
    new_item.unit_price = 5
    new_item.quantity = 10
    # 1: How to unit test this one?
    # 2: Error message: 
    # -[#<Item:0x0000000140933cf8 @orders=[], @name="coffee pods", @unit_price=5, @quantity=10>]
    # +[#<Item:0x0000000140bfbb20 @orders=[], @name="coffee pods", @unit_price=5, @quantity=10>]
    item_repository = double :item_repository
    expect(item_repository).to receive(:create).with(new_item).and_return(nil)
    order_repository = double :order_repository

    #repeat the welcome page unless input = 0 ('exit'.to_s)
    expect(io).to receive(:puts).with("What do you want to do?\n  1 = list all shop items\n  2 = create a new item\n  3 = list all orders\n  4 = create a new order\n  5 = find order with items\n  exit")
    expect(io).to receive(:gets).and_return('exit')

    app = Application.new(
      'shop',
      io,
      item_repository,
      order_repository
    )
    app.run
  end

  it "input = 5" do
    io = double :io
    expect(io).to receive(:puts).with("Welcome to the shop management program!")
    expect(io).to receive(:puts).with("What do you want to do?\n  1 = list all shop items\n  2 = create a new item\n  3 = list all orders\n  4 = create a new order\n  5 = find order with items\n  exit")
    expect(io).to receive(:gets).and_return('5')

    expect(io).to receive(:puts).with("Which order (id) do you want to find with items?")
    expect(io).to receive(:gets).and_return('3')

    item_repository = double :item_repository
    order_repository = double :order_repository
    expect(order_repository).to receive(:find_with_items).with(3).and_return(['Anna', '2019-03-12', ["voile", "toilet roll", "light bulbs"]])
    expect(io).to receive(:puts).with('Customer: Anna has ordered ["voile", "toilet roll", "light bulbs"] on 2019-03-12.')

    #repeat the welcome page unless input = 0 ('exit'.to_s)
    expect(io).to receive(:puts).with("What do you want to do?\n  1 = list all shop items\n  2 = create a new item\n  3 = list all orders\n  4 = create a new order\n  5 = find order with items\n  exit")
    expect(io).to receive(:gets).and_return('exit')

    app = Application.new(
      'shop',
      io,
      item_repository,
      order_repository
    )
    app.run
  end
end