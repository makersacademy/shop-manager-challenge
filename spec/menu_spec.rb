require 'menu'

RSpec.describe Menu do
  it 'puts' do
    io = double :io
    expect(io).to receive(:puts).with('Welcome to the shop management program!')
    expect(io).to receive(:puts).with('What do you want to do?')
    expect(io).to receive(:puts).with('1 = list all shop items')
    expect(io).to receive(:puts).with('2 = create a new item')
    expect(io).to receive(:puts).with('3 = list all orders')
    expect(io).to receive(:puts).with('4 = create a new order')
  
    menu = Menu.new(io)
    menu.show_menu
  end
  it 'gets' do
    io = double :io
    expect(io).to receive(:gets).and_return('1')  
    menu = Menu.new(io)
    expect(menu.get_result).to eq('1')
  end

  it 'gets' do
    io = double :io
    expect(io).to receive(:gets).and_return('5')  
    menu = Menu.new(io)
    expect { menu.get_result }.to raise_error('Invalid number')
  end





end