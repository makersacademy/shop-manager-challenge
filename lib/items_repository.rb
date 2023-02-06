# Repository Class
require_relative './items'
class ItemsRepository
	def all
    sql = 'SELECT * FROM items;'
    result_set = DatabaseConnection.exec_params(sql, [])
    items = []
    result_set.each do |record|
      item = Items.new
      item.id = record['id']
      item.name = record['name']
      item.unit_price = record['unit_price']
      item.quantity = record['quantity']

      items << item
    end
      return items
  end

  def stock(items)
    i=0
    items.each do
      return "##{items[i].id} #{items[i].name} - Unit price: #{items[i].unit_price} - Quantity: #{items[i].quantity}"
      i+=1
    end
  end

  def find(id)
    sql = "SELECT name, unit_price, quantity FROM items WHERE id = $1"
    result_set = DatabaseConnection.exec_params(sql, [id])

    result_set.each do |record|
      item = Items.new
      item.id = record['id']
      item.name = record['name']
      item.unit_price = record['unit_price']
      item.quantity = record['quantity']
      return item
    end
  end

  def create(item)
    
    sql = "INSERT INTO items (name, unit_price, quantity) VALUES('#{item.name}', #{item.unit_price}, #{item.quantity});"
    result_set = DatabaseConnection.exec_params(sql, [])
    return result_set
    
  end

end