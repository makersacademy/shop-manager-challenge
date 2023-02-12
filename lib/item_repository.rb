require "item"

class ItemRepository

  def all
    sql = 'SELECT id, name, unit_price, quantity FROM items;'
    result_set = DatabaseConnection.exec_params(sql,[])

    items = []
    result_set.each do |smth|
      item = Item.new
      item.id = smth['id'].to_i
      item.name = smth['name']
      item.unit_price = smth['unit_price']
      item.quantity = smth['quantity']
      items << item
    end

    return items
  end

  def find(id)
    sql = 'SELECT id, name, unit_price, quantity FROM items WHERE id = $1;'
    params = [id]
    result_set = DatabaseConnection.exec_params(sql,params)[0]

    item = Item.new
    item.id = result_set['id'].to_i
    item.name = result_set['name']
    item.unit_price = result_set['unit_price']
    item.quantity = result_set['quantity']

    return item

  end

  def create(item)
    # Executes the SQL query:
    # INSERT INTO items (name, unit_price, quantity) VALUES ($1, $2, $3);

    # creates an item object and doesn't return anything
  end

  def delete(id)
    # Executes the SQL query:
    # DELETE FROM items WHERE id = $1;

    # deletes an item
  end

  def update(item)
    # Executes the SQL query:
    # UPDATE items SET name = $1, unit_price = $2, quantity = $3 WHERE id = $4;
  end
end
