module ItemManager

  private

  # ---------------------
  # MAIN MENU PROCESS
  # ---------------------

  def _execute_item_option(selected)
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
    _puts "------------"
    _puts "ALL ITEMS"
    _puts "------------"
    @item_repository.all.each do |item|
      _format_item(item) # method in FIND METHOD PROCESS
      _puts
    end
  end

  # ---------------------
  # FIND METHOD CONTEXT
  # ---------------------

  def _find_process_for_item_manager
    find_mode = _which_find? # 'item' or 'item with orders'
    _find_item if find_mode == "just the item"
    _find_with_orders if find_mode == "item with orders"
  end

  def _which_find?
    _puts "--------------"
    _puts "Just the item?"
    _puts "--------------"
    _puts " 1 - just the item"
    _puts " 2 - the item with linked orders"

    selected_mode = _prompt.to_i
    return "just the item" if selected_mode == 1
    return "item with orders" if selected_mode == 2

    _which_find? # calls the method again if invalid input
  end

  def _find_item
    _show_header
    find = lambda { |id| @item_repository.find(id) }
    item = _get_item_with(find)
    _format_item(item) # method a couple of lines below
  end

  def _find_with_orders
    _show_header
    find_with_orders = lambda { |id| @item_repository.find_with_orders(id) }
    item = _get_item_with(find_with_orders)
    _format_item_with_orders(item) # method a couple of lines below
  end

  def _show_header
    _puts "--------------"
    _puts "Which item?"
    _puts "--------------"
  end

  # GET ITEM METHOD FOR FIND AND FIND WITH ORDERS METHOD
  # also checks if item exist

  def _get_item_with(lambda)
    while true
      id = _prompt("Enter the item ID: ").to_i
      begin
        item = lambda.call(id)
      rescue
        _puts
        _puts "Sorry, this item doesn't exist. Try again."
        next
      end
      break
    end 
    return item
  end

  # FORMAT METHOD FOR FIND AND ALL METHODS

  def _format_item(item)
    _puts "------------"
    _puts "ITEM \##{item.id}"
    _puts "------------"
    _puts "Item: #{item.name}" 
    _puts "Price: £#{item.price}"
    _puts "Quantity: #{item.quantity}"
  end

  def _format_item_with_orders(item)
    _format_item(item)
    _puts
    _puts "ORDER#{_add_s_if_plural(item.orders)}:".upcase

    item.orders.map do |order| # format list of linked orders
      _puts "\##{order.id} - date: #{order.date} - customer: #{order.customer}"
    end
  end

  # ---------------------
  # CREATE METHOD CONTEXT
  # ---------------------

  def _create_process_for_item_manager
    new_item = Item.new
    _puts "---------"
    _puts "NEW ITEM"
    _puts "---------"
    item = _prompt_all_item_attributes_for(new_item) # method at end of page in SHARED METHOD
    @item_repository.create(item)
    _puts "Order successfully created."
  end

  # ---------------------
  # UPDATE METHOD CONTEXT
  # ---------------------

  def _update_process_for_item_manager
    _puts "------------"
    _puts "Which item?"
    _puts "------------"

    id = _prompt("Enter the item ID").to_i
    item_to_update = @item_repository.find(id)
    attribute_to_update = _show_item_attribute_options
    _processing_item_update_with(item_to_update, attribute_to_update)
    @item_repository.update(item_to_update)
    _puts "Order successfully updated."
  end

  def _show_item_attribute_options
    _puts "-----------------"
    _puts "Which attributes?"
    _puts "-----------------"
    _puts " 1 - item name"
    _puts " 2 - item price"
    _puts " 3 - item remaining stock"
    _puts " 4 - all of the above"

    return _attribute_selected  # method can be found in SHARED METHOD in app.rb file

  end

  def _processing_item_update_with(item_to_update, attribute_to_update)
    case attribute_to_update
    when 1
      _prompt_item_name_for(item_to_update)
    when 2
      _prompt_item_price_for(item_to_update)
    when 3
      _prompt_item_quantity_for(item_to_update)
    when 4
      _prompt_all_item_attributes_for(item_to_update)
    end
  end

  # ---------------------
  # DELETE METHOD CONTEXT
  # ---------------------

  def _delete_process_for_item_manager
    _puts "------------"
    _puts "Which order?"
    _puts "------------"
    item_id = _prompt("Enter the order ID").to_i
    @item_repository.delete(item_id)
    _puts "Item successfully deleted."
  end

  # ---------------------
  # SHARED METHODS
  # ---------------------

  def _prompt_item_name_for(new_item)
    new_item.name = _prompt "What is the item name?"
  end

  def _prompt_item_price_for(new_item)
    new_item.price = _prompt("What is its selling price?").to_i
  end

  def _prompt_item_quantity_for(new_item)
    new_item.quantity = _prompt("How many in stock?").to_i
  end

  def _prompt_all_item_attributes_for(new_item)
    _prompt_item_name_for(new_item)
    _prompt_item_price_for(new_item)
    _prompt_item_quantity_for(new_item)
    return new_item
  end
end
