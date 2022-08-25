USER STORIES


As a shop manager
So I can know which items I have in stock
I want to keep a list of my shop items with their name and unit price. < table

As a shop manager
So I can know which items I have in stock
I want to know which quantity (a number) I have for each item.

As a shop manager
So I can manage items
I want to be able to create a new item.

As a shop manager
So I can know which orders were made
I want to keep a list of orders with their customer name.

As a shop manager
So I can know which orders were made
I want to assign each order to their corresponding item.

As a shop manager
So I can know which orders were made
I want to know on which date an order was placed. 

As a shop manager
So I can manage orders
I want to be able to create a new order.

Methods required to:
Print to terminal the instruction
Get user input for either:
 - print list of items
 - print list of order
 - add new item
 - add new order (with date and match to items)


 Class structure:

 ```ruby

class Application

    def run
        #Starts the terminal interaction with the customer
    end

    private

    def print_item_list
        #prints item list with format "#{id} - #{item_name}
    end

    def print_order_list
        #prints order list with format "#{id} - #{customer_name} 
            #print item ordered underneath the customer names?
    end

    def user_input_choice
        #Asks the user for an input choice, stores the input choice and determines the next step
    end

    def create_order
        #Asks customer for their name
        #Asks customer for the item_ids they wish to purchase
        #Stores the date of the order
        #Calls the create_order method from OrderRepository
    end

    def create_item
        #Asks customer for item name, item price, and item quantity.
    end
end

 ```