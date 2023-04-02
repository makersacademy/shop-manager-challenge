require './app'

def reset_reset_table
    seed_sql = File.read('spec/seeds_shop_manager_test.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
end
  
RSpec.describe Application do
    context "testing the program methods" do
        before(:each) do 
            reset_reset_table
        end

        it 'Tests prints program menu' do
            io = double :io
            fake_item = double :items
            fake_order = double :orders
            program = Application.new('shop_manager_test', io, fake_order, fake_item)
        
            expect(io).to receive(:puts).with("Welcome to the shop manager!").ordered
            expect(io).to receive(:puts).with("").ordered
            expect(io).to receive(:puts).with("What do you want to do?").ordered
            expect(io).to receive(:puts).with("  1 = List all shop items").ordered
            expect(io).to receive(:puts).with("  2 = Create a new item").ordered
            expect(io).to receive(:puts).with("  3 = List all orders").ordered
            expect(io).to receive(:puts).with("  4 = Create a new order").ordered
            expect(io).to receive(:puts).with("  9 = Exit").ordered
            
            item = program.print_program_menu
        end

        it "tests input '1' shop manager program" do
            io = double :io
            fake_item = ItemRepository.new
            fake_order = OrderRepository.new
            program_menu = Application.new('shop_manager_test', io, fake_order, fake_item)
            expect(io).to receive(:gets).and_return('1').ordered
            expect(io).to receive(:puts).with("1 - hammer: 5.99: 10")
            expect(io).to receive(:puts).with("2 - glue: 2.99: 5")
            output = program_menu.shop_manager_program   
        end

        it "tests input '3' shop manager program" do
            io = double :io
            fake_item = ItemRepository.new
            fake_order = OrderRepository.new
            program_menu = Application.new('shop_manager_test', io, fake_order, fake_item)
            expect(io).to receive(:gets).and_return('3').ordered
            expect(io).to receive(:puts).with("1 - chris: 1999-01-08: 1")
            expect(io).to receive(:puts).with("2 - tom: 2003-01-09: 1")
            output = program_menu.shop_manager_program   
        end

        it "tests input '2' shop manager program" do
            io = double :io
            fake_item = ItemRepository.new
            fake_order = OrderRepository.new
            program_menu = Application.new('shop_manager_test', io, fake_order, fake_item)
            expect(io).to receive(:gets).and_return('2').ordered
            expect(io).to receive(:puts).with("Enter name of item: ").ordered
            expect(io).to receive(:gets).and_return('tape').ordered
            expect(io).to receive(:puts).with("Enter price of item: ").ordered
            expect(io).to receive(:gets).and_return('4.99').ordered
            expect(io).to receive(:puts).with("Enter quantity of item: ").ordered
            expect(io).to receive(:gets).and_return('60').ordered
            output = program_menu.shop_manager_program   
        end

        it "tests input '4' shop manager program" do
            io = double :io
            fake_item = ItemRepository.new
            fake_order = OrderRepository.new
            program_menu = Application.new('shop_manager_test', io, fake_order, fake_item)
            expect(io).to receive(:gets).and_return('4').ordered
            expect(io).to receive(:puts).with("Enter customer order name: ").ordered
            expect(io).to receive(:gets).and_return('dave').ordered
            expect(io).to receive(:puts).with("Enter order date (YYYY-MM-DD): ").ordered
            expect(io).to receive(:gets).and_return('2023-08-09').ordered
            expect(io).to receive(:puts).with("Enter order_id of item: ").ordered
            expect(io).to receive(:gets).and_return('1').ordered
            output = program_menu.shop_manager_program   
        end

        it 'does match a charater in program menu' do
            io = double :io
            fake_item = ItemRepository.new
            fake_order = OrderRepository.new
            program_menu = Application.new('shop_manager_test', io, fake_order, fake_item)
            expect(io).to receive(:gets).and_return('10').ordered
            expect(io).to receive(:puts).with("I don't know what you meant, try again").ordered
            output = program_menu.shop_manager_program   
        end
    end
end