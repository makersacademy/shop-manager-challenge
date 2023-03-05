module PrivateMethods

  private

  # ---------------------
  # PROMPT METHODS
  # ---------------------
  def _show(message = "")
    @io.puts message
  end

  def _prompt(message = "")
    @io.puts message
    return @io.gets.chomp
  end

  def _prompt_for_main_options(user_choice)
    _show "What would you like to do?"
    _show " 1 - view all #{user_choice}s"
    _show " 2 - view a specific #{user_choice}"
    _show " 3 - create a new #{user_choice}"
    _show " 4 - update an #{user_choice}"
    _show " 5 - delete an #{user_choice}"

   the_other_repo = user_choice == "order" ? "item" : "order"
    _show " 0 - I want to manage my #{the_other_repo}s"
    return _prompt.to_i
  end

  def _prompt_for_update_options
    while true
      _show
      _show "Which attributes?"
      _show " 1 - date of order"
      _show " 2 - customer name"
      _show " 3 - list of items"
      _show " 4 - all of the above"
      _show

      choice = _prompt("Enter a number between 1 and 4").to_i

      is_valid = choice > 0 && choice <= 4
      unless is_valid
        _show
        _show("Sorry, choice not available")
        next
      else
        return choice
      end
    end
  end

  def _prompt_new_date
    @io.puts "Please enter the date (YYYY-MM-DD):"
    return @io.gets.chomp
  end

  def _prompt_new_customer
    @io.puts "Please enter the customer name:"
    return @io.gets.chomp
  end

  def _prompt_new_items
    @io.puts "Please enter ID of items purchased (separate with , no spaces):"
    return @io.gets.chomp
  end

  def _prompt_all_attributes(order)
    order.date = _prompt_new_date
    order.customer = _prompt_new_customer
    item_ids = _prompt_new_items
    order.items = _add_items_into_order(order, item_ids)
    return order
  end
  
  # ---------------------
  # CRUD METHODS CALLS
  # ---------------------

  def _all_method_for_OrderRepository
    @order_repository.all.each do |order|
      _format_order(order)
    end
  end

  def _find_method_for_OrderRepository
    id = _prompt("Please enter an order ID: ").to_i
    order = @order_repository.find(id)
    _format_order(order)
  end

  def _create_method_for_OrderRepository
    new_order = Order.new
    order = _prompt_all_attributes(new_order)
    @order_repository.create(order)
  end

  def _update_method_for_OrderRepository(order, attribute_to_update)
    case attribute_to_update
    when 1
      order.date = _prompt_new_date
      @order_repository.update(order)
    when 2
      order.customer = _prompt_new_customer
      @order_repository.update(order)
    when 3
      item_ids = _prompt_new_items
      order.items = _add_items_into_order(order, item_ids)
      @order_repository.update(order)
    when 4
      all_attributes = _prompt_all_attributes(order)
      @order_repository.update(all_attributes)
    else
    end
  end

  # ---------------------
  # EXTRA FEATURES METHODS
  # ---------------------

  def _add_items_into_order(order, item_ids_str)
    items = []
    item_ids_arr = item_ids_str.split(",").map(&:to_i)
    ids_to_objects = item_ids_arr.each do |itemID| 
      items << @item_repository.find(itemID)
    end

    return items
  end

  def _format_order(order)
    _show "OrderID: #{order.id}"
    _show "Date: #{order.date}" 
    _show "Customer: #{order.customer}"
    _show "Item#{_add_s_if_plural(order)} purchased:"

    order.items.map do |item|
      _show "- #{item.name}: £#{item.price}"
    end
  end
  
  def _add_s_if_plural(order)
    list_of_items = order.items
    length = list_of_items.length
    return length > 1 ? "s" : ""
  end
end