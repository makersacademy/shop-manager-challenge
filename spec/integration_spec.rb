require "application"
require "item_repository"
require "order_repository"

RSpec.describe "integration" do
  before(:each) do
    reset_tables
  end

  describe "Application#run" do
    context "when user chooses option 1" do
      it "prints all the shop items when user inputs option" do
        fake_io = double :fake_io, puts: nil
        allow(fake_io).to receive(:gets).and_return("1\n")
        expect(fake_io).to receive(:puts).with(
          "#1 milk - Unit price: £1.75 - Quantity: 20"
        )
        expect(fake_io).to receive(:puts).with(
          "#2 spinach - Unit price: £1.15 - Quantity: 1"
        )
        expect(fake_io).to receive(:puts).with(
          "#3 pineapple - Unit price: £0.95 - Quantity: 0"
        )
        expect(fake_io).to receive(:puts).with(
          "#4 chocolate - Unit price: £2.10 - Quantity: 16"
        )
        expect(fake_io).to receive(:puts).with(
          "#5 cereal - Unit price: £1.85 - Quantity: 45"
        )
        expect(fake_io).to receive(:puts).with(
          "#6 coffee - Unit price: £4.50 - Quantity: 2"
        )
      
        app = Application.new("shop_manager_test", io = fake_io)
        app.run
      end
    end
    
    context "when user chooses option 2" do
      it "creates a new item" do
        fake_io = double :fake_io, puts: nil, print: nil
        expect(fake_io).to receive(:gets).and_return("2\n")
        expect(fake_io).to receive(:gets).and_return("new_item\n")
        expect(fake_io).to receive(:gets).and_return("105\n")
        expect(fake_io).to receive(:gets).and_return("3\n")
        
        app = Application.new("shop_manager_test", io = fake_io)
        app.run
        
        repo = ItemRepository.new
        expect(repo.all).to include(
          have_attributes(
            name: "new_item",
            unit_price: "105",
            quantity: "3"
          )
        )
      end
    end
    
    context "when user chooses option 3" do
      it "lists all orders" do
        fake_io = double :fake_io, puts: nil

        allow(fake_io).to receive(:gets).and_return("3\n")

        expect(fake_io).to receive(:puts).with(
          "#1 Customer: Alice - Date placed: 2021-02-05"
        )
        expect(fake_io).to receive(:puts).with("    milk - Unit price: £1.75")
        expect(fake_io).to receive(:puts).with("")
        
        expect(fake_io).to receive(:puts).with(
          "#2 Customer: Bob - Date placed: 2022-03-06"
        )
        expect(fake_io).to receive(:puts).with("    milk - Unit price: £1.75")
        expect(fake_io).to receive(:puts).with("    spinach - Unit price: £1.15")
        expect(fake_io).to receive(:puts).with("    pineapple - Unit price: £0.95")
        expect(fake_io).to receive(:puts).with("    cereal - Unit price: £1.85")
        expect(fake_io).to receive(:puts).with("")
        
        expect(fake_io).to receive(:puts).with(
          "#3 Customer: Carol - Date placed: 2022-06-21"
        )
        expect(fake_io).to receive(:puts).with("    milk - Unit price: £1.75")
        expect(fake_io).to receive(:puts).with("    coffee - Unit price: £4.50")
        expect(fake_io).to receive(:puts).with("")
        
        expect(fake_io).to receive(:puts).with(
          "#4 Customer: Dom - Date placed: 2023-10-16"
        )
        expect(fake_io).to receive(:puts).with("    milk - Unit price: £1.75")
        expect(fake_io).to receive(:puts).with("    spinach - Unit price: £1.15")
        expect(fake_io).to receive(:puts).with("    chocolate - Unit price: £2.10")
        expect(fake_io).to receive(:puts).with("")
        
        app = Application.new("shop_manager_test", io = fake_io)
        app.run 
      end
    end

    context "when user chooses option 4" do
      it "creates a new order" do
        fake_io = double :fake_io, puts: nil, print: nil
        expect(fake_io).to receive(:gets).and_return("4\n")
        expect(fake_io).to receive(:gets).and_return("customer1\n")
        expect(fake_io).to receive(:gets).and_return("2022-01-02")

        app = Application.new("shop_manager_test", io = fake_io)
        app.run

        repo = OrderRepository.new
        expect(repo.all).to include(
          have_attributes(
            customer_name: "customer1",
            date_placed: "2022-01-02"
          )
        )
      end
    end
  end
end
