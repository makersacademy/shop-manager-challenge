class Application
    def initialize(database_name, io, item_repository, order_repository)
        DatabaseConnection.connect(database_name)
        @io = io
        @item_repository = item_repository
        @order_repository = order_repository
    end

    def run
        @io.puts 'Welcome to the shop management program!'
        @io.puts user_prompt
        @input = @io.gets.chomp
        while @input != 'q'
            if @input == '1'
                @io.puts "Here's a list of all shop items:\n"
                @io.puts items
                @io.puts user_prompt
                @input = @io.gets.chomp
            elsif @input == '2'
                @io.puts "Here's a list of all current orders:\n"
                @io.puts orders
                @io.puts user_prompt
                @input = @io.gets.chomp
            end
        end
        @io.puts "Tasks complete" if @input == 'q'
    end

    private

    def user_prompt
        "What do you want to do?\n 1 = list all shop items\n 2 = create a new item\n 3 = list all orders\n 4 = create a new order\n q = quit"
    end

    def items
        items_list = ""
        items = @item_repository.all
        items.each_with_index { |item, i| items_list << " ##{i + 1} - #{item.name}\n" }
        return items_list
    end

    def orders
        orders_list = ""
        orders = @order_repository.all
        orders.each_with_index { |order, i| orders_list << " ##{i + 1} - #{order.customer_name}\n" }
        return orders_list
    end
end
