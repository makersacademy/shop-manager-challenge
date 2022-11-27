class CreateOrder

  def initialize(item_repository, order_repository, io)
    @io = io
    @order_repository = order_repository
    @item_repository = item_repository
  end

  def create_order
    order = Order.new

    enter_customer_name(order)
    enter_order_date(order)
    enter_item_id(order)
    
    @order_repository.create(order)

    confirmation_message
  end

  private

  def enter_customer_name(order)
    @io.puts "Enter Customer name:"
    order.customer_name = @io.gets.chomp
  end

  def enter_order_date(order)
    order.order_date = ""
    until order.order_date =~ /([12]\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01]))/  do
      @io.puts "Enter Order date (YYYY-MM-DD):"
      order.order_date = @io.gets.chomp
    end
  end

  def enter_item_id(order)
    item_id_match = false
    until item_id_match == true do   
      @io.puts "Enter Item ID:"
      order.item_id = @io.gets.chomp.to_i 
      @item_repository.all.each do |item|
        item_id_match = true if item.id == order.item_id
      end
    end
  end

  def confirmation_message
    added_item = @order_repository.all.last.customer_name
    @io.puts "Order for #{added_item} has been added"
  end
end