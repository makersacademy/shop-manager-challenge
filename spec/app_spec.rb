require_relative '../app'

RSpec.describe Application do
  let(:database_name) { 'shop_manager_test' }
  let(:io) { double('IO') }
  let(:item_repository) { double('ItemRepository') }
  let(:order_repository) { double('OrderRepository') }
  let(:order_item_repository) { double('OrderItemRepository') }


  subject(:app) { Application.new(database_name, io, item_repository, order_repository, order_item_repository) }

  describe '#run' do
    context 'when choice is 1' do
      let(:items) { [double('Item', id: 1, name: 'CPU', unit_price: 76.99, quantity: 7)] }

      before do
        allow(io).to receive(:puts)
        allow(io).to receive(:print)
        allow(io).to receive(:gets).and_return("1\n")

        allow(item_repository).to receive(:all).and_return(items)
      end

      it 'lists all items in stock' do
        expect(io).to receive(:puts).with("----------------------------------------------")
        expect(io).to receive(:puts).with("Welcome to the shop management program!\n\n")
        expect(io).to receive(:puts).with("What do you want to do?")
        expect(io).to receive(:puts).with(" 1 = list all shop items")
        expect(io).to receive(:puts).with(" 2 = create a new item")
        expect(io).to receive(:puts).with(" 3 = list all orders")
        expect(io).to receive(:puts).with(" 4 = create a new order")
        expect(io).to receive(:print).with("\nEnter your choice: ")
        expect(io).to receive(:puts).with("\nHere's a list of all shop items:")
        expect(io).to receive(:puts).with(" #1 CPU - Unit price: 76.99 - Quantity: 7")

        app.run
      end
    end

    context 'when choice is 2' do
      let(:new_item_data) { { name: 'New Item', unit_price: 9.99, quantity: 5 } }
      let(:new_item) { double('Item') }
    
      before do
        allow(io).to receive(:puts)
        allow(io).to receive(:print)
        allow(io).to receive(:gets).and_return("2\n", new_item_data[:name], new_item_data[:unit_price].to_s, new_item_data[:quantity].to_s)
    
        allow(item_repository).to receive(:create).and_return(true)
        allow(Item).to receive(:new).and_return(new_item)
        allow(new_item).to receive(:name=)
        allow(new_item).to receive(:unit_price=)
        allow(new_item).to receive(:quantity=)
      end
    
      it 'creates a new item' do
        expect(io).to receive(:puts).with("----------------------------------------------")
        expect(io).to receive(:puts).with("Welcome to the shop management program!\n\n")
        expect(io).to receive(:puts).with("What do you want to do?")
        expect(io).to receive(:puts).with(" 1 = list all shop items")
        expect(io).to receive(:puts).with(" 2 = create a new item")
        expect(io).to receive(:puts).with(" 3 = list all orders")
        expect(io).to receive(:puts).with(" 4 = create a new order")
        expect(io).to receive(:print).with("\nEnter your choice: ")
        expect(io).to receive(:puts).with("\nCreating a new item...")
        expect(io).to receive(:print).with("Enter item name: ")
        expect(io).to receive(:print).with("Enter unit price: ")
        expect(io).to receive(:print).with("Enter quantity: ")
        expect(io).to receive(:puts).with("\nNew item created successfully.\n")
    
        expect(Item).to receive(:new).and_return(new_item)
        expect(new_item).to receive(:name=).with(new_item_data[:name])
        expect(new_item).to receive(:unit_price=).with(new_item_data[:unit_price])
        expect(new_item).to receive(:quantity=).with(new_item_data[:quantity])
        expect(item_repository).to receive(:create).with(new_item)
    
        app.run
      end
    end
    
    

    context 'when choice is 3' do
      let(:orders) { [double('Order', id: 1, customer_name: 'Test_name', order_date: '2023-08-26')] }

      before do
        allow(io).to receive(:puts)
        allow(io).to receive(:print)
        allow(io).to receive(:gets).and_return("3\n")

        allow(order_repository).to receive(:all).and_return(orders)
      end

      it 'lists all orders' do
        expect(io).to receive(:puts).with("----------------------------------------------")
        expect(io).to receive(:puts).with("Welcome to the shop management program!\n\n")
        expect(io).to receive(:puts).with("What do you want to do?")
        expect(io).to receive(:puts).with(" 1 = list all shop items")
        expect(io).to receive(:puts).with(" 2 = create a new item")
        expect(io).to receive(:puts).with(" 3 = list all orders")
        expect(io).to receive(:puts).with(" 4 = create a new order")
        expect(io).to receive(:print).with("\nEnter your choice: ")
        expect(io).to receive(:puts).with("\nHere's a list of all orders:")
        expect(io).to receive(:puts).with(" #1 - Customer Name: Test_name - Order Date: 2023-08-26\n")

        app.run
      end
    end

    context 'when choice is 4' do
      let(:customer_name) { 'Test Customer' }
      let(:new_order) { double('Order', id: 1) } # Mocked order with id
      let(:item_id) { 1 }
      let(:item) { double('Item') }
      let(:order_id) { 1 } # Newly created order id
    
      before do
        allow(io).to receive(:puts)
        allow(io).to receive(:print)
        allow(io).to receive(:gets).and_return("4\n", customer_name, 'n')
    
        allow(Order).to receive(:new).and_return(new_order)
        allow(new_order).to receive(:customer_name=)
        allow(new_order).to receive(:order_date=)
        allow(order_repository).to receive(:all).and_return([new_order]) # Return the mocked order in the repository
        allow(new_order).to receive(:id).and_return(order_id) # Return the mocked order id
      end
    
      it 'creates a new order' do
        allow(order_repository).to receive(:create)
        allow(io).to receive(:print).with("Do you want to add an item to this order? (y/n):\n ").and_return("n\n")
        expect(io).to receive(:puts).with("----------------------------------------------")
        expect(io).to receive(:puts).with("Welcome to the shop management program!\n\n")
        expect(io).to receive(:puts).with("What do you want to do?")
        expect(io).to receive(:puts).with(" 1 = list all shop items")
        expect(io).to receive(:puts).with(" 2 = create a new item")
        expect(io).to receive(:puts).with(" 3 = list all orders")
        expect(io).to receive(:puts).with(" 4 = create a new order")
        expect(io).to receive(:print).with("\nEnter your choice: ")
        expect(io).to receive(:puts).with("\nCreating a new order...")
        expect(io).to receive(:print).with("Enter customer name: ")
        expect(io).to receive(:puts).with("\nNew order created successfully.\n")
    
        expect(Order).to receive(:new).and_return(new_order)
        expect(new_order).to receive(:customer_name=).with(customer_name)
        expect(new_order).to receive(:order_date=).with(Date.today)
        expect(order_repository).to receive(:create).with(new_order)
    
        app.run
      end
    
      it 'does not prompt to add items when choice is "n"' do
        allow(order_repository).to receive(:create)
        expect(io).to receive(:print).with("Do you want to add an item to this order? (y/n):\n ").and_return("n\n")
    
        app.run
      end
    
      context 'when user wants to add an item' do
        let(:item_name) { "Item" }
        let(:customer_name) { "John Doe" }
        let(:new_order) { instance_double(Order) }
        
        before do
          allow(io).to receive(:puts)
          allow(io).to receive(:print)
          allow(io).to receive(:gets).and_return("4\n", customer_name, 'y', item_id.to_s)
          
          allow(item_repository).to receive(:all).and_return([item])
          allow(item_repository).to receive(:find).with(item_id).and_return(item)
          allow(order_item_repository).to receive(:create)
          
          allow(Order).to receive(:new).and_return(new_order)
          allow(new_order).to receive(:customer_name=)
          allow(new_order).to receive(:order_date=)
          allow(order_repository).to receive(:all).and_return([new_order]) # Return the mocked order in the repository
          allow(new_order).to receive(:id).and_return(order_id) # Return the mocked order id
          allow(order_repository).to receive(:create).and_return(nil)
          allow(item).to receive(:id).and_return(item_id).at_least(:once)
          
          allow(item).to receive(:name)
          allow(item).to receive(:unit_price)
          allow(item).to receive(:quantity)
        end
      
        it 'allows the user to add an item to the order' do
          # Stub the create method to return the order item
          order_item = OrderItem.new
          order_item.order_id = order_id
          order_item.item_id = item_id
          order_item.quantity = 5
          allow(order_item_repository).to receive(:create).with(order_id, item_id).and_return(order_item)
          
          # Call the method under test
          subject.run
          
        
          expect(order_item_repository).to have_received(:create).with(order_id, item_id)
          expect(io).to have_received(:puts).with("Item added to the order.\n")
        end
      end
      
    end
       
  end
end