require "shared_context"
require_relative "../app"

describe Application do
  
  include_context "doubles setup"

  subject do 
    described_class.new('shop_database', kernel, orderRepo, itemRepo)
  end

  describe "#initialize method" do
    it "should instantiate a new object" do
      expect(subject).to be
    end
    it "should throw an error when given a wrong number of arguments" do
      expect { described_class.new }.to raise_error ArgumentError
    end
  end

  describe "#run method" do
    it "should output the 'Order Manager' options when the user enters 1" do
      allow(kernel).to receive(:gets) { "1" }
      subject.run
      expect(kernel).to have_received(:puts).with("ORDER MANAGER")
    end
    it "should output the 'Item Manager' options when the user enters 1" do
      allow(kernel).to receive(:gets) { "2" }
      subject.run
      expect(kernel).to have_received(:puts).with("ITEM MANAGER")
    end
    it "should ask again when the user enters invalid input" do
      expect(kernel).to receive(:gets) { "3" }
      expect(kernel).to receive(:puts).with("Sorry, option not available")
      expect(kernel).to receive(:gets) { "1" }
      expect(kernel).to receive(:gets) { "1" }
      subject.run
    end

    context "When in the 'Order Manager'" do

      context "with invalid input" do

        it "should restart the loop" do
          expect(kernel).to receive(:gets) { "1" }
          expect(kernel).to receive(:gets) { "6" }
          expect(kernel).to receive(:gets) { "1" }
          subject.run
        end

      end

      context "Option 1 - all orders" do

        it "should output a formatted list of all orders" do
          expect(kernel).to receive(:gets) { "1" }
          expect(kernel).to receive(:gets) { "1" }
          expect(orderRepo).to receive(:all) { [order1, order2, order3, order4, order5] }
          subject.run
          expect(kernel).to have_received(:puts).with("Date: #{order1.date}") 
          expect(kernel).to have_received(:puts).with("Customer: #{order1.customer}") 
          expect(kernel).to have_received(:puts).with("Date: #{order2.date}") 
          expect(kernel).to have_received(:puts).with("Customer: #{order2.customer}") 
          expect(kernel).to have_received(:puts).with("Date: #{order3.date}") 
          expect(kernel).to have_received(:puts).with("Customer: #{order3.customer}") 
        end
      end

      context "Option 2 - find orders" do

        context "then an id not found" do
          it "should restart the loop" do
            expect(kernel).to receive(:gets) { "1" }
            expect(kernel).to receive(:gets) { "2" }
            expect(kernel).to receive(:gets) { "6" }
            expect(orderRepo).to receive(:find).and_raise(IndexError)
            expect(kernel).to receive(:puts).with "Sorry, this order doesn't exist. Try again."
            expect(kernel).to receive(:gets) { "1" }
            subject.run
          end
        end

        it "should output a formatted form of the selected order - test 1" do
          expect(kernel).to receive(:gets) { "1" }
          expect(kernel).to receive(:gets) { "2" }
          expect(kernel).to receive(:gets) { "1" }
          expect(orderRepo).to receive(:find).with(1) { order1 }
          subject.run
          expect(kernel).to have_received(:puts).with("Date: #{order1.date}") 
          expect(kernel).to have_received(:puts).with("Customer: #{order1.customer}") 
        end
        it "should output a formatted form of the selected order - test 2" do
          expect(kernel).to receive(:gets) { "1" }
          expect(kernel).to receive(:gets) { "2" }
          expect(kernel).to receive(:gets) { "5" }
          expect(orderRepo).to receive(:find).with(5) { order5 }
          subject.run
          expect(kernel).to have_received(:puts).with("Date: #{order5.date}") 
          expect(kernel).to have_received(:puts).with("Customer: #{order5.customer}") 
        end
      end

      context "Option 3 - create order" do

        it "should add a new order" do
          expect(kernel).to receive(:gets) { "1" }
          expect(kernel).to receive(:gets) { "3" }
          expect(kernel).to receive(:gets) { "2023-03-03" }
          expect(kernel).to receive(:gets) { "Pam" }
          expect(kernel).to receive(:gets) { "5" }
          expect(orderRepo).to receive(:create)
          subject.run
        end
        it "should ignore items not found" do
          expect(kernel).to receive(:gets) { "1" }
          expect(kernel).to receive(:gets) { "3" }
          expect(kernel).to receive(:gets) { "2023-03-03" }
          expect(kernel).to receive(:gets) { "Pam" }
          expect(kernel).to receive(:gets) { "2" }
          expect(itemRepo).to receive(:find).and_raise(IndexError)
          expect(kernel).to receive(:puts).with("1 item not found was ignored.")
          subject.run
        end
      end

      context "Option 4 - update order" do

        it "should restart the loop if invalid input" do
          expect(kernel).to receive(:gets) { "1" }
          expect(kernel).to receive(:gets) { "4" }
          expect(kernel).to receive(:gets) { "1" }
          expect(kernel).to receive(:gets) { "5" }
          expect(kernel).to receive(:puts).with("Sorry, choice not available. Try again.")
          expect(kernel).to receive(:gets) { "2" }
          expect(kernel).to receive(:gets) { "James" }
          subject.run
        end
        it "should update only the date of an existing order" do
          expect(kernel).to receive(:gets) { "1" }
          expect(kernel).to receive(:gets) { "4" }
          expect(kernel).to receive(:gets) { "1" }
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

      context "Option 5 - delete" do
        
        it "should delete an existing order" do
          expect(kernel).to receive(:gets) { "1" }
          expect(kernel).to receive(:gets) { "5" }
          expect(kernel).to receive(:gets) { "1" }
          expect(orderRepo).to receive(:delete)
          subject.run
        end
      end

      context "Option 9 - switch manager" do

        it "should switch manager menu" do
          expect(kernel).to receive(:gets) { "1" }
          expect(kernel).to receive(:gets) { "9" }
          expect(kernel).to receive(:puts).with("ITEM MANAGER")
          expect(kernel).to receive(:gets) { "1" }
          expect(itemRepo).to receive(:all)
          subject.run
        end
      end
    end

    describe "When in the 'Item Manager'" do

      context "the user enter an invalid input" do

        it "should restart the loop" do
          expect(kernel).to receive(:gets) { "2" }
          expect(kernel).to receive(:gets) { "6" }
          expect(kernel).to receive(:gets) { "1" }
          subject.run
        end

      end

      context "Option 1 - see all items" do

        it "should output a formatted list of all items" do
          expect(kernel).to receive(:gets) { "2" }
          expect(kernel).to receive(:gets) { "1" }
          expect(itemRepo).to receive(:all) { [item1, item2, item3, item4, item5] }
          subject.run
          expect(kernel).to have_received(:puts).with("Item: #{item1.name}")
          expect(kernel).to have_received(:puts).with("Price: £#{item1.price}")
          expect(kernel).to have_received(:puts).with("Quantity: #{item1.quantity}")
          expect(kernel).to have_received(:puts).with("Item: #{item2.name}")
          expect(kernel).to have_received(:puts).with("Price: £#{item2.price}")
          expect(kernel).to have_received(:puts).with("Quantity: #{item2.quantity}")
          expect(kernel).to have_received(:puts).with("Item: #{item3.name}")
          expect(kernel).to have_received(:puts).with("Price: £#{item3.price}")
          expect(kernel).to have_received(:puts).with("Quantity: #{item3.quantity}")
        end

      end

      describe "Option 2 - find item" do

        before(:each) do
          expect(kernel).to receive(:gets) { "2" }
          expect(kernel).to receive(:gets) { "2" }
        end

        context "the user enter an invalid choice of find method" do
          it "should restart the loop" do
            expect(kernel).to receive(:gets) { "3" }
            expect(kernel).to receive(:gets) { "1" }
            expect(kernel).to receive(:gets) { "1" }
            subject.run
          end
        end

        context "then 1 to see just the item" do

          context "then an id not found" do
            it "should restart the loop" do
              expect(kernel).to receive(:gets) { "1" }
              expect(kernel).to receive(:gets) { "6" }
              expect(itemRepo).to receive(:find).and_raise(IndexError)
              expect(kernel).to receive(:puts).with "Sorry, this item doesn't exist. Try again."
              expect(kernel).to receive(:gets) { "1" }
              subject.run
            end
          end

          it "should output a formatted form of the selected item - test 1" do
            expect(kernel).to receive(:gets) { "1" }
            expect(kernel).to receive(:gets) { "1" }
            expect(itemRepo).to receive(:find).with(1) { item1 }
            subject.run
            expect(kernel).to have_received(:puts).with("Item: #{item1.name}") 
            expect(kernel).to have_received(:puts).with("Price: £#{item1.price}")
            expect(kernel).to have_received(:puts).with("Quantity: #{item1.quantity}")
          end
          it "should output a formatted form of the selected item - test 2" do
            expect(kernel).to receive(:gets) { "1" }
            expect(kernel).to receive(:gets) { "3" }
            expect(itemRepo).to receive(:find).with(3) { item3 }
            subject.run
            expect(kernel).to have_received(:puts).with("Item: #{item3.name}") 
            expect(kernel).to have_received(:puts).with("Price: £#{item3.price}")
            expect(kernel).to have_received(:puts).with("Quantity: #{item3.quantity}")
          end

        end

        context "then 2 to see the item with linked orders" do

          context "then an id not found" do
            it "should restart the loop" do
              expect(kernel).to receive(:gets) { "2" }
              expect(kernel).to receive(:gets) { "6" }
              expect(itemRepo).to receive(:find_with_orders).and_raise(IndexError)
              expect(kernel).to receive(:puts).with "Sorry, this item doesn't exist. Try again."
              expect(kernel).to receive(:gets) { "1" }
              subject.run
            end
          end

          it "should output a formatted form of the selected item with linked orders - test 1" do
            expect(kernel).to receive(:gets) { "2" }
            expect(kernel).to receive(:gets) { "1" }
            expect(itemRepo).to receive(:find_with_orders).with(1) { item1 }
            allow(item1).to receive(:orders) { [order1, order4, order5] }
            subject.run
            expect(kernel).to have_received(:puts).with("Item: #{item1.name}") 
            expect(kernel).to have_received(:puts).with("Price: £#{item1.price}")
            expect(kernel).to have_received(:puts).with("Quantity: #{item1.quantity}")
            expect(kernel).to have_received(:puts).with("\##{order1.id} - date: #{order1.date} - customer: #{order1.customer}")
            expect(kernel).to have_received(:puts).with("\##{order4.id} - date: #{order4.date} - customer: #{order4.customer}")
            expect(kernel).to have_received(:puts).with("\##{order5.id} - date: #{order5.date} - customer: #{order5.customer}")
          end

          it "should output a formatted form of the selected item with linked orders - test 2" do
            expect(kernel).to receive(:gets) { "2" }
            expect(kernel).to receive(:gets) { "3" }
            expect(itemRepo).to receive(:find_with_orders).with(3) { item3 }
            allow(item3).to receive(:orders) { [order2, order3, order4] }
            subject.run
            expect(kernel).to have_received(:puts).with("Item: #{item3.name}") 
            expect(kernel).to have_received(:puts).with("Price: £#{item3.price}")
            expect(kernel).to have_received(:puts).with("Quantity: #{item3.quantity}")
            expect(kernel).to have_received(:puts).with("\##{order2.id} - date: #{order2.date} - customer: #{order2.customer}")
            expect(kernel).to have_received(:puts).with("\##{order3.id} - date: #{order3.date} - customer: #{order3.customer}")
            expect(kernel).to have_received(:puts).with("\##{order4.id} - date: #{order4.date} - customer: #{order4.customer}")
          end
        end

      end

      describe "Option 3 - create item" do
        it "should add a new item" do
          expect(kernel).to receive(:gets) { "2" }
          expect(kernel).to receive(:gets) { "3" }
          expect(kernel).to receive(:gets) { "GoPro 11" }
          expect(kernel).to receive(:gets) { "400" }
          expect(kernel).to receive(:gets) { "45" }
          expect(itemRepo).to receive(:create)
          subject.run
        end
      end

      describe "Option 4 - update item" do

        before do
          expect(kernel).to receive(:gets) { "2" }
          expect(kernel).to receive(:gets) { "4" }
        end

        it "should restart the loop if invalid input" do
          expect(kernel).to receive(:gets) { "1" }
          expect(kernel).to receive(:gets) { "5" }
          expect(kernel).to receive(:puts).with("Sorry, choice not available. Try again.")
          expect(kernel).to receive(:gets) { "2" }
          expect(kernel).to receive(:gets) { "349" }
          subject.run
        end
        it "should update only the name of an existing item" do
          expect(kernel).to receive(:gets) { "1" }
          expect(kernel).to receive(:gets) { "1" }
          expect(kernel).to receive(:gets) { "Helicopter" }
          expect(itemRepo).to receive(:update)
          subject.run
        end
        it "should update only the price of an existing item" do
          expect(kernel).to receive(:gets) { "1" }
          expect(kernel).to receive(:gets) { "2" }
          expect(kernel).to receive(:gets) { "99" }
          expect(itemRepo).to receive(:update)
          subject.run
        end
        it "should update only the quantity of an existing item" do
          expect(kernel).to receive(:gets) { "1" }
          expect(kernel).to receive(:gets) { "3" }
          expect(kernel).to receive(:gets) { "100" }
          expect(itemRepo).to receive(:update)
          subject.run
        end
        it "should update all attributes of an existing order" do
          expect(kernel).to receive(:gets) { "1" }
          expect(kernel).to receive(:gets) { "4" }
          expect(kernel).to receive(:gets) { "Helicopter" }
          expect(kernel).to receive(:gets) { "99" }
          expect(kernel).to receive(:gets) { "50" }
          expect(itemRepo).to receive(:update)
          subject.run
        end
      end

      context "Option 5 - delete item" do
        it "should delete an existing order" do
          expect(kernel).to receive(:gets) { "2" }
          expect(kernel).to receive(:gets) { "5" }
          expect(kernel).to receive(:gets) { "1" }
          expect(itemRepo).to receive(:delete)
          subject.run
        end
      end

      context "Option 9 - switch manager" do

        it "should switch manager menu" do
          expect(kernel).to receive(:gets) { "2" }
          expect(kernel).to receive(:gets) { "9" }
          expect(kernel).to receive(:puts).with("ORDER MANAGER")
          expect(kernel).to receive(:gets) { "1" }
          expect(orderRepo).to receive(:all)
          subject.run
        end
      end
    end
  end 
end
