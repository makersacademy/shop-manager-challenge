module OrderManager

  private

  # ---------------------
  # CRUD METHODS PROCESS
  # ---------------------

  def _execute_order_process(selected)
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
      _format_order(order)
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
    _format_order(order)
  end

  # GET ORDER FOR FIND METHODS
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

  # FORMATTING METHOD FOR FIND METHODS

  def _format_order(order)
    _show "------------"
    _show "ORDER \##{order.id}"
    _show "------------"
    _show "Date: #{order.date}" 
    _show "Customer: #{order.customer}"
    _show "Item#{_add_s_if_plural(order.items)} purchased:"

    order.items.map do |item|
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
    order = _prompt_all_attributes_for_new_order(new_order) # method at end of page in SHARED METHOD
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
    order = @order_repository.find(id)
    attribute_to_update = _prompt_update_order_options
    _update_method_for_order_manager(order, attribute_to_update)
    @order_repository.update(order)
    _show "Order successfully updated."
  end

  def _prompt_update_order_options
    _show "-----------------"
    _show "Which attributes?"
    _show "-----------------"
    _show " 1 - date of order"
    _show " 2 - customer name"
    _show " 3 - list of items"
    _show " 4 - all of the above"

    return _get_user_input

  end

  def _update_method_for_order_manager(order, attribute_to_update)
    case attribute_to_update
    when 1
      _prompt_for_order_date(order)
    when 2
      _prompt_for_order_customer_name(order)
    when 3
      _prompt_for_order_list_of_items(order)
    when 4
      _prompt_all_attributes_for_new_order(order)
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

  def _prompt_all_attributes_for_new_order(order)
    _prompt_for_order_date(order)
    _prompt_for_order_customer_name(order)
    _prompt_for_order_list_of_items(order)
    return order
  end

  def _prompt_for_order_date(order)
    order.date = _prompt "Please enter the date (YYYY-MM-DD):"
  end

  def _prompt_for_order_customer_name(order)
    order.customer = _prompt "Please enter the customer name:"
  end

  def _prompt_for_order_list_of_items(order)
    item_ids = _prompt "Please enter ID of items purchased (separate with , no spaces):"
    order.items = _add_items_into_order(item_ids)
  end

  # Helper method for method above - 
  # when creating a new order or updating an existing one 
  # it fetches the items purchased by the customer 
  # and push them in the order.items attributes
  # ignore items not found
  def _add_items_into_order(item_ids_str)
    items = []
    counter = 0
    
    item_ids_arr = item_ids_str.split(",").map(&:to_i)
    ids_to_objects = item_ids_arr.each do |item_id| 
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
