require_relative '../app'

describe Application do 
  it 'Should return a list of options to the user' do
    io = double :io
    expect(io).to receive(:puts).with("What do you want to do?")
    expect(io).to receive(:puts).with("1 = list all shop items\n2 = create a new item\n3 = list all orders\n4 = create a new order")
    app = Application.new(io)
    app.run
  end
end
