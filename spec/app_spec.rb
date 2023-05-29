require_relative '../app'

RSpec.describe Application do
  let(:database_name) { 'shop_manager_test' }
  let(:io) { double('IO') }
  let(:item_repository) { double('ItemRepository') }
  let(:order_repository) { double('OrderRepository') }
  let(:order_item_repository) { double('OrderItemRepository') }


  subject(:app) { Application.new(database_name, io, item_repository, order_repository, order_item_repository) }

  describe '#run' do
    context 'when choice is 1' do
      let(:items) { [double('Item', id: 1, name: 'CPU', unit_price: 76.99, quantity: 7)] }

      before do
        allow(io).to receive(:puts)
        allow(io).to receive(:print)
        allow(io).to receive(:gets).and_return("1\n")

        allow(item_repository).to receive(:all).and_return(items)
      end

      it 'lists all items in stock' do
        expect(io).to receive(:puts).with("----------------------------------------------")
        expect(io).to receive(:puts).with("Welcome to the shop management program!\n\n")
        expect(io).to receive(:puts).with("What do you want to do?")
        expect(io).to receive(:puts).with(" 1 = list all shop items")
        expect(io).to receive(:puts).with(" 2 = create a new item")
        expect(io).to receive(:puts).with(" 3 = list all orders")
        expect(io).to receive(:puts).with(" 4 = create a new order")
        expect(io).to receive(:print).with("\nEnter your choice: ")
        expect(io).to receive(:puts).with("\nHere's a list of all shop items:")
        expect(io).to receive(:puts).with(" #1 CPU - Unit price: 76.99 - Quantity: 7")

        app.run
      end
    end

    context 'when choice is 3' do
      let(:orders) { [double('Order', id: 1, customer_name: 'Test_name', order_date: '2023-08-26')] }

      before do
        allow(io).to receive(:puts)
        allow(io).to receive(:print)
        allow(io).to receive(:gets).and_return("3\n")

        allow(order_repository).to receive(:all).and_return(orders)
      end

      it 'lists all orders' do
        expect(io).to receive(:puts).with("----------------------------------------------")
        expect(io).to receive(:puts).with("Welcome to the shop management program!\n\n")
        expect(io).to receive(:puts).with("What do you want to do?")
        expect(io).to receive(:puts).with(" 1 = list all shop items")
        expect(io).to receive(:puts).with(" 2 = create a new item")
        expect(io).to receive(:puts).with(" 3 = list all orders")
        expect(io).to receive(:puts).with(" 4 = create a new order")
        expect(io).to receive(:print).with("\nEnter your choice: ")
        expect(io).to receive(:puts).with("\nHere's a list of all orders:")
        expect(io).to receive(:puts).with(" #1 - Customer Name: Test_name - Order Date: 2023-08-26\n")

        app.run
      end
    end
  end
end