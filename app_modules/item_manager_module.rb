module ItemManager

  private

  # ---------------------
  # CRUD METHODS PROCESS
  # ---------------------

  def _execute_item_process(selected)
    case selected
    when 1
      _all_process_for_item_manager
    when 2
      _find_process_for_item_manager
    when 3
      _create_process_for_item_manager
    when 4
      _update_process_for_item_manager
    when 5
      _delete_process_for_item_manager
    when 9
      _show_main_menu_for("order")
    else
      _wrong_input_process_for("item")
    end
  end

  # ---------------------
  # ALL METHOD CONTEXT
  # ---------------------

  def _all_process_for_item_manager
    _show "------------"
    _show "ALL ITEMS"
    _show "------------"
    @item_repository.all.each do |item|
      _format_item(item)
      _show
    end
  end

  # ---------------------
  # FIND METHOD CONTEXT
  # ---------------------

  def _find_process_for_item_manager
    find_mode = _which_find? # 'just the item' or 'item with orders'
    _find_method_for_item_manager if find_mode == "just the item"
    _find_with_orders_for_item_manager if find_mode == "item with orders"
  end

  def _which_find?
    _show "--------------"
    _show "Just the item?"
    _show "--------------"
    _show " 1 - just the item"
    _show " 2 - the item with linked orders"

    selected_mode = _prompt.to_i
    return "just the item" if selected_mode == 1
    return "item with orders" if selected_mode == 2

    _which_find? # calls the method again if invalid input
  end

  def _find_method_for_item_manager
    _show "--------------"
    _show "Which item?"
    _show "--------------"
    find = lambda { |id| @item_repository.find(id) }
    item = _get_item_with(find)
    _format_item(item)
  end

  def _find_with_orders_for_item_manager
    _show "--------------"
    _show "Which item?"
    _show "--------------"
    find_with_orders = lambda { |id| @item_repository.find_with_orders(id) }
    item = _get_item_with(find_with_orders)
    _format_item_with_orders(item)
  end

  # GET ITEM FOR FIND METHODS
  # also checks if item exist

  def _get_item_with(lambda)
    while true
      id = _prompt("Enter the item ID: ").to_i
      begin
        item = lambda.call(id)
      rescue
        _show
        _show "Sorry, this item doesn't exist. Try again."
        next
      end
      break
    end 
    return item
  end

  # FORMATTING METHOD FOR FIND METHODS

  def _format_item(item)
    _show "------------"
    _show "ITEM \##{item.id}"
    _show "------------"
    _show "Item: #{item.name}" 
    _show "Price: £#{item.price}"
    _show "Quantity: #{item.quantity}"
  end

  def _format_item_with_orders(item)
    _format_item(item)
    _show
    _show "ORDER#{_add_s_if_plural(item.orders)}:".upcase
    item.orders.map do |order| # format list of linked orders
      _show "\##{order.id} - date: #{order.date} - customer: #{order.customer}"
    end
  end

  # ---------------------
  # CREATE METHOD CONTEXT
  # ---------------------

  def _create_process_for_item_manager
    new_item = Item.new
    _show "---------"
    _show "NEW ITEM"
    _show "---------"
    item = _prompt_all_attributes_for_new_item(new_item) # method at end of page in SHARED METHOD
    @item_repository.create(item)
    _show "Order successfully created."
  end

  # ---------------------
  # UPDATE METHOD CONTEXT
  # ---------------------

  def _update_process_for_item_manager
    _show "------------"
    _show "Which item?"
    _show "------------"
    id = _prompt("Enter the item ID").to_i
    item = @item_repository.find(id)
    attribute_to_update = _prompt_for_update_item_options
    _update_selected_attrbutes(item, attribute_to_update)
    @item_repository.update(item)
    _show "Order successfully updated."
  end

  def _prompt_for_update_item_options
    _show "-----------------"
    _show "Which attributes?"
    _show "-----------------"
    _show " 1 - item name"
    _show " 2 - item price"
    _show " 3 - item remaining stock"
    _show " 4 - all of the above"

    return _get_user_input

  end

  def _update_selected_attrbutes(item, attribute_to_update)
    case attribute_to_update
    when 1
      _prompt_for_item_name(item)
    when 2
      _prompt_for_item_price(item)
    when 3
      _prompt_for_item_quantity(item)
    when 4
      _prompt_all_attributes_for_new_item(item)
    end
  end

  # ---------------------
  # DELETE METHOD CONTEXT
  # ---------------------

  def _delete_process_for_item_manager
    _show "------------"
    _show "Which order?"
    _show "------------"
    item_id = _prompt("Enter the order ID").to_i
    @item_repository.delete(item_id)
    _show "Item successfully deleted."
  end

  # ---------------------
  # SHARED METHODS
  # ---------------------

  def _prompt_for_item_name(item)
    item.name = _prompt "What is the item name?"
  end

  def _prompt_for_item_price(item)
    item.price = _prompt("What is its selling price?").to_i
  end

  def _prompt_for_item_quantity(item)
    item.quantity = _prompt("How many in stock?").to_i
  end

  def _prompt_all_attributes_for_new_item(item)
    _prompt_for_item_name(item)
    _prompt_for_item_price(item)
    _prompt_for_item_quantity(item)
    return item
  end
end
