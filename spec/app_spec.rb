require_relative "../app.rb"
require "item_repository"
require "order_repository"

def reset_tables
  seed_sql = File.read('spec/seeds_all.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

describe Application do
  before(:each) do
    reset_tables
  end

  it "returns all items" do
    io = double :io

    app = Application.new(
      'shop_manager_test',
      io,
      ItemRepository.new,
      OrderRepository.new
    )

    expect(io).to receive(:puts).with("Welcome to the shop management program!").ordered
    expect(io).to receive(:puts).with(no_args).ordered
    expect(io).to receive(:puts).with("What do you want to do?").ordered
    expect(io).to receive(:puts).with("  1 = list all shop items")
    expect(io).to receive(:puts).with("  2 = create a new item")
    expect(io).to receive(:puts).with("  3 = list all orders")
    expect(io).to receive(:puts).with("  4 = create a new order")
    expect(io).to receive(:puts).with("  5 = Exit")
    expect(io).to receive(:gets).and_return("1").ordered
    app.run
    # expect { app.run }.to output("1 - Super Shark Vacuum Cleaner - x 30\n2 - Makerspresso Coffee Machine - x 15\n3 - Porridge Oats - x 100\n4 - Avocado - x 17\n5 - teg - x 12\n").to_stdout
  end

  xit "adds a new item" do
    io = double :io

    app = Application.new(
      'shop_manager_test',
      io,
      ItemRepository.new,
      OrderRepository.new
    )

    expect(io).to receive(:puts).with("Welcome to the shop management program!").ordered
    expect(io).to receive(:puts).with(no_args).ordered
    expect(io).to receive(:puts).with("What do you want to do?").ordered
    expect(io).to receive(:puts).with("  1 = list all shop items")
    app.run
  end

end