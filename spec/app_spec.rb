require_relative '../app'

RSpec.describe Application do
  before(:each) do
    @database = 'shop_manager_test'
    @io = double :io
    @order_1 = double :order, id:1, customer:'Peter Jones', date:01/02/2023, item_id:1
    @order_2 = double :order, id:2, customer:'Freda Gill', date:04/02/2023, item_id:2
    @order_repo = double :order_repo, all:[@order_1, @order_2] 
    @item_1 = double :item, id:1, name:'Hat', price:10, qty:60
    @item_2 = double :item, id:2, name:'Trainers', price:100, qty:500 
    @item_repo = double :item_repo, all:[@item_1, @item_2] 
  end

    after(:each) do
      app = Application.new(@database, @io, @order_repo, @item_repo)
      app.run
    end

    it 'returns items when selection 1' do
      expect(@io).to receive(:puts).with("Welcome to the shop management program!")
      expect(@io).to receive(:puts).with("What would you like to do?\n1 - List all shop items\n2 - Create a new item\n")
      expect(@io).to receive(:puts).with("3 - List all shop orders\n4 - Create a new order\n")
      expect(@io).to receive(:gets).and_return('1')
      expect(@io).to receive(:puts).with('1 - Hat - Price: £10 - Qty: 60')
      expect(@io).to receive(:puts).with('2 - Trainers - Price: £100 - Qty: 500')
    end  

    it ' returns orders when selection 2' do
      expect(@io).to receive(:puts).with("Welcome to the shop management program!")
      expect(@io).to receive(:puts).with("What would you like to do?\n1 - List all shop items\n2 - Create a new item\n")
      expect(@io).to receive(:puts).with("3 - List all shop orders\n4 - Create a new order\n")
      expect(@io).to receive(:gets).and_return('3')
      expect(@io).to receive(:puts).with('1 - Customer: Peter Jones - Date: 01/02/2023 - Item Id: 1')
      expect(@io).to receive(:puts).with('1 - Customer: Freda Gill - Date: 04/02/2023 - Item Id: 2')
    end
end  