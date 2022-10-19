require 'order_repository'

def reset_tables
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

RSpec.describe OrderRepository do
  before(:each) do 
    reset_tables
  end
  
  describe "#all" do
    it "returns an array of Order objects" do
      repo = OrderRepository.new
      all_orders = repo.all
        
      expect(all_orders.length).to eq 6
      expect(all_orders.first.id).to eq 1
      expect(all_orders.first.order_date).to eq '2022-10-10'
      expect(all_orders.first.customer_name).to eq 'customer_1'
      expect(all_orders.last.id).to eq 6
      expect(all_orders.last.order_date).to eq '2022-10-09'
      expect(all_orders.last.customer_name).to eq 'customer_6'
    end
  end
  
  describe "#find" do
    it "returns an Order object given a record id" do
      repo = OrderRepository.new
      id_to_find = 5
      found_item = repo.find(id_to_find)
      
      expect(found_item.id).to eq 5
      expect(found_item.order_date).to eq '2022-10-17'
      expect(found_item.customer_name).to eq 'customer_5'
    end
    
    it "returns false if the record id doesn't exist" do
      repo = OrderRepository.new
      id_to_find = 100
      expect(repo.find(id_to_find)).to eq false
    end
  end
  
  describe "#create" do
    it "add a record to the table given an Order object" do
      new_order = Order.new
      new_order.order_date = '2022-10-19'
      new_order.customer_name = 'new_customer'
      
      repo = OrderRepository.new
      number_of_orders = repo.all.length
      repo.create(new_order)
      
      expect(repo.all.length).to eq (number_of_orders + 1)
      expect(repo.all).to include (
        have_attributes(
          order_date: '2022-10-19',
          customer_name: 'new_customer'
        )
      )
    end
  end
  
  describe "#find_by_item" do
    it "returns an array of all orders containing a given item" do
      repo = OrderRepository.new
      item_id = 2
      orders = repo.find_by_item(item_id)
      
      expect(orders.length).to eq 3
      expect(orders.first.id).to eq 4
      expect(orders.first.order_date).to eq '2022-10-11'
      expect(orders.first.customer_name).to eq 'customer_4'
    end
    
    it "returns false if the array is empty" do
      repo = OrderRepository.new
      item_id = 200
      orders = repo.find_by_item(item_id)
      expect(orders).to eq false
    end
  end
  
  describe "#assign_order_to_item" do
    it "assigns an order to item given order id and item id" do
      repo = OrderRepository.new
      new_order = Order.new
      
      item_id_to_link = 1
      order_to_link = repo.find(3)
      
      repo.assign_order_to_item(order_to_link.id, item_id_to_link)
      
      orders = repo.find_by_item(item_id_to_link)
            
      expect(orders).to include (
        have_attributes(
          id: 3,
          order_date: '2022-10-18',
          customer_name: 'customer_3'
        )
      )
    end
  end

end
