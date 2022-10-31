require_relative '../app'

def reset_shop_table
  seed_sql = File.read('spec/seeds_shop.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end
 
describe Application do
  before(:each) do 
    reset_shop_table
  end

  it 'prints out all items in the shop' do
    terminal = double(:terminal)
    expect(terminal).to receive(:puts).with("Welcome to Shop Manager!").ordered
    expect(terminal).to receive(:puts).with("Pick an option (input number):").ordered
    expect(terminal).to receive(:puts).with("1 - List items in stock").ordered
    expect(terminal).to receive(:puts).with("2 - Add new item to stock").ordered
    expect(terminal).to receive(:puts).with("3 - List all orders on record").ordered
    expect(terminal).to receive(:puts).with("4 - Add new order to record").ordered
    expect(terminal).to receive(:puts).with("5 - Exit").ordered
    expect(terminal).to receive(:gets).and_return("1").ordered
    expect(terminal).to receive(:puts).with('ITEM: Socks - PRICE: $2.50 - STOCK: 100 units').ordered
    expect(terminal).to receive(:puts).with('ITEM: Trousers - PRICE: $11.00 - STOCK: 75 units').ordered
    expect(terminal).to receive(:puts).with('ITEM: Shirt - PRICE: $12.00 - STOCK: 60 units').ordered
    expect(terminal).to receive(:puts).with('ITEM: Shoes - PRICE: $30.00 - STOCK: 50 units').ordered
    expect(terminal).to receive(:puts).with('ITEM: Skirt - PRICE: $7.50 - STOCK: 65 units').ordered
    expect(terminal).to receive(:puts).with('ITEM: Hat - PRICE: $5.50 - STOCK: 90 units').ordered
    expect(terminal).to receive(:puts).with('ITEM: Scarf - PRICE: $3.50 - STOCK: 120 units').ordered
    expect(terminal).to receive(:puts).with('ITEM: Dress - PRICE: $12.50 - STOCK: 70 units').ordered
    items = ItemRepository.new
    orders = OrderRepository.new
    app = Application.new('shop_manager_test', terminal, items, orders)
    app.run
  end

  it 'lists all orders on shop record' do
    terminal = double(:terminal)
    expect(terminal).to receive(:puts).with("Welcome to Shop Manager!").ordered
    expect(terminal).to receive(:puts).with("Pick an option (input number):").ordered
    expect(terminal).to receive(:puts).with("1 - List items in stock").ordered
    expect(terminal).to receive(:puts).with("2 - Add new item to stock").ordered
    expect(terminal).to receive(:puts).with("3 - List all orders on record").ordered
    expect(terminal).to receive(:puts).with("4 - Add new order to record").ordered
    expect(terminal).to receive(:puts).with("5 - Exit").ordered
    expect(terminal).to receive(:gets).and_return("3").ordered
    expect(terminal).to receive(:puts).with('CUSTOMER NAME: Sia - ORDER DATE: 2022-10-29')
    expect(terminal).to receive(:puts).with('CUSTOMER NAME: Bon - ORDER DATE: 2022-09-28')
    expect(terminal).to receive(:puts).with('CUSTOMER NAME: Ozzy - ORDER DATE: 2022-08-27')
    expect(terminal).to receive(:puts).with('CUSTOMER NAME: Lana - ORDER DATE: 2022-07-26')
    expect(terminal).to receive(:puts).with('CUSTOMER NAME: Ari - ORDER DATE: 2022-06-25')
    items = ItemRepository.new
    orders = OrderRepository.new
    app = Application.new('shop_manager_test', terminal, items, orders)
    app.run
  end

  it 'creates a new item' do
    terminal = double(:terminal)
    expect(terminal).to receive(:puts).with("Welcome to Shop Manager!").ordered
    expect(terminal).to receive(:puts).with("Pick an option (input number):").ordered
    expect(terminal).to receive(:puts).with("1 - List items in stock").ordered
    expect(terminal).to receive(:puts).with("2 - Add new item to stock").ordered
    expect(terminal).to receive(:puts).with("3 - List all orders on record").ordered
    expect(terminal).to receive(:puts).with("4 - Add new order to record").ordered
    expect(terminal).to receive(:puts).with("5 - Exit").ordered
    expect(terminal).to receive(:gets).and_return("2").ordered
    expect(terminal).to receive(:puts).with("Enter item name to add:")
    expect(terminal).to receive(:gets).and_return("sunglasses").ordered
    expect(terminal).to receive(:puts).with("Enter price for Sunglasses:")
    expect(terminal).to receive(:gets).and_return("9.50").ordered
    expect(terminal).to receive(:puts).with("Enter stock quantity for Sunglasses:")
    expect(terminal).to receive(:gets).and_return("70").ordered
    expect(terminal).to receive(:puts).with("70 x Sunglasses @ $9.50 added to stock.")
    items = ItemRepository.new
    orders = OrderRepository.new
    app = Application.new('shop_manager_test', terminal, items, orders)
    app.run
  end

  it 'creates a new order' do
    terminal = double(:terminal)
    expect(terminal).to receive(:puts).with("Welcome to Shop Manager!").ordered
    expect(terminal).to receive(:puts).with("Pick an option (input number):").ordered
    expect(terminal).to receive(:puts).with("1 - List items in stock").ordered
    expect(terminal).to receive(:puts).with("2 - Add new item to stock").ordered
    expect(terminal).to receive(:puts).with("3 - List all orders on record").ordered
    expect(terminal).to receive(:puts).with("4 - Add new order to record").ordered
    expect(terminal).to receive(:puts).with("5 - Exit").ordered
    expect(terminal).to receive(:gets).and_return("4").ordered
    expect(terminal).to receive(:puts).with("Enter customer name:").ordered
    expect(terminal).to receive(:gets).and_return("Rey").ordered
    expect(terminal).to receive(:puts).with("Enter order date (YYYY-MM-DD):")
    expect(terminal).to receive(:gets).and_return("2022-10-28").ordered
    expect(terminal).to receive(:puts).with("Order record created. Assign items? (Y/N)").ordered
    expect(terminal).to receive(:gets).and_return("y").ordered
    expect(terminal).to receive(:puts).with("Enter item ID to add to order:").ordered
    expect(terminal).to receive(:gets).and_return("2").ordered
    expect(terminal).to receive(:puts).with("Trousers added to Order ID: 6.").ordered
    expect(terminal).to receive(:puts).with("Add another item? (Y/N)").ordered
    expect(terminal).to receive(:gets).and_return("Y").ordered
    expect(terminal).to receive(:puts).with("Enter item ID to add to order:").ordered
    expect(terminal).to receive(:gets).and_return("3").ordered
    expect(terminal).to receive(:puts).with("Shirt added to Order ID: 6.").ordered
    expect(terminal).to receive(:puts).with("Add another item? (Y/N)").ordered
    expect(terminal).to receive(:gets).and_return("n").ordered
    item_repo = ItemRepository.new
    order_repo = OrderRepository.new
    app = Application.new('shop_manager_test', terminal, item_repo, order_repo)
    app.run
    orders = order_repo.all
    expect(orders.length).to eq 6
    expect(orders.last.id).to eq '6'
    expect(orders.last.customer_name).to eq 'Rey'
    expect(orders.last.date).to eq '2022-10-28'
  end

end
