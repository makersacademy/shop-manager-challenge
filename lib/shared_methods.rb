module Record

  def self.to_order(record)
    order = Order.new
    order.id = record["id"].to_i
    order.date = record["date"]
    order.customer = record["customer"]
    return order
  end

  def self.to_item(record)
    item = Item.new
    item.id = record["itemID"].to_i
    item.name = record["name"]
    item.price = record["price"].to_i
    item.quantity = record["quantity"].to_i
    return item
  end
  
end
