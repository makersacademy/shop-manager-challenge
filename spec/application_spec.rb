require_relative "../app"

describe Application do
  def reset_tables
    seeds_sql = File.read("seeds/seeds_items_orders.sql")
    connection = PG.connect({ host: "127.0.0.1", dbname: "shop_manager_test" })
    connection.exec(seeds_sql)
  end

  def expected_starter(io)
    expect(io).to receive(:puts).with("Welcome to the shop management program!")
  end

  def expected_menu(io)
    options = ["list all shop items", "create a new item", "update an item's price", "update stock of an item", "list all orders", "create a new order"]
    expect(io).to receive(:puts).with("")
    expect(io).to receive(:puts).with("What do you want to do?")
    expect(io).to receive(:puts).with("")
    options.each_with_index do |option, index|
      expect(io).to receive(:puts).with("#{index + 1} = #{option}")
    end
    expect(io).to receive(:puts).with("")
    expect(io).to receive(:puts).with("Enter your option:")
  end

  def expected_quit(io)
    expect(io).to receive(:puts).with("")
    expect(io).to receive(:puts).with("Do you want to continue the programme? (y/n)")
    expect(io).to receive(:gets).and_return("n")
  end

  before(:each) do
    reset_tables
    @io = double :io
    @order_repo = double :order_repo
    @item_repo = double :item_repo
    @app = Application.new("shop_manager_test", @io, @order_repo, @item_repo)
  end

  it "handles invalid input and keeps asking for a valid one" do
    expected_starter(@io)
    expected_menu(@io)
    expect(@io).to receive(:gets).and_return("1$!/23rwq")
    expect(@io).to receive(:puts).with("Invalid input. Please enter again:")
    expect(@io).to receive(:gets).and_return("1")
    expect(@io).to receive(:puts).with(1)
    expected_quit(@io)
    @app.run
  end
end
