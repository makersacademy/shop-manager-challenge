require_relative "./item"

class ItemRepository
  def all
    # SELECT id, name, price, quantity FROM items;

  end

  def create(item)
    # INSERT INTO items (name, price, quantity) VALUES($1, $2, $3);

  end
end