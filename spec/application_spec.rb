require_relative "../app"

describe Application do
  before (:each) do
    @io = double(:io)
    @item_repository = double(:item_repository)
    @order_repository = double(:order_repository)

    menu = <<~MENU
      Welcome to the shop management program!

      What do you want to do?
        1 = list all shop items
        2 = create a new item
        3 = list all orders
        4 = create a new order

    MENU

    expect(@io).to receive(:puts).with(menu).ordered
  end

  after (:each) do
    database_name = "shop"
    app = Application.new(database_name, @io, @item_repository, @order_repository)
    app.run
  end

  describe "#run" do
    it "outputs all items" do
      expect(@io).to receive(:gets).and_return("1").ordered

      expect(@io).to receive(:puts).with("Here's a list of all shop items:").ordered

      items = [
        double(:item, id: 1, name: "Super Shark Vacuum Cleaner", unit_price: 99, quantity: 30),
        double(:item, id: 2, name: "Makerspresso Coffee Machine", unit_price: 69, quantity: 15)
      ]

      expect(@item_repository).to receive(:all).and_return(items).ordered

      expected = <<~EXPECTED.chomp
        Item #: 1 | Super Shark Vacuum Cleaner | Unit Price: 99 | Quantity: 30
        Item #: 2 | Makerspresso Coffee Machine | Unit Price: 69 | Quantity: 15
      EXPECTED

      expect(@io).to receive(:puts).with(expected).ordered

    end

    it "creates a new item" do
      expect(@io).to receive(:gets).and_return("2").ordered
      expect(@io).to receive(:puts).with("New item:").ordered
      expect(@io).to receive(:print).with("Item name: ").ordered
      expect(@io).to receive(:gets).and_return("Shiny New Item").ordered
      expect(@io).to receive(:print).with("Unit price (integer): ").ordered
      expect(@io).to receive(:gets).and_return("49").ordered
      expect(@io).to receive(:print).with("Quantity: ").ordered
      expect(@io).to receive(:gets).and_return("100").ordered

      new_item = have_attributes(name: 'Shiny New Item', unit_price: 49, quantity: 100)
      expect(@item_repository).to receive(:create).with(new_item).ordered
      expect(@io).to receive(:puts).with("Item created!").ordered
    end

    it "outputs all orders" do
      expect(@io).to receive(:gets).and_return("3").ordered

      expect(@io).to receive(:puts).with("Here's a list of all orders:").ordered

      orders = [
        double(:order, id: 1, customer_name: "Alice", date: "2023-01-29", item_id: 1),
        double(:order, id: 2, customer_name: "Bob", date: "2023-01-30", item_id: 2),
        double(:order, id: 3, customer_name: "Carry", date: "2023-01-31", item_id: 2),
        double(:order, id: 4, customer_name: "Dan", date: "2023-02-01", item_id: 1),
      ]

      expect(@order_repository).to receive(:all).and_return(orders).ordered

      expected = <<~EXPECTED.chomp
        Order #: 1 | Customer: Alice | Date: 29/01/23 | Item #: 1
        Order #: 2 | Customer: Bob | Date: 30/01/23 | Item #: 2
        Order #: 3 | Customer: Carry | Date: 31/01/23 | Item #: 2
        Order #: 4 | Customer: Dan | Date: 01/02/23 | Item #: 1
      EXPECTED

      expect(@io).to receive(:puts).with(expected).ordered
    end

    it "creates a new order" do
      expect(@io).to receive(:gets).and_return("4").ordered
      expect(@io).to receive(:puts).with("New order:").ordered
      expect(@io).to receive(:print).with("Item #: ").ordered
      expect(@io).to receive(:gets).and_return("1").ordered
      expect(@io).to receive(:print).with("Your name: ").ordered
      expect(@io).to receive(:gets).and_return("Eve").ordered
      expect(Time).to receive(:now).and_return(Time.new(2023, 1, 31)).ordered

      new_order = have_attributes(customer_name: "Eve", date: "2023-01-31", item_id: 1)
      expect(@order_repository).to receive(:create).with(new_order).ordered
      expect(@io).to receive(:puts).with("Order created!").ordered
    end
  end
end
