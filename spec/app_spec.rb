require "shared_context"
require_relative "../app"

describe Application do

  def reset_table
    seed_sql = File.read('spec/seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_database' })
    connection.exec(seed_sql)
  end

  before(:each) do 
    reset_table
  end

  include_context "doubles setup"

  subject do 
    described_class.new( 'shop_database', kernel, orderRepo, itemRepo )
  end

  context "#initialize method" do
    it "should accepts a number of four arguments" do
      expect(subject).to be
    end
    it "should throw an error when given a wrong number of arguments" do
      expect { described_class.new }.to raise_error ArgumentError
    end
  end

  describe "#run method" do
    it "should output the 'Orders Manager' options when the user enters 1" do
      allow(kernel).to receive(:gets) { "1" }
      subject.run
      expect(kernel).to have_received(:puts).with("Orders Manager")
    end
    it "should output the 'Items Manager' options when the user enters 1" do
      allow(kernel).to receive(:gets) { "2" }
      subject.run
      expect(kernel).to have_received(:puts).with("Items Manager")
    end

    context "in the 'Orders Manager' context" do
      context "Option 1" do
        it "should output a formatted list of all orders" do
          expect(kernel).to receive(:gets) { "1" }
          expect(kernel).to receive(:gets) { "1" }
          expect(orderRepo).to receive(:all) { [order1, order2, order3, order4, order5] }
          subject.run
          expect(kernel).to have_received(:puts).with("OrderID: 1") 
          expect(kernel).to have_received(:puts).with("Date: #{order1.date}") 
          expect(kernel).to have_received(:puts).with("Customer: #{order1.customer}") 
          expect(kernel).to have_received(:puts).with("OrderID: #{order2.id}") 
          expect(kernel).to have_received(:puts).with("Date: #{order2.date}") 
          expect(kernel).to have_received(:puts).with("Customer: #{order2.customer}") 
          expect(kernel).to have_received(:puts).with("OrderID: #{order3.id}") 
          expect(kernel).to have_received(:puts).with("Date: #{order3.date}") 
          expect(kernel).to have_received(:puts).with("Customer: #{order3.customer}") 
        end
      end

      context "Option 2" do
        it "should output a formatted form of the selected order - test 1" do
          expect(kernel).to receive(:gets) { "1" }
          expect(kernel).to receive(:gets) { "2" }
          expect(kernel).to receive(:gets) { "1" }
          expect(orderRepo).to receive(:find).with(1) { order1 }
          subject.run
          expect(kernel).to have_received(:puts).with("OrderID: #{order1.id}") 
          expect(kernel).to have_received(:puts).with("Date: #{order1.date}") 
          expect(kernel).to have_received(:puts).with("Customer: #{order1.customer}") 
        end
        it "should output a formatted form of the selected order - test 2" do
          expect(kernel).to receive(:gets) { "1" }
          expect(kernel).to receive(:gets) { "2" }
          expect(kernel).to receive(:gets) { "5" }
          expect(orderRepo).to receive(:find).with(5) { order5 }
          subject.run
          expect(kernel).to have_received(:puts).with("OrderID: #{order5.id}") 
          expect(kernel).to have_received(:puts).with("Date: #{order5.date}") 
          expect(kernel).to have_received(:puts).with("Customer: #{order5.customer}") 
        end
      end

      context "Option 3" do
        it "should add a new order" do
          expect(kernel).to receive(:gets) { "1" }
          expect(kernel).to receive(:gets) { "3" }
          expect(kernel).to receive(:gets) { "2023-03-03" }
          expect(kernel).to receive(:gets) { "Pam" }
          expect(kernel).to receive(:gets) { "5" }
          expect(orderRepo).to receive(:create)
          subject.run
        end
      end

      context "Option 4" do
        it "should update only the date of an existing order" do
          expect(kernel).to receive(:gets) { "1" }
          expect(kernel).to receive(:gets) { "4" }
          expect(kernel).to receive(:puts).with("Which order?")
          expect(kernel).to receive(:puts).with("(Enter the order ID)")
          expect(kernel).to receive(:gets) { "1" }
          expect(kernel).to receive(:puts).with("Which attributes?")
          expect(kernel).to receive(:puts).with(" 1 - date of order")
          expect(kernel).to receive(:puts).with(" 2 - customer name")
          expect(kernel).to receive(:puts).with(" 3 - list of items")
          expect(kernel).to receive(:puts).with(" 4 - all of the above")
          expect(kernel).to receive(:gets) { "1" }
          expect(kernel).to receive(:gets) { "2023-03-03" }
          expect(orderRepo).to receive(:update)
          subject.run
        end
        it "should update only the customer name of an existing order" do
          expect(kernel).to receive(:gets) { "1" }
          expect(kernel).to receive(:gets) { "4" }
          expect(kernel).to receive(:gets) { "1" }
          expect(kernel).to receive(:gets) { "2" }
          expect(kernel).to receive(:gets) { "James" }
          expect(orderRepo).to receive(:update)
          subject.run
        end
        it "should update only the list of items of an existing order" do
          expect(kernel).to receive(:gets) { "1" }
          expect(kernel).to receive(:gets) { "4" }
          expect(kernel).to receive(:gets) { "1" }
          expect(kernel).to receive(:gets) { "3" }
          expect(kernel).to receive(:gets) { "1,2,3" }
          expect(orderRepo).to receive(:update)
          subject.run
        end
        it "should update all attributes of an existing order" do
          expect(kernel).to receive(:gets) { "1" }
          expect(kernel).to receive(:gets) { "4" }
          expect(kernel).to receive(:gets) { "1" }
          expect(kernel).to receive(:gets) { "4" }
          expect(kernel).to receive(:gets) { "2023-03-03" }
          expect(kernel).to receive(:gets) { "James" }
          expect(kernel).to receive(:gets) { "1,2,3" }
          expect(orderRepo).to receive(:update)
          subject.run
        end
      end

      context "Option 5" do
        it "should delete an existing order" do
          expect(kernel).to receive(:gets) { "1" }
          expect(kernel).to receive(:gets) { "5" }
          expect(kernel).to receive(:puts).with("Which order?")
          expect(kernel).to receive(:puts).with("(Enter the order ID)")
          expect(kernel).to receive(:gets) { "1" }
          expect(orderRepo).to receive(:delete)
          subject.run
        end
      end
    end
  end 
end
