require_relative "../app"

RSpec.describe Application do
    describe "run method" do
        it "prints items and orders to the terminal" do
            item = double :fake_item, id: '1', name: 'shirt', price: '£30.00', quantity: 5
            item_repo = double :fake_repo, all: [item]
            order = double :fake_order, id: '1,', customer_name: 'Jack'
            order_repo = double :fake_repo, all: [order]

            io = double :fake_io
            expect(io).to receive(:puts).with('Welcome to the shop management program!').ordered
            expect(io).to receive(:puts).with("What do you want to do?\n 1 = list all shop items\n 2 = create a new item\n 3 = list all orders\n 4 = create a new order\n q = quit").ordered
            expect(io).to receive(:gets).and_return('1').ordered
            expect(io).to receive(:puts).with("Here's a list of all shop items:\n").ordered
            expect(io).to receive(:puts).with(" #1 - shirt, price: £30.00, quantity: 5\n")
            expect(io).to receive(:puts).with("What do you want to do?\n 1 = list all shop items\n 2 = create a new item\n 3 = list all orders\n 4 = create a new order\n q = quit").ordered
            expect(io).to receive(:gets).and_return('2').ordered
            expect(io).to receive(:puts).with("Here's a list of all current orders:\n").ordered
            expect(io).to receive(:puts).with(" #1 - Jack\n")
            expect(io).to receive(:puts).with("What do you want to do?\n 1 = list all shop items\n 2 = create a new item\n 3 = list all orders\n 4 = create a new order\n q = quit").ordered
            expect(io).to receive(:gets).and_return('1').ordered
            expect(io).to receive(:puts).with("Here's a list of all shop items:\n").ordered
            expect(io).to receive(:puts).with(" #1 - shirt, price: £30.00, quantity: 5\n")
            expect(io).to receive(:puts).with("What do you want to do?\n 1 = list all shop items\n 2 = create a new item\n 3 = list all orders\n 4 = create a new order\n q = quit").ordered
            expect(io).to receive(:gets).and_return('q').ordered
            expect(io).to receive(:puts).with("Tasks complete").ordered
            app = Application.new('shop_manager_test', io, item_repo, order_repo)
            app.run
        end
    end
end