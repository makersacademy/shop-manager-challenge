require_relative '../app.rb'

describe Application do
  before(:each) do
    @database = 'items_orders_test_2'
    @io = double :io
    @item = double :item, id:1, name:'Apple', price:"$2.00", quantity:10
    @item_repo = double :item_repo, all:[@item]
    @order = double :order, id:1, customer_name:'Ryan', placed_date:'2023-02-03', items:[['Apple',2]]
    @order_repo = double :order_repo, all:[@order]
  end

 it 'greets the user and shows options' do
  expect(@io).to receive(:puts).with('Welcome to the shop management program!')
  expect(@io).to receive(:puts).with("\n")
  expect(@io).to receive(:puts).with('What do you want to do?')
  expect(@io).to receive(:puts).with('  1 = list all shop items')
  expect(@io).to receive(:puts).with('  2 = create a new item')
  expect(@io).to receive(:puts).with('  3 = list all orders')
  expect(@io).to receive(:puts).with('  4 = create a new order')
  expect(@io).to receive(:gets).and_return('1')
  expect(@io).to receive(:puts).with("Here's a list of all shop items:")
  expect(@io).to receive(:puts).with("\n")
  expect(@io).to receive(:puts).with(' #1 Apple - Unit price: $2.00 - Quantity: 10')
  app = Application.new(@database,@io,@item_repo,@order_repo)
  app.run
 end 
end
