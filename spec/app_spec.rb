require_relative '../app'
require 'item_repository'
require 'order_repository'

RSpec.describe Application do
  it "print the header" do
    io = double :io
    order_repository = OrderRepository.new
    item_repository = ItemRepository.new
    expect(io).to receive(:puts).with("Welcome to the shop management program!")
    expect(io).to receive(:puts).with("")
    expect(io).to receive(:puts).with("What do you want to do?")
    expect(io).to receive(:puts).with("1 = list all shop items")
    expect(io).to receive(:puts).with("2 = create a new item")
    expect(io).to receive(:puts).with("3 = list all orders")
    expect(io).to receive(:puts).with("4 = create a new order")
    expect(io).to receive(:gets).and_return("1")

    app = Application.new("shop_manager_test", io, order_repository, item_repository)
    app.run
  end
end
