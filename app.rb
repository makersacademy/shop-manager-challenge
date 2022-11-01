#RUN THE SHOP PROGRAM FROM HERE
$LOAD_PATH << "lib"
require 'orders'
require 'stocks'

class Application

    def initialize (database,inputkernel,orders_repo,stocks_repo)
        DatabaseConnection.connect(database)
        @io = inputkernel
        @ordersrepo = orders_repo
        @stocksrepo = stocks_repo
        
    end

    def run
      input1 = ""
      while input1 != 8 do
        @io.puts "Welcome to the shop management program!"\
          "\nWhat do you want to do?"\
            "\n   1 = list all shop items"\
            "\n   2 = create a new item"\
            "\n   3 = delete an item"\
            "\n   4 = list all orders"\
            "\n   5 = create a new order"\
            "\n   6 = find a customer's order"\
            "\n   7 = view customers of a product"\
            "\n   8 = exit program"
          input1 = @io.gets.chomp.to_i
          case input1
            when 1 then 
              @io.p @stocksrepo.show_all_stock
            when 2 then 
              @io.puts "enter your addition in format item-price-qty"
              input2 = @io.gets.chomp.split('-')
              @stocksrepo.add_new_item(input2[0],input2[1],input2[2])
              @io.puts "#{input2[0]} successfully added to catalogue"
            when 3 then
              @io.puts "enter the id of the item to delete"
              input3 = @io.gets.chomp.to_i
              @stocksrepo.delete_stock(input3)
              @io.puts "item successfully deleted"
            when 4 then 
              @io.p @ordersrepo.show_customer_orders
            when 5 then
              @io.puts "enter your addition in format name:date:itemid:qty"
              input5 = @io.gets.chomp.split(':')
              @ordersrepo.add_new_order(input5[0],input5[1],input5[2],input5[3])
              @io.puts "#{input5[0]} successfully added to orders"
            when 6 then
              @io.puts "enter customer name"
              input6 = @io.gets.chomp
              @ordersrepo.show_order_details_single(input6).each{|line| @io.puts "#{line['customer_name']} ordered "\
              "#{line['stock_item_ordered_qty']}x of #{line['item_name']} on #{line['order_date']}"}
            when 7 then
              @io.puts "enter item name"
              input7 = @io.gets.chomp
              @io.puts "#{input7} bought by:"
              @stocksrepo.view_customers_who_bought(input7).each {|line| @io.puts "#{line['customer_name']} on #{line['order_date']}"}
            when 8 then @io.print "Goodbye!!!!!"
          end
      end
    end

end

if __FILE__ == $0
    app = Application.new(
      'shop2',
      Kernel,
      OrdersRepo.new,
      StockItemsRepo.new
    )
    app.run
end



