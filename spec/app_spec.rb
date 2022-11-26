require_relative '../app'

RSpec.describe Application do
  def load_app
    @io = double :io
    @app = Application.new(
      'shop_manager_test',
      @io,
      ItemRepository.new,
      OrderRepository.new
    )
  end
  def reset_students_table
    seed_sql = File.read('spec/seeds_shop_manager.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end

  before(:each) do 
    load_app
    reset_students_table
  end

  it 'puts interactive menu' do
    expect(@io).to receive(:puts).with("Welcome to the shop management program!")
    expect(@io).to receive(:puts).with("What do you want to do?")
    expect(@io).to receive(:puts).with("  1 = list all shop items")
    expect(@io).to receive(:puts).with("  2 = create a new item")
    expect(@io).to receive(:puts).with("  3 = list all orders")
    expect(@io).to receive(:puts).with("  4 = create a new order")
    @app.run
  end
end