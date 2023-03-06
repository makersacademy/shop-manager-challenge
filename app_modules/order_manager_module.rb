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
    _show "------------"
    _show "ALL ORDERS"
    _show "------------"
    @order_repository.all.each do |order|
      _format_order(order) # method in FIND METHOD PROCESS
      _show
    end
  end

  # ---------------------
  # FIND METHOD PROCESS
  # ---------------------

  def _find_process_for_order_manager
    _show "------------"
    _show "Which order?"
    _show "------------"
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
        _show
        _show "Sorry, this order doesn't exist. Try again."
        next
      end
      break
    end 
    return order
  end

  # FORMAT METHOD FOR 'FIND' AND 'ALL' PROCESS

  def _format_order(order)
    _show "------------"
    _show "ORDER \##{order.id}"
    _show "------------"
    _show "Date: #{order.date}" 
    _show "Customer: #{order.customer}"
    _show "Item#{_add_s_if_plural(order.items)} purchased:"

    order.items.map do |item| # format list of linked items
      _show "- #{item.name}: £#{item.price}"
    end
  end

  # ---------------------
  # CREATE METHOD PROCESS
  # ---------------------

  def _create_process_for_order_manager
    new_order = Order.new
    _show "---------"
    _show "NEW ORDER"
    _show "---------"
    order = _prompt_all_order_attributes_for(new_order) # method at end of page in SHARED METHOD
    @order_repository.create(order)
    _show
    _show "Order successfully created."
  end

  # ---------------------
  # UPDATE METHOD PROCESS
  # ---------------------

  def _update_process_for_order_manager
    _show "------------"
    _show "Which order?"
    _show "------------"
    
    id = _prompt("Enter the order ID").to_i
    order_to_update = @order_repository.find(id)
    attribute_to_update = _show_order_attribute_options
    _processing_order_update_with(order_to_update, attribute_to_update)
    @order_repository.update(order_to_update)
    _show "Order successfully updated."
  end

  def _show_order_attribute_options
    _show "-----------------"
    _show "Which attributes?"
    _show "-----------------"
    _show " 1 - date of order"
    _show " 2 - customer name"
    _show " 3 - list of items"
    _show " 4 - all of the above"

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
    _show "------------"
    _show "Which order?"
    _show "------------"
    order_id = _prompt "Enter the order ID"
    @order_repository.delete(order_id)
    _show "Order successfully deleted."
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
    _show
    _show "#{counter} item#{counter > 1 ? "s" : ""} not found #{counter > 1 ? "were" : "was"} ignored."
    return items
  end
end
