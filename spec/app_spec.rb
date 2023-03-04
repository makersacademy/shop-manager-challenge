require_relative "../app"

describe Application do
  it "puts's user prompts and breaks loop with no input" do
    io = double :kernel
    app = Application.new(
      'shop_manager_test',
      io,
      ItemRepository.new,
      OrderRepository.new
    )
    expect(io).to receive(:puts).with("Welcome to the shop managment program!")
    expect(io).to receive(:puts).with(
    "What do you want to do?  
  1 = List all shop items  
  2 = Create a new item  
  3 = List all orders  
  4 = Create a new order")
  expect(io).to receive(:gets).and_return("")
    app.run
  end

  it "returns list of items" do
    app = Application.new(
      'shop_manager_test',
      Kernel,
      ItemRepository.new,
      OrderRepository.new
    )
    expect(app.format_items_list).to eq ["1 - item1 - Price: 66.5 - Quantity: 70", "2 - item2 - Price: 33.25 - Quantity: 35", "3 - item3 - Price: 5.99 - Quantity: 300"]
    
  end
end
