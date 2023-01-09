require_relative './item'

class ItemRepository
  def all
    sql = "SELECT id, name, unit_price, quantity FROM items"
    result_set = DatabaseConnection.exec_params(sql, [])

    items = []

    result_set.each do |record|
      item = Item.new

      item.id = record["id"]
      item.name = record["name"]
      item.unit_price = record["unit_price"]
      item.quantity = record["quantity"]
    
      items.push(item)
    end

    return items
  end

  # PROBABLY NOT NEEDED
  # def find(id)
  #   # Executes the SQL query:
  #   # SELECT id, name, cohort_name FROM items WHERE id = $1;

  #   # Returns a single Item object.
  # end

  # def create(item)
  # end

  #PROBABLY NOT NEEDED
  # def update(item)
  # end

  # def delete(id)
  # end
end