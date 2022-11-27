class CreateOrder

  def create_order(item_repository, order_repository, io)
    order = Order.new
    item_id_match = false
    order.order_date = ""

    io.puts "Enter Customer name:"
    order.customer_name = io.gets.chomp

    until order.order_date =~ /([12]\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01]))/  do
      io.puts "Enter Order date:"
      order.order_date = io.gets.chomp
    end

    until item_id_match == true do   
    io.puts "Enter Item ID:"
      order.item_id = io.gets.chomp.to_i 
      item_repository.all.each do |item|
        if item.id == order.item_id
          item_id_match = true
        end
      end
    end
    
    order_repository.create(order)
    added_item = order_repository.all.last.customer_name

    io.puts "Order for #{added_item} has been added"
  end

end