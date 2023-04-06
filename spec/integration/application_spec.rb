require_relative '../../app'
require "spec_helper"

def reset_tables
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

describe Application do 
  let(:kernel) { double(:kernel) }
  let(:app) { Application.new('shop_manager_test', kernel,  ItemRepository.new, OrderRepository.new) }

  before :each do
    reset_tables
  end

  def ask_for_user_input
    expect(kernel).to receive(:puts).with("What do you want to do?").ordered
    expect(kernel).to receive(:puts).with("  1 = list all shop items").ordered
    expect(kernel).to receive(:puts).with("  2 = create a new item").ordered
    expect(kernel).to receive(:puts).with("  3 = list all orders").ordered
    expect(kernel).to receive(:puts).with("  4 = create a new order").ordered
    expect(kernel).to receive(:puts).with(" ").ordered
  end

  it "Displays all items" do
    ask_for_user_input
    expect(kernel).to receive(:gets).and_return("1").ordered
    expect(kernel).to receive(:puts).with([" #1 MacBookPro - Unit price: 999.99 - Quantity: 50", " #2 Magic Mouse - Unit price: 30.00 - Quantity: 10", " #3 Charger - Unit price: 50.49 - Quantity: 25"]).ordered
    app.run
  end

  it "Allows user to add an item" do
    ask_for_user_input
    expect(kernel).to receive(:gets).and_return("2").ordered
    expect(kernel).to receive(:puts).with("Enter the item name:").ordered
    expect(kernel).to receive(:gets).and_return("Shaver").ordered
    expect(kernel).to receive(:puts).with("Enter the item's unit price (A float,to two decimal places):").ordered
    expect(kernel).to receive(:gets).and_return("9.99").ordered
    expect(kernel).to receive(:puts).with("Enter the item's quantity in the inventory:").ordered
    expect(kernel).to receive(:gets).and_return("25").ordered
    app.run
    item_repo = ItemRepository.new
    expect(item_repo.all.length).to eq 4
    expect(item_repo.all.first.name).to eq "MacBookPro"
    expect(item_repo.all.last.name).to eq "Shaver"
    expect(item_repo.all.last.unit_price).to eq 9.99
  end

  it "Displays all orders" do
    ask_for_user_input
    expect(kernel).to receive(:gets).and_return("3").ordered
    expect(kernel).to receive(:puts).with("Here's a list of all shop items:").ordered
    expect(kernel).to receive(:puts).with(" ").ordered
    # expect(kernel).to receive(:puts).with('[" Order #1 - Uncle Bob - 2022-09-05\n   Items:", "     Charger, £50.49", "     Magic Mouse, £30.00",...BookPro, £999.99", " Order #2 - Linus Torvalds - 2023-02-22\n   Items:", "     Magic Mouse, £30.00"]').ordered
    expect(kernel).to receive(:puts).with(" Order #1 - Uncle Bob - 2022-09-05\n   Items:\n     Charger, £50.49\n     Magic Mouse, £30.00\n     MacBookPro, £999.99\n Order #2 - Linus Torvalds - 2023-02-22\n   Items:\n     Magic Mouse, £30.00\n").ordered
    app.run  
  end

  it "Lets the user create a new order" do
    ask_for_user_input
    expect(kernel).to receive(:gets).and_return("4").ordered
    expect(kernel).to receive(:puts).with("Enter the cumstomer name for the order:").ordered
    expect(kernel).to receive(:gets).and_return("Bart").ordered
    expect(kernel).to receive(:puts).with("Select the items you'd like to order:").ordered
    expect(kernel).to receive(:puts).with(" #1 MacBookPro - Unit price: 999.99 - Quantity available: 50").ordered
    expect(kernel).to receive(:puts).with("Quantity:").ordered
    expect(kernel).to receive(:gets).and_return("1").ordered
    expect(kernel).to receive(:puts).with(" #2 Magic Mouse - Unit price: 30.0 - Quantity available: 10").ordered
    expect(kernel).to receive(:puts).with("Quantity:").ordered
    expect(kernel).to receive(:gets).and_return("1").ordered
    expect(kernel).to receive(:puts).with(" #3 Charger - Unit price: 50.49 - Quantity available: 25").ordered
    expect(kernel).to receive(:puts).with("Quantity:").ordered
    expect(kernel).to receive(:gets).and_return("1").ordered
    expect(kernel).to receive(:puts).with("Order ID: 3 confirmed!").ordered
    app.run  
    orders = OrderRepository.new.all
    expect(orders.length).to eq 3
    expect(orders.first.customer_name).to eq "Uncle Bob"
    expect(orders.last.customer_name).to eq "Bart"
    expect(orders.last.date).to eq(Date.today.strftime("%Y-%m-%d"))
    # TODO - work out how to test the below two lines
    # expect(orders.last.items.length).to eq 3
    # expect(orders.last.items.last.name).to eq "Charger"
  end
end