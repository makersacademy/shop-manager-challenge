require_relative '/Users/tayanne/Developer/Projects/shop-manager-challenge/app.rb'

def reset_items_table
    seed_sql = File.read('spec/shop_manager.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager' })
    connection.exec(seed_sql)
end

describe Management do
    before(:each) do 
        reset_items_table
    end

    it 'list all shop items' do
        io = double :io
        expect(io).to receive(:gets).and_return("1")
        expect(io).to receive(:puts).with("#1 Carrot Cake - Unit price: $30.00 - Quantity: 2")
        expect(io).to receive(:puts).with("#2 Apple Cake - Unit price: $34.50 - Quantity: 3")
        expect(io).to receive(:puts).with("#3 Chocolate Cake - Unit price: $38.00 - Quantity: 1")
        management = Management.new(io)
        management.run
    end

    it 'creates a new item' do
        io = double :io
        expect(io).to receive(:gets).and_return("2")
        expect(io).to receive(:gets).and_return("4")
        expect(io).to receive(:gets).and_return("Orange Cake")
        expect(io).to receive(:gets).and_return("26.90")
        expect(io).to receive(:gets).and_return("3")
        management = Management.new(io)
        management.run
    end

    it 'list all the orders' do
        io = double :io
        expect(io).to receive(:gets).and_return("3")
        expect(io).to receive(:puts).with("#1 Customer: Ana - Date: 2022-06-08")
        expect(io).to receive(:puts).with("#2 Customer: Maria - Date: 2022-07-07")
        expect(io).to receive(:puts).with("#3 Customer: Jon - Date: 2022-09-09")
        expect(io).to receive(:puts).with("#4 Customer: Tom - Date: 2022-08-09")
        expect(io).to receive(:puts).with("#5 Customer: Tay - Date: 2022-02-02")
        expect(io).to receive(:puts).with("#6 Customer: Iz - Date: 2022-03-10")
        management = Management.new(io)
        management.run
    end

    it 'creates a new order' do
        io = double :io
        expect(io).to receive(:gets).and_return("4")
        expect(io).to receive(:gets).and_return("7")
        expect(io).to receive(:gets).and_return("Angel")
        expect(io).to receive(:gets).and_return("2022-09-05")
        management = Management.new(io)
        management.run
    end
end 