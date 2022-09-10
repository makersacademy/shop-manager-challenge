require 'application'

RSpec.describe Application do
  def reset_tables
    seed_sql = File.read('spec/seeds_tests.sql')
    user = ENV['PGUSER1'].to_s
    password = ENV['PGPASSWORD'].to_s
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager', user: user, password: password })

    connection.exec(seed_sql)
  end

  before(:each) do 
    reset_tables
  end

  describe "#print_all_items" do
    it "prints all shop items" do      
      io = double :io
      item_repository = ItemRepository.new
      order_repository = OrderRepository.new
      app = Application.new('shop_manager', io, item_repository, order_repository)
      expect(io).to receive(:puts).with("#1 - Item 1 - Price: 1 - Stock quantiy: 5")
      expect(io).to receive(:puts).with("#2 - Item 2 - Price: 2 - Stock quantiy: 10")
      app.print_all_items
    end
  end



end
