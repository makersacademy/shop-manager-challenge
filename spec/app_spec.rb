require_relative '../app.rb'

RSpec.describe Application do
  it "prints the list of items if user input is 1" do
    terminal = double :terminal
    item_repository = double :item_repository
    order_repository = double :order_repository
    expect(terminal).to receive(:puts).with("Welcome to the shop management program!").ordered
    expect(terminal).to receive(:puts).with("").ordered
    expect(terminal).to receive(:puts).with("What do you want to do?").ordered
    expect(terminal).to receive(:puts).with("  1 = list all shop items").ordered
    expect(terminal).to receive(:puts).with("  2 = create a new item").ordered
    expect(terminal).to receive(:puts).with("  3 = list all orders").ordered
    expect(terminal).to receive(:puts).with("  4 = create a new shop order").ordered
    expect(terminal).to receive(:puts).with("").ordered
    expect(terminal).to receive(:gets).and_return("1").ordered
    expect(terminal).to receive(:puts).with("").ordered
    expect(terminal).to receive(:puts).with("Here's a list of all shop items:").ordered
    app = Application.new("shop_inventory_test", terminal, item_repository, order_repository)
    app.run
  end
end