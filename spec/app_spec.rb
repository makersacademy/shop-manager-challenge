require_relative '../app'

RSpec.describe Application do
  it "input = 1" do
    io = double :io
    expect(io).to receive(:puts).with("Welcome to the shop management program!")
    expect(io).to receive(:puts).with("What do you want to do?\n  1 = list all shop items\n  2 = create a new item\n  3 = list all orders\n  4 = create a new order\n  5 = find order with items\n  exit")
    expect(io).to receive(:gets).and_return('1')

    item_1 = double :item
    expect(item_1).to receive(:id).and_return(1)
    expect(item_1).to receive(:name).and_return('voile')
    expect(item_1).to receive(:unit_price).and_return(13)
    expect(item_1).to receive(:quantity).and_return(260)
    item_2 = double :item
    expect(item_2).to receive(:id).and_return(2)
    expect(item_2).to receive(:name).and_return('microSD')
    expect(item_2).to receive(:unit_price).and_return(30)
    expect(item_2).to receive(:quantity).and_return(50)
    item_repository = double :item_repository
    expect(item_repository).to receive(:all).and_return([item_1, item_2])

    order_repository = double :order_repository

    expect(io).to receive(:puts).with("Here's a list of all shop items:")
    expect(io).to receive(:puts).with("#1 voile - Unit price: 13 - Quantity: 260")
    expect(io).to receive(:puts).with("#2 microSD - Unit price: 30 - Quantity: 50")

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
    expect(io).to receive(:gets).with('2')

    item_repository = double :item_repository
    order_repository = double :order_repository

    app = Application.new(
      'shop',
      Kernel,
      item_repository,
      order_repository
    )
    app.run
  end

  xit "input = 5" do
    io = double :io
    expect(io).to receive(:puts).with("Welcome to the shop management program!")
    expect(io).to receive(:puts).with("What do you want to do?\n  1 = list all shop items\n  2 = create a new item\n  3 = list all orders\n  4 = create a new order\n  5 = find order with items\n  exit")
    expect(io).to receive(:gets).with('5')

    item_repository = double :item_repository
    order_repository = double :order_repository

    app = Application.new(
      'shop',
      Kernel,
      item_repository,
      order_repository
    )
    app.rb
  end
end