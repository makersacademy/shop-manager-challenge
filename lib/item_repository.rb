require 'item'

class ItemRepository
  def initialize
  end

  def all
    items = []

    sql = "SELECT * FROM items;"
    result = DatabaseConnection.exec_params(sql, [])

    result.each do |row|
      item = Item.new

      item.id = row["id"]
      item.name = row["name"]
      item.unit_price = row["unit_price"]
      item.quantity = row["quantity"]

      items << item
    end

    return items
  end
end