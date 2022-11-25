require_relative '../app'
def terminal_message(io)
        expect(io).to receive(:puts).with("Welcome to the shop management program!").ordered
        expect(io).to receive(:puts).with("What would you like to do?").ordered
        expect(io).to receive(:puts).with("1 - List all products").ordered
        expect(io).to receive(:puts).with("2 - Create a new item").ordered
        expect(io).to receive(:puts).with("3 - list all orders").ordered
        expect(io).to receive(:puts).with("4 - create a new order").ordered
        expect(io).to receive(:print).with("Enter your choice: ").ordered
end

RSpec.describe Application do
    it 'given choice 1 it lists all products' do
        io = double(:io)
        terminal_message(io)
        expect(io).to receive(:gets).and_return(1)

        expect(io).to receive(:puts).with("Here's a list of all shop items:").ordered
        expect(io).to receive(:puts).with("#1 - PS5 - Quantity: 2").ordered
        expect(io).to receive(:puts).with("#2 - XBOX - Quantity: 10").ordered

        app = Application.new(
            'shop_manager_test',
            io,
            ProductRepository.new,
            OrderRepository.new
          )
          app.run
    end


    it 'given choice 2 it creates a new order' do
        io = double(:io)
        terminal_message(io)
        expect(io).to receive(:gets).and_return(2)

        expect(io).to receive(:print).with("Product name: ").ordered
        expect(io).to receive(:gets).and_return('NINTENDO SWITCH')
        expect(io).to receive(:print).with("Unit price: ").ordered
        expect(io).to receive(:gets).and_return('300')
        expect(io).to receive(:print).with("Quantity: ").ordered
        expect(io).to receive(:gets).and_return('25')
        expect(io).to receive(:puts).with("Item: NINTENDO SWITCH added").ordered

        app = Application.new(
            'shop_manager_test',
            io,
            ProductRepository.new,
            OrderRepository.new
          )
          app.run

    end

    it 'given choice 3 it lists all orders' do
        io = double(:io)
        terminal_message(io)
        expect(io).to receive(:gets).and_return(3)

        expect(io).to receive(:puts).with("Here's a list of all orders:").ordered
        expect(io).to receive(:puts).with("#1 - Customer name: Harry - Date: 2022-11-25").ordered
        expect(io).to receive(:puts).with("#2 - Customer name: Jack - Date: 2022-11-24").ordered

        app = Application.new(
            'shop_manager_test',
            io,
            ProductRepository.new,
            OrderRepository.new
          )
          app.run
    end

    it 'given choice 4 it creates a new order' do
        io = double(:io)
        terminal_message(io)
        expect(io).to receive(:gets).and_return(4)
        expect(io).to receive(:print).with("Customer name: ").ordered
        expect(io).to receive(:gets).and_return('Molly')
        expect(io).to receive(:puts).with("Order by: MOLLY made").ordered
        app = Application.new(
            'shop_manager_test',
            io,
            ProductRepository.new,
            OrderRepository.new
          )
          app.run
        


    end


end