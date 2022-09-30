require_relative '../app'

RSpec.describe Application do
  def initialize(io)
    @io = io
  end

  def reset_items_table
    seed_sql = File.read('spec/seeds_items.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager' })
    connection.exec(seed_sql)
  end

  def reset_orders_table
    seed_sql = File.read('spec/seeds_orders.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager' })
    connection.exec(seed_sql)
  end

  before(:each) do 
    reset_items_table
    reset_orders_table
  end 

  describe "#welome_choices"
  context "text on initialisation" do
    it "puts list of actions a user can perform" do
      @io = double :io
      welcome_choices
      run_app
    end
  end

  describe "user selection" do
    context "select 1" do
      it "returns a list of shop items" do
        @io = double :io
        welcome_choices
        expect(io).to receive(:gets).and_return("1")
        expect(@io).to receive(:puts).with("3 = list all orders")
        expect(@io).to receive(:puts).with("4 = create a new order\n")
        run_app
      end
    end
  end
      
  private

  def welcome_choices
    expect(@io).to receive(:puts).with("Welcome to the Game-azon management program!\n")
    expect(@io).to receive(:puts).with("What do you want to do?")
    expect(@io).to receive(:puts).with("1 = list all shop items")
    expect(@io).to receive(:puts).with("2 = create a new item")
    expect(@io).to receive(:puts).with("3 = list all orders")
    expect(@io).to receive(:puts).with("4 = create a new order\n")
    expect(@io).to receive(:puts).with("Enter:")
  end

  def run_app
    app = Application.new('shop_manager', @io, 'item_repository', 'order_repository')
    app.run
  end
end