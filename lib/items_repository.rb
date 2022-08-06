require_relative "item"

class ItemsRepository
  def all
    sql = 'SELECT id, item_name, price, quantity FROM items;'
    result_set = DatabaseConnection.exec_params(sql, [])

    output = []
    result_set.each{|object|
      item = Item.new
      item.id = object['id']
      item.item_name = object['item_name']
      item.price = object['price']
      item.quantity = object['quantity']
      output << item
      }
     return output
  end

  def find(id)
    sql = 'SELECT id, item_name, price, quantity  FROM items WHERE id = $1;'
    params = [id]
    result_set = DatabaseConnection.exec_params(sql, params)
    item = Item.new
    result_set.each{|object|
      item.id = object['id']
      item.item_name = object['item_name']
      item.price = object['price']
      item.quantity = object['quantity']
      }
      return item
  end

  # Add more methods below for each operation you'd like to implement.

  # def create(student)
  # end

  # def update(student)
  # end

  # def delete(student)
  # end
end