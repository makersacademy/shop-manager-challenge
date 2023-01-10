require_relative 'lib/item_repository'
require_relative 'lib/order_repository'
require_relative 'lib/item'
require_relative 'lib/order'

class Application

        def initialize(database_name, io, item_repository, order_repository)
            DatabaseConnection.connect('shop_manager_test')
          @io = io
          @item_repository = item_repository
          @order_repository = order_repository
        end
      

        def run
          welcome
          choice = @io.gets.chomp
          handle_choice(choice)
      end
      

      def welcome
      
      @io.puts "Welcome to the shop management program!"
      @io.puts
      @io.puts "What do you want to do?"
      @io.puts "1 = list all shop items"
      @io.puts "2 = create a new item"
      @io.puts "3 = list all orders"
      @io.puts "4 = create a new order"

      @io.puts
      @io.puts "Enter:"

      end

      def handle_choice(choice)

        @io.puts
        case choice
        
        when '1'
            'list_of_all_shop_items'

        when '2'
            'create_a_new_item'

        when '3'
            'list_all_orders'

        when '4'
            'create_a_new_order'

        else

            @io.puts "This choice is invalid"

        end
    end


    def list_of_all_shop_items

        @item_repository = ItemRepository.new
        items = @item_repository.all
        items.sort_by! {|item| item.id.to_i}
        items.each do |record|

            @io.puts "#{record.id} - #{record.item_name} - Unit_price: #{record.unit_price} - Quantiy: #{record.quantity}"

        end


        def create_a_new_item

            @item_repository = ItemRepository.new
            
            new_item = Item.new
        
        new_item.item_name = 'LG TV'
        new_item.unit_price = '2000'
        new_item.quantity = '7'
        new_item.order_id = '2'

        @item_repository.create(new_item)
        @io.puts "A newly item was created in the record"
        @io.puts "#{new_item.item_name} - Unit_price: #{new_item.unit_price} - Quantiy: #{new_item.quantity}"

        end

        def create_a_new_order
        @item_repository = ItemRepository.new
        new_order = Order.new
        
        new_order.order_date = '07/01/2023'
        new_order.customer_name = 'Bianca'
        new_order.item_id = '2'

        @order_repository.create(new_order)
        @io.puts "A newly order was created in the record"
        @io.puts "Customer_name: #{record.customer_name} - Order_date: #{record.order_date}"

        end

        def list_all_orders

        @order_repository = OrderRepository.new
        orders = @order_repository.all
        items.sort_by! {|order| order.id.to_i}
        orders.each do |record|
        
            @io.puts "Customer_name: #{record.customer_name} - Order_date: #{record.order_date}"

        end
    end
end


if __FILE__ == $0
    app = Application.new(
      'shop_manager_test',
      Kernel,
      ItemRepository.new,
      OrderRepository.new
    )
    app.run
  end