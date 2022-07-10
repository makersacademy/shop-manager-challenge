require 'app'
require 'item_repository'

def reset_items_table
    seed_sql = File.read('spec/seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager' })
    connection.exec(seed_sql)
end

RSpec.describe Application do

    before(:each) do 
        reset_items_table
    end

    xit "shows all available shop items" do
        io = double :fake_io
        expect(io).to receive(:puts).with('Welcome to the shop management program!')
        expect(io).to receive(:puts).with('What do you want to do?')
        expect(io).to receive(:puts).with('1 = list all shop items 2 = create a new item 3 = list all orders 4 = create a new order')
        expect(io).to receive(:gets).and_return('1')

        app = Application.new('shop_manager', io)
        expect(app.run).to eq '1. Cheese $3.00, 33. 
2. Cherries $4.00, 368. 
3. Watermelon $2.50, 99. 
4. Strawberries $3.50, 150. 
5. Strawberries $3.50, 150. 
'
    end

    xit "creates a new item in the shop items db" do
        io = double :fake_io
        expect(io).to receive(:puts).with('Welcome to the shop management program!')
        expect(io).to receive(:puts).with('What do you want to do?')
        expect(io).to receive(:puts).with('1 = list all shop items 2 = create a new item 3 = list all orders 4 = create a new order')
        expect(io).to receive(:gets).and_return('2')
        expect(io).to receive(:puts).with('List the following parameters of the item separated by comma: name, price, quantity.')
        expect(io).to receive(:gets).and_return('Bananas, 1, 133')

        app = Application.new('shop_manager', io)
        app.run

        item_repo = ItemRepository.new
        all_items = item_repo.all
        last_item = all_items.last
        expect(last_item.item_name).to eq 'Bananas'
    end

    xit "lists all orders" do
        io = double :fake_io
        expect(io).to receive(:puts).with('Welcome to the shop management program!')
        expect(io).to receive(:puts).with('What do you want to do?')
        expect(io).to receive(:puts).with('1 = list all shop items 2 = create a new item 3 = list all orders 4 = create a new order')
        expect(io).to receive(:gets).and_return('3')

        app = Application.new('shop_manager', io)

        expect(app.run).to eq "1. Irina - 2022-07-03 00:00:00.
2. Tim - 2022-07-01 00:00:00.
3. Julien - 2022-07-02 00:00:00.
4. Jane - 2022-06-01 00:00:00.
"
    end

    it "creates a new order" do
        io = double :fake_io
        expect(io).to receive(:puts).with('Welcome to the shop management program!')
        expect(io).to receive(:puts).with('What do you want to do?')
        expect(io).to receive(:puts).with('1 = list all shop items 2 = create a new item 3 = list all orders 4 = create a new order')
        expect(io).to receive(:gets).and_return('4')
        expect(io).to receive(:puts).with('List the following parameters of the new order separated by a comma: customer name, date.')
        expect(io).to receive(:gets).and_return('Someone, 2022/10/07')

        app = Application.new('shop_manager', io)
        app.run

        order_repo = OrderRepository.new
        all_orders = order_repo.all
        last_order = all_orders.last
        expect(last_order.customer_name).to eq 'Someone'
        expect(last_order.date).to eq '2022-10-07 00:00:00'

    end

end