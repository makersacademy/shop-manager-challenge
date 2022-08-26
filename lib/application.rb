require_relative './database_connection.rb'
require_relative './order_repository.rb'

class Application
    def initialize (database_name, item_repository, order_repository, io=Kernel )
        DatabaseConnection.connect(database_name)
        @item_repo = item_repository
        @order_repo = order_repository
        @io = io
    end

    def run
        @io.puts "Welcome to the Shop Managing Software v17.34 by Nick Incorporated\n\n\n -----Please follow the instructions laid out below to manage your shop-----"
        user_input_choice
        #Starts the terminal interaction with the customer
        # order = Order.new
        # order.customer_name = customer_name
        # order.order_date = Time.now --> formatted
        # order.items_to_buy = [1,2,3,4]
    
        # orderrepo = OrderRepository.new
        # orderrepo.create(order)
    end

    private
    # Printing lists
    def print_item_list
        item_list = @item_repo.all.map do |record|
            "#{record.id} - #{record.item_name}: £#{sprintf("%.2f" % record.item_price.to_f.round(2))}"
        end
        return item_list.join("\n")
    end

    def print_order_list
        order_list = []
        @order_repo.all.each do |record|
            order_list << "\n#{record.id} - #{record.customer_name} on date: #{record.order_date}" 
            order_list << "\n       " + item_names_by_order(record.customer_name).join("\n       ")
        end
        return order_list.join("")
    end

    #Terminal flow

    def user_input_choice
        @io.puts "\n\nPlease type either 'list items', 'add item', 'list orders' or 'add order'"
        @io.puts "Type 'quit' to exit the manager".center(73)
        input_choice = @io.gets.chomp.downcase
        unless input_choice == 'quit'
            menu_choice_flow(input_choice)
        end
        return nil 
    end

    def menu_choice_flow(input_choice)
        if input_choice == 'list items'
            @io.puts print_item_list 
        elsif input_choice == 'add item'
            create_item 
        elsif input_choice == 'list orders'
            @io.puts print_order_list 
        elsif input_choice == 'add order'
            create_order 
        else 
            @io.puts "\n\n** Error - please input your command carefully ** \n\n"
        end
        self.user_input_choice
    end

    #Adding to database

    def create_order
        order = Order.new
        @io.puts "Please type in the customer's name"
        order.customer_name = @io.gets.chomp
        @io.puts "Please type in the item number of the items the customer wishes to order, separated by a comma ','."
        
        item_choices = @io.gets.chomp.split(',')
        item_choices.each do |item|
            order.items_to_buy << item.strip.to_i
        end

        order.order_date = Time.now.strftime("%Y-%m-%d")
        p order.items_to_buy
        @order_repo.create(order)
        return nil
    end

    def create_item
        item = Item.new
        @io.puts("Please type in the item's name\n")
        item.item_name = @io.gets.chomp
        @io.puts("Please type in the cost of the item without a pound sign\n")
        item.item_price = @io.gets.chomp
        @io.puts("Please type in the quantity of the items you have available to sell\n")
        item.item_quantity = @io.gets.chomp
        @item_repo.create(item)
        return nil
    end



    def item_names_by_order(customer_name) 
        item_names = (@order_repo.find_items_by_customer_name(customer_name)).map do |record|
            record.item_name
        end
        return item_names
    end
end

if __FILE__ == $0
    app = Application.new(
      'shop_manager',
      ItemRepository.new,
      OrderRepository.new,
      Kernel
    )
    app.run
end
