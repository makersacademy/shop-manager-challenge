## Model classes
```ruby
class Item
  attr_accessor :id, :name, :unit_price, :quantity
end

class Order
  attr_accessor :id, :customer_name, :date
  @items = []
end
```

## Repository classes
```ruby
class ItemRepository
  def list
    # query = 'SELECT id, name, unit_price, quantity FROM items;'
    # returns an array of Item objects
  end

  def create(item)
    # query = 'INSERT INTO items (name, unit_price, quantity) VALUES ($1, $2, $3);'
    # params = [item.name, item.unit_price, item.quantity]
    # returns nil
  end
end

class OrderRepository
  def list
    # query = 'SELECT id, customer_name, date FROM orders;'
    # returns an array of Order objects
  end

  def assign_item(order, item)
    # query = 'INSERT INTO orders_items (order_id, item_id) VALUES ($1, $2);'
    # params = [order.id, item.id]
  end

  def create(order)
    # query = 'INSERT INTO order (customer_name, date) VALUES ($1, $2);'
    # params = [order.customer_name, order.date]
  end
end
```