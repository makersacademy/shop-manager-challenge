require_relative '../app' 
  
def reset_table
  seed_sql = File.read('spec/table_seed.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager' })
  connection.exec(seed_sql)
end

describe Application do
  before(:each) do
    reset_table
  end
  it "should show the user options" do
    io = double :io
    app = Application.new('shop_manager', io, ItemRepository.new, OrderRepository.new)
    expect(io).to receive(:puts).with("What do you want to do?")
    expect(io).to receive(:puts).with("1 = list all shop items")
    expect(io).to receive(:puts).with("2 = create a new item")
    expect(io).to receive(:puts).with("3 = list all orders")
    expect(io).to receive(:puts).with("4 = create a new order")
    # expect(io).to receive(:gets).and_return("1")

    app.ask_user
  end
  it "should return all items" do
    io = double :io
    app = Application.new('shop_manager', io, ItemRepository.new, OrderRepository.new)
    expect(io).to receive(:puts).with("Here's a list of all shop items:")
    expect(io).to receive(:puts).with("1. Bread - $1.5 - amount: 10")
    expect(io).to receive(:puts).with("2. Milk - $2.5 - amount: 10")
    expect(io).to receive(:puts).with("3. Eggs - $3.5 - amount: 10")
    expect(io).to receive(:puts).with("4. Cheese - $4.5 - amount: 10")
    expect(io).to receive(:puts).with("5. Butter - $5.5 - amount: 10")
    expect(io).to receive(:puts).with("6. Apples - $6.5 - amount: 10")
    expect(io).to receive(:puts).with("7. Oranges - $7.5 - amount: 10")
    expect(io).to receive(:puts).with("8. Bananas - $8.5 - amount: 10")
    expect(io).to receive(:puts).with("9. Peaches - $9.5 - amount: 10")
    expect(io).to receive(:puts).with("10. Pears - $10.5 - amount: 10")
    app.print_all_items
  end
end
