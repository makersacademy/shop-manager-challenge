require 'app'
require 'item_repository'

RSpec.describe Application do
    it "greets you and shows the options" do
        io = double :fake_io
        expect(io).to receive(:puts).with('Welcome to the shop management program!')
        expect(io).to receive(:puts).with('What do you want to do?')
        expect(io).to receive(:puts).with('1 = list all shop items 2 = create a new item 3 = list all orders 4 = create a new order')
        item_repository = ItemRepository.new

        app = Application.new('shop_manager', io, item_repository)
        app.run
    end

    it "greets you and shows the options" do
        io = double :fake_io
        expect(io).to receive(:puts).with('Welcome to the shop management program!')
        expect(io).to receive(:puts).with('What do you want to do?')
        expect(io).to receive(:puts).with('1 = list all shop items 2 = create a new item 3 = list all orders 4 = create a new order')
        expect(io).to receive(:gets).and_return('1')
        item_repository = ItemRepository.new

        app = Application.new('shop_manager', io, item_repository)
        expect(app.run).to eq '1. Cheese $3.00, 33. 2. Cherries $4.00, 368. 3. Watermelon $2.50, 99. 4. Strawberries $3.50, 150. 5. Strawberries $3.50, 150. 6. Soup $3.00, 50. '
    end

end