require_relative "./item"

class ItemRepository
  def all
    # returns an array of Item objects
    sql = "SELECT id, name, unit_price, quantity FROM items ORDER BY id;"
    result = DatabaseConnection.exec_params(sql, [])

    items = []

    result.each do |record|
      item = Item.new
      item.id = record["id"].to_i
      item.name = record["name"]
      item.unit_price = record["unit_price"].to_f
      item.quantity = record["quantity"].to_i

      items << item
    end

    return items
  end

  def create_item(name, price, quantity)
    # creates an Item object and save a record to database
    sql = "INSERT INTO items (name, unit_price, quantity) VALUES ($1, $2, $3)"
    params = [name, price, quantity]
    DatabaseConnection.exec_params(sql, params)
  end

  # update an item's quantity from items table
  # action : '+' or '-'
  def update_stock(id, qty, action)
    fail "Invalid id. Please enter again." unless exist?(id)
    sql = "UPDATE items SET quantity = quantity #{action == "+" ? "+" : "-"} $1 WHERE id = $2"
    params = [qty, id]
    DatabaseConnection.exec_params(sql, params)
  end

  # updates an item's price from items table
  def update_price(id, price)
    fail "Invalid id. Please enter again." unless exist?(id)
    sql = "UPDATE items SET unit_price = $1 WHERE id = $2"
    params = [price, id]
    DatabaseConnection.exec_params(sql, params)
  end

  # deletes an item from items table
  def remove_item(id)
    fail "Invalid id. Please enter again." unless exist?(id)
    sql = "DELETE FROM items WHERE id = $1"
    params = [id]
    DatabaseConnection.exec_params(sql, params)
  end

  # returns true if the num <= quantity
  def enough_stock?(id, num)
    fail "Invalid id. Please enter again." unless exist?(id)
    sql = "SELECT quantity FROM items WHERE id = $1"
    params = [id]
    quantity = DatabaseConnection.exec_params(sql, params)[0]["quantity"].to_i

    return num <= quantity
  end

  private

  # returns true if the record in 'items' table exists
  def exist?(id)
    sql = "SELECT id FROM items WHERE items.id = $1"
    params = [id]
    item = DatabaseConnection.exec_params(sql, params)
    return !item.ntuples.zero?
  end
end
