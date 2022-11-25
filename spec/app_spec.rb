require_relative '../app'

def reset_tables
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_challenge_test' })
  connection.exec(seed_sql)
end

describe Application do
  before(:each) do 
    reset_tables
  end

  it 'prints all shop items' do 
    terminal = double(:terminal)

    expect(terminal).to receive(:puts).with("\nWelcome to the shop management program!")
    expect(terminal).to receive(:puts).with("\nWhat would you like to do?")
    expect(terminal).to receive(:puts).with("  1 - list all shop items")
    expect(terminal).to receive(:puts).with("  2 - create a new item")
    expect(terminal).to receive(:puts).with("  3 - list all orders")
    expect(terminal).to receive(:puts).with("  4 - create a new order")
    expect(terminal).to receive(:puts).with("\nEnter you choice:")
    expect(terminal).to receive(:gets).and_return('1')
    expect(terminal).to receive(:puts).with("\nHere is your list of shop items:")
    expect(terminal).to receive(:puts).with('#1 - sandwich - Unit Price - 2.99 - Quantity - 10')
    expect(terminal).to receive(:puts).with('#2 - bananas - Unit Price - 1.99 - Quantity - 15')
    expect(terminal).to receive(:puts).with('#3 - toilet roll - Unit Price - 3.00 - Quantity - 20')
    expect(terminal).to receive(:puts).with('#4 - crisps - Unit Price - 0.99 - Quantity - 15')
    expect(terminal).to receive(:puts).with('#5 - sausage roll - Unit Price - 1.50 - Quantity - 10')
    
    application = Application.new('shop_challenge_test', terminal, OrderRepository.new, ShopItemRepository.new)
    application.run
  end

end