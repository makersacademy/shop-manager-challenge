require_relative '../app'

def reset_items_table
  seed_sql = File.read('spec/seeds_items.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

def reset_orders_table
  seed_sql = File.read('spec/seeds_orders.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

RSpec.describe Application do
  before(:each) do 
    reset_items_table
    reset_orders_table
  end

  context 'when user selects 1' do
    it 'returns list of items' do
      io = double :io

      expect(io).to receive(:puts).with("Welcome to the shop management program!\n\n").ordered
      expect(io).to receive(:puts).with(
          "What do you want to do?\n" \
          "  1 = list all shop items\n" \
          "  2 = create a new item\n" \
          "  3 = list all orders\n" \
          "  4 = create a new order\n" \
          "  9 = exit\n\n"
        ).ordered
      expect(io).to receive(:gets).and_return('1').ordered
      expect(io).to receive(:puts).with("\nHere's a list of all shop items:\n\n").ordered
      expect(io).to receive(:puts).with("  1. Flake - Unit price: 99 - Quantity: 10").ordered
      expect(io).to receive(:puts).with("  2. Twix - Unit price: 110 - Quantity: 5").ordered

      app = Application.new(
        'shop_manager_test',
        io,
        ItemRepository.new,
        OrderRepository.new
      )
      app.run
    end
  end

  context 'when user selects 2' do
    it 'creates a new item' do
      io = double :io

      expect(io).to receive(:puts).with("Welcome to the shop management program!\n\n").ordered
      expect(io).to receive(:puts).with(
          "What do you want to do?\n" \
          "  1 = list all shop items\n" \
          "  2 = create a new item\n" \
          "  3 = list all orders\n" \
          "  4 = create a new order\n" \
          "  9 = exit\n\n"
        ).ordered
      expect(io).to receive(:gets).and_return('2').ordered
      expect(io).to receive(:puts).with("Enter the name of the new item:").ordered
      expect(io).to receive(:gets).and_return('Wispa').ordered
      expect(io).to receive(:puts).with("Enter the unit price of the new item:").ordered
      expect(io).to receive(:gets).and_return('99').ordered
      expect(io).to receive(:puts).with("Enter the quantity of the new item:").ordered
      expect(io).to receive(:gets).and_return('15').ordered
      expect(io).to receive(:puts).with("New item created!").ordered
      
      app = Application.new(
        'shop_manager_test',
        io,
        ItemRepository.new,
        OrderRepository.new
      )
      app.run

      repo = ItemRepository.new

      items = repo.all

      last_item = items.last

      expect(last_item.id).to eq '3'
      expect(last_item.name).to eq 'Wispa'
      expect(last_item.unit_price).to eq '99'
      expect(last_item.quantity).to eq '15'
    end
  end

  context 'when user selects 3' do
    it 'returns list of orders' do
      io = double :io

      expect(io).to receive(:puts).with("Welcome to the shop management program!\n\n").ordered
      expect(io).to receive(:puts).with(
          "What do you want to do?\n" \
          "  1 = list all shop items\n" \
          "  2 = create a new item\n" \
          "  3 = list all orders\n" \
          "  4 = create a new order\n" \
          "  9 = exit\n\n"
        ).ordered
      expect(io).to receive(:gets).and_return('3').ordered
      expect(io).to receive(:puts).with("\nHere's a list of all orders:\n\n").ordered
      expect(io).to receive(:puts).with("  1. Customer name: David - Date: 2023-03-03 - Item ID: 1").ordered
      expect(io).to receive(:puts).with("  2. Customer name: David - Date: 2023-05-01 - Item ID: 1").ordered
      expect(io).to receive(:puts).with("  3. Customer name: Anna - Date: 2023-05-01 - Item ID: 2").ordered
      
      app = Application.new(
        'shop_manager_test',
        io,
        ItemRepository.new,
        OrderRepository.new
      )
      app.run
    end
  end

  context 'when user selects 9' do
    it 'exits' do
      io = double :io

      expect(io).to receive(:puts).with("Welcome to the shop management program!\n\n").ordered
      expect(io).to receive(:puts).with(
          "What do you want to do?\n" \
          "  1 = list all shop items\n" \
          "  2 = create a new item\n" \
          "  3 = list all orders\n" \
          "  4 = create a new order\n" \
          "  9 = exit\n\n"
        ).ordered
      expect(io).to receive(:gets).and_return('9').ordered
      expect(Kernel).to receive(:exit).with(0).ordered

      app = Application.new(
        'shop_manager_test',
        io,
        ItemRepository.new,
        OrderRepository.new
      )
      app.run
    end
  end

  context "when user doesn't enter a valid input" do
    it 'asks for a valid input' do
      io = double :io

      expect(io).to receive(:puts).with("Welcome to the shop management program!\n\n").ordered
      expect(io).to receive(:puts).with(
          "What do you want to do?\n" \
          "  1 = list all shop items\n" \
          "  2 = create a new item\n" \
          "  3 = list all orders\n" \
          "  4 = create a new order\n" \
          "  9 = exit\n\n"
        ).ordered
      expect(io).to receive(:gets).and_return('5').ordered
      expect(io).to receive(:puts).with("Please input 1, 2, 3, 4 or 9").ordered

      app = Application.new(
        'shop_manager_test',
        io,
        ItemRepository.new,
        OrderRepository.new
      )
      app.run
    end
  end
end
