# interface class

class String
    # global method for int check later
    def numeric?
        Float(self) != nil rescue false
    end
end

class UserInterface

    def initialize(io)

        @io = io
        @item_repos = ItemRepository.new
        @order_repos = OrderRepository.new

    end

    def run

        show("Welcome to the shop management program!\n")
        menu_prompt()

    end

    private

    def show(message)
        @io.puts(message)
    end

    def prompt(message)
        @io.puts(message)
        return @io.gets.chomp
    end

    def menu_prompt()

        # menu
        show("\nWhat do you want to do?")
        menu_str = [
            "\t1 = list all shop items",
            "\t2 = create a new item",
            "\t3 = list all orders",
            "\t4 = create new order",
            "\t5 = exit"
        ].join("\n")
        show(menu_str)

        # prompt choice, keep prompting until a valid
        # input is recieved
        option_choice = ""
        while ((option_choice.to_i>0) && (option_choice.to_i<6))==false
            option_choice = prompt("Input an option [1 - 5]")
        end

        # handle choice
        case option_choice
        when "1"
            list_all_items()
        when "2"
            create_new_item()
        when "3"
            list_all_orders()
        when "4"
            create_new_order()
        when "5"
            # nothing, stop
        end

    end

    def list_all_items()

        show("\nPrinting all items...\n")

        items_array = @item_repos.all()

        items_array.each do |item|
            show("\t##{item.id} #{item.name} - Unit price: #{item.unitprice} - Quantity: #{item.quantity}\n")
        end

        show("\n#{items_array.length} items printed.\n")

        menu_prompt()

    end

    def create_new_item()

        show("\nCreate a new item...\n")

        # create, set

        new_item = Item.new
        new_item.name = ""
        new_item.unitprice = ""
        new_item.quantity = ""
        while(new_item.name.length<1)
            new_item.name = prompt("Item name:")
        end
        while(new_item.unitprice.numeric? == false)
            new_item.unitprice = prompt("Item unit price:")
        end
        while(new_item.quantity.numeric? == false)
            new_item.quantity = prompt("Item quantity:")
        end

        # add to repos

        @item_repos.create(new_item)

        # finish

        show("The item has been added. Would you like to see a list of all shop items?")
        choice = ""
        while(choice != "y" && choice != "n")
            choice = prompt("[y/n]")
        end

        if(choice=="y")
            list_all_items()
        else
            menu_prompt()
        end

    end

    def list_all_orders()

        show("\nPrinting all orders...\n")

        orders_array = @order_repos.all()

        orders_array.each do |order|
            show("\t##{order.id} #{order.item} - Customer name: #{order.customername} - Date: #{order.date}\n")
        end

        show("\n#{orders_array.length} orders printed.\n")

        menu_prompt()

    end

    def create_new_order()

        show("\nCreate a new order...\n")

        # create, set

        new_order = Order.new
        new_order.item = ""
        new_order.customername = ""
        while(new_order.item.numeric? == false)
            new_order.item = prompt("Item ID:")
        end
        while(new_order.customername.length<1)
            new_order.customername = prompt("Customer name:")
        end

        # add to repos

        @order_repos.create(new_order)

        # finish

        show("The order has been added. Would you like to see a list of all orders?")
        choice = ""
        while(choice != "y" && choice != "n")
            choice = prompt("[y/n]")
        end

        if(choice=="y")
            list_all_orders()
        else
            menu_prompt()
        end

    end

end