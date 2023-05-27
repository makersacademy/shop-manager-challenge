class OrderItemRepository

  def find(order_id, item_id)
    # order_id and item_id are integers representing the order and item IDs to search for
    # SELECT order_id, item_id FROM order_items WHERE order_id = $1 AND item_id = $2;
    # Returns an instance of OrderItem object
  end

  def update(item_id, item)
    # Executes the SQL query;
    # UPDATE items SET name = $1, unit_price = $2, quantity = $3 WHERE id = $4;

    # The values $1, $2, $3, and $4 are placeholders for the actual values to be updated in the query.
    # The values are typically obtained from the `item` object, such as `item.name`, `item.unit_price`, `item.quantity`.

    # Returns nothing (only updates the record)
  end

  def delete(order_id, item_id)
    # Executes the SQL;
    # DELETE FROM order_items WHERE order_id = $1 AND item_id = $2;
    # Returns nothing (only deletes the record)
  end

end