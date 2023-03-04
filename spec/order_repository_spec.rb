require "order_repository"
require "shared_context"

describe OrderRepository do
  def reset_table
    seed_sql = File.read('spec/seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_database_test' })
    connection.exec(seed_sql)
  end

  before(:each) do 
    reset_table
  end
  after(:each) do 
    reset_table
  end

  include_context "doubles setup"

  describe "#all method" do
    it "should returns a list of all 5 orders with their attributes" do
      result = subject.all
      expect(result.length).to eq 5
      expect(result.first.id).to eq 1
      expect(result.first.date).to eq "2023-03-01"
      expect(result.first.customer).to eq "Jim"
      expect(result.last.id).to eq 5
      expect(result.last.date).to eq "2022-11-01"
      expect(result.last.customer).to eq "Yim"
    end
    it "and also a list of items sold for each order - test 1" do
      result = subject.all

      get_order_items_length = lambda { |order| order.items.length }

      expect(get_order_items_length.call(result[0])).to eq 2
      expect(get_order_items_length.call(result[1])).to eq 2
      expect(get_order_items_length.call(result[2])).to eq 2
      expect(get_order_items_length.call(result[3])).to eq 5
      expect(get_order_items_length.call(result[4])).to eq 3
    end
    it "and also a list of items sold for each order - test 2" do
      result = subject.all

      get_order_first_item_id = lambda { |order| order.items[0].id }

      expect(get_order_first_item_id.call(result[0])).to eq 1
      expect(get_order_first_item_id.call(result[1])).to eq 2
      expect(get_order_first_item_id.call(result[2])).to eq 3
      expect(get_order_first_item_id.call(result[3])).to eq 1
      expect(get_order_first_item_id.call(result[4])).to eq 1
    end
  end

  describe "#find method" do
    context "with id = 1" do
      it "should return the order" do
        result = subject.find(1)
        expect(result.id).to eq 1
        expect(result.date).to eq "2023-03-01"
        expect(result.customer).to eq "Jim"
      end
      it "and also the list of item(s) sold" do
        result = subject.find(1)
        expect(result.items.length).to eq 2
        expect(result.items[0].name).to eq "Xbox series X"
        expect(result.items[0].price).to eq 399
        expect(result.items[0].quantity).to eq 20
      end
    end
    context "with id = 4" do
      it "should return the order" do
        result = subject.find(4)
        expect(result.id).to eq 4
        expect(result.date).to eq "2022-12-01"
        expect(result.customer).to eq "Lim"
      end
      it "and also the list of item(s) sold" do
        result = subject.find(4)
        expect(result.items.length).to eq 5
      end
    end
    context "with id = 5" do
      it "should return the order" do
        result = subject.find(5)
        expect(result.id).to eq 5
        expect(result.date).to eq "2022-11-01"
        expect(result.customer).to eq "Yim"
      end
      it "and also the list of item(s) sold" do
        result = subject.find(5)
        expect(result.items.length).to eq 3
      end
    end
  end

  describe "#create method" do

    it "should add a new order into the 'orders' table" do
      subject.create(order6)
      result = subject.find(6)
      expect(subject.all.length).to eq 6
      expect(result.id).to eq 6
      expect(result.date).to eq "2023-03-03"
      expect(result.customer).to eq "Pam"
    end
    it "and link the item sold with the order in the join table" do
      subject.create(order6)
      order = subject.find(6)
      item = order.items[0]

      expect(item.id).to eq 5
      expect(item.name).to eq "Ipad"
      expect(item.price).to eq 369
    end
    it "or multiple items with the order in the join table" do
      subject.create(order7)
      order = subject.find(6)
      items = order.items

      item_attributes = []
      get_id = lambda { |item| item_attributes << item.id }
      get_name = lambda { |item| item_attributes << item.name }
      get_price = lambda { |item| item_attributes << item.price }
      get_quantity = lambda { |item| item_attributes << item.quantity }
      
      items.each(&get_id)
      expect(item_attributes).to contain_exactly 5, 3, 2

      item_attributes = []
      items.each(&get_name)
      expect(item_attributes).to contain_exactly 'Dell Monitor 4K', 'Macbook Air', 'Ipad'

      item_attributes = []
      items.each(&get_price)
      expect(item_attributes).to contain_exactly 369, 1249, 499

      item_attributes = []
      items.each(&get_quantity)
      expect(item_attributes).to contain_exactly 29, 24, 39
    end
    it "should update the available stock of the items sold - test 1" do
      subject.create(order6)
      order = subject.find(6)
      item = order.items[0]

      expect(item.quantity).to eq 39
    end
    it "should update the available stock of the items sold - test 2" do
      subject.create(order7)
      order = subject.find(6)
      items = order.items
      expect(items[0].quantity).to eq 24
      expect(items[1].quantity).to eq 29
      expect(items[2].quantity).to eq 39
    end
  end

  describe "#update method" do
    it "should change the date and name of order with id = 1" do
      allow(order1).to receive(:date) { '2023-03-03' }
      allow(order1).to receive(:customer) { 'Pam' }

      subject.update(order1)
      result = subject.find(1)
      expect(result.id).to eq 1
      expect(result.date).to eq '2023-03-03'
      expect(result.customer).to eq 'Pam'
    end
    it "should change only the name of order id = 3" do
      allow(order3).to receive(:customer) { 'Pam' }

      subject.update(order3)
      result = subject.find(3)
      expect(result.id).to eq 3
      expect(result.date).to eq '2023-01-01'
      expect(result.customer).to eq 'Pam'
    end
    it "and can also change the list of items sold in the order" do
      allow(order3).to receive(:items) { [item1] }
      
      subject.update(order3)
      order = subject.find(3)
      items = order.items
      expect(items.length).to eq 1
    end
  end

  describe "#delete method" do
    it "should remove an order from the table" do
      subject.delete(5)
      expect(subject.all.length).to eq 4
    end
  end
end
