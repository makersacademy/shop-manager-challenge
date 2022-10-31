# frozen_string_literal: false

require_relative '../app'

describe Application do
  def reset_tables
    seed_sql = File.read('spec/seeds_orders.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end

  before :each do
    reset_tables
  end

  context 'given the user selects "1 = list all shop items"' do
    it 'returns a list of available shop items' do
      terminal = double :terminal
      expect(terminal).to receive(:puts).with('Welcome to the shop management program!').ordered
      expect(terminal).to receive(:puts).with("\nWhat do you want to do?").ordered
      expect(terminal).to receive(:puts).with('1 = list all shop items').ordered
      expect(terminal).to receive(:puts).with('2 = create a new item').ordered
      expect(terminal).to receive(:puts).with('3 = list all orders').ordered
      expect(terminal).to receive(:puts).with("4 = create a new order\n").ordered
      
      expect(terminal).to receive(:gets).and_return('1').ordered

      expect(terminal).to receive(:puts).with("\nHere's a list of all shop items:\n").ordered

      expect(terminal).to receive(:puts).with("# Apple - Unit price: 90 - Quantity: 2").ordered
      expect(terminal).to receive(:puts).with("# Banana - Unit price: 75 - Quantity: 3").ordered
      expect(terminal).to receive(:puts).with("# Cherries - Unit price: 120 - Quantity: 1").ordered

      order_repository = OrderRepository.new
      item_repository = ItemRepository.new
      item = Item.new
      app = Application.new('shop_manager_test', terminal, order_repository, item_repository, item)
      app.run
    end
  end

  context 'given the user selects "2 = create a new item"' do
    it 'creates a new item' do
      terminal = double :terminal
      expect(terminal).to receive(:puts).with('Welcome to the shop management program!').ordered
      expect(terminal).to receive(:puts).with("\nWhat do you want to do?").ordered
      expect(terminal).to receive(:puts).with('1 = list all shop items').ordered
      expect(terminal).to receive(:puts).with('2 = create a new item').ordered
      expect(terminal).to receive(:puts).with('3 = list all orders').ordered
      expect(terminal).to receive(:puts).with("4 = create a new order\n").ordered
      
      expect(terminal).to receive(:gets).and_return('2').ordered
      expect(terminal).to receive(:puts).and_return('Enter the item name:').ordered
      expect(terminal).to receive(:gets).and_return('Orange').ordered
      expect(terminal).to receive(:puts).and_return('Enter the item unit price:').ordered
      expect(terminal).to receive(:gets).and_return('80').ordered
      expect(terminal).to receive(:puts).with("\nItem created").ordered

      order_repository = OrderRepository.new
      item_repository = ItemRepository.new
      item = Item.new
      app = Application.new('shop_manager_test', terminal, order_repository, item_repository, item)
      app.run
    end
  end
end
