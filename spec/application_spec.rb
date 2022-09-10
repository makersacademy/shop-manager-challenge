require 'application'
require 'item_repository'
require 'order_repository'
require 'item'
require 'order'

RSpec.describe 'Application' do
  let(:io) { double(:io) }
  let(:app) { Application.new(
    io: io,
    order_repository: OrderRepository.new,
    item_repository: ItemRepository.new
    ) 
  }

  def reset_tables
    sql = File.read('./spec/seeds_test.sql')
    connection = PG.connect({ host: ENV['DATABASE_HOST'], dbname: ENV['DATABASE_NAME'] })
    connection.exec(sql) 
  end

  before(:each) do
    reset_tables
  end
  
  describe '#run' do
    context 'when menu item 1 is seleceted' do
      it 'lists all items' do
        menu
        expect(io).to receive(:gets).and_return("1\n").ordered
        expect(io).to receive(:puts).with('Here is a list of all items').ordered
        expect(io).to receive(:puts).with('1 - Sun Lamp - Unit price: 39 - Quantity: 50').ordered
        expect(io).to receive(:puts).with('2 - Bass Guitar - Unit price: 189 - Quantity: 25').ordered
        expect(io).to receive(:puts).with('3 - Ergonomic Keyboard - Unit price: 89 - Quantity: 95').ordered
        app.run
      end
    end
    
    context 'when menu item 2 is seleceted' do
      it 'creates a new item' do
        menu
        expect(io).to receive(:gets).and_return '2'
        expect(io).to receive(:puts).with('Item name:').ordered
        expect(io).to receive(:gets).and_return('Beanbag').ordered
        expect(io).to receive(:puts).with('Unit price:').ordered
        expect(io).to receive(:gets).and_return('79').ordered
        expect(io).to receive(:puts).with('Stock:').ordered
        expect(io).to receive(:gets).and_return('25').ordered
        expect(io).to receive(:puts).with('Item created.').ordered
        app.run
        items = ItemRepository.new.all
        expect(items.length).to eq 4
        expect(items.last.name).to eq 'Beanbag'
        expect(items.last.price).to eq '79'
        expect(items.last.stock).to eq '25'
        expect(items.last.id).to eq '4'
      end
    end
    
    context 'when menu item 3 is selected' do
      it 'lists all orders' do
        menu
        expect(io).to receive(:gets).and_return '3'
        expect(io).to receive(:puts).with('Here is a list of all orders').ordered
        expect(io).to receive(:puts).with('Order:').ordered
        expect(io).to receive(:puts).with('1 - Customer: Thundercat - Date: 15/05/2022').ordered
        expect(io).to receive(:puts).with('Item:').ordered
        expect(io).to receive(:puts).with('2 - Bass Guitar - Unit price: 189 - Quantity: 25').ordered
        expect(io).to receive(:puts).with('Order:').ordered
        expect(io).to receive(:puts).with('2 - Customer: Steve Jobs - Date: 15/06/2022').ordered
        expect(io).to receive(:puts).with('Item:').ordered
        expect(io).to receive(:puts).with('3 - Ergonomic Keyboard - Unit price: 89 - Quantity: 95').ordered
        expect(io).to receive(:puts).with('Order:').ordered
        expect(io).to receive(:puts).with('3 - Customer: Alice Coltrane - Date: 15/07/2022').ordered
        expect(io).to receive(:puts).with('Item:').ordered
        expect(io).to receive(:puts).with('1 - Sun Lamp - Unit price: 39 - Quantity: 50').ordered
        app.run
      end
    end

    context 'when menu item 4 is seleceted' do
      it 'creates a new order' do
        menu
        expect(io).to receive(:gets).and_return '4'
        expect(io).to receive(:puts).with('Customer name:').ordered
        expect(io).to receive(:gets).and_return('Bugs Bunny').ordered
        expect(io).to receive(:puts).with('Order date:').ordered
        expect(io).to receive(:gets).and_return('20/08/2022').ordered
        expect(io).to receive(:puts).with('Item ID:').ordered
        expect(io).to receive(:gets).and_return('1').ordered
        expect(io).to receive(:puts).with('Order created.').ordered
        app.run
        orders = OrderRepository.new.all_with_item
        expect(orders.length).to eq 4
      end
    end
  end

  def menu
    expect(io).to receive(:puts).with('Welcome to the shop management program!').ordered
    expect(io).to receive(:puts).with('Select an item from the menu:').ordered
    expect(io).to receive(:puts).with('1 - list all shop items').ordered
    expect(io).to receive(:puts).with('2 - create a new item').ordered
    expect(io).to receive(:puts).with('3 - list all orders').ordered
    expect(io).to receive(:puts).with('4 - create a new order').ordered
  end
end
