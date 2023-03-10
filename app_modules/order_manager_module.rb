module OrderManager

  private

  # ---------------------
  # MAIN MENU PROCESS
  # ---------------------

  def _execute_order_option(selected)
    case selected
    when 1
      _all_process_for_order_manager
    when 2
      _find_process_for_order_manager
    when 3
      _create_process_for_order_manager
    when 4
      _update_process_for_order_manager
    when 5
      _delete_process_for_order_manager
    when 9
      _show_main_menu_for("item")
    else
      _wrong_input_process_for("order")
    end
  end

  # ---------------------
  # ALL METHOD PROCESS
  # ---------------------

  def _all_process_for_order_manager
    _puts "------------"
    _puts "ALL ORDERS"
    _puts "------------"
    @order_repository.all.each do |order|
      _format_order(order) # method in FIND METHOD PROCESS
      _puts
    end
  end

  # ---------------------
  # FIND METHOD PROCESS
  # ---------------------

  def _find_process_for_order_manager
    _puts "------------"
    _puts "Which order?"
    _puts "------------"
    order = _get_order
    _format_order(order) # method a couple of lines below
  end

  # GET ORDER METHOD FOR 'FIND'
  # also checks if order exist

  def _get_order
    while true
      id = _prompt("Enter the order ID: ").to_i
      begin
        order = @order_repository.find(id)
      rescue
        _puts
        _puts "Sorry, this order doesn't exist. Try again."
        next
      end
      break
    end 
    return order
  end

  # FORMAT METHOD FOR 'FIND' AND 'ALL' PROCESS

  def _format_order(order)
    _puts "------------"
    _puts "ORDER \##{order.id}"
    _puts "------------"
    _puts "Date: #{order.date}" 
    _puts "Customer: #{order.customer}"
    _puts "Item#{_add_s_if_plural(order.items)} purchased:"

    order.items.map do |item| # format list of linked items
      _puts "- #{item.name}: £#{item.price}"
    end
  end

  # ---------------------
  # CREATE METHOD PROCESS
  # ---------------------

  def _create_process_for_order_manager
    new_order = Order.new
    _puts "---------"
    _puts "NEW ORDER"
    _puts "---------"
    order = _prompt_all_order_attributes_for(new_order) # method at end of page in SHARED METHOD
    @order_repository.create(order)
    _puts
    _puts "Order successfully created."
  end

  # ---------------------
  # UPDATE METHOD PROCESS
  # ---------------------

  def _update_process_for_order_manager
    _puts "------------"
    _puts "Which order?"
    _puts "------------"
    
    id = _prompt("Enter the order ID").to_i
    order_to_update = @order_repository.find(id)
    attribute_to_update = _show_order_attribute_options
    _processing_order_update_with(order_to_update, attribute_to_update)
    @order_repository.update(order_to_update)
    _puts "Order successfully updated."
  end

  def _show_order_attribute_options
    _puts "-----------------"
    _puts "Which attributes?"
    _puts "-----------------"
    _puts " 1 - date of order"
    _puts " 2 - customer name"
    _puts " 3 - list of items"
    _puts " 4 - all of the above"

    return _attribute_selected # method can be found in SHARED METHOD in app.rb file

  end

  def _processing_order_update_with(order_to_update, attribute_to_update)
    case attribute_to_update
    when 1
      _prompt_date_for(order_to_update)
    when 2
      _prompt_customer_name_for(order_to_update)
    when 3
      _prompt_items_list_for(order_to_update)
    when 4
      _prompt_all_order_attributes_for(order_to_update)
    end
  end

  # ---------------------
  # DELETE METHOD PROCESS
  # ---------------------

  def _delete_process_for_order_manager
    _puts "------------"
    _puts "Which order?"
    _puts "------------"
    order_id = _prompt "Enter the order ID"
    @order_repository.delete(order_id)
    _puts "Order successfully deleted."
  end

  # ---------------------
  # SHARED METHODS
  # ---------------------

  def _prompt_all_order_attributes_for(new_order)
    _prompt_date_for(new_order)
    _prompt_customer_name_for(new_order)
    _prompt_items_list_for(new_order)
    return new_order
  end

  def _prompt_date_for(new_order)
    new_order.date = _prompt "Please enter the date (YYYY-MM-DD):"
  end

  def _prompt_customer_name_for(new_order)
    new_order.customer = _prompt "Please enter the customer name:"
  end

  def _prompt_items_list_for(new_order)
    item_ids = _prompt "Please enter ID of items purchased (separate with , no spaces):"
    new_order.items = _add_items_to_order_given(item_ids)
  end

  # Helper method for method above - 
  # when creating a new order or updating an existing one 
  # it fetches the items purchased by the customer 
  # and push them in the order.items attributes
  # ignore items not found
  def _add_items_to_order_given(item_ids)
    items = []
    counter = 0
    
    arr_of_int = item_ids.split(",").map(&:to_i)
    int_to_objects = arr_of_int.each do |item_id| 
      begin
        item = @item_repository.find(item_id)
      rescue
        counter += 1
        next
      end
      items << item
    end
    _puts
    _puts "#{counter} item#{counter > 1 ? "s" : ""} not found #{counter > 1 ? "were" : "was"} ignored."
    return items
  end
end
