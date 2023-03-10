require "item_repository"
require "shared_context"

describe ItemRepository do
  def reset_table
    seed_sql = File.read('spec/seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_database' })
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
    it "shoud return a list of all 5 items" do
      result = subject.all
      expect(result.length).to eq 5
    end
    it "should return a list of items with their attributes" do
      result = subject.all
      expect(result.first.id).to eq 1
      expect(result.first.name).to eq 'Xbox series X'
      expect(result.first.price).to eq 399
      expect(result.first.quantity).to eq 20
      expect(result.last.id).to eq 5
      expect(result.last.name).to eq 'Ipad'
      expect(result.last.price).to eq 369
      expect(result.last.quantity).to eq 40
    end
  end

  describe "#find method" do
    context "with id = 1" do
      it "should return the item Xbox" do
        result = subject.find(1)
        expect(result.id).to eq 1
        expect(result.name).to eq 'Xbox series X'
        expect(result.price).to eq 399
        expect(result.quantity).to eq 20
      end
    end
    context "with id = 3" do
      it "should return the item MacBook Air" do
        result = subject.find(3)
        expect(result.id).to eq 3
        expect(result.name).to eq 'Macbook Air'
        expect(result.price).to eq 1249
        expect(result.quantity).to eq 30
      end
    end
  end

  describe "find_with_orders" do

    def orders_arr_length(id)
      item = subject.find_with_orders(id) 
      item_with_order = item.orders
      return item_with_order.length
    end
    
    it "should returns a list of 3 orders which contains an Xbox" do
      result = orders_arr_length(1)   
      expect(result).to eq 3
    end
    it "should returns a list of 2 orders which contains a Dell Monitor" do
      result = orders_arr_length(2)
      expect(result).to eq 2
    end
    it "should returns a list of 3 orders which contains a MacBook Air" do
      result = orders_arr_length(3)
      expect(result).to eq 3
    end
    it "should returns a list of 3 orders which contains a LG TV" do
      result = orders_arr_length(4) 
      expect(result).to eq 3
    end
    it "should returns a list of 3 orders which contains an Ipad" do
      result = orders_arr_length(5)
      expect(result).to eq 3
    end
  end

  describe "#create method" do
    it "should add a new item in the items table" do
      subject.create(item6)
      result = subject.find(6)
      expect(result.id).to eq 6
      expect(result.name).to eq 'GoPro 11'
      expect(result.price).to eq 400
      expect(result.quantity).to eq 45
    end
  end

  describe "#update method" do
    it "should update all attributes of an item" do
      allow(item1).to receive(:name) { "PS5" }
      allow(item1).to receive(:price) { 479 }
      allow(item1).to receive(:quantity) { 10 }
      subject.update(item1)
      result = subject.find(1)
      expect(result.id).to eq 1
      expect(result.name).to eq "PS5"
      expect(result.price).to eq 479
      expect(result.quantity).to eq 10
    end
    it "should update changed attributes and keep unchanged ones" do
      allow(item1).to receive(:price) { 349 }
      subject.update(item1)
      result = subject.find(1)
      expect(result.id).to eq 1
      expect(result.name).to eq 'Xbox series X'
      expect(result.price).to eq 349
      expect(result.quantity).to eq 20
    end
  end

  describe "#delete method" do
    it "should remove an item from the items table" do
      subject.delete(1)
      result = subject.all
      expect(result.length).to eq 4
      expect(result.first.id).to eq 2
      expect { subject.find(1) }.to raise_error IndexError
    end
  end
end
