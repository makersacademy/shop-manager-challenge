require_relative "./order"

class OrderRepository
  def all
    # SELECT id, customer, date, item_id FROM orders;

  end

  def create(order)
    # INSERT INTO orders (customer, date, item_id) VALUES($1, $2, $3);

  end
end