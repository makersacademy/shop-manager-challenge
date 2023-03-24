require_relative "../app"
require 'item_repository'

def reset_tables
    seed_sql = File.read('spec/seeds_shop_manager.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
end

RSpec.describe 'shop manager integration' do
    describe "run method" do
        before(:each) { reset_tables }
        it "prints items to the terminal" do
            item_repo = ItemRepository.new
            order = double :fake_order, id: '1,', customer_name: 'Jack'
            order_repo = double :fake_repo, all: [order]

            io = double :fake_io
            expect(io).to receive(:puts).with('Welcome to the shop management program!').ordered
            expect(io).to receive(:puts).with("What do you want to do?\n 1 = list all shop items\n 2 = create a new item\n 3 = list all orders\n 4 = create a new order\n q = quit").ordered
            expect(io).to receive(:gets).and_return('1').ordered
            expect(io).to receive(:puts).with("Here's a list of all shop items:\n").ordered
            expect(io).to receive(:puts).with(" #1 - shirt, price: $35.00, quantity: 5\n #2 - jeans, price: $50.00, quantity: 6\n #3 - hoodie, price: $40.00, quantity: 3\n").ordered
            expect(io).to receive(:puts).with("What do you want to do?\n 1 = list all shop items\n 2 = create a new item\n 3 = list all orders\n 4 = create a new order\n q = quit").ordered
            expect(io).to receive(:gets).and_return('q').ordered
            expect(io).to receive(:puts).with("Tasks complete").ordered
            app = Application.new('shop_manager_test', io, item_repo, order_repo)
            app.run
        end
    end
end