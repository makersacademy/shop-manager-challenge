require_relative '../app'
require 'item_repository'
require 'order_repository'

def reset_shop_manager
  seed_sql = File.read('./spec/seeds_shop_manager.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

describe Application do
  before(:each) do 
    reset_shop_manager
  end

  it "Asks user what they want to do, and returns list of all shop items" do
    io = double :io
    item_repository = ItemRepository.new
    order_repository = OrderRepository.new

    expect(io).to receive(:puts).with("Welcome to the shop management program!").ordered

    app = Application.new('shop_manager_test', io, item_repository, order_repository)
    app.run
  end

end
