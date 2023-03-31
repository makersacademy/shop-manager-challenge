require_relative '../app.rb'
require 'database_connection'
require 'item_repository.rb'
require 'customer_repository.rb'
require 'order_repository.rb'

def reset_all_tables
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  seed_sql = File.read('spec/seeds_all.sql')
  connection.exec(seed_sql)
end

describe Application do
  before(:each) do 
    reset_all_tables
  end
  let(:i_repo) { ItemRepository.new }
  let(:c_repo) { CustomerRepository.new }
  let(:o_repo) { OrderRepository.new }
  let(:io) { double(:io) }
  let(:app) { Application.new('shop_manager_test', io, c_repo, i_repo, o_repo)}

  context 'when checked for UI messages' do
    it 'displays a choice menu to user and returns their result' do
      expect(io).to receive(:puts).with("")
      expect(io).to receive(:puts).with("What would you like to do? Choose one from below")
      expect(io).to receive(:puts).with("1 to list all items with their prices.")
      expect(io).to receive(:puts).with("2 to list all items with their stock quantities")
      expect(io).to receive(:puts).with("3 to list all orders made to this day")
      expect(io).to receive(:puts).with("4 to list all orders made by a specific customer")
      expect(io).to receive(:puts).with("5 to create a new item")
      expect(io).to receive(:puts).with("6 to create a new order")
      expect(io).to receive(:puts).with("9 to exit program")
      expect(io).to receive(:gets).and_return("1")
      app.ask_for_choice
    end
    
  end
end
