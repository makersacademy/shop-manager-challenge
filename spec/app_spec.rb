require_relative '../app'

RSpec.describe Application do
  it 'returns a list of all shop items' do
    io = double :io
    expect(io).to receive(:puts).with('Welcome to the shop management program!')
    expect(io).to receive(:puts).with ("What do you want to do?")
    expect(io).to receive(:puts).with ("1 = list all shop items")
    expect(io).to receive(:puts).with ("2 = create a new item")
    expect(io).to receive(:puts).with ("3 = list all orders")
    expect(io).to receive(:puts).with ("4 = create a new order")
    expect(io).to receive(:gets).and_return('1')
    application = Application.new('shop_challenge_test', io, ItemRepository.new)
    application.run
  end
end
