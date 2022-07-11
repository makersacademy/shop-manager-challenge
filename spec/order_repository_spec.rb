require 'database_connection'
require 'order_repository'
require 'order'
require 'item'
RSpec.describe OrderRepository do

  def reset_table
    DatabaseConnection.exec(File.read('spec/shop_seed.sql'))
  end 


  before(:each) do
    reset_table
  end



  it "creates a new order" do

    order_repo = OrderRepository.new
    order = Order.new
    order.customer_name = 'James'
    order.order_date = '2011-12-01'
    item_1, item_2 = Item.new('Vacuum Cleaner'), Item.new('Coffee Machine')
    item_hash = {item_1=> 1, item_2=> 2}
    order_repo.create(order, item_hash)
    expect(DatabaseConnection.exec('SELECT * FROM orders').to_a.length).to eq(4)

    

  end 









end 
