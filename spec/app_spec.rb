require_relative "../app"

describe Application do
  it "puts's user prompts and breaks loop with no input" do
    io = double :kernel
    app = Application.new(
      'music_library',
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

  it "puts list of items" do
    io = double :kernel
    app = Application.new(
      'music_library',
      io,
      ItemRepository.new,
      OrderRepository.new
    )
    expect(io).to receive(:puts).with 
  end
end
